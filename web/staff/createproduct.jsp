<%-- 
    Document   : createproduct
    Created on : Jun 18, 2024, 12:42:19 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
        <style>
            .img-preview {
                margin-top: 10px;
                display: flex;
                flex-wrap: wrap;
            }
            .img-preview .image-container {
                position: relative;
                margin-right: 10px;
                margin-bottom: 10px;
            }
            .img-preview img {
                width: 200px;
                height: 200px;
                object-fit: cover;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .img-preview .remove-btn {
                position: absolute;
                top: 5px;
                right: 5px;
                background: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                border-radius: 50%;
                width: 25px;
                height: 25px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .placeholder{
                height: 64px;
            }
        </style>
    </head>
    <body>
         
         <%@ include file="../public/navbar.jsp" %>


        <div class="container mt-5">
            <h2>Add New Product</h2>
            <div id="image-preview" class="img-preview"></div>
            <form action="${pageContext.request.contextPath}/cproduct" method="POST" enctype="multipart/form-data">
                <div>
                    <label for="productImage">Product Image:</label>
                    <input type="file" id="productImage" name="files" accept=".jpg,.jpeg,.png,.gif,.avif" multiple onchange="previewImages()" required>
                </div>
                <div class="form-group">
                    <label for="productName">Product Name:</label>
                    <input type="text" class="form-control" id="pname" name="pname" required placeholder="Enter Product Name">
                    <div id="nameError" style="color:red; display:none;">Product name already exists!</div>
                </div>
                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" class="form-control" id="price" name="price" required oninput="validity.valid||(value='');" placeholder="VND">
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="brand">Brand:</label>
                    <select class="form-control" id="brand" name="brand">
                        <c:forEach var="brand" items="${brands}">
                            <option value="${brand.bid}">${brand.bname}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="category">Category:</label>
                    <select class="form-control" id="category" name="category">
                        <c:forEach var="cat" items="${cats}">
                            <option value="${cat.catid}">${cat.catname}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Is Listed:</label>
                    <div style="display: flex; align-items: center;">
                        <div style="margin-right: 10px;">
                            <input type="radio" id="isListedTrue" name="isListed" value="true" required>
                            <label for="isListedTrue">Yes</label>
                        </div>
                        <div>
                            <input type="radio" id="isListedFalse" name="isListed" value="false" checked>
                            <label for="isListedFalse">No</label>
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>

        <script>
    document.getElementById('pname').addEventListener('input', function () {
        var pname = this.value;
        var nameError = document.getElementById('nameError');
        if (pname.length > 0) {
            fetch('${pageContext.request.contextPath}/CreateProductController', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'action=checkProductName&pname=' + encodeURIComponent(pname)
            })
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    nameError.style.display = 'block';
                } else {
                    nameError.style.display = 'none';
                }
            })
            .catch(error => console.error('Error:', error));
        } else {
            nameError.style.display = 'none';
        }
    });

    var fileList = [];

    function previewImages() {
        var preview = document.querySelector('#image-preview');
        var files = document.querySelector('input[type=file]').files;
        var allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/avif'];
        
        preview.innerHTML = ''; // Clear previous previews
        fileList = Array.from(files); // Update fileList with the new files
        
        fileList.forEach(function (file, index) {
            if (allowedTypes.includes(file.type)) {
                var reader = new FileReader();
                reader.addEventListener('load', function () {
                    var imageContainer = document.createElement('div');
                    imageContainer.classList.add('image-container');
                    
                    var image = new Image();
                    image.title = file.name;
                    image.src = this.result;
                    image.classList.add('thumbnail');
                    
                    var removeButton = document.createElement('button');
                    removeButton.classList.add('remove-btn');
                    removeButton.innerHTML = 'X';
                    removeButton.onclick = function () {
                        removeImage(index);
                    };
                    
                    imageContainer.appendChild(image);
                    imageContainer.appendChild(removeButton);
                    preview.appendChild(imageContainer);
                });
                reader.readAsDataURL(file);
            } else {
                alert('Invalid file type: ' + file.name + '. Only JPG, JPEG, PNG, GIF, and AVIF files are allowed.');
            }
        });
        
        updateFileInput();
    }

    function removeImage(index) {
        fileList.splice(index, 1);
        updateFileInput();
        previewImages(); // Re-render the previews
    }

    function updateFileInput() {
        var dataTransfer = new DataTransfer();
        
        fileList.forEach(function(file) {
            dataTransfer.items.add(file);
        });
        
        document.querySelector('input[type=file]').files = dataTransfer.files;
    }
</script>

    </body>
</html>
