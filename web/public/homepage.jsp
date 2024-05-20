<%-- 
    Document   : homepage
    Created on : May 16, 2024, 12:52:35 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dal.ProductImgDBContext" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
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

            .banner-container {
                width: calc(100% - 20px);
                margin: 10px;
            }

            .banner-img {
                width: 100%;

            }

            .banner-img img {
                width: 100%;
            }

            .option {
                color: #777777; /* Default color */
                text-decoration: none; /* Remove underline */
                transition: color 0.3s; /* Smooth color transition */
            }

            .option:hover {
                color: #333333; /* Darker shade on hover */
            }

            .selected {
                font-weight: bold; /* Bold font for selected option */
                text-decoration: underline; /* Underline for selected option */
            }

            .placeholder {
                background-color: #f5f5f5; /* Light gray color */
                width: 100%; /* Full width */
                height: 200px; /* Adjust height as needed */
                /* Other styles as needed */
            }

            .custom-dropdown {
                border: none; /* Remove border */
                border-radius: 5px; /* Add some border-radius for rounded corners */
                background-color: #ffffff; /* Set background color */
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1); /* Add a faint box-shadow */
                padding: 5px 10px; /* Add padding */
                outline: none; /* Remove default focus outline */
            }

            .custom-dropdown option {
                padding: 5px 10px; /* Add padding to dropdown options */
                border: none; /* Remove border */
                border-radius: 5px; /* Add some border-radius for rounded corners */
                background-color: #ffffff; /* Set background color */
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1); /* Add a faint box-shadow */
            }

            .custom-dropdown:focus {
                outline: none; /* Remove default focus outline */
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
                min-height: 300px; /* Adjust the height as needed */
                margin-bottom: 10px; /* Add space below each product box */
            }
            .product img {
                max-width: 100%;
                max-height: 100%;
                object-fit: cover; /* Ensures the image covers the entire box */
            }
            .product-body {
                padding: 10px; /* Add padding to the product body */
            }
            .product:hover {
                background-color: #f2f2f2; /* Slightly dark gray */
                cursor: pointer;
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
            <div class="nav-option ${param.nav == 'homepage' ? 'active' : ''}" data-nav-option="homepage">HOME</div>
            <div class="nav-option ${param.nav == 'option2' ? 'active' : ''}" data-nav-option="option2">OPTION 2</div>
            <div class="nav-option ${param.nav == 'option3' ? 'active' : ''}" data-nav-option="option3">OPTION 3</div>
            <div class="nav-option ${param.nav == 'option4' ? 'active' : ''}" data-nav-option="option4">OPTION 4</div>
            <div class="nav-option ${param.nav == 'option5' ? 'active' : ''}" data-nav-option="option5">OPTION 5</div>
        </div>

        <div class="row" id="pagination-section"></div>

        <div class="container">
            <div class="row">
                <div class="col-10 offset-1">
                    <div class="banner-container">
                        <div class="banner-img">
                            <img src="${pageContext.request.contextPath}/img/other_picture/banner.png" class="img-fluid" alt="Banner Image">
                        </div>
                    </div>
                </div>
            </div>
        </div>





        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <a href="?sort=all<%= request.getParameter("page") != null ? "&page=" + request.getParameter("page") : "" %><%= request.getParameter("filter") != null ? "&filter=" + request.getParameter("filter") : "" %>" class="option <%= (request.getParameter("sort") == null || "all".equals(request.getParameter("sort"))) ? "selected" : "" %>">All products</a>
                </div>
                <div class="col-md-3">
                    <a href="?sort=desc<%= request.getParameter("page") != null ? "&page=" + request.getParameter("page") : "" %><%= request.getParameter("filter") != null ? "&filter=" + request.getParameter("filter") : "" %>" class="option <%= "desc".equals(request.getParameter("sort")) ? "selected" : "" %>">High price</a>
                </div>
                <div class="col-md-3">
                    <a href="?sort=asc<%= request.getParameter("page") != null ? "&page=" + request.getParameter("page") : "" %><%= request.getParameter("filter") != null ? "&filter=" + request.getParameter("filter") : "" %>" class="option <%= "asc".equals(request.getParameter("sort")) ? "selected" : "" %>">Low price</a>
                </div>
                <div class="col-md-3">
                    <div class="filter-option">
                        <span>Filter by:</span>
                        <select id="filterDropdown" onchange="applyFilter()" class="custom-dropdown">
                            <option value="?<%= request.getParameter("sort") != null ? "sort=" + request.getParameter("sort") : "" %><%= request.getParameter("page") != null ? "&page=" + request.getParameter("page") : "" %>"
                                    <%= (request.getParameter("filter") == null || "all".equals(request.getParameter("filter"))) ? "selected" : "" %>>All</option>
                            <option value="?filter=shirt<%= request.getParameter("sort") != null ? "&sort=" + request.getParameter("sort") : "" %><%= request.getParameter("page") != null ? "&page=" + request.getParameter("page") : "" %>"
                                    <%= "shirt".equals(request.getParameter("filter")) ? "selected" : "" %>>Shirt</option>
                            <option value="?filter=pant<%= request.getParameter("sort") != null ? "&sort=" + request.getParameter("sort") : "" %><%= request.getParameter("page") != null ? "&page=" + request.getParameter("page") : "" %>"
                                    <%= "pant".equals(request.getParameter("filter")) ? "selected" : "" %>>Pant</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>


        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <c:if test="${activePage > 1}">
                        <a href="?page=${activePage - 1}&sort=${param.sort}&filter=${param.filter}" class="btn btn-primary">Previous</a>
                    </c:if>
                    <c:forEach var="page" begin="1" end="${productpaged.size()}">
                        <c:if test="${activePage == page}">
                            <span class="btn btn-secondary">${page}</span>
                        </c:if>
                        <c:if test="${activePage != page}">
                            <a href="?page=${page}&sort=${param.sort}&filter=${param.filter}" class="btn btn-primary">${page}</a>
                        </c:if>
                    </c:forEach>
                    <c:if test="${activePage < productpaged.size()}">
                        <a href="?page=${activePage + 1}&sort=${param.sort}&filter=${param.filter}" class="btn btn-primary">Next</a>
                    </c:if>
                </div>
            </div>
        </div>


        <div class="container product-container">
            <div class="row">
                <c:forEach var="productPage" items="${productpaged}" varStatus="pageLoop">
                    <c:if test="${pageLoop.index + 1 == activePage}"> <!-- activePage should match page index + 1 -->
                        <c:forEach var="product" items="${productPage}" varStatus="productLoop">
                            <div class="col-md-3">
                                <div class="product card" onclick="openProductDetails('${product.pname}', '${product.price}', '${product.description}', '${pageContext.request.contextPath}/${product.productimgs[0].getImgpath()}')">
                                    <img src="${pageContext.request.contextPath}/${product.productimgs[0].getImgpath()}" class="card-img-top img-fluid" alt="${product.pname}" style="max-width: 100%; max-height: 200px;">
                                    <div class="card-body">
                                        <h5 class="card-title">${product.pname}</h5>
                                        <p class="card-text">${product.price}d</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <c:if test="${activePage > 1}">
                        <a href="?page=${activePage - 1}&sort=${param.sort}&filter=${param.filter}" class="btn btn-primary">Previous</a>
                    </c:if>
                    <c:forEach var="page" begin="1" end="${productpaged.size()}">
                        <c:if test="${activePage == page}">
                            <span class="btn btn-secondary">${page}</span>
                        </c:if>
                        <c:if test="${activePage != page}">
                            <a href="?page=${page}&sort=${param.sort}&filter=${param.filter}" class="btn btn-primary">${page}</a>
                        </c:if>
                    </c:forEach>
                    <c:if test="${activePage < productpaged.size()}">
                        <a href="?page=${activePage + 1}&sort=${param.sort}&filter=${param.filter}" class="btn btn-primary">Next</a>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="placeholder"></div>

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

            function scrollToPagination() {
                const paginationSection = document.getElementById('pagination-section');
                if (paginationSection) {
                    paginationSection.scrollIntoView({behavior: 'instant'});
                }
            }

            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                const pageParam = urlParams.get('page');
                const path = window.location.pathname; // Get the current URL path

                // Check if the path is NOT exactly "/homepage" and if the pageParam exists and is not equal to '1'
                if (path !== '/homepage' && pageParam) {
                    scrollToPagination();
                }
            };

            function openProductDetails(name, price, description, imgPath) {
                // Update modal content with product details
                document.getElementById('productName').innerText = name;
                document.getElementById('productPrice').innerText = "Price: " + price + "d";
                document.getElementById('productDescription').innerText = "Description: " + description;
                document.getElementById('productImg').src = imgPath;

                // Show the modal
                $('#productModal').modal('show');
            }




        </script>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>

</html>
