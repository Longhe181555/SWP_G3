<%-- 
    Document   : ViewAllStaffAccount
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
                    <th></th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addStaffModal">
            Add New Staff
        </button>
        <!-- The Modal -->
        <div class="modal fade" id="addStaffModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Add New Staff</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal Body -->
                    <div class="modal-body">
                        <form id="addStaffForm">
                            <div class="form-group">
                                <label for="username">Username:</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                            <div class="form-group">
                                <label for="fullname">Fullname:</label>
                                <input type="text" class="form-control" id="fullname" name="fullname" required>
                            </div>
                            <div class="form-group">
                                <label for="phoneNumber">Phone Number:</label>
                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
                            </div>
                            <div class="form-group">
                                <label for="address">Address:</label>
                                <input type="text" class="form-control" id="address" name="address" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password:</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                        </form>
                    </div>

                    <!-- Modal Footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" form="addStaffForm" class="btn btn-primary">Add Staff</button>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#addStaffForm').on('submit', function (event) {
                    event.preventDefault();
                    var username = $('#username').val();
                    var fullname = $('#fullname').val();
                    var email = $('#email').val();
                    var password = $('#password').val();
                    var address = $('#address').val();
                    var phoneNumber = $('phoneNumber').val();

                    $.ajax({
                        url: 'admin-staff-account', // replace with your servlet URL
                        method: 'POST',
                        data: {
                            username: username,
                            fullname: fullname,
                            email: email,
                            password: password,
                            address: address,
                            phoneNumber: phoneNumber
                        },
                        success: function (response) {
                            // handle success
                            alert(response);
                            // You can close the modal here if needed
                            $('#addStaffModal').modal('hide');
                            window.location.reload();
                        },
                        error: function (xhr, status, error) {
                            // handle error
                            alert('Error adding staff:' + error);
                            $('#addStaffModal').modal('hide');
                        }
                    });
                });

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
                        address: item.address || '',
                        aid : item.aid
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
                        {data: 'address'},
                        {
                            data: null,
                            className: "center",
                            render: function (data, type, row) {
                                return '<a href="admin-edit-staff?id=' + row.aid + '">Edit staff</a>';
                            }
                        }
                    ]
                });
            });
        </script>
    </body>
</html>
