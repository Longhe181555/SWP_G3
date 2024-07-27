<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
        <title>Update Product</title>
        <style>
            .placeholder {
                height: 64px;
                width: 100%;
            }
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
            .img-preview .remove-btn.disabled {
                background: rgba(0, 0, 0, 0.2);
                cursor: not-allowed;
            }
            .warning {
                color: red;
                font-weight: bold;
                display: none;
            }
        </style>
    </head>
    <body>
        <%@ include file="../public/navbar.jsp" %>

        <div class="container product_detail mt-5">
            <h1>Update Product</h1>
            <c:if test="${not empty product}">
                <form action="${pageContext.request.contextPath}/UpdateProductController" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="pid" value="${param.pid}">
                    <!-- Store the original price -->
                    <input type="hidden" id="original-price" value="${product.price}">
                    <div class="row">
                        <div class="col-md-6">
                            <!-- Existing Images -->
                            <div id="existing-images" class="img-preview">
                                <c:forEach var="img" items="${product.productimgs}">
                                    <div class="image-container">
                                        <img src="${pageContext.request.contextPath}/${img.imgpath}" alt="Product Image">
                                        <button type="button" class="remove-btn" onclick="removeExistingImage(this, '${img.imgpath}')">X</button>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- New Image Preview -->
                            <div id="new-image-preview" class="img-preview"></div>
                            <div class="form-group mt-3">
                                <label for="images">Update Images:</label>
                                <input type="file" name="images" multiple class="form-control-file" id="images" onchange="previewImages()">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="pname">Product Name:</label>
                                <input type="text" class="form-control" id="pname" name="pname" value="${product.pname}">
                            </div>
                            <div class="form-group">
                                <label for="price">Price:</label>
                                <input type="number" class="form-control" id="price" name="price" value="${product.price}" oninput="checkPriceChange()">
                            </div>
                            <div class="warning" id="price-warning">
                                Changing the price will notify users with this item in their cart.
                            </div>
                            <div class="form-group">
                                <label for="description">Description:</label>
                                <textarea class="form-control" id="description" name="description" rows="3">${product.description}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="brand">Brand:</label>
                                <select class="form-control" id="brand" name="brand">
                                    <c:forEach var="brand" items="${brands}">
                                        <option value="${brand.bid}" ${brand.bid == product.brand.bid ? 'selected' : ''}>${brand.bname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <input type="hidden" name="removedImages" id="removed-images" value="">
                            <input type="submit" class="btn btn-primary" value="Update Product">
                        </div>
                    </div>
                </form>
            </c:if>
            <c:if test="${empty product}">
                <p>Product not found.</p>
            </c:if>
        </div>

        <script>
            function removeExistingImage(button, imagePath) {
                var existingImages = document.querySelectorAll('#existing-images .image-container');
                if (existingImages.length <= 1) {
                    alert('Cannot remove the last existing image.');
                    return;
                }

                button.parentElement.remove();

                // Add image path to removed images list
                var removedImagesInput = document.querySelector('#removed-images');
                var removedImages = removedImagesInput.value.split(',').filter(Boolean);
                removedImages.push(imagePath);
                removedImagesInput.value = removedImages.join(',');
            }

            function previewImages() {
                var preview = document.querySelector('#new-image-preview');
                var files = document.querySelector('input[type=file]').files;
                var allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/avif'];

                preview.innerHTML = ''; // Clear previous previews

                Array.from(files).forEach(function (file) {
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
                                removeNewImage(file);
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
            }

            function removeNewImage(file) {
                var input = document.querySelector('input[type=file]');
                var dataTransfer = new DataTransfer();

                Array.from(input.files).forEach(function (f) {
                    if (f !== file) {
                        dataTransfer.items.add(f);
                    }
                });

                input.files = dataTransfer.files;
                previewImages(); // Re-render the previews
            }

            function checkPriceChange() {
                var originalPrice = parseFloat(document.getElementById('original-price').value);
                var currentPrice = parseFloat(document.getElementById('price').value);
                var warning = document.getElementById('price-warning');

                if (currentPrice !== originalPrice) {
                    warning.style.display = 'block';
                } else {
                    warning.style.display = 'none';
                }
            }
        </script>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUd1En2Xj9nX6jP+QqVvBB3w7A+0xF+W+0b+U2t6U5yprnU8rquz" crossorigin="anonymous"></script>
    </body>
</html>
