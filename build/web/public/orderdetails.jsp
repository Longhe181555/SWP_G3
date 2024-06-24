<%-- 
    Document   : orderdetails
    Created on : Jun 24, 2024, 12:29:12 PM
    Author     : duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Details</title>
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
                text-align: center;
            }
            h1 {
                color: #333;
            }
            .order-details {
                margin-top: 20px;
                text-align: left;
            }
            .btn-back-home {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #007BFF;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .btn-back-home:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Order Details</h1>
            <div class="order-details">
                <p><strong>Order ID:</strong> ${order.orid}</p>
                <p><strong>AID:</strong> ${order.aid}</p>
                <p><strong>Date:</strong> ${order.date}</p>
                <p><strong>Description:</strong> ${order.description}</p>
                <p><strong>Status:</strong> ${order.status}</p>
                <p><strong>PMID:</strong> ${order.pmid}</p>
            </div>
            <a href="/home" class="btn-back-home">Back Home</a>
        </div>
    </body>
</html>

