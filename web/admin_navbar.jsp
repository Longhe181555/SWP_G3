<%-- 
    Document   : admin_navbar
    Created on : Jul 2, 2024, 11:06:11 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }

            .my-container {
                display: flex;
                height: 100vh;
                padding: 0;
                margin: 0;
            }

            .navbar {
                width: 200px;
                background-color: #333;
                display: flex;
                flex-direction: column;
                padding-top: 20px;
                justify-content: normal;
                margin-bottom: 0;
                padding-top: 0;
            }

            .navbar a {
                padding: 15px 20px;
                text-decoration: none;
                font-size: 18px;
                color: white;
                width: 100%;
                display: block;
                text-align: center;
            }

            .navbar a:hover {
                background-color: #575757;
            }

            .content {
                flex-grow: 2;
                padding: 10px;
                background-color: #f1f1f1;
            }

            .highlight {
                background-color: #4CAF50 !important; /* Green background */
            }

        </style>
    </head>
    <body>
        <div class="navbar">
            <a href="${pageContext.request.contextPath}/dashboard" id="dashboardLink">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin-customer-account" id="staffManagementLink">Customer Management</a>
            <a href="${pageContext.request.contextPath}/admin-staff-account" id="customerManagementLink">Staff Management</a>
        </div>
    </body>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var currentURL = window.location.href;
            var dashBoardLink = document.getElementById("dashboardLink");
            var staffManagementLink = document.getElementById("staffManagementLink");
            var customerManagementLink = document.getElementById("customerManagementLink");
            if(currentURL.includes("/dashboard")){
                dashBoardLink.classList.add("highlight");
            }else if(currentURL.includes("/admin-customer-account")){
                staffManagementLink.classList.add("highlight");
            }else if(currentURL.includes("/admin-staff-account")){
                customerManagementLink.classList.add("highlight");
            }
        });
    </script>
</html>
