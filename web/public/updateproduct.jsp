<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <title>Update Product</title>
        <style>

            * {
                margin: 0;
                padding: 0;
            }
            .header-container{
                padding: 10px 0px;
                width: 100%;
                background-color: black;
                color: white;
            }
            .header-content{
                padding-top: 5px;
                padding-bottom: 10px;
                text-align: center;
                font-size: 25px;
                font-family: "Arial", sans-serif;
            }
            .header-right,.header-left{
                font-family: "Arial", sans-serif;
                display:flex;
                color:white;
            }

            .header-options{
                display:flex;
                justify-content: space-around;
            }
            .nav-bar {
                background-color: #f5f5f5;
                padding: 10px;
                display: flex;
                justify-content: center;
            }

            .nav-option {
                padding: 8px 16px;
                margin: 0 10px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .nav-option{
                color:#666666;
                font-family: "Arial", sans-serif;
                font-weight: bold;
            }
            .nav-option:hover {
                background-color: #e0e0e0;
            }
            .nav-option.active {
                text-decoration: underline; /* Underline the active option */
            }
            .header-link:hover {
                color: #ffcc00; /* Change to any color you like */
                text-shadow: 0 0 10px rgba(255, 204, 0, 0.5); /* Adjust glow effect */
            }
            .header-link {
                margin: 0 10px;
                color: white;
                text-decoration: none;
                cursor: pointer;
                transition: color 0.3s ease, text-shadow 0.3s ease;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="header-container">
                <div class="header-options">
                    <div class="header-left"> 
                        <p class="header-link">Search </p>||
                        <p class="header-link"> Order history</p>    
                    </div>
                    <div class="header-right">
                        <a href="account" class="header-link">My Account</a>||  
                        <p class="header-link"> Checkout</p>||
                        <a href="logout" class="header-link">Logout</a>
                    </div>
                </div>
            </div>
            <div class="header-container">
                <div class="header-content">
                    <p>MEN'S WEAR</p>
                </div>
            </div> 
        </div>
        <div class="nav-bar">
            <div class="nav-option ${param.nav == 'homepage' ? 'active' : ''}" data-nav-option="homepage" onclick="goToHomepage()">HOME</div>
        </div>

        <div class="container product_detail mt-5">
            <h1>Update Product</h1>
            <c:if test="${not empty product}">
                <form action="updateproduct" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="pid" value="${product.pid}">
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
                            <div class="form-group mt-3">
                                <label for="images">Update Images:</label>
                                <input type="file" name="images" multiple class="form-control-file" id="images">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="pname">Product Name:</label>
                                <input type="text" class="form-control" id="pname" name="pname" value="${product.pname}">
                            </div>
                            <div class="form-group">
                                <label for="price">Price:</label>
                                <input type="text" class="form-control" id="price" name="price" value="${product.price}">
                            </div>
                            <div class="form-group">
                                <label for="description">Description:</label>
                                <textarea class="form-control" id="description" name="description" rows="3">${product.description}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="brand">Brand:</label>
                                <select class="form-control" id="brand" name="brand">
                                    <c:forEach var="brand" items="${brands}">
                                        <option value="${brand.bid}" <c:if test="${brand.bid == product.brand.bid}">selected</c:if>>${brand.bname}</option>
                                    </c:forEach>
                                </select>
                            </div>
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
            function goToHomepage() {
                window.location.href = '<%= request.getContextPath() %>/homepage';
            }
        </script>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>
