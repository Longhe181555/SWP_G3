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
        <link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            .placeholder{
                height: 64px;
            }
        </style>
    </head>
    <body>
        <div class="placeholder"></div>
        <nav class="navbar navbar-expand-lg bg-dark text-white fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand text-white fs-2" href="homepage">MEN'S WEAR</a>
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <c:if test="${Account.role == 'staff' || Account.role == 'admin'}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="dashboard" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color:white;font-size:20px">
                                Dashboard
                            </a>
                            <ul class="dropdown-menu" >
                                <li><a class="dropdown-item" href="pmanagement" >Product Management</a></li>
                                <!--                                <li><a class="dropdown-item" href="#" >Another action</a></li>
                                                                <li><hr class="dropdown-divider"></li>
                                                                <li><a class="dropdown-item" href="#">Something else here</a></li>-->
                            </ul>
                        </li>
                    </c:if>
                </ul>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <form class="d-flex ms-auto" role="search" action="${pageContext.request.contextPath}/productlist" method="GET">
                        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="search">
                        <button class="btn btn-outline-success" type="submit">Search</button>
                    </form>
                    <ul class="navbar-nav ms-3 me-3">
                        <c:choose>
                            <c:when test="${empty Account}">
                                <li class="nav-item d-flex align-items-center">
                                    <a class="nav-link text-white" href="account">Login/Register</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item d-flex align-items-center">
                                    <div class="dropdown">
                                        <a class="nav-link text-white dropdown-toggle" href="#" role="button" id="accountDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                            ${Account.fullname}
                                            <img src="${Account.img}" alt="Profile Image" style="border-radius: 50%; width: 40px; height: 40px;">
                                        </a>
                                        <ul class="dropdown-menu" aria-labelledby="accountDropdown">
                                            <li><a class="dropdown-item" href="account">Account Detail</a></li>
                                            <li><a class="dropdown-item" href="#">Order History</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item" href="logout">Logout</a></li>
                                        </ul>
                                    </div>
                                </li>
                            </c:otherwise>
                        </c:choose>
                        <li class="nav-item d-flex align-items-center">
                            <a class="nav-link text-white" href="#"><i class="bi bi-bell"></i></a>
                        </li>
                        <li class="nav-item d-flex align-items-center">
                            <a class="nav-link text-white" href="#"><i class="bi bi-bag"></i></a>
                        </li>

                    </ul>
                </div>
            </div>
        </nav>



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
                    <input type="text" class="form-control" id="pname" name="pname" required>
                    <div id="nameError" style="color:red; display:none;">Product name already exists!</div>
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

    function previewImages() {
        var preview = document.querySelector('#image-preview');
        var files = document.querySelector('input[type=file]').files;
        var allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/avif'];
        
        preview.innerHTML = ''; // Clear previous previews
        
        Array.from(files).forEach(function (file) {
            if (allowedTypes.includes(file.type)) {
                var reader = new FileReader();
                reader.addEventListener('load', function () {
                    var image = new Image();
                    image.title = file.name;
                    image.src = this.result;
                    image.classList.add('thumbnail');
                    preview.appendChild(image);
                });
                reader.readAsDataURL(file);
            } else {
                alert('Invalid file type: ' + file.name + '. Only JPG, JPEG, PNG, GIF, and AVIF files are allowed.');
            }
        });
    }
</script>

    </body>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
</html>
