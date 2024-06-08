<%-- 
    Document   : homepage
    Created on : May 16, 2024, 12:52:35 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
        <style>


            .custom-dropdown option {
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                background-color: #ffffff;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            }

            .custom-dropdown:focus {
                outline: none;
            }

            .footer {
                background-color: black;
                padding: 10px 0;
                text-align: center;
            }

            .footer-text {
                color: white;
                margin: 0;
            }
            .card-title {
                font-size:16px;
            }

            .product {
                min-height: 300px;
                margin-bottom: 10px;
            }
            .product img {
                max-width: 100%;
                max-height: 100%;
                object-fit: cover;
            }
            .product-body {
                padding: 10px;
            }
            .product:hover {
                background-color: #f2f2f2;
                cursor: pointer;
            }
            .header-link:hover {
                color: #ffcc00;
                text-shadow: 0 0 10px rgba(255, 204, 0, 0.5);
            }
            .header-link {
                margin: 0 10px;
                color: white;
                text-decoration: none;
                cursor: pointer;
                transition: color 0.3s ease, text-shadow 0.3s ease;
            }
            .product-title {
                font-size: 16px;
            }
            .original-price {
                text-decoration: line-through;
            }

            .discounted-price, .discount-description {
                color: red;
            }
            .rating-star{
                color:gold;
            }
        </style>

    </head>
    <body>
        <div class="placeholder"></div>


        <nav class="navbar navbar-expand-lg bg-dark text-white fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand text-white fs-2" href="homepage">MEN'S WEAR</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <form class="d-flex ms-auto" role="search">
                        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-success text-white" type="submit">Search</button>
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



        <div class="container my-4">
            <div id="bannerCarousel" class="carousel slide mx-auto" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <a href="productlist">
                            <img src="${pageContext.request.contextPath}/img/other_picture/Banner1.png" class="d-block w-100" alt="Banner Image 1" style="max-height: 350px">
                        </a>
                    </div>
                    <div class="carousel-item">
                        <a href="productlist?order=dateDesc">
                            <img src="${pageContext.request.contextPath}/img/other_picture/banner2.png" class="d-block w-100" alt="Banner Image 2" style="max-height: 350px">
                        </a>
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#bannerCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#bannerCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>

        <hr/>


        <div class="container mt-3">
            <div class="row">
                <div class="col-6">
                    <h2>NEWLY ADDED</h2>
                </div>
                <div class="col-6 text-end">
                    <a href="productlist?order=dateDesc" class="btn btn-primary">See More</a>
                </div>
            </div>
            <div class="row row-cols-6 mt-3"> <!-- Adjust the number of columns as needed -->
                <c:forEach var="product" items="${newProduct}">
                    <div class="col">
                        <div class="card h-100 d-flex flex-column position-relative">
                            <!-- Add NEW badge -->
                            <span class="badge bg-warning position-absolute top-0 end-0">NEW</span>
                            <img src="${pageContext.request.contextPath}/${product.productimgs[0].imgpath}" class="card-img-top img-fluid" alt="${product.pname}">
                            <div class="card-body d-flex flex-column justify-content-between">
                                <h5 class="card-title product-title">${product.pname}</h5>
                                <c:if test="${product.avarageRating > 0}">
                                    <p class="card-text rating-star">
                                        <c:forEach var="i" begin="1" end="5">
                                            <c:choose>
                                                <c:when test="${i <= product.avarageRating}">
                                                    <i class="bi bi-star-fill"></i>
                                                </c:when>
                                                <c:when test="${i > product.avarageRating && i - 1 < product.avarageRating}">
                                                    <i class="bi bi-star-half"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </p>
                                </c:if>                                <p class="card-text">
                                    <c:if test="${not empty product.discountDescription}">
                                        <span class="badge bg-danger text-white position-absolute top-0 end-0 py-2 px-3">DISCOUNTED</span>
                                        <span class="badge bg-warning position-absolute top-0 end-0 mt-4">NEW</span>
                                        <span class="discount-description">Up to ${product.discountDescription} values</span><br>
                                        <span class="original-price" style="text-decoration: line-through;">${product.price}đ</span> -
                                        <span class="discounted-price">${product.discountedPrice}đ</span>
                                    </c:if>
                                    <c:if test="${empty product.discountDescription}">
                                        $${product.price}đ
                                    </c:if>
                                </p>
                                <a href="${pageContext.request.contextPath}/productdetail?pid=${product.pid}" class="btn btn-primary mt-auto">View Details</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <hr/>
        <!--#343a40-->

        <div class="container mt-3">
            <div class="row">
                <div class="col-6">
                    <h2>DISCOUNTED</h2>
                </div>
                <div class="col-6 text-end">
                    <a href="productlist?discount=on" class="btn btn-primary">See More</a>
                </div>
            </div>
            <div class="row mt-3 product-row">
                <c:forEach var="product" items="${discountedProduct}">
                    <div class="col">
                        <div class="card h-100 d-flex flex-column position-relative">
                            <img src="${pageContext.request.contextPath}/${product.productimgs[0].imgpath}" class="card-img-top img-fluid" alt="${product.pname}">
                            <div class="card-body d-flex flex-column justify-content-between">
                                <span class="badge bg-danger text-white position-absolute top-0 end-0 py-2 px-3">DISCOUNTED</span>
                                <h5 class="card-title product-title">${product.pname}</h5>
                                <c:if test="${product.avarageRating > 0}">
                                    <p class="card-text rating-star">
                                        <c:forEach var="i" begin="1" end="5">
                                            <c:choose>
                                                <c:when test="${i <= product.avarageRating}">
                                                    <i class="bi bi-star-fill"></i>
                                                </c:when>
                                                <c:when test="${i > product.avarageRating && i - 1 < product.avarageRating}">
                                                    <i class="bi bi-star-half"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </p>
                                </c:if>
                                <p class="card-text">
                                    <span class="discount-description">Up to ${product.discountDescription} values</span><br>
                                    <span class="original-price">${product.price}đ</span> -
                                    <span class="discounted-price">${product.discountedPrice}đ</span>
                                </p>
                                <a href="${pageContext.request.contextPath}/productdetail?pid=${product.pid}" class="btn btn-primary mt-auto">View Details</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </div>

        <hr/>

        <div class="container mt-3">
            <div class="row">
                <div class="col-6">
                    <h2>Loved by all</h2>
                </div>
                <div class="col-6 text-end">
                    <a href="productlist?order=ratingDesc" class="btn btn-primary">See More</a>
                </div>
            </div>
            <div class="row row-cols-6 mt-3"> <!-- Adjust the number of columns as needed -->
                <c:forEach var="product" items="${highRatingProducts}">
                    <div class="col">
                        <div class="card h-100 d-flex flex-column position-relative">
                            <img src="${pageContext.request.contextPath}/${product.productimgs[0].imgpath}" class="card-img-top img-fluid" alt="${product.pname}">
                            <div class="card-body d-flex flex-column justify-content-between">
                                <h5 class="card-title product-title">${product.pname}</h5>
                                <c:if test="${product.avarageRating > 0}">
                                    <p class="card-text rating-star">
                                        <c:forEach var="i" begin="1" end="5">
                                            <c:choose>
                                                <c:when test="${i <= product.avarageRating}">
                                                    <i class="bi bi-star-fill"></i>
                                                </c:when>
                                                <c:when test="${i > product.avarageRating && i - 1 < product.avarageRating}">
                                                    <i class="bi bi-star-half"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </p>
                                </c:if>
                                <p class="card-text">
                                    <c:if test="${not empty product.discountDescription}">
                                        <span class="badge bg-danger text-white position-absolute top-0 end-0 py-2 px-3">DISCOUNTED</span>
                                        <span class="discount-description">Up to ${product.discountDescription} values</span><br>
                                        <span class="original-price" style="text-decoration: line-through;">${product.price}đ</span> -
                                        <span class="discounted-price">${product.discountedPrice}đ</span>
                                    </c:if>
                                    <c:if test="${empty product.discountDescription}">
                                        $${product.price}đ
                                    </c:if>
                                </p>
                                <a href="${pageContext.request.contextPath}/productdetail?pid=${product.pid}" class="btn btn-primary mt-auto">View Details</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <hr/>      
        <div class="container mt-3">
            <div class="row">
                <div class="col-12">
                    <h2>Popular Brands</h2>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12">
                    <div class="brand-scroll-container" style="overflow-x: auto; white-space: nowrap; text-align: center;">
                        <!-- Iterate over brands and display each brand image as a clickable link -->
                        <c:forEach var="brand" items="${brands}">
                            <div class="brand-img-container" style="display: inline-block; margin-right: 10px;">
                                <a href="brandDetail?bid=${brand.bid}">
                                    <img src="${pageContext.request.contextPath}/${brand.img}" class="img-fluid" alt="${brand.bname}" style="width: 100px; height: auto;">
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>                
        <hr/>                

        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <p class="footer-text">About us</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <p class="footer-text">All pictures from brands are used for educational purposes only and are not intended for commercial use.</p>
                    </div>
                </div>
            </div>
        </footer>


        <div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="productModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="productModalLabel">Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <img src="" id="productImg" class="img-fluid" alt="Product Image">
                            </div>
                            <div class="col-md-6">
                                <h5 id="productName"></h5>
                                <p id="productPrice"></p>
                                <p id="productDescription"></p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <script>

            function applyFilter() {
                var filterDropdown = document.getElementById('filterDropdown');
                var selectedValue = filterDropdown.options[filterDropdown.selectedIndex].value;
                window.location.href = selectedValue;
            }

            window.addEventListener('beforeunload', function () {
                localStorage.setItem('scrollPosition', window.scrollY);
            });

            // Restore scroll position after page loads
            window.addEventListener('load', function () {
                const scrollPosition = localStorage.getItem('scrollPosition');
                if (scrollPosition !== null) {
                    window.scrollTo(0, scrollPosition);
                    localStorage.removeItem('scrollPosition'); // Clean up
                }
            });





        </script>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    </body>

</html>
