<%-- 
    Document   : navbar
    Created on : Jun 21, 2024, 8:20:13 AM
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
        <style>
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
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>                
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
