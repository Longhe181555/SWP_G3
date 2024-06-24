
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <title>JSP Page</title>
        <style>

            * {
                margin: 0;
                padding: 0;
            }
            .header-container{
                padding: 10px 0px;
                width: 100%;
                background-color: black;
                color: white;
            }
            .header-content{
                padding-top: 5px;
                padding-bottom: 10px;
                text-align: center;
                font-size: 25px;
                font-family: "Arial", sans-serif;
            }
            .header-right,.header-left{
                font-family: "Arial", sans-serif;
                display:flex;
                color:white;
            }

            .header-options{
                display:flex;
                justify-content: space-around;
            }
            .nav-bar {
                background-color: #f5f5f5;
                padding: 10px;
                display: flex;
                justify-content: center;
            }

            .nav-option {
                padding: 8px 16px;
                margin: 0 10px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .nav-option{
                color:#666666;
                font-family: "Arial", sans-serif;
                font-weight: bold;
            }
            .nav-option:hover {
                background-color: #e0e0e0;
            }
            .nav-option.active {
                text-decoration: underline; /* Underline the active option */
            }
            .header-link:hover {
                color: #ffcc00; /* Change to any color you like */
                text-shadow: 0 0 10px rgba(255, 204, 0, 0.5); /* Adjust glow effect */
            }
            .header-link {
                margin: 0 10px;
                color: white;
                text-decoration: none;
                cursor: pointer;
                transition: color 0.3s ease, text-shadow 0.3s ease;
            }
            .rating-stars {
                color: gold;
            }
            .d-flex {
                display: flex;
            }

            .align-items-center {
                align-items: center;
            }

            .me-2 {
                margin-right: 0.5rem;
            }

            .me-3 {
                margin-right: 1rem;
            }

            .flex-wrap {
                flex-wrap: wrap;
            }

            .form-check {
                display: flex;
                align-items: center;
            }

        </style>
    </head>
    <body>

        <div class="header">
            <div class="header-container">
                <div class="header-options">
                    <div class="header-left"> 
                        <p class="header-link">Search </p>||
                        <p class="header-link"> Order history</p>    
                    </div>
                    <div class="header-right">
                        <a href="account" class="header-link">My Account</a>||  
                        <p class="header-link"> Checkout</p>||
                        <a href="logout" class="header-link">Logout</a>
                    </div>
                </div>
            </div>

            <div class="header-container">
                <div class="header-content">
                    <p>List Cart</p>
                </div>
            </div> 
        </div>
        <div class="nav-bar">
            <div class="nav-option ${param.nav == 'homepage' ? 'active' : ''}" data-nav-option="homepage" onclick="goToHomepage()">HOME</div>
<!--            <div class="nav-option ${param.nav == 'option2' ? 'active' : ''}" data-nav-option="option2">OPTION 2</div>
            <div class="nav-option ${param.nav == 'option3' ? 'active' : ''}" data-nav-option="option3">OPTION 3</div>
            <div class="nav-option ${param.nav == 'option4' ? 'active' : ''}" data-nav-option="option4">OPTION 4</div>
            <div class="nav-option ${param.nav == 'option5' ? 'active' : ''}" data-nav-option="option5">OPTION 5</div>-->
        </div>

        <div class="shopping-cart">
            <div class="px-4 px-lg-0">
                <div class="pb-5">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 p-5 bg-white rounded shadow-sm mb-5">
                                <!-- Shopping cart table -->
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="p-2 px-3 text-uppercase">Product</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Price</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Discount</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Quantity</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Total</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Action</div>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${list}" var="o">
                                                <tr>
                                                    <th scope="row">
                                                        <div class="p-2">
                                                            <img src="${o.imgPath != null ? o.imgPath : 'default.jpg'}" alt="" width="70" class="img-fluid rounded shadow-sm">
                                                            <div class="ml-3 d-inline-block align-middle">
                                                                <h5 class="mb-0"><a href="#" class="text-dark d-inline-block">${o.productName != null ? o.productName : 'N/A'}</a></h5>
                                                                <span class="text-muted font-weight-normal font-italic">${o.sizeName != null ? o.sizeName : 'N/A'}, ${o.colorName != null ? o.colorName : 'N/A'}</span>
                                                            </div>
                                                        </div>
                                                    </th>
                                                    <td class="align-middle"><strong>${o.price != null ? o.price : 'N/A'} VND</strong></td>
                                                    <td class="align-middle"><strong style="color: red">
                                                            ${o.discountType == 'percentage' ? o.price - (o.value * o.price)/100 : (o.discountType == 'fixedAmount' ? o.value + ' VND' : 'N/A')}
                                                        </strong></td>
                                                    <td class="align-middle">
                                                        <a href="PlusToCart?quantity=-1&id=${o.productId}&stock=${o.stock}"><button class="btnSub">-</button></a>
                                                        <strong>${o.quantity}</strong>
                                                        <a href="PlusToCart?quantity=1&id=${o.productId}&stock=${o.stock}"><button class="btnAdd">+</button></a>
                                                    </td>
                                                    <td class="align-middle"><strong>${o.quantity * (o.price - (o.value * o.price)/100)} VND</strong></td>
                                                    <td class="align-middle">
                                                        <a href="DeleteCart?cartId=${o.cartId}" class="text-dark">
                                                            <button type="button" class="btn btn-danger">Delete</button>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <% if (request.getAttribute("message") != null) { %>
                                    <p class="btn-danger"><%= request.getAttribute("message") %></p>
                                    <% } %>
                                </div>
                                <!-- End -->
                            </div>
                        </div>
                        <div class="row py-5 p-4 bg-white rounded shadow-sm">
                            <div class="col-lg-6">
                                <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Voucher</div>
                                <div class="p-4">
                                    <div class="input-group mb-4 border rounded-pill p-2">
                                        <input type="text" placeholder="Nhập Voucher" aria-describedby="button-addon3" class="form-control border-0">
                                        <div class="input-group-append border-0">
                                            <button id="button-addon3" type="button" class="btn btn-dark px-4 rounded-pill"><i class="fa fa-gift mr-2"></i>Sử dụng</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Thành tiền</div>
                                <div class="p-4">
                                    <ul class="list-unstyled mb-4">
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Total cost</strong><strong id="totalPrice">${totalPrice} $</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Shipment</strong><strong></strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Discount</strong><strong id="totalDiscount">${totalDiscount} $</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Total Payment</strong>
                                            <h5 class="font-weight-bold" id="totalPayment">${totalPrice - totalDiscount} $</h5>
                                        </li>
                                    </ul>
                                    <a href="Order" onclick="checkTotalPrice(event)" class="btn btn-dark rounded-pill py-2 btn-block">Buy now</a>
                                </div>
                            </div>
                        </div>

                        <script>
                            function checkTotalPrice(event) {
                                var totalPrice = parseFloat(document.getElementById('totalPrice').textContent.replace('$', '').trim());

                                if (totalPrice === 0) {
                                    event.preventDefault();
                                    alert('Giỏ hàng của bạn đang trống. Vui lòng thêm sản phẩm để tiếp tục.');
                                }
                            }
                        </script>
                    </div>
                </div>
            </div>
        </div>



        <script>
            function goToHomepage() {
                window.location.href = '<%= request.getContextPath() %>/homepage';
            }
        </script>


        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
