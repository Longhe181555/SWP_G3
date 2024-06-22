<%-- 
    Document   : productdetail
    Created on : May 22, 2024, 10:30:02 AM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>

            .placeholder{
                height: 64px;
            }
            .rating-stars {
                color: gold;
            }

            .color-option.selected .color-square {
                border-color: red;
            }
            .color-option {
                display: inline-block;
                margin: 5px;
                cursor: pointer;
            }
            .color-square {
                width: 40px;
                height: 40px;
                display: inline-block;
                margin-right: 5px;
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
        </style>
    </head>
    <body>
        <%@ include file="navbar.jsp" %>
    <div class="container product_detail mt-5">
        <h1>Product Details</h1>
        <button onclick="goBack()" style="margin-bottom: 20px">Back</button>
        <c:if test="${not empty product}">
            <div class="row">
                <div class="col-md-6">
                    <div id="productCarousel" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <c:forEach var="img" items="${product.productimgs}" varStatus="loop">
                                <div class="carousel-item <c:if test='${loop.index == 0}'>active</c:if>">
                                    <img src="${pageContext.request.contextPath}/${img.imgpath}" class="d-block w-100" alt="Product Image">
                                </div>
                            </c:forEach>
                        </div>
                        <a class="carousel-control-prev" href="#productCarousel" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#productCarousel" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>
                <div class="col-md-6">
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
                    <c:if test="${Account.role == 'staff'}">
                        <button type="button" class="btn btn-primary" onclick="location.href = 'updateProduct'">Update Product</button>
                        <button type="button" class="btn btn-secondary" onclick="location.href = 'updateProductStock'">Update Product Stock</button>
                    </c:if>
                    <p class="font-weight-bold">${product.price}d</p>
                    <div class="size-dropdowns">
                        <select class="size-select" onchange="toggleColorOptions(this)">
                            <option value="">Select Size</option>
                            <c:forEach var="entry" items="${groupedBySize}">
                                <option value="${entry.key}">${entry.key}</option>
                            </c:forEach>
                        </select>

                        <c:forEach var="entry" items="${groupedBySize}">
                            <div class="color-options" data-size="${entry.key}" style="display: none;">
                                <c:forEach var="pi" items="${entry.value}">
                                    <div class="color-option" data-color="${pi.color}" data-stock="${pi.stockcount}" onclick="selectColor(this)">
                                        <div class="color-square" style="background-color: ${pi.color}; border: 1px solid black;"></div>
                                        <span class="stock-count" style="font-size:10px">(${pi.stockcount})</span>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:forEach>
                    </div>                 
                    <p>${product.description}</p>
                    <p><strong>Brand:</strong> ${product.brand.bname}</p>
                    <c:if test="${Account.role == 'staff'|| Account.role == 'admin'}">
                        <button type="button" class="btn btn-primary" onclick="location.href = 'updateProduct?pid=${product.pid}'">Update Product</button>
                        <button type="button" class="btn btn-secondary" onclick="location.href = 'updateProductStock'">Update Product Stock</button>
                    </c:if>
                </div>
            </div>
        </c:if>
        <c:if test="${empty product}">
            <p>Product not found.</p>
        </c:if>

    </div>

    <div class="container">
        <h3 class="mt-5">Recent Feedback</h3>
        <c:forEach var="feedback" items="${fs}">
            <div class="card mt-3">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center">
                            <img src="${pageContext.request.contextPath}/${feedback.account.img}" alt="Profile Image" style="border-radius: 50%; width: 40px; height: 40px;" class="mr-3">
                            <div>
                                <h5 class="card-title d-inline">${feedback.account.fullname}</h5>
                                <span class="card-text ml-3 rating-stars">
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
    <div class="container mt-5">
        <a href="feedback?pid=${product.pid}" class="btn-custom">See all feedbacks</a>
    </div>



    <script>
        // Function to navigate back to the previous page
        function goBack() {
            window.history.back();
        }
        function toggleColorOptions(select) {
            var size = select.value;
            var colorOptions = document.querySelectorAll('.color-options');
            colorOptions.forEach(function (option) {
                if (option.getAttribute('data-size') === size) {
                    option.style.display = 'block';
                } else {
                    option.style.display = 'none';
                }
            });
        }

        function selectColor(colorOption) {
            var colorOptions = colorOption.parentElement.querySelectorAll('.color-option');
            colorOptions.forEach(function (option) {
                option.classList.remove('selected');
            });
            colorOption.classList.add('selected');
        }
    </script>


</body>
</html>
