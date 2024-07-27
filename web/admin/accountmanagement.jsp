<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css" rel="stylesheet">
        <title>Account Management</title>
    </head>
    <body>
        <%@ include file="../public/navbar.jsp" %>

        <div class="container-fluid" style="margin: 10px 20px">
            <h1>Account Management</h1>

            <!-- Buttons -->
            <div class="mb-3">
                <!-- Add New Staff/Admin Account button -->
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addAccountModal">Add New Staff/Admin Account</button>
            </div>

            <div class="mb-3">
                <label for="roleFilter" class="form-label">Filter by Role</label>
                <select id="roleFilter" class="form-select">
                    <option value="">All Roles</option>
                    <option value="customer">Customer</option>
                    <option value="staff">Staff</option>
                    <option value="admin">Admin</option>
                </select>
            </div>

            <table id="accountTable" class="display table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>AID</th>
                        <th>Full Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Gender</th>
                        <th>Birthdate</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Last Login</th>
                        <th>Action</th> 
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="account" items="${accounts}">
                        <tr>
                            <td>${account.aid}</td>
                            <td>${account.fullname}</td>
                            <td>${account.username}</td>
                            <td>${account.email}</td>
                            <td>${account.phonenumber}</td>
                            <td>${account.gender ? 'Male' : 'Female'}</td>
                            <td>${account.birthdate}</td>
                            <td>${account.role}</td>
                            <td>${account.status}</td>
                            <td class="last-login" data-date="${account.lastLogin}">${account.lastLogin}</td>
                            <td>
                                <a href="admin/accountdetail.jsp?aid=${account.aid}" class="btn btn-info btn-sm">Detail</a>
                                <c:if test="${account.role == 'staff'}">
                                    <button type="button" class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#editProfileModal${account.aid}">
                                        Edit Profile
                                    </button>
                                </c:if>
                            </td>
                        </tr>

                        <!-- Modal for editing account -->
                    <div class="modal fade" id="editProfileModal${account.aid}" tabindex="-1" role="dialog" aria-labelledby="editProfileModalLabel${account.aid}" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editProfileModalLabel${account.aid}">Edit Staff Profile</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="admin/updateaccount" method="post">
                                        <input type="hidden" id="edit-aid${account.aid}" name="aid" value="${account.aid}">
                                        <div class="form-group">
                                            <label for="edit-fullname${account.aid}">Full Name</label>
                                            <input type="text" class="form-control" id="edit-fullname${account.aid}" name="fullname" value="${account.fullname}" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="edit-username${account.aid}">Username</label>
                                            <input type="text" class="form-control" id="edit-username${account.aid}" name="username" value="${account.username}" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="edit-password${account.aid}">Password</label>
                                            <input type="password" class="form-control" id="edit-password${account.aid}" name="password" required value="*******">
                                        </div>
                                        <div class="form-group">
                                            <label for="edit-email${account.aid}">Email</label>
                                            <input type="email" class="form-control" id="edit-email${account.aid}" name="email" value="${account.email}" required pattern="^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$" title="Enter a valid email address.">
                                        </div>
                                        <div class="form-group">
                                            <label for="edit-phonenumber${account.aid}">Phone Number</label>
                                            <input type="text" class="form-control" id="edit-phonenumber${account.aid}" name="phonenumber" value="${account.phonenumber}" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="edit-gender${account.aid}">Gender</label>
                                            <select class="form-control" id="edit-gender${account.aid}" name="gender" required>
                                                <option value="male" ${account.gender == 'male' ? 'selected' : ''}>Male</option>
                                                <option value="female" ${account.gender == 'female' ? 'selected' : ''}>Female</option>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Save Changes</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Modal for adding new account -->
        <div class="modal fade" id="addAccountModal" tabindex="-1" role="dialog" aria-labelledby="addAccountModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addAccountModalLabel">Add New Staff/Admin Account</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="admin/addaccount" method="post">
                            <div class="form-group">
                                <label for="fullname">Full Name</label>
                                <input type="text" class="form-control" id="fullname" name="fullname" required>
                            </div>
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,10}$" title="Password must be between 8 to 10 characters and include at least one uppercase letter, one lowercase letter, one digit, and one special character.">
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required pattern="^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$" title="Enter a valid email address.">
                            </div>
                            <div class="form-group">
                                <label for="phonenumber">Phone Number</label>
                                <input type="text" class="form-control" id="phonenumber" name="phonenumber" required>
                            </div>
                            <div class="form-group">
                                <label for="role">Role</label>
                                <select class="form-control" id="role" name="role">
                                    <option value="staff">Staff</option>
                                    <option value="admin">Admin</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Add Account</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#accountTable').DataTable();
            });
        </script>
    </body>
</html>
