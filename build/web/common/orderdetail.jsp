<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Detail</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            /* Custom cloth shop styles */
            body {
                background-color: #f8f9fa; /* Light gray background */
                font-family: Arial, sans-serif;
            }
            .container {
                margin-top: 20px;
            }
            .dark-yellow {
                color: darkorange;
            }
            .dark-green {
                color: darkgreen;
            }
            .red {
                color: red;
            }
            .center {
                text-align: center;
            }
            .color-square {
                display: inline-block;
                width: 20px;
                height: 20px;
                border: 1px solid #ccc;
                margin-right: 5px;
                vertical-align: middle;
            }
            #order-items-table {
                margin-top: 20px;
            }
            .sold-Price {
                font-weight: bold;
            }
            .btn-back {
                margin-top: 20px;
            }
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
        <div class="container">
            <%@ include file="../public/navbar.jsp" %>
            <h2 class="dark-yellow center">Order Detail</h2>
            <p>Customer: ${order.account.fullname}</p>
            <p>Purchase Date: ${order.date}</p>
            <p>Total Bill: <fmt:formatNumber type="number" pattern="#,###" value="${order.totalPrice}" /> vnd</p>
            <p>Payment: ${order.payment}</p>
            <p>Shipping Note: ${order.note}</p>
            <p>Shipping to: ${order.address}</p>
            <c:if test="${Account.role == 'staff' || Account.role == 'admin'}">
                <p>Processed By: ${order.processedBy.fullname}</p>
            </c:if>
            <p>Shipping Status:
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
            </p>
            <p>Processed Date: ${empty order.processedDate ? 'Not yet' : order.processedDate}</p>

            <h3>Items Included in Order</h3>
            <table id="order-items-table" class="table table-striped">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Size</th>
                        <th>Color</th>
                        <th>Unit Price</th>
                        <th>Quantity</th>
                        <th>Total Price</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="orderItem" items="${orderItems}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}/${orderItem.productItem.product.productimgs[0].imgpath}" class="img-fluid" style="width: 50px; height: 50px;" alt="${orderItem.productItem.product.pname}">
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${orderItem.product_status == 'Archived'}">
                                        <div style="color: red"> Unavailable product </div>
                                    </c:when>
                                    <c:otherwise>
                                        ${fn:substring(orderItem.productItem.product.pname, 0, 20)}...
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${orderItem.productItem.size}</td>
                            <td>
                                <div class="color-square" style="background-color: ${orderItem.productItem.color};"></div>${orderItem.productItem.color}
                            </td>
                            <td>
                                <span class="sold-Price">
                                    <fmt:formatNumber type="number" pattern="#,###" value="${orderItem.soldPrice}" /> vnd
                                </span> per Item
                            </td>
                            <td>${orderItem.amount}</td>
                            <td>
                                <fmt:formatNumber type="number" pattern="#,###" value="${orderItem.soldPrice * orderItem.amount}" /> vnd
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <a href="<c:choose>
                   <c:when test="${account.role == 'admin' or account.role == 'staff'}">
                       ordermanagement
                   </c:when>
                   <c:otherwise>
                       vieworderhistory
                   </c:otherwise>
               </c:choose>" class="btn btn-secondary btn-back">
                <c:choose>
                    <c:when test="${account.role == 'admin' or account.role == 'staff'}">
                        Back to Order Management
                    </c:when>
                    <c:otherwise>
                        Back to Order History
                    </c:otherwise>
                </c:choose>
            </a>
        </div>

        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
