<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css" rel="stylesheet">
        <style>
            .color-square {
                display: inline-block;
                width: 20px;
                height: 20px;
                margin-right: 5px;
                border: 1px solid #ccc;
                opacity: 0.7;
            }
            .price-discounted {
                text-decoration: line-through;
                color: #888;
                margin-right: 5px;
            }
            .in-stock {
                color: green;
            }
            .not-enough-stock {
                color: darkgoldenrod;
            }
            .out-of-stock {
                color: red;
            }
        </style>
    </head>
    <body>
        <%@ include file="../public/navbar.jsp" %>
        <div class="container">
            <input type="hidden" value='${carts}' id="cartItems" />
            <table id="cart-table" class="table table-striped">
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
                            <td>${fn:substring(cart.productItem.product.pname, 0, 20)}...</td>
                            <td>${cart.productItem.size}</td>
                            <td><div class="color-square" style="background-color: ${cart.productItem.color};"></div>${cart.productItem.color}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty cart.productItem.discount.dtype}">
                                        <span class="price-discounted">
                                            <fmt:formatNumber type="number" pattern="#,###" value="${cart.productItem.product.price}" /> vnd
                                        </span>
                                        <fmt:formatNumber type="number" pattern="#,###" value="${cart.productItem.discountedPrice}" /> vnd
                                        <br/>
                                        <small>Valid until ${cart.productItem.discount.to}</small>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber type="number" pattern="#,###" value="${cart.productItem.product.price}" /> vnd
                                    </c:otherwise>
                                </c:choose>
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
                                        <span class="in-stock">In stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><button class="btn btn-danger" onclick="removeCartItem(${cart.cartid})">Remove</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="6" style="text-align: right;"><strong>Total Price:</strong></td>
                        <td><strong id="totalBill"><fmt:formatNumber type="number" pattern="#,###" value="${totalBill}" /> vnd</strong></td>
                        <td></td>
                        <td><button class="btn btn-primary" onclick="checkout()">Check Out</button></td>
                    </tr>
                </tfoot>
            </table>
        </div>

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

                                $('.cart-amount').on('keydown', function (e) {
                                    var keyCode = e.keyCode || e.which;

                                
                                    if (keyCode === 38 || keyCode === 40) { 
                                        e.preventDefault();

                                        var currentVal = parseInt($(this).val());
                                        var min = parseInt($(this).attr('min'));
                                        var max = parseInt($(this).attr('max'));

                                        if (keyCode === 38) { 
                                            currentVal = validateAmountRange(currentVal + 1, min, max);
                                        } else if (keyCode === 40) { 
                                            currentVal = validateAmountRange(currentVal - 1, min, max);
                                        }

                                        $(this).val(currentVal);

                                       
                                        $(this).trigger('change');
                                    }
                                });

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

                                function removeCartItem(cartId) {
                                    if (confirm('Are you sure you want to remove this item from your cart?')) {
                                        $.ajax({
                                            url: 'removeCartItem',
                                            type: 'POST',
                                            data: {cartId: cartId},
                                            success: function (response) {
                                                location.reload();
                                            },
                                            error: function (xhr, status, error) {
                                                console.error('Error removing item from cart:', error);
                                            }
                                        });
                                    }
                                }

                                function checkout() {
                                    alert('Proceeding to checkout...');
                                }
                            });

        </script>
    </body>
</html>
