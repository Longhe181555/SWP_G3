<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Stock Management</title>
        <link href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css" rel="stylesheet">
        <style>
            .color-box {
                width: 30px;
                height: 30px;
                display: inline-block;
                vertical-align: middle;
            }
            .color-name {
                display: inline-block;
                vertical-align: middle;
                margin-left: 10px;
            }
            .add-stock-container {
                margin-top: 20px;
                border: 1px solid #ccc;
                padding: 10px;
            }
            .add-stock-container select, .add-stock-container input[type="number"], .add-stock-container button {
                margin-right: 10px;
                margin-bottom: 10px;
            }
            .error-message {
                color: red;
                font-size: 12px;
                margin-top: 5px;
            }
        </style>
    </head>
    <body>
        <%@ include file="../public/navbar.jsp" %>
        <div class="container">
            <h1>Product Stock Management</h1>
            <c:if test="${not empty product}">
                <div class="row align-items-center">
                    <div class="col-md-2">
                        <div id="productCarouselSummary" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner">
                                <c:forEach var="img" items="${product.productimgs}" varStatus="loop">
                                    <div class="carousel-item <c:if test='${loop.index == 0}'>active</c:if>">
                                        <img src="${pageContext.request.contextPath}/${img.imgpath}" class="d-block w-100" alt="Product Image">
                                    </div>
                                </c:forEach>
                            </div>
                            <a class="carousel-control-prev" href="#productCarouselSummary" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next" href="#productCarouselSummary" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-10">
                        <h2>${product.pname}</h2>
                        <c:if test="${product.avarageRating > 0}">
                            <p class="card-text rating-star">
                                <c:forEach var="i" begin="1" end="5">
                                    <c:choose>
                                        <c:when test="${i <= product.avarageRating}">
                                            <i class="bi bi-star-fill"></i>
                                        </c:when>
                                        <c:when test="${i > product.avarageRating && i - 1 < product.avarageRating}">
                                            <i class="bi bi-star-half"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-star"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </p>
                        </c:if>
                        <p class="font-weight-bold">${product.price}d</p>
                        <div class="size-dropdowns">
                            <c:forEach var="entry" items="${groupedBySize}">
                                <div class="size-group">
                                    <label>${entry.key}</label>
                                    <select class="color-select">
                                        <c:forEach var="pi" items="${entry.value}">
                                            <option value="${pi.color}" style="background-color: ${pi.color}; color: #000;">
                                                ${pi.color} (${pi.stockcount})
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </c:forEach>
                        </div>                  
                        <p>${product.description}</p>
                        <p><strong>Brand:</strong> ${product.brand.bname}</p>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty product}">
                <p>Product not found.</p>
            </c:if>

            <input type="hidden" id="productPid" value="${product.pid}">        

            <div class="add-stock-container">
                <h2>Add New Stock</h2>
                <select id="sizeSelect">
                    <option value="">Size</option>
                    <c:forEach items="${sizes}" var="size">
                        <option value="${size.sid}">${size.sname}</option>
                    </c:forEach>
                    <option value="All">All Sizes</option>
                </select>
                <select id="colorSelect">
                    <option value="">Color</option>
                    <c:forEach items="${colors}" var="color">
                        <option value="${color.cid}">${color.cname}</option>
                    </c:forEach>
                    <option value="All">All Colors</option>
                </select>
                <input type="number" id="stockCount" value="0" min="0" oninput="validity.valid||(value='');">
                <button onclick="addStock()">Add Stock</button>  <button onclick="location.reload();">Reload Table</button>
                <div id="errorText" class="error-message"></div>
            </div>

            <div class="add-stock-container">
                <h2>Add Stock Count to Multiple Items</h2>
                <select id="sizeSelectMulti">
                    <option value="">Size</option>
                    <c:forEach items="${sizes}" var="size">
                        <option value="${size.sid}">${size.sname}</option>
                    </c:forEach>
                    <option value="All">All Sizes</option>
                </select>
                <select id="colorSelectMulti">
                    <option value="">Color</option>
                    <c:forEach items="${colors}" var="color">
                        <option value="${color.cid}">${color.cname}</option>
                    </c:forEach>
                    <option value="All">All Colors</option>
                </select>
                <input type="number" id="stockAdjustment" value="0">
                <select id="adjustmentType">
                    <option value="increase">Increase</option>
                    <option value="decrease">Decrease</option>
                </select>
                <button onclick="addStockCountMulti()">Add Stock Count To All Stock</button>
                <div id="errorTextMulti" class="error-message"></div>

                <!-- Quick add buttons -->
                <div class="quick-add-container">
                    <h3>Quick add to all</h3>
                    <button onclick="quickAdjustStock(1)">+1</button>
                    <button onclick="quickAdjustStock(10)">+10</button>
                    <button onclick="quickAdjustStock(100)">+100</button>
                    <button onclick="quickAdjustStock(-1)">-1</button>
                    <button onclick="quickAdjustStock(-10)">-10</button>
                    <button onclick="quickAdjustStock(-100)">-100</button>
                    <div>
                        <input type="number" id="customAdjustment" placeholder="Custom" oninput="validity.valid||(value='');">
                        <button onclick="quickAdjustStockCustom()">Add Custom Amount</button>
                    </div>
                </div>
            </div>



            <table id="stock-table" class="display" style="width:100%">
                <thead>
                    <tr>
                        <th>Product Stock ID</th>
                        <th>Product Name</th>
                        <th>Color</th>
                        <th>Size</th>
                        <th>Stock Count</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${productItems}" var="item">
                        <tr>
                            <td>${item.piid}</td>
                            <td>${item.product.pname}</td>
                            <td>
                                <div class="color-box" style="background-color: ${item.color};"></div>
                                <span class="color-name">${item.color}</span>
                            </td>
                            <td>${item.size}</td>
                            <td><input type="number" value="${item.stockcount}" min="0" onchange="updateStockCount(${item.piid})" data-piid="${item.piid}"></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
        <script>
                                $(document).ready(function () {
                                    $('#stock-table').DataTable({
                                        "paging": true,
                                        "info": false,
                                        "searching": true
                                    });
                                });

                                function updateStockCount(piid) {
                                    var stockcount = $('#stock-table input[type=number][data-piid=' + piid + ']').val();

                                    $.ajax({
                                        url: 'updateStock',
                                        method: 'POST',
                                        data: {
                                            piid: piid,
                                            stockcount: stockcount
                                        },
                                        success: function (response) {
                                            console.log('Stock count updated successfully.');
                                        },
                                        error: function (xhr, status, error) {
                                            console.error('Error updating stock count:', error);
                                            alert('Error updating stock count.');
                                        }
                                    });
                                }

                                function addStock() {
                                    var size = $('#sizeSelect').val();
                                    var color = $('#colorSelect').val();
                                    var stockcount = $('#stockCount').val();
                                    var pid = $('#productPid').val(); // Get pid from hidden input field

                                    if (size === '' || color === '') {
                                        alert('Please select both size and color.');
                                        return;
                                    }

                                    $.ajax({
                                        url: 'AddNewStockController',
                                        method: 'POST',
                                        data: {
                                            size: size,
                                            color: color,
                                            stockcount: stockcount,
                                            pid: pid
                                        },
                                        success: function (response) {
                                            if (response === 'exists') {
                                                $('#errorText').text('This Product Item already exists');
                                            } else {
                                                if (size === 'All' || color === 'All') {
                                                    if (confirm('Are you sure you want to add stock for all sizes or colors?')) {
                                                        console.log('Adding stock for all sizes or colors...');
                                                        location.reload();
                                                    } else {
                                                        return;
                                                    }
                                                } else {
                                                    console.log('Adding stock for size ' + size + ' and color ' + color + '...');
                                                    $.ajax({
                                                        url: 'addStock',
                                                        method: 'POST',
                                                        data: {
                                                            size: size,
                                                            color: color,
                                                            stockcount: stockcount,
                                                            pid: pid
                                                        },
                                                        success: function (response) {
                                                            console.log('Stock added successfully.');
                                                            location.reload();
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error('Error adding stock:', error);
                                                            location.reload();

                                                        }
                                                    });
                                                }
                                            }
                                        }
                                    });
                                }

                                function reloadDataTable() {
                                    var table = $('#stock-table').DataTable();
                                    table.clear().draw();

                                    table.ajax.reload(function (json) {
                                        console.log('DataTable reloaded.');
                                    });
                                }
                                function addStockCountMulti() {
                                    var size = $('#sizeSelectMulti').val();
                                    var color = $('#colorSelectMulti').val();
                                    var stockAdjustment = parseInt($('#stockAdjustment').val());
                                    var adjustmentType = $('#adjustmentType').val();
                                    var pid = $('#productPid').val();

                                    if (size === '' || color === '') {
                                        alert('Please select both size and color.');
                                        return;
                                    }
                                    var isAllSizes = (size === 'All');
                                    var isAllColors = (color === 'All');

                                    $.ajax({
                                        url: 'AddStockCountMultiController',
                                        method: 'POST',
                                        data: {
                                            size: size,
                                            color: color,
                                            stockAdjustment: stockAdjustment,
                                            adjustmentType: adjustmentType,
                                            pid: pid,
                                            isAllSizes: isAllSizes,
                                            isAllColors: isAllColors
                                        },
                                        success: function (response) {
                                            if (response === 'error') {
                                                $('#errorTextMulti').text('Error adding stock count.');
                                            } else {
                                                console.log('Stock count updated successfully.');
                                                location.reload(); // Reload the page or update table as needed
                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            console.error('Error adding stock count:', error);
                                            alert('Error adding stock count.');
                                        }
                                    });
                                }

                                function quickAdjustStock(amount) {
                                    $('#sizeSelectMulti').val('All');
                                    $('#colorSelectMulti').val('All');
                                    $('#stockAdjustment').val(Math.abs(amount));
                                    $('#adjustmentType').val((amount >= 0) ? 'increase' : 'decrease');
                                    addStockCountMulti();
                                }

                                function quickAdjustStockCustom() {
                                    var customAmount = parseInt($('#customAdjustment').val());
                                    if (!isNaN(customAmount)) {
                                        $('#sizeSelectMulti').val('All');
                                        $('#colorSelectMulti').val('All');
                                        var adjustmentType = (customAmount >= 0) ? 'increase' : 'decrease';
                                        $('#stockAdjustment').val(Math.abs(customAmount));
                                        $('#adjustmentType').val(adjustmentType);
                                        addStockCountMulti();
                                    } else {
                                        $('#errorTextMulti').text('Please enter a valid custom amount.');
                                    }
                                }

        </script>
    </body>
</html>
