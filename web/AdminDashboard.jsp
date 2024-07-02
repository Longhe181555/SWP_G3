<%-- 
    Document   : AdminDashboard
    Created on : Jun 23, 2024, 11:47:27 AM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>

            .statistic{
                display: flex;
                flex-direction: row;
                justify-content: space-around;
                margin-top: 20px;
                width: 100%;
            }
            
            .revenue{
                display: flex;
                flex-direction: row;
                justify-content: space-around;
                margin-top: 20px;
                width: 70vw;
            }

            .status , .total-ammount{
                padding: 5px;
                display: flex;
                flex-direction: row;
                background-color: white;
                border-radius: 10px;
                border: 2px solid black;
            }

            .icon{
                width: 20px;
                height: 40px;
            }

            .date-picker-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .date-picker-label {
                margin-bottom: 10px;
                font-size: 1.2em;
                color: #333;
            }

            .date-picker-input {
                padding: 10px;
                font-size: 1em;
                border: 2px solid #007bff;
                border-radius: 4px;
                outline: none;
                transition: border-color 0.3s;
            }

            .date-picker-input:focus {
                border-color: #0056b3;
            }


        </style>
    </head>
    <body>
        <div class="my-container">
            <%@include file="../admin_navbar.jsp" %>
            <div class="content">
                <input type="hidden" id="months" value='${months}' />
                <div class="statistic">
                    <div class="date-picker-container">
                        <label for="date-picker" class="date-picker-label">Select a Date:</label>
                        <input type="date" id="date-picker" class="date-picker-input" value="${date}" onchange="changeDate(this.value)">
                    </div>
                    <div class="total-ammount">
                        <div>
                            <i class="glyphicon glyphicon-stats icon"></i>
                        </div>
                        <div>
                            <h4>Tiền bán hàng</h4>
                            <p>${statistic[0]}</p>
                        </div>
                    </div>
                    <div class="status">
                        <div>
                            <i class="glyphicon glyphicon-shopping-cart icon"></i>
                        </div>
                        <div>
                            <div><h4 style="display: inline;">Đơn đặt hàng</h4> : ${totalOrder}</div>
                            <div> <h5 style="display: inline;">Xác nhận</h5> : ${statistic[1]} | <h5 style="display: inline;">Giao hàng</h5> ${statistic[2]}</div>
                        </div>
                    </div>
                </div>
                <div class="revenue">
                    <h1>Doanh thu theo tháng</h1>
                    <!-- Canvas element where the chart will be rendered -->
                    <canvas id="myChart" width="200" height="100"></canvas>
                </div>
                <script>
                    function changeDate(date) {
                        window.location.href = "dashboard?date=" + date;
                    }

                    window.onload = function () {
                        // JSON string
                        var jsonString = document.getElementById("months").value;
                        console.log(jsonString);
                        // Parse the JSON string
                        var jsonData = JSON.parse(jsonString);

                        var currentYear = new Date().getFullYear();

                        // Extract keys and values from the JSON data
                        var labels = Object.keys(jsonData).map(key => key + '/' + currentYear);
                        var data = Object.values(jsonData);

                        // Get the context of the canvas element we want to select
                        var ctx = document.getElementById('myChart').getContext('2d');

                        // Create a new chart
                        var myChart = new Chart(ctx, {
                            type: 'bar', // The type of chart we want to create
                            data: {
                                labels: labels, // The formatted labels
                                datasets: [{
                                        label: 'Values', // The label for the dataset
                                        data: data, // The data points
                                        backgroundColor: [
                                            'rgba(255, 99, 132, 0.2)',
                                            'rgba(54, 162, 235, 0.2)',
                                            'rgba(255, 206, 86, 0.2)'
                                        ],
                                        borderColor: [
                                            'rgba(255, 99, 132, 1)',
                                            'rgba(54, 162, 235, 1)',
                                            'rgba(255, 206, 86, 1)'
                                        ],
                                        borderWidth: 1
                                    }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true // Start the y-axis at 0
                                    }
                                }
                            }
                        });
                    }
                </script>
            </div>
        </div>
    </body>
</html>
