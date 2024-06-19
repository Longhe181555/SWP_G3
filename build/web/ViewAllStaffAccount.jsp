<%-- 
    Document   : ViewAllStaffAccount
    Created on : Jun 5, 2024, 11:14:49 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Accounts</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <!-- DataTables CSS -->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- DataTables JS -->
        <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    </head>
    <body>
        <input type="hidden" value='${staffs}' id="staffs" />
        <table id="staff-table" class="table table-striped table-bordered" style="width:100%">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                    <th>Gender</th>
                    <th>Date Of Birth</th>
                    <th>Address</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <script>
            $(document).ready(function () {
                // Sample JSON data
                var jsonData = document.getElementById("staffs").value;
                // Parse JSON data
                var dataSet = JSON.parse(jsonData);
                dataSet = dataSet.map(function (item) {
                    return {
                        username: item.username || '',
                        email: item.email || '',
                        phonenumber: item.phonenumber || '',
                        gender: item.gender || '',
                        birthdate: item.birthdate || '',
                        address: item.address || ''
                    };
                });
                // Initialize DataTable
                $('#staff-table').DataTable({
                    data: dataSet,
                    columns: [
                        {data: 'username'},
                        {data: 'email'},
                        {data: 'phonenumber'},
                        {data: 'gender'},
                        {data: 'birthdate'},
                        {data: 'address'}
                    ]
                });
            });
        </script>
    </body>
</html>
