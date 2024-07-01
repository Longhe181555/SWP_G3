<%-- 
    Document   : EditStaff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <title>Edit Staff</title>
    </head>
    <body>
        <%@include file="../public/navbar.jsp" %>
        <form method="POST" action="admin-edit-staff">
            <h2 style="color: red;">${error}</h2>
            <input type="hidden" name="id" value="${id}" />
            <div class="form-group">
                <label for="editEmail">Email:</label>
                <input type="email" class="form-control" id="editEmail" name="email" required value="${email}">
            </div>
            <div class="form-group">
                <label for="editAddress">Address:</label>
                <input type="text" class="form-control" id="editAddress" name="address" required value="${address}">
            </div>
            <div class="form-group">
                <label for="editPhoneNumber">Phone Number:</label>
                <input type="text" class="form-control" id="editPhoneNumber" name="phonenumber" required value="${phoneNumber}">
            </div>
            <button class="btn btn-primary" type="submit">Save changes</button>
        </form>
    </body>
</html>
