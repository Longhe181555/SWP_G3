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

            <!-- Nav tabs -->
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="pending-tab" data-toggle="tab" href="#pending" role="tab" aria-controls="pending" aria-selected="true">Pending Orders</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="confirmed-tab" data-toggle="tab" href="#confirmed" role="tab" aria-controls="confirmed" aria-selected="false">Confirmed Orders</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="shipping-tab" data-toggle="tab" href="#shipping" role="tab" aria-controls="shipping" aria-selected="false">Shipping Orders</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="shipped-tab" data-toggle="tab" href="#shipped" role="tab" aria-controls="shipped" aria-selected="false">Shipped Orders</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="rejected-tab" data-toggle="tab" href="#rejected" role="tab" aria-controls="rejected" aria-selected="false">Rejected Orders</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="cancelled-tab" data-toggle="tab" href="#cancelled" role="tab" aria-controls="cancelled" aria-selected="false">Cancelled Orders</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="order-log-tab" data-toggle="tab" href="#order-log" role="tab" aria-controls="order-log" aria-selected="false">Order Logs</a>
                </li>
            </ul>


            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="pending" role="tabpanel" aria-labelledby="pending-tab">
                    <table id="order-management-table" class="table table-striped">
                        <h2 class="mt-4"> Order in pending status </h2>
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
                                <th>Process Order</th>
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
                                    <td>${order.note}</td> 
                                    <td>
                                        <button class="btn btn-info" onclick="viewOrderDetails(${order.orderId})">Detail</button> 
                                    </td>
                                    <td style="display: flex">  

                                        <button class="btn btn-dark" onclick="confirmChangeStatus(${order.orderId}, 1)">Confirm order</button>
                                        <button class="btn btn-danger" onclick="confirmChangeStatus(${order.orderId}, 4)">Reject order</button>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="order-log" role="tabpanel" aria-labelledby="order-log-tab">
                    <table id="order-log-table" class="table table-striped">
                        <h2 class="mt-4"> Order log </h2>
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
                <div class="tab-pane fade" id="shipping" role="tabpanel" aria-labelledby="shipping-tab">
                    <table id="shipping-orders-table" class="table table-striped">

                        <h2 class="mt-4"> Order in shipping status </h2>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Total Price</th>
                                <th>Product Amount</th>
                                <th>Created Date</th>
                                <th>Sent by</th>
                                <th>Action</th>
                                <th>Process order</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${shipping}">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###" /> VND</td>
                                    <td>${order.totalAmount}</td>
                                    <td><fmt:formatDate value="${order.date}" pattern="yyyy-MM-dd" /></td>
                                    <td>${order.account.fullname}</td>
                                    <td>
                                        <button class="btn btn-info" onclick="viewOrderDetails(${order.orderId})">Detail</button>
                                    </td>
                                    <td>
                                        <button class="btn btn-dark" onclick="confirmChangeStatus(${order.orderId}, 3)">Change Status: Shipped</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="confirmed" role="tabpanel" aria-labelledby="confirmed-tab">
                    <table id="confirmed-orders-table" class="table table-striped">

                        <h2 class="mt-4"> Order in confirmed status </h2>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Total Price</th>
                                <th>Product Amount</th>
                                <th>Created Date</th>
                                <th>Sent by</th>
                                <th>Action</th>
                                <th>Process order</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${confirmed}">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###" /> VND</td>
                                    <td>${order.totalAmount}</td>
                                    <td><fmt:formatDate value="${order.date}" pattern="yyyy-MM-dd" /></td>
                                    <td>${order.account.fullname}</td>
                                    <td>
                                        <button class="btn btn-info" onclick="viewOrderDetails(${order.orderId})">Detail</button>
                                    </td>
                                    <td>
                                        <button class="btn btn-dark" onclick="confirmChangeStatus(${order.orderId}, 2)">Change Status to: Shipped</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="shipped" role="tabpanel" aria-labelledby="shipped-tab">
                    <table id="shipped-orders-table" class="table table-striped">
                        <h2 class="mt-4"> Order in shipped status </h2>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Total Price</th>
                                <th>Product Amount</th>
                                <th>Created Date</th>
                                <th>Sent by</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${shipped}">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###" /> VND</td>
                                    <td>${order.totalAmount}</td>
                                    <td><fmt:formatDate value="${order.date}" pattern="yyyy-MM-dd" /></td>
                                    <td>${order.account.fullname}</td>
                                    <td>
                                        <button class="btn btn-info" onclick="viewOrderDetails(${order.orderId})">Detail</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="rejected" role="tabpanel" aria-labelledby="rejected-tab">
                    <table id="rejected-orders-table" class="table table-striped">
                        <!-- Table headers for rejected orders -->
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Total Price</th>
                                <th>Product Amount</th>
                                <th>Created Date</th>
                                <th>Sent by</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${rejected}">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###" /> VND</td>
                                    <td>${order.totalAmount}</td>
                                    <td><fmt:formatDate value="${order.date}" pattern="yyyy-MM-dd" /></td>
                                    <td>${order.account.fullname}</td>
                                    <td>
                                        <button class="btn btn-info" onclick="viewOrderDetails(${order.orderId})">Detail</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="cancelled" role="tabpanel" aria-labelledby="cancelled-tab">
                    <table id="cancelled-orders-table" class="table table-striped">
                        <!-- Table headers for cancelled orders -->
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Total Price</th>
                                <th>Product Amount</th>
                                <th>Created Date</th>
                                <th>Sent by</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${cancelled}">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###" /> VND</td>
                                    <td>${order.totalAmount}</td>
                                    <td><fmt:formatDate value="${order.date}" pattern="yyyy-MM-dd" /></td>
                                    <td>${order.account.fullname}</td>
                                    <td>
                                        <button class="btn btn-info" onclick="viewOrderDetails(${order.orderId})">Detail</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
                                            $(document).ready(function () {
                                                $('#pending-orders-table').DataTable({
                                                    paging: false,
                                                    searching: false,

                                                    order: [[4, 'desc']]
                                                });
                                                $('#shipping-orders-table').DataTable({
                                                    paging: false,
                                                    searching: false,

                                                    order: [[4, 'desc']]
                                                });
                                                $('#confirmed-orders-table').DataTable({
                                                    paging: false,
                                                    searching: false,

                                                    order: [[4, 'desc']]
                                                });
                                                $('#shipped-orders-table').DataTable({
                                                    paging: false,
                                                    searching: false,

                                                    order: [[4, 'desc']]
                                                });
                                                $('#rejected-orders-table').DataTable({
                                                    paging: false,
                                                    searching: false,

                                                    order: [[4, 'desc']]
                                                });
                                                $('#cancelled-orders-table').DataTable({
                                                    paging: false,
                                                    searching: false,

                                                    order: [[4, 'desc']]
                                                });
                                                $('#order-log-table').DataTable({
                                                    paging: false,
                                                    searching: false,

                                                    order: [[3, 'desc']]
                                                });
                                            });

                                            function viewOrderDetails(orderId) {
                                                window.location.href = 'orderdetail?orderId=' + orderId;
                                            }
                                            function confirmChangeStatus(orderId, status) {
                                                if (confirm('Are you sure you want to change status this order?')) {
                                                    $.ajax({
                                                        url: 'SetOrderStatusController',
                                                        type: 'POST',
                                                        data: {orderId: orderId,
                                                            status: status
                                                        },
                                                        success: function (response) {
                                                            if (response.success) {
                                                                alert('Order status changed successfully.');
                                                                location.reload();
                                                            } else {
                                                                alert('Failed to change the order status. Please try again.');
                                                            }
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error('Error cancelling order:', error);
                                                            alert('Error changing status. Please try again.');
                                                        }
                                                    });
                                                }
                                            }


    </script>
</body>
</html>
