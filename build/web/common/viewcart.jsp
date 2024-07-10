<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
            .ok-button {
                margin-left: 10px;
            }
        </style>
    </head>
    <body>
        <%@ include file="../public/navbar.jsp" %>



        <div class="container">

            <c:set var="containsARStatus" value="false" />
            <h2 style="text-align: center;color: darkorange">Your Cart</h2>
            <input type="hidden" value='${carts}' id="cartItems"/>
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
                            <td>
                                <c:choose>
                                    <c:when test="${cart.product_status == 'Archived'}">
                                        Product Unavailable, please remove it to be able to checkout
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
                                <c:choose>
                                    <c:when test="${not empty cart.productItem.discount.dtype}">
                                        <span class="price-discounted">
                                            <fmt:formatNumber type="number" pattern="#,###" value="${cart.productItem.product.price}" /> vnd
                                        </span>
                                        <fmt:formatNumber type="number" pattern="#,###" value="${cart.productItem.discountedPrice}" /> vnd
                                        <br/>
                                        <small>Discount last until ${cart.productItem.discount.to}</small>
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
                            <td>
                                <button class="btn btn-danger" onclick="removeCartItem(${cart.cartid})">Remove</button>
                            </td>
                        </tr>
                        <c:set var="containsARStatus" value="${containsARStatus or cart.product_status == 'Archived'}" />
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="6" style="text-align: right;"><strong>Total Price:</strong></td>
                        <td><strong id="totalBill"><fmt:formatNumber type="number" pattern="#,###" value="${totalBill}" /> vnd</strong></td>
                        <td></td>
                        <td>
                            <c:choose>
                                <c:when test="${not containsARStatus}">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#checkoutModal">
                                        Checkout
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary" disabled>Please remove unavailable product to checkout</button>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </tfoot>
            </table>
            <div id="statusAlert" class="alert alert-danger alert-dismissible fade show" role="alert" style="display: none">
                <span id="alertMessage"></span>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <button type="button" class="btn btn-primary ok-button" onclick="clearProductStatus()">OK</button>
            </div>
        </div>


        <div class="modal fade" id="checkoutModal" tabindex="-1" role="dialog" aria-labelledby="checkoutModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="checkoutModalLabel">Your Cart</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-8">
                                <table id="cart-summary-table" class="table">
                                    <thead>
                                        <tr>
                                            <th>Item</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cart" items="${carts}">
                                            <tr>
                                                <td>${fn:substring(cart.productItem.product.pname, 0, 20)}...</td>
                                                <td><fmt:formatNumber type="number" pattern="#,###" value="${cart.soldPrice}" /> vnd</td>
                                                <td>${cart.amount}</td>
                                                <td><fmt:formatNumber type="number" pattern="#,###" value="${cart.soldPrice * cart.amount}" /> vnd</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-md-4">
                                <form id="checkoutForm" action="createpayment" method="GET" onsubmit="return validateForm()">
                                    <div class="form-group">
                                        <label for="address">Choose your address:</label>
                                        <select class="form-control" id="address" name="address" onchange="toggleOtherAddress()">
                                            <c:forEach var="address" items="${account.addresses}">
                                                <option value="${address}">${address}</option>
                                            </c:forEach>
                                            <option value="Other">Other</option>
                                        </select>
                                    </div>

                                    <div id="otherAddressInput" class="form-group" style="display: none;">
                                        <label for="otherAddress">Enter other address:</label>
                                        <input type="text" class="form-control" id="otherAddress" name="otherAddress">
                                        <small id="otherAddressError" class="text-danger"></small>
                                    </div>

                                    <div class="form-group">
                                        <label for="note">Note for shipper:</label>
                                        <textarea class="form-control" id="note" name="note" rows="3"></textarea>
                                    </div>

                                    <input type="hidden" id="amount" name="amount" value="${totalBill}">
                                    <button type="submit" class="btn btn-primary">Pay</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
        <script>

                                    function validateForm() {
                                        var addressSelect = document.getElementById("address");
                                        var otherAddressInput = document.getElementById("otherAddress");
                                        var otherAddressError = document.getElementById("otherAddressError");

                                        // Reset error message
                                        otherAddressError.innerText = "";

                                        // Check if "Other" is selected and otherAddress is empty
                                        if (addressSelect.value === "Other" && (otherAddressInput.value === null || otherAddressInput.value.trim() === "")) {
                                            otherAddressError.innerText = "Please enter your address or choose another option.";
                                            return false;
                                        }

                                        return true;
                                    }



                                    function toggleOtherAddress() {
                                        var addressSelect = document.getElementById("address");
                                        var otherAddressInput = document.getElementById("otherAddressInput");

                                        if (addressSelect.value === "Other") {
                                            otherAddressInput.style.display = "block";
                                        } else {
                                            otherAddressInput.style.display = "none";
                                        }
                                    }
            <c:forEach var="cart" items="${carts}">
                                    displayProductStatusAlert('${cart.product_status}', '${cart.productItem.product.pname} - size: ${cart.productItem.size}');
            </c:forEach>
                                        function displayProductStatusAlert(productStatus, pname) {
                                            var alertMessage = '';
                                            switch (productStatus) {
                                                case 'Archived':
                                                    alertMessage = 'A product inside your cart is set as archived status, please remove it <br/> ' + 'Product: ' + pname;
                                                    break;
                                                case 'PriceUpdate':
                                                    alertMessage = 'The price of a product inside your cart has just been updated, you can choose to remove it <br/> ' + 'Product: ' + pname;
                                                    break;
                                                case 'DiscountEnded':
                                                    alertMessage = 'Discount from a product inside your cart has just run out <br/> ' + 'Product: ' + pname;
                                                    break;
                                            }

                                            if (alertMessage !== '') {
                                                $('#statusAlert').html('<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
                                                        alertMessage +
                                                        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                                                        '<span aria-hidden="true">&times;</span>' +
                                                        '</button>' +
                                                        '<button type="button" class="btn btn-primary ok-button" onclick="clearProductStatus()">OK</button>' +
                                                        '</div>').show();
                                            }
                                        }

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

                                            window.clearProductStatus = function () {
                                                $.ajax({
                                                    url: 'ClearProductStatusController',
                                                    type: 'POST',
                                                    data: {},
                                                    success: function (response) {
                                                        if (response.success) {
                                                            location.reload();
                                                        } else {
                                                            console.error('Failed to clear product status:', response.message);
                                                        }
                                                    },
                                                    error: function (xhr, status, error) {
                                                        console.error('Error clearing product status:', error);
                                                    }
                                                });
                                            };
                                        });
        </script>
    </body>
</html>
