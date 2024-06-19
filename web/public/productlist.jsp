<%-- 
    Document   : productlist
    Created on : Jun 4, 2024, 8:01:01 PM
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
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <style>
            .placeholder{
                height: 64px;
            }
            .original-price {
                text-decoration: line-through;
            }

            .discounted-price, .discount-description {
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="placeholder"></div>
        <div class="container my-4" style="width: 50%">
            <div id="bannerCarousel" class="carousel slide mx-auto" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <a href="productlist">
                            <img src="${pageContext.request.contextPath}/img/other_picture/Banner1.png" class="d-block w-100" alt="Banner Image 1">
                        </a>
                    </div>
                    <div class="carousel-item">
                        <a href="productlist?order=dateDesc">
                            <img src="${pageContext.request.contextPath}/img/other_picture/banner2.png" class="d-block w-100" alt="Banner Image 2">
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



        <nav class="navbar navbar-expand-lg bg-dark text-white fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand text-white fs-2" href="homepage">MEN'S WEAR</a>
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

        <div class="container mt-4 fluid">
            <div class="row">
                <div class="col-4">
                    <div class="filter-options">
                        <h4>Filter Options</h4>
                        <form method="get" action="productlist">

                            <div class="form-group">
                                <label for="search">Search</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="search" name="search" placeholder="Search..." value="${param.search}">
                                    <div class="input-group-append">
                                        <button class="btn btn-success" type="submit">Go</button>
                                    </div>
                                </div>
                            </div>



                            <div class="form-group">
                                <label for="category">Category</label>
                                <select class="form-control" id="category" name="category">
                                    <option value="" ${empty param.category ? 'selected' : ''}>All</option>
                                    <c:forEach var="cat" items="${cats}">
                                        <option value="${cat.catid}" ${param.category == cat.catid ? 'selected' : ''}>${cat.catname}</option>
                                    </c:forEach>
                                </select>
                            </div>


                            <div class="form-group">
                                <label for="brand">Brand</label>
                                <select class="form-control" id="brand" name="brand">
                                    <option value="" ${empty param.brand ? 'selected' : ''}>All</option>
                                    <c:forEach var="brand" items="${brands}">
                                        <option value="${brand.bid}" ${param.brand == brand.bid ? 'selected' : ''}>${brand.bname}</option>
                                    </c:forEach>
                                </select>
                            </div>


                            <div class="form-group">
                                <label for="minPrice">Price From</label>
                                <input type="number" class="form-control" id="minPrice" name="minPrice" placeholder="Min Price" value="${param.minPrice}" min="0" step="1">
                            </div>
                            <div class="form-group">
                                <label for="maxPrice">Price To</label>
                                <input type="number" class="form-control" id="maxPrice" name="maxPrice" placeholder="Max Price" value="${param.maxPrice}" min="0" step="1">
                            </div>


                            <div class="form-group">
                                <label for="rating">Rating</label>
                                <div class="rating">
                                    <span class="rating-stars">
                                        <c:forEach var="i" begin="1" end="5">
                                            <c:choose>
                                                <c:when test="${param.rating == i}">
                                                    <i class="bi bi-star" data-rating="${i}" style="color: orange;"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-star" data-rating="${i}" style="color: orange;"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </span> or higher
                                    <input type="hidden" class="form-control" id="rating" name="rating" value="${param.rating}">
                                </div>
                            </div>
                            <input type="hidden" id="page" name="page" value="${param.page}">
                            <input type="hidden" id="order" name="order" value="${param.order}">
                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" id="discount" name="discount" ${param.discount == 'on' ? 'checked' : ''}>
                                <label class="form-check-label" for="discount">Have Discount</label>
                            </div>
                            <button type="submit" class="btn btn-primary">Filter</button>
                            <a class="btn btn-secondary" href="./productlist">Reset</a>
                        </form>
                    </div>
                </div>

                <!-- Product list column -->
                <div class="col-8 bg-light">
                    <div class="row bg-light py-2 mb-3">
                        <div class="col-6">
                            <select id="sortingDropdown" name="order">
                                <option value="" ${param.order == null || param.order.isEmpty() ? 'selected' : ''}>Order by</option>

                                <c:choose>
                                    <c:when test="${param.order eq 'priceDesc'}">
                                        <option value="priceDesc" selected>Price: High to Low</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="priceDesc">Price: High to Low</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${param.order eq 'priceAsc'}">
                                        <option value="priceAsc" selected>Price: Low to High</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="priceAsc">Price: Low to High</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${param.order eq 'dateDesc'}">
                                        <option value="dateDesc" selected>Date: New to Old</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="dateDesc">Date: New to Old</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${param.order eq 'ratingDesc'}">
                                        <option value="ratingDesc" selected>Rating: High to Low</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="ratingDesc">Rating: High to Low</option>
                                    </c:otherwise>
                                </c:choose>       
                            </select>                       
                        </div>
                        <div class="col-6 text-end">

                            <div class="row">
                                <div class="col">
                                    <button id="toggleButton" class="btn btn-primary">
                                        <span id="icon" class="bi bi-collection"></span> <!-- Default icon -->
                                    </button>
                                </div>

                                <div id="paginationContainer" class="col" style="display: ${not empty param.page ? 'block' : 'none'};">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-center">
                                            <c:forEach var="page" begin="1" end="${totalPages}">
                                                <li class="page-item <c:if test="${currentPage eq page}">active</c:if>">
                                                    <a class="page-link" href="?page=${page}&search=${param.search}&category=${param.category}&brand=${param.brand}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&rating=${param.rating}&order=${param.order}">${page}</a>
                                                </li>
                                            </c:forEach>
                                        </ul> 
                                    </nav>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row row-cols-4 mt-3">             
                        <c:choose>
                            <c:when test="${empty products}">
                                <div class="col-12 text-center text-muted">
                                    <p>Nothing here beside invisible clothes</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="product" items="${products}" begin="${start}" end="${end}">
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
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>


        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const stars = document.querySelectorAll('.rating-stars i');
                const ratingInput = document.getElementById('rating');
                const selectedRating = parseInt(ratingInput.value);

                // Loop through each star and fill up stars based on the selected rating
                stars.forEach((star, index) => {
                    if (index < selectedRating) {
                        star.classList.remove('bi-star');
                        star.classList.add('bi-star-fill');
                    } else {
                        star.classList.remove('bi-star-fill');
                        star.classList.add('bi-star');
                    }
                });

                // Add click event listener to stars
                stars.forEach(star => {
                    star.addEventListener('click', function () {
                        const clickedRating = parseInt(this.getAttribute('data-rating'));

                        // Fill the clicked star and unfill the others
                        stars.forEach((star, index) => {
                            if (index < clickedRating) {
                                star.classList.remove('bi-star');
                                star.classList.add('bi-star-fill');
                            } else {
                                star.classList.remove('bi-star-fill');
                                star.classList.add('bi-star');
                            }
                        });

                        // Update the value of the hidden input to the clicked rating
                        ratingInput.value = clickedRating;
                    });
                });
            });

            const sortingDropdown = document.getElementById('sortingDropdown');

            // Add event listener for change event on sorting dropdown
            sortingDropdown.addEventListener('change', function () {
                // Get the selected option value
                const selectedOrder = sortingDropdown.value;

                // Set the value of the hidden "order" input field in the filter form
                document.getElementById('order').value = selectedOrder;

                // Submit the filter form
                document.querySelector('.filter-options form').submit();
            });

            const toggleButton = document.getElementById('toggleButton');

            toggleButton.addEventListener('click', function () {
                let currentPage = new URLSearchParams(window.location.search).get('page');

                currentPage = currentPage === null ? 1 : null;
                let newURL = window.location.pathname + '?';
                if (currentPage !== null) {
                    newURL += 'page=' + currentPage + '&';
                }
                newURL += '?page=${page}&search=${param.search}&category=${param.category}&brand=${param.brand}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&rating=${param.rating}&order=${param.order}';
                window.location.href = newURL;
            });


            window.addEventListener('load', function () {
                const scrollPosition = localStorage.getItem('scrollPosition');
                if (scrollPosition !== null) {
                    window.scrollTo(0, parseInt(scrollPosition, 10));
                    localStorage.removeItem('scrollPosition'); // Clean up
                }
            });

            window.addEventListener('scroll', function () {
                localStorage.setItem('scrollPosition', window.scrollY);
            });

        </script>




        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
