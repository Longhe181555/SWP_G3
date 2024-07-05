<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <title>Profile</title>
    <style>
       
    </style>
</head>
<body>
    
    <%@ include file="../public/navbar.jsp" %>
    
    
    
    <hr style="width: 90%">
    <div class="container rounded bg-white mt-5 mb-5">
        <div class="row">
            <div class="col-md-3 border-right">
                <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                    <img src="${account.img}" alt="Profile Image" class="rounded-circle mt-5" width="150">
                </div>
            </div>
            <div class="col-md-5 border-right">
                <div class="p-3 py-5">
                    <form action="updateAccount" method="post">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-right">Profile</h4>
                        </div>
                        <div class="row mt-2">
                            <div class="col-md-12">
                                <label class="labels">Full Name</label>
                                <input type="text" class="form-control" placeholder="Full name" value="${account.username}" required name="fullname">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <label class="labels">Password</label>
                                <input type="password" class="form-control" placeholder="Password" value="${account.password}" readonly>
                                <a href="common/changepass.jsp">Change Password?</a></br>
                                <label class="labels">Email</label>
                                <input type="email" class="form-control" placeholder="Email" value="${account.email}" required name="email">
                                <label class="labels">Phone</label>
                                <input type="text" class="form-control" placeholder="Phone" value="${account.phonenumber}" required name="phone">
                                <label class="labels">Gender</label>
                                <select class="form-control" required name="gender">
                                    <option value="male" ${account.gender ? 'selected' : ''}>Male</option>
                                    <option value="female" ${!account.gender ? 'selected' : ''}>Female</option>
                                </select>
                                <label class="labels">Date of Birth</label>
                                <input type="date" class="form-control" value="${account.birthdate}" required name="dob">
                            </div>
                        </div>
                        <div class="mt-5 text-center">
                            <button class="btn btn-submit" type="submit">Save</button>
                            <button class="btn btn-cancel" type="reset">Cancel</button>
                        </div>
                        <c:if test="${not empty message}">
                            <div class="alert alert-info">${message}</div>
                        </c:if>
                    </form>
                                <a href="${pageContext.request.contextPath}/homepage" class="btn-cancel" style="text-decoration: none;padding: 5px">Back to homepage</a>

                </div>
            </div>
        </div>
    </div>
                              
</body>
</html>
