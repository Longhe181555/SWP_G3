<%-- 
    Document   : productfeedbacks
    Created on : Jun 10, 2024, 12:38:20 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <style>
            .product-summary .carousel-inner img {
                max-width: 100px;
                max-height: 100px;
            }
            .product-summary h2 {
                font-size: 1.25rem;
            }
            .product-summary .rating-star i {
                font-size: 0.875rem;
            }
            .product-summary p {
                margin: 0.25rem 0;
            }
            .product-summary .size-group label {
                font-size: 0.875rem;
            }
            .product-summary .color-select {
                font-size: 0.875rem;
            }
            .product-summary .font-weight-bold {
                font-size: 1rem;
            }
            .rating i {
                cursor: pointer;
                font-size: 1.5rem;
            }
            .rating i.selected {
                color: orange;
            }
            .btn-custom {
                background-color: white;
                border: 2px solid green;
                color: green;
                display: block;
                text-align: center;
                padding: 10px;
                text-decoration: none;
                width: 100%;
            }
            .btn-custom:hover {
                background-color: green;
                color: white;
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
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
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



    <div class="container product_summary mt-5">
        <div class="container"><button onclick="goBack()" style="margin-bottom: 20px">Back</button>
            <c:if test="${not empty product}">
                <div class="row align-items-center">
                    <div class="col-md-2">
                        <div id="productCarouselSummary" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner">
                                <c:forEach var="img" items="${product.productimgs}" varStatus="loop">
                                    <div class="carousel-item <c:if test='${loop.index == 0}'>active</c:if>">
                                        <img src="${pageContext.request.contextPath}/${img.imgpath}" class="d-block w-100" alt="Product Image">
                                    </div>
                                </c:forEach>
                            </div>
                            <a class="carousel-control-prev" href="#productCarouselSummary" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next" href="#productCarouselSummary" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-10">
                        <h2>${product.pname}</h2>
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
                        <p class="font-weight-bold">${product.price}d</p>
                        <div class="size-dropdowns">
                            <c:forEach var="entry" items="${groupedBySize}">
                                <div class="size-group">
                                    <label>${entry.key}</label>
                                    <select class="color-select">
                                        <c:forEach var="pi" items="${entry.value}">
                                            <option value="${pi.color}" style="background-color: ${pi.color}; color: #000;">
                                                ${pi.color} (${pi.stockcount})
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </c:forEach>
                        </div>                  
                        <p>${product.description}</p>
                        <p><strong>Brand:</strong> ${product.brand.bname}</p>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty product}">
                <p>Product not found.</p>
            </c:if>

            <hr/>
            <div class="container mt-5">
                <h1>Give Product Feedback</h1>
                <form id="feedbackForm" action="givefeedback" method="post" onsubmit="return validateForm()">
                    <div class="form-group">
                        <label for="rating">Rating</label>
                        <div class="rating">
                            <span class="rating-stars" style="color:orange">
                                <c:forEach var="i" begin="1" end="5">
                                    <i class="bi bi-star" data-rating="${i}" onclick="setRating(${i})"></i>
                                </c:forEach>
                            </span>
                            <input type="hidden" class="form-control" id="rating" name="rating" value="">
                        </div>
                        <span id="ratingError" style="color: red; display: none;">Please fill in star rating</span>
                        <span id="feedbackError" style="color: red; display: none;">Please fill in feedback</span>
                    </div>
                    <div class="form-group">
                        <label for="feedback">Feedback</label>
                        <textarea class="form-control" id="feedback" name="feedback" rows="4" required></textarea>
                    </div>
                    <input type="hidden" name="pid" value="${product.pid}">
                    <button type="submit" class="btn btn-custom" id="submitButton">Give feedback</button>
                </form>
            </div>
            <hr/>




        </div>
        <div class="container">
            <h3 class="mt-5">Product Feedback</h3>
            <c:forEach var="feedback" items="${fs}">
                <div class="card mt-3">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/${feedback.account.img}" alt="Profile Image" style="border-radius: 50%; width: 40px; height: 40px;" class="mr-3">
                                <div>
                                    <h5 class="card-title d-inline">${feedback.account.fullname}</h5>
                                    <span class="card-text ml-3 rating-stars-fixed" style="color:orange">
                                        <c:forEach var="i" begin="1" end="5">
                                            <c:choose>
                                                <c:when test="${i <= feedback.rating}">
                                                    <i class="bi bi-star-fill"></i>
                                                </c:when>
                                                <c:when test="${i > feedback.rating && i - 1 < feedback.rating}">
                                                    <i class="bi bi-star-half"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </span>
                                </div>
                            </div>
                            <div>
                                <span class="card-text"><small class="text-muted">Date: ${feedback.date}</small></span>
                            </div>
                        </div>
                        <p class="card-text mt-2">${feedback.comment}</p>
                    </div>
                </div>
            </c:forEach>
        </div>    



    </div>
    <script>


        function goBack() {
            window.history.back();
        }

        document.addEventListener('DOMContentLoaded', function () {
            const stars = document.querySelectorAll('.rating-stars i');
            const ratingInput = document.getElementById('rating');
            let selectedRating = parseFloat(ratingInput.value);

            function updateStars(newRating) {
                stars.forEach((star, index) => {
                    const starValue = index + 1; // Stars are 1-indexed
                    if (starValue <= newRating) {
                        star.classList.remove('bi-star');
                        star.classList.add('bi-star-fill');
                    } else {
                        star.classList.remove('bi-star-fill');
                        star.classList.add('bi-star');
                    }
                    if (starValue - 0.5 === newRating) { // Check for half-star
                        star.classList.remove('bi-star');
                        star.classList.add('bi-star-half');
                    } else {
                        star.classList.remove('bi-star-half');
                    }
                });
                ratingInput.value = newRating;
            }

            updateStars(selectedRating);

            function isCloserToCenter(clickX, starWidth) {
                const center = starWidth / 2;
                return clickX < center;
            }

            stars.forEach(star => {
                star.addEventListener('click', function (event) {
                    const clickedRating = parseFloat(this.getAttribute('data-rating'));
                    const clickX = event.clientX - this.getBoundingClientRect().left;
                    const starWidth = this.offsetWidth;
                    const isCloser = isCloserToCenter(clickX, starWidth);

                    let newRating;
                    if (isCloser) {
                        newRating = clickedRating - 0.5;
                    } else {
                        newRating = Math.ceil(clickedRating);
                    }
                    updateStars(newRating);
                });
            });
        });




        function validateForm() {
            // Rating validation
            const ratingInput = document.getElementById('rating');
            const rating = parseFloat(ratingInput.value);
            const ratingError = document.getElementById('ratingError');
            let isValid = true;

            if (isNaN(rating) || rating === 0) {
                ratingError.style.display = 'block';
                isValid = false;
            } else {
                ratingError.style.display = 'none';
            }

            // Feedback textarea validation
            const feedback = document.getElementById('feedback').value.trim();
            const feedbackError = document.getElementById('feedbackError');

            if (feedback === "") {
                feedbackError.style.display = 'block';
                isValid = false;
            } else {
                feedbackError.style.display = 'none';
            }

            return isValid;
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
