<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order History</title>
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
            <h2 style="text-align: center;">Order History</h2>

            <!-- Order History Table -->
            <table id="order-history-table" class="table table-striped">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Total Price</th>
                        <th>Product Amount</th>
                        <th>Date</th>
                        <th>Status</th>
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
                            <td>
                                <button class="btn btn-info" onclick="viewOrderDetails(${order.orderId})">Detail</button>
                                <c:if test="${order.status == 0}">
        <!--                            <button class="btn btn-warning" onclick="editOrder(${order.orderId})">Edit</button>-->
                                    <button class="btn btn-danger" onclick="confirmCancelOrder(${order.orderId})">Cancel</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
            <script>
                                            $(document).ready(function () {
                                                // Initialize DataTable without search and paging
                                                $('#order-history-table').DataTable({
                                                    paging: false,
                                                    order: [[3, 'desc']] 
                                                });

                                                $('#previous-bought-table').DataTable({
                                                    searching: false,
                                                    paging: false,
                                                    ordering: false
                                                });
                                            });

                                            function viewOrderDetails(orderId) {
                                                window.location.href = 'orderdetail?orderId=' + orderId;
                                            }

                                            function editOrder(orderId) {
                                                if (confirm('Are you sure you want to edit this order?')) {
                                                    window.location.href = 'editorder.jsp?orderId=' + orderId;
                                                }
                                            }

                                            function confirmCancelOrder(orderId) {
                                                if (confirm('Are you sure you want to cancel this order?')) {
                                                    $.ajax({
                                                        url: 'CancelOrderController',
                                                        type: 'POST',
                                                        data: {orderId: orderId},
                                                        success: function (response) {
                                                            if (response.success) {
                                                                alert('Order cancelled successfully.');
                                                                location.reload();
                                                            } else {
                                                                alert('Failed to cancel the order. Please try again.');
                                                            }
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error('Error cancelling order:', error);
                                                            alert('Error cancelling order. Please try again.');
                                                        }
                                                    });
                                                }
                                            }
            </script>
    </body>
</html>
