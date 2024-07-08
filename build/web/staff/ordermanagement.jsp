<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Order Management</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css" rel="stylesheet">
    <style>
        .status-pending {
            color: orange;
        }
        .status-confirmed {
            color: darkgreen;
        }
        .status-shipping {
            color: blue;
        }
        .status-shipped {
            color: green;
        }
        .status-rejected, .status-cancelled {
            color: darkred;
        }
    </style>
</head>
<body>
<%@ include file="../public/navbar.jsp" %>

<div class="container">
    <h2 style="text-align: center;">Order Management</h2>

    <table id="order-management-table" class="table table-striped">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Total Price</th>
            <th>Product Amount</th>
            <th>Created Date</th>
            <th>Status</th>
            <th>Sent by</th>
            <th>Order Item Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.orderId}</td>
                <td><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###" /> VND</td>
                <td>${order.totalAmount}</td>
                <td><fmt:formatDate value="${order.date}" pattern="yyyy-MM-dd" /></td>
                <td>
                    <c:choose>
                        <c:when test="${order.status == 0}">
                            <span class="status-pending">Pending</span>
                        </c:when>
                        <c:when test="${order.status == 1}">
                            <span class="status-confirmed">Confirmed</span>
                        </c:when>
                        <c:when test="${order.status == 2}">
                            <span class="status-shipping">Shipping</span>
                        </c:when>
                        <c:when test="${order.status == 3}">
                            <span class="status-shipped">Shipped</span>
                        </c:when>
                        <c:when test="${order.status == 4}">
                            <span class="status-rejected">Rejected</span>
                        </c:when>
                        <c:when test="${order.status == 5}">
                            <span class="status-cancelled">Cancelled</span>
                        </c:when>
                    </c:choose>
                </td>
                <td>${order.account.fullname}</td>
                <td>${order.note}</td> <!-- Display Order Item Status here -->
                <td>
                    <button class="btn btn-info" onclick="viewOrderDetails(${order.orderId})">Detail</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <h2 style="text-align: center;">Order Log</h2>

    <table id="order-log-table" class="table table-striped">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Total Price</th>
            <th>Product Amount</th>
            <th>Created Date</th>
            <th>Status</th>
            <th>Sent by</th>
            <th>Processed Date</th>
            <th>Processed By</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orderList}">
            <tr>
                <td>${order.orderId}</td>
                <td><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###" /> VND</td>
                <td>${order.totalAmount}</td>
                <td><fmt:formatDate value="${order.date}" pattern="yyyy-MM-dd" /></td>
                <td>
                    <c:choose>
                        <c:when test="${order.status == 0}">
                            <span class="status-pending">Pending</span>
                        </c:when>
                        <c:when test="${order.status == 1}">
                            <span class="status-confirmed">Confirmed</span>
                        </c:when>
                        <c:when test="${order.status == 2}">
                            <span class="status-shipping">Shipping</span>
                        </c:when>
                        <c:when test="${order.status == 3}">
                            <span class="status-shipped">Shipped</span>
                        </c:when>
                        <c:when test="${order.status == 4}">
                            <span class="status-rejected">Rejected</span>
                        </c:when>
                        <c:when test="${order.status == 5}">
                            <span class="status-cancelled">Cancelled</span>
                        </c:when>
                    </c:choose>
                </td>
                <td>${order.account.fullname}</td>
                <td><fmt:formatDate value="${order.processedDate}" pattern="yyyy-MM-dd" /></td>
                <td>${order.processedBy.fullname}</td>
                <td>
                    <button class="btn btn-info" onclick="viewOrderDetails(${order.orderId})">Detail</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function () {
        $('#order-management-table').DataTable({
            paging: false
        });
        $('#order-log-table').DataTable({
            paging: false
        });
    });

    function viewOrderDetails(orderId) {
        window.location.href = 'orderdetail?orderId=' + orderId;
    }
</script>
</body>
</html>
