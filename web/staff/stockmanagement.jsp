<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stock Management</title>
        <link href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css" rel="stylesheet">
        <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
        <style>
            .placeholder {
                height: 64px;
                width: 100%;
            }
            .red {
                color: red;
            }
        </style>
    </head>
    <body>
        <%@ include file="../public/navbar.jsp" %>

  
        <input type="hidden" value='${stockList}' id="stockList" />
        <div class="container" style="margin-top:40px">
            <div>
         
            </div>
            <div class="container" style="margin-top:20px">
                <div>
                    <table id="stock-table" class="table table-striped">
                        <thead>
                            <tr>
                                <th scope="col">Stock Count</th>
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
                var jsonData = document.getElementById("stockList").value;
                var dataSet = JSON.parse(jsonData);
                dataSet = dataSet.map(function (item) {
                    return {
                        stockcount: item.stockcount || ''
                    };
                });
                $('#stock-table').DataTable({
                    data: dataSet,
                    columns: [
                        {data: 'stockcount'}
                    ]  
                });
            });
        </script>
    </body>
</html>
