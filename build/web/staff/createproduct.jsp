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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
        <style>
            .img-preview {
                margin-top: 10px;
                display: flex;
                flex-wrap: wrap;
            }
            .img-preview img {
                margin-right: 10px;
                margin-bottom: 10px;
                width: 200px;
                height: 200px;
                object-fit: cover;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2>Add New Product</h2>
            <div id="image-preview" class="img-preview">

            </div>
            <form action="${pageContext.request.contextPath}/cproduct" method="POST" enctype="multipart/form-data">
                <div>
                    <label for="productImage">Product Image:</label>
                    <input type="file" id="productImage" name="files" accept="image/*" multiple onchange="previewImages()" required>
                </div>
                <div class="form-group">
                    <label for="productName">Product Name:</label>
                    <input type="text" class="form-control" id="pname" name="pname" required>
                </div>
                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" class="form-control" id="price" name="price" required>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="brand">Brand:</label>
                    <select class="form-control" id="brand" name="brand">
                        <c:forEach var="brand" items="${brands}">
                            <option value="${brand.bid}" >${brand.bname}</option>
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
            function previewImages() {
                var preview = document.querySelector('#image-preview');
                var files = document.querySelector('input[type=file]').files;

                preview.innerHTML = ''; // Clear previous previews

                function readAndPreview(file) {
                    // Make sure `file` is an image
                    if (/\.(jpe?g|png|gif)$/i.test(file.name)) {
                        var reader = new FileReader();

                        reader.addEventListener('load', function () {
                            var image = new Image();
                            image.title = file.name;
                            image.src = this.result;
                            image.classList.add('thumbnail');
                            preview.appendChild(image);
                        });

                        reader.readAsDataURL(file);
                    }
                }

                if (files) {
                    [].forEach.call(files, readAndPreview);
                }
            }
        </script>
    </body>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</html>
