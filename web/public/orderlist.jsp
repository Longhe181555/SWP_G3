<%-- 
    Document   : orderlist
    Created on : Jun 24, 2024, 9:28:12 AM
    Author     : duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .no-orders {
            text-align: center;
            color: #666;
            margin-top: 20px;
        }the
        .btn-back-home:hover {
            background-color: #0056b3;
        }
    </style>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order List</title>
    </head>
    <body>
        <h1>Pending Orders</h1>
        <c:if test="${empty orders}">
            <p>No pending orders found.</p>
        </c:if>
        <c:if test="${not empty orders}">
            <table border="1">
                <tr>
                    <th>Order ID</th>
                    <th>AID</th>
                    <th>Date</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>PMID</th>
                </tr>
                <c:forEach var="order" items="${requestScope.orders}">
                    <tr>
                        <td>${order.getOrid()}</td>
                        <td>${order.getAid()}</td>
                        <td>${order.getDate()}</td>
                        <td>${order.getDescription()}</td>
                        <td>${order.getStatus()}</td>
                        <td>${order.getPmid()}</td>
                        <td><a href="public/orderdetails.jsp?orderId=${order.getOrid()}" class="details-link">View Details</a></td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
             <a href="public/homepage.jsp" class="btn-back-home">Back Home</a>
    </body>
</html>
