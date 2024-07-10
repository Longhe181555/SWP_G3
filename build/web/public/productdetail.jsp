<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Details</title>
        <style>
            .color-option {
                display: inline-block;
                cursor: pointer;
                padding: 1px;
                border-radius: 0;
                border: 2px solid white;
            }

            .color-option.selected {
                border-color: black;
            }

            .color-square {
                width: 40px;
                height: 40px;
                display: inline-block;
                border: 1px solid black;
                opacity: 0.6;
            }


            .size-option.selected {
                border-color: black;
                border-width: 2px;
                border-style: solid;
                box-shadow: 0 0 3px rgba(0, 0, 0, 0.5);
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
            .original-price {
                text-decoration: line-through;
            }


            .discounted-price {
                color: red;
            }
            .size-option {
                position: relative;
                padding: 10px;
                margin: 5px;
                border: 1px solid #ccc;
                cursor: pointer;
                display: inline-block;
            }

            .discount-indicator {
                position: absolute;
                top: 0;
                right: 0;
                background-color: yellow;
                color: black;
                font-size: 7px;
                padding: 2px 5px;
                border-radius: 3px;
            }
            .price-container {
                display: flex;
                align-items: center;
            }
            .price-container p {
                margin-right: 10px;


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
                                <div class="price-container">
                                    <p class="font-weight-bold" id="originalPrice"><fmt:formatNumber value="${product.price}" type="number" pattern="#,###" /> VND</p>
                                    <p class="font-weight-bold" id="discountedPrice"></p>
                                </div>
                                <div class="color-dropdowns">
                                    <div id="colorOptions">
                                        <c:forEach var="entry" items="${groupedByColor}">
                                            <div class="color-option" data-color="${entry.key}" onclick="selectColor(this)" style="height: 45px;
                                            width:45px">
                                                <div class="color-square" style="background-color: ${entry.key};"></div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div id="sizeOptions">
                                    <c:forEach var="entry" items="${groupedByColor}">
                                        <div class="size-options" data-color="${entry.key}" style="display: none;">
                                            <c:set var="allSizes" value="${['S', 'M', 'L', 'XL']}"/>
                                            <c:forEach var="size" items="${allSizes}">
                                                <c:set var="found" value="false"/>
                                                <c:forEach var="pi" items="${entry.value}">
                                                    <c:if test="${pi.size == size}">
                                                        <div class="size-option" data-size="${pi.size}" data-stock="${pi.stockcount}" onclick="selectSize(this)">
                                                            ${pi.size} <span class="stock-count">(${pi.stockcount})</span>
                                                            <c:if test="${pi.discount != null}">
                                                                <span class="discount-indicator">discounted</span>
                                                            </c:if>
                                                        </div>
                                                        <c:set var="found" value="true"/>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${!found}">
                                                    <div class="size-option" style="text-decoration: line-through;
                                                         color: #ccc;
                                                         cursor: not-allowed;">
                                                        ${size} <span class="stock-count">(0)</span>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </c:forEach>
                                </div>



                            </div>
                            <div class="quantity-input">
                                <label for="quantity">Quantity:</label>
                                <input type="number" id="quantity" name="quantity" min="1" value="1" required>
                            </div>
                            <button class="" onclick="addToCart()" style="width: 100px;
                                    height: 30px;
                                    margin-top: 20px">Add to Cart</button>
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
                                        <img src="${pageContext.request.contextPath}/${feedback.account.img}" alt="Profile Image" style="border-radius: 50%;
                                        width: 40px;
                                        height: 40px;" class="mr-3">
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





                function goBack() {
                    window.history.back();
                }

                function selectColor(colorOption) {
                    var colorOptions = document.querySelectorAll('.color-option');
                    colorOptions.forEach(function (option) {
                        option.classList.remove('selected');
                    });
                    colorOption.classList.add('selected');

                    var selectedColor = colorOption.getAttribute('data-color');
                    var sizeOptions = document.querySelectorAll('.size-options');
                    sizeOptions.forEach(function (option) {
                        if (option.getAttribute('data-color') === selectedColor) {
                            option.style.display = 'block';
                        } else {
                            option.style.display = 'none';
                        }
                    });

                    // Select the first available size option that is not crossed out
                    var firstAvailableSizeOption = document.querySelector('.size-options[data-color="' + selectedColor + '"] .size-option:not([style*="text-decoration: line-through;"]');
                    if (firstAvailableSizeOption) {
                        firstAvailableSizeOption.click();
                    }
                }


                function selectSize(sizeOption) {
                    var sizeOptions = document.querySelectorAll('.size-option');
                    sizeOptions.forEach(function (option) {
                        option.classList.remove('selected');
                    });
                    sizeOption.classList.add('selected');
                    var selectedColorOption = document.querySelector('.color-option.selected');
                    if (selectedColorOption) {
                        var selectedColor = selectedColorOption.getAttribute('data-color');
                        var selectedSize = sizeOption.getAttribute('data-size');
                        updateDiscountedPrice(selectedSize, selectedColor);
                    }

                }

                function addToCart() {
                    var selectedColorOption = document.querySelector('.color-option.selected');
                    var selectedSizeOption = document.querySelector('.size-option.selected');
                    var quantity = document.getElementById('quantity').value;

                    if (!selectedColorOption) {
                        alert('Please select a color.');
                        return;
                    }

                    if (!selectedSizeOption) {
                        alert('Please select a size.');
                        return;
                    }

                    var selectedColor = selectedColorOption.getAttribute('data-color');
                    var selectedSize = selectedSizeOption.getAttribute('data-size');
                    var piid = selectedSizeOption.getAttribute('data-piid');

                    // AJAX request to add to cart
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "AddToCartController", true);
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                            if (xhr.status === 200) {
                                alert('Product added to cart');
                                location.reload();
                            } else {
                                alert('Failed to add to cart');
                            }
                        }
                    };
                    xhr.send("action=addToCart&piid=" + piid + "&quantity=" + quantity);
                }
                window.onload = function () {
                    var firstColorOption = document.querySelector('.color-option');
                    if (firstColorOption) {
                        firstColorOption.click();
                    }

                    var firstAvailableSizeOption = document.querySelector('.size-option:not([style*="display: none;"])');
                    if (firstAvailableSizeOption) {
                        firstAvailableSizeOption.click();

                    }
                };
                function updateDiscountedPrice(size, color) {
                    var pid = ${product.pid};
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "ProductDetailController", true);
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                            var response = JSON.parse(xhr.responseText);
                            var discountedPrice = response.discountedPrice;
                            var value = response.value;
                            var piid = response.piid;
                            var originalPriceElement = document.getElementById('originalPrice');
                            var discountedPriceElement = document.getElementById('discountedPrice');
                            var originalPrice = ${product.price};
                            var isDiscounted = discountedPrice < originalPrice;
                               
                            var formattedPrice = discountedPrice.toLocaleString('en-US', {
                             style: 'currency',
                             currency: 'VND'
                                });   
                               
                            if (isDiscounted) {
                                originalPriceElement.classList.add('original-price');
                                discountedPriceElement.textContent = 'Discount ' + value + '% off: ' + formattedPrice;
                                discountedPriceElement.classList.add('discounted-price');
                            } else {
                                originalPriceElement.classList.remove('original-price');
                                discountedPriceElement.textContent = '';
                                discountedPriceElement.classList.remove('discounted-price');
                            }


                            var sizeOption = document.querySelector('.size-option.selected');
                            if (sizeOption) {
                                var currentPIID = sizeOption.getAttribute('data-piid');
                                if (currentPIID !== piid) {
                                    sizeOption.setAttribute('data-piid', piid);
                                }
                            }
                        }
                    };
                    xhr.send("action=updateDiscountedPrice&pid=" + pid + "&size=" + size + "&color=" + color);
                }

            </script>
        </body>
    </html>
