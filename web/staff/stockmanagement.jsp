<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Stock Management</title>
    <link href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css" rel="stylesheet">
    <style>
        .placeholder {
            height: 64px;
            width: 100%;
        }
        .red {
            color: red;
        }
        .yellow {
            color: yellow;
        }
        .green {
            color: green;
        }
    </style>
</head>
<body>
    <%@ include file="../public/navbar.jsp" %>
    <div class="container" style="margin-top:40px">
        <div>
            <a id="btnManageProducts" class="btn btn-primary" href="pmanagement">Manage Products</a>
        </div>
        <div class="container" style="margin-top:20px">
            <div>
                <table id="stock-table" class="table table-striped">
                    <thead>
                        <tr>
                            <th scope="col">Product ID</th>
                            <th scope="col">Image</th>
                            <th scope="col">Product Name</th>
                            <th scope="col">Stock Count</th>
                            <th scope="col">Is Listed</th>
                            <th scope="col">Added Date</th>
                            <th scope="col">Actions</th>
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
            // Initialize DataTable with checkboxes
            var table = $('#stock-table').DataTable({
                columns: [
                    {data: 'productId'},
                    {data: 'image'},
                    {data: 'productName'},
                    {data: 'stockCount'},
                    {data: 'isListed'},
                    {data: 'addedDate'},
                    {data: 'actions'}
                ],
                order: [[2, 'desc']], 
                paging: true,
                searching: true,
                info: true
            });

            // Fetch stock items data via AJAX
            $.ajax({
                url: 'getStockItems',
                method: 'GET',
                success: function (data) {
                    var dataSet = data.map(function (item) {
                        var stockCount = item.stockcount;
                        var stockClass = '';
                        if (stockCount === 0) {
                            stockClass = 'red';
                        } else if (stockCount < 50) {
                            stockClass = 'yellow';
                        } else {
                            stockClass = 'green';
                        }

                        return {
                            productId: item.product.pid,
                            image: '<img src="' + item.product.productimgs[0].imgpath + '" class="card-img-top img-fluid" alt="' + item.pname + '" style="width:50px;height:50px">',
                            productName: item.product.pname,
                            stockCount: '<span class="' + stockClass + '">' + stockCount + '</span>',
                            isListed: item.product.isListed ? 'Yes' : 'No', // Display as text
                            addedDate: item.product.date, // Display the date
                            actions: '<form action="productstock" method="get" style="display:inline-block;">' +
                                    '<input type="hidden" name="pid" value="' + item.product.pid + '" />' +
                                    '<button type="button" class="btn btn-primary btn-sm update-button">Update Stock</button>' +
                                    '</form>'
                        };
                    });

                    table.clear().rows.add(dataSet).draw(); // Populate DataTable with data
                },
                error: function (xhr, status, error) {
                    console.error('AJAX Error:', error);
                }
            });

            // Handle update button click
            $('#stock-table').on('click', '.update-button', function () {
                var form = $(this).closest('form');
                var confirmed = confirm('Do you want to update this stock item?');
                if (confirmed) {
                    form.submit();
                }
            });
        });
    </script>
      <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
</body>
</html>
