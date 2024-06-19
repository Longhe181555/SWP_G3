<%-- 
    Document   : productmanagement
    Created on : Jun 11, 2024, 12:48:42 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .placeholder{
                height: 64px;
                width: 100%;
            }

        </style>
    </head>
    <body>
        <div class="placeholder"></div>

        <nav class="navbar navbar-expand-lg bg-dark text-white fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand text-white fs-2" href="homepage">MEN'S WEAR</a>
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <c:if test="${Account.role == 'staff' || Account.role == 'admin'}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color:white;font-size:20px">
                                Dashboard
                            </a>
                            <ul class="dropdown-menu" >
                                <li><a class="dropdown-item" href="pmanagement" >Product Management</a></li>
                                <!--                                <li><a class="dropdown-item" href="#" >Another action</a></li>
                                                                <li><hr class="dropdown-divider"></li>
                                                                <li><a class="dropdown-item" href="#">Something else here</a></li>-->
                            </ul>
                        </li>
                    </c:if>
                </ul>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <form class="d-flex ms-auto" role="search" action="${pageContext.request.contextPath}/productlist" method="GET">
                        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="search">
                        <button class="btn btn-outline-success" type="submit">Search</button>
                    </form>
                    <ul class="navbar-nav ms-3 me-3">
                        <c:choose>
                            <c:when test="${empty Account}">
                                <li class="nav-item d-flex align-items-center">
                                    <a class="nav-link text-white" href="account">Login/Register</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item d-flex align-items-center">
                                    <div class="dropdown">
                                        <a class="nav-link text-white dropdown-toggle" href="#" role="button" id="accountDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                            ${Account.fullname}
                                            <img src="${Account.img}" alt="Profile Image" style="border-radius: 50%; width: 40px; height: 40px;">
                                        </a>
                                        <ul class="dropdown-menu" aria-labelledby="accountDropdown">
                                            <li><a class="dropdown-item" href="account">Account Detail</a></li>
                                            <li><a class="dropdown-item" href="#">Order History</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item" href="logout">Logout</a></li>
                                        </ul>
                                    </div>
                                </li>
                            </c:otherwise>
                        </c:choose>
                        <li class="nav-item d-flex align-items-center">
                            <a class="nav-link text-white" href="#"><i class="bi bi-bell"></i></a>
                        </li>
                        <li class="nav-item d-flex align-items-center">
                            <a class="nav-link text-white" href="#"><i class="bi bi-bag"></i></a>
                        </li>

                    </ul>
                </div>
            </div>
        </nav>

        <div class="container" style="margin-top:40px">
            <div>
                <a id="btnAddProduct" href="cproduct" class="btn btn-primary">Add New Product</a>
                <button id="btnAddBrand" class="btn btn-primary">Add New Brand</button>
                <button id="btnManageStock" class="btn btn-primary">Manage Product Stock</button>
            </div>
            <div class="container" style="margin-top:20px">
                <div>
                    <table id="product-table" class="table table-striped">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Image</th>
                                <th scope="col">Name</th>
                                <th scope="col">Price</th>
                                <th scope="col">Brand</th>
                                <th scope="col">Category</th>
                                <th scope="col">Date</th>
                                <th scope="col">Actions</th>
                                <th scope="col">Is Listed</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>




        <script>
            $(document).ready(function () {
                $('#product-table').on('change', 'input[type=radio]', function () {
                    var pid = $(this).attr('name').replace('isListed', '');
                    var value = $(this).val();

                    $.ajax({
                        url: 'changeListedController',
                        method: 'POST',
                        data: {
                            pid: pid,
                            value: value
                        },
                        success: function (response) {
                            console.log('Successfully updated listed status.');
                        },
                        error: function (xhr, status, error) {
                            console.error('AJAX Error:', error);
                        }
                    });
                });

                $.fn.dataTable.ext.order['dom-checkbox'] = function (settings, col) {
                    return this.api().column(col, {order: 'index'}).nodes().map(function (td, i) {
                        return $('input', td).prop('checked') ? '1' : '0';
                    });
                };

                // Custom sorting function for date column
                $.fn.dataTable.ext.order['date-uk-pre'] = function (a) {
                    var ukDatea = a.replace(/ /g, '');
                    return Date.parse(ukDatea);
                };

                $.ajax({
                    url: 'getProducts',
                    method: 'GET',
                    success: function (data) {
                        var dataSet = data.map(function (item) {
                            var isListedRadios = '<input type="radio" name="isListed' + item.pid + '" value="true" ' +
                                    (item.isListed ? 'checked' : '') +
                                    '/> Yes ' +
                                    '<input type="radio" name="isListed' + item.pid + '" value="false" ' +
                                    (!item.isListed ? 'checked' : '') +
                                    '/> No ';

                            // Format date to YYYY-MM-DD for proper sorting
                            var formattedDate = new Date(item.date).toISOString().slice(0, 10);

                            return {
                                pid: item.pid,
                                img: '<img src="' + item.productimgs[0].imgpath + '" class="card-img-top img-fluid" alt="' + item.pname + '" style="width:50px;height:50px">',
                                pname: item.pname,
                                price: item.price,
                                brand: item.brand.bname,
                                category: item.category.catname,
                                date: formattedDate,
                                isListed: isListedRadios,
                                actions: '<form action="updateProduct" method="get" style="display:inline-block;">' +
                                        '<input type="hidden" name="pid" value="' + item.pid + '" />' +
                                        '<button type="button" class="btn btn-primary btn-sm update-button">Update</button>' +
                                        '</form>' +
                                        '<form action="deleteProduct" method="post" style="display:inline-block;" class="delete-form">' +
                                        '<input type="hidden" name="pid" value="' + item.pid + '" />' +
                                        '<button type="button" class="btn btn-danger btn-sm delete-button">Delete<i class="bi bi-trash"></i></button>' +
                                        '</form>'
                            };
                        });

                        $('#product-table').DataTable({
                            data: dataSet,
                            columns: [
                                {data: 'pid'},
                                {data: 'img'},
                                {data: 'pname'},
                                {data: 'price'},
                                {data: 'brand'},
                                {data: 'category'},
                                {data: 'date', title: 'Date', type: 'date-uk-pre'},
                                {data: 'isListed', title: 'Is Listed', orderDataType: 'dom-checkbox'},
                                {data: 'actions', title: 'Actions'}
                            ],
                            order: [[6, 'desc']], // Example: Sort by Date column descending by default
                            paging: true,
                            searching: true,
                            info: true
                        });
                    },
                    error: function (xhr, status, error) {
                        console.error('AJAX Error:', error);
                    }
                });

                // Confirmation dialog for delete button
                $('#product-table').on('click', '.delete-button', function () {
                    var form = $(this).closest('.delete-form');
                    var confirmed = confirm('Deleting this product will delete all items from pending cart and order. Confirmed orders will appear as "Deleted Item". Are you sure?');
                    if (confirmed) {
                        form.submit();
                    }
                });

                // Confirmation dialog for update button
                $('#product-table').on('click', '.update-button', function () {
                    var form = $(this).closest('form');
                    var confirmed = confirm('Changing any field will remove the item from pending cart/order, and notify the customers, do you want to update it?');
                    if (confirmed) {
                        form.submit();
                    }
                });
            });

        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
