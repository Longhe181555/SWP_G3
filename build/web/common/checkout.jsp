<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Checkout</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            margin-top: 50px;
        }
        .cart-table {
            float: left;
            width: 60%;
        }
        .payment-form {
            float: right;
            width: 40%;
            padding-left: 20px;
        }
        .color-square {
            display: inline-block;
            width: 20px;
            height: 20px;
            margin-right: 5px;
            border: 1px solid #ccc;
            opacity: 0.7;
        }
        .out-of-stock {
            color: red;
        }
    </style>
</head>
<body>
    <%@ include file="../public/navbar.jsp" %>


    <div class="container">
        <h2 style="text-align: center; color: darkorange;">Here's what's in your cart</h2>
        <div class="cart-table">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Size</th>
                        <th>Color</th>
                        <th>Price</th>
                        <th>Amount</th>
                        <th>Total Price</th>
                        <th>Stock Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cart" items="${carts}">
                        <tr>
                            <td><img src="${pageContext.request.contextPath}/${cart.productItem.product.productimgs[0].imgpath}" class="img-fluid" alt="${cart.productItem.product.pname}" style="width: 50px; height: 50px;"></td>
                            <td>
                                <c:choose>
                                    <c:when test="${cart.product_status == 'Archived'}">
                                        <span style="color: red;">Product Unavailable, please remove it to be able to checkout</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="productdetail?pid=${cart.productItem.product.pid}" style="text-decoration: none;">
                                            ${fn:substring(cart.productItem.product.pname, 0, 20)}...
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${cart.productItem.size}</td>
                            <td>
                                <div class="color-square" style="background-color: ${cart.productItem.color};"></div>${cart.productItem.color}
                            </td>
                            <td>
                                <fmt:formatNumber type="number" pattern="#,###" value="${cart.soldPrice}" /> vnd
                            </td>
                            <td>
                                <input type="number" class="cart-amount" data-cartid="${cart.cartid}" value="${cart.amount}" min="1" max="${cart.productItem.stockcount}">
                            </td>
                            <td class="cart-total-price">
                                <fmt:formatNumber type="number" pattern="#,###" value="${cart.soldPrice * cart.amount}" /> vnd
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${cart.productItem.stockcount == 0}">
                                        <span class="out-of-stock">Out of stock</span>
                                    </c:when>
                                    <c:when test="${cart.amount > cart.productItem.stockcount}">
                                        <span class="not-enough-stock">Not enough stock</span>
                                    </c:when>
                                    <c:otherwise>
                                        In stock
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-danger" onclick="removeCartItem(${cart.cartid})">Remove</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="6" style="text-align: right;"><strong>Total Price:</strong></td>
                        <td><strong id="totalBill"><fmt:formatNumber type="number" pattern="#,###" value="${totalBill}" /> vnd</strong></td>
                        <td></td>
                        <td>
                            <c:if test="${not containsARStatus}">
                                <a class="btn btn-primary" href="checkout">Proceed to Checkout</a>
                            </c:if>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
        <div class="payment-form">
            <h3>Credit Card Payment</h3>
            <form action="processPayment" method="post">
                <button type="submit" class="btn btn-success">Pay Now</button>
                
            </form>
        </div>
    </div>

    <a class="btn btn-secondary" href="/vcart" style="position: fixed; bottom: 20px; right: 20px;">Back</a>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.cart-amount').on('input', function () {
                var cartId = $(this).data('cartid');
                var newAmount = $(this).val();
                newAmount = validateAmountRange(newAmount, $(this).attr('min'), $(this).attr('max'));
                if (newAmount !== $(this).data('lastvalue')) {
                    $(this).data('lastvalue', newAmount);
                    updateCartAmount(cartId, newAmount);
                }
            });

            function validateAmountRange(value, min, max) {
                min = parseInt(min);
                max = parseInt(max);
                value = parseInt(value);
                if (isNaN(value) || value < min) {
                    return min;
                } else if (value > max) {
                    return max;
                } else {
                    return value;
                }
            }

            function updateCartAmount(cartId, newAmount) {
                $.ajax({
                    url: 'ChangeCartAmountController',
                    type: 'POST',
                    data: {
                        cartId: cartId,
                        amount: newAmount
                    },
                    success: function (response) {
                        if (response.success) {
                            location.reload();
                        } else {
                            alert('Failed to update the cart. Please try again.');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error updating cart amount:', error);
                    }
                });
            }

            window.removeCartItem = function (cartId) {
                if (confirm('Are you sure you want to remove this item from your cart?')) {
                    $.ajax({
                        url: 'RemoveFromCartController',
                        type: 'POST',
                        data: {cartId: cartId},
                        success: function (response) {
                            if (response.success) {
                                location.reload();
                            } else {
                                alert('Failed to remove the item: ' + response.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error removing item from cart:', error);
                            alert('Error removing item from cart. Please try again.');
                        }
                    });
                }
            };
        });
    </script>
</body>
</html>
