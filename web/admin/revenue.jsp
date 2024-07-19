<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Revenue Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .chart-container {
            width: 100%; /* Adjust width to fit column */
            height: 400px;
            margin-bottom: 20px;
        }
        .small-chart-container {
            width: 100%; /* Adjust width to fit column */
            height: 300px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="mt-4">Revenue Dashboard</h1>
    <%@ include file="../public/navbar.jsp" %>

    <div class="row">
        <div class="col-6">
            <div class="chart-container">
                <h2>Monthly Revenue</h2>
                <canvas id="monthlyRevenueChart"></canvas>
            </div>
            <div class="chart-container">
                <h2>Yearly Revenue</h2>
                <canvas id="yearlyRevenueChart"></canvas>
            </div>
            <div class="row">
                <div class="col-6">
                    <div class="small-chart-container">
                        <h3>Revenue for This Month: <fmt:formatNumber value="${totalMonthRevenue}" pattern="#,##0"/> VND</h3>
                        <canvas id="weeklyPieChart"></canvas>
                    </div>
                </div>
                <div class="col-6">
                    <div class="small-chart-container">
                        <h3>Weekly Revenue</h3>
                        <canvas id="weeklyColumnChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-6">
            <h1 class="mt-4">Top Buyers</h1>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                <tr>
                    <th>Full Name</th>
                    <th>Revenue</th>
                    <th>Number of Orders</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="buyer" items="${topbuyer}">
                    <tr>
                        <td>${buyer.fullname}</td>
                        <td>${buyer.status}</td>
                        <td>${buyer.email}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies (jQuery and Popper.js) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var monthlyCtx = document.getElementById('monthlyRevenueChart').getContext('2d');
        var yearlyCtx = document.getElementById('yearlyRevenueChart').getContext('2d');
        var weeklyPieCtx = document.getElementById('weeklyPieChart').getContext('2d');
        var weeklyColumnCtx = document.getElementById('weeklyColumnChart').getContext('2d');

        var monthlyRevenueChart = new Chart(monthlyCtx, {
            type: 'bar',
            data: {
                labels: JSON.parse('<%= request.getAttribute("monthlyLabelsJson") %>'),
                datasets: [{
                    label: 'Revenue (VND)',
                    data: JSON.parse('<%= request.getAttribute("monthlyRevenueJson") %>'),
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    }
                }
            }
        });

        var yearlyRevenueChart = new Chart(yearlyCtx, {
            type: 'line',
            data: {
                labels: JSON.parse('<%= request.getAttribute("yearlyLabelsJson") %>'),
                datasets: [{
                    label: 'Revenue (VND)',
                    data: JSON.parse('<%= request.getAttribute("yearlyRevenueJson") %>'),
                    backgroundColor: 'rgba(255, 206, 86, 0.2)',
                    borderColor: 'rgba(255, 206, 86, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    }
                }
            }
        });

        var weeklyPieChart = new Chart(weeklyPieCtx, {
            type: 'pie',
            data: {
                labels: JSON.parse('<%= request.getAttribute("weeklyLabelsJson") %>'),
                datasets: [{
                    label: 'Revenue (VND)',
                    data: JSON.parse('<%= request.getAttribute("weeklyRevenueJson") %>'),
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    }
                }
            }
        });

        var weeklyColumnChart = new Chart(weeklyColumnCtx, {
            type: 'bar',
            data: {
                labels: JSON.parse('<%= request.getAttribute("weeklyLabelsJson") %>'),
                datasets: [{
                    label: 'Revenue (VND)',
                    data: JSON.parse('<%= request.getAttribute("weeklyRevenueJson") %>'),
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    }
                }
            }
        });
    });
</script>
</body>
</html>
