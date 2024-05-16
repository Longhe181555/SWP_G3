<%-- 
    Document   : homepage
    Created on : May 16, 2024, 12:52:35 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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

            .featured-line-top, .featured-line-bottom {
                border-color: #333;
                border-width: 1px;
            }

            .featured-text {
                margin-top: -12px;
                background-color: white;
                padding: 0 10px;
                display: inline-block;
            }

            .option {
                padding: 10px;
            }

            .option:hover {
                background-color: #f0f0f0;
                transition: background-color 0.3s ease;
            }

            .placeholder {
                background-color: #f5f5f5; /* Light gray color */
                width: 100%; /* Full width */
                height: 400px; /* Adjust height as needed */
                /* Other styles as needed */
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



        </style>
    </head>
    <body>
        <div class="header">
            <div class="header-container">
                <div class="header-options">
                    <div class="header-left"> 
                        <p> Search |</p>
                        <p>| Order history </p>    
                    </div>
                    <div class="header-right">
                        <p> My Account |</p>  
                        <p>| Checkout </p>
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
        <div class="container">
            <div class="row">
                <div class="col-10 offset-1">
                    <div class="banner-container">
                        <div class="banner-img">
                            <img src="${pageContext.request.contextPath}/img/other_picture/banner_placeholder.png" class="img-fluid" alt="Banner Image">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <hr class="featured-line-top">
                </div>
                <div class="col-md-6">
                    <hr class="featured-line-top">
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <h4 class="featured-text">FEATURED ITEM</h4>
                </div>
                <div class="col-md-6"></div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <hr class="featured-line-bottom">
                </div>
                <div class="col-md-6">
                    <hr class="featured-line-bottom">
                </div>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <div class="option">
                        All products
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="option">
                        High Price
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="option">
                        Low Price
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="option">
                        Place holder text
                    </div>
                </div>
            </div>
        </div>               

        <div class="container">
            <div class="row">
                <c:forEach var="product" items="${products}">
                    <div class="col-md-4">
                        <div class="product">
                            <img src="${pageContext.request.contextPath}${product.img}" class="img-fluid" alt="Product Image">
                        </div>
                    </div>
                </c:forEach>
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
            </div>
        </footer>

    </body>

</html>
