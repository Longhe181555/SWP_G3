<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
    <style>
        .container {
            width: 90%;
            margin: auto;
        }
        .rounded {
            border-radius: 0.25rem;
        }
        .bg-white {
            background-color: #fff;
        }
        .border-right {
            border-right: 1px solid #dee2e6;
        }
    
        .labels {
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 0.5rem;
            margin-top: 0.5rem;
            margin-bottom: 0.5rem;
        }
        .text-right {
            text-align: right;
        }
        a {
            color: blue;
            font-size: 12px;
        }
        .btn {
            padding: 0.5rem 1rem;
            margin-top: 1rem;
            margin-right: 0.5rem;
        }
        .btn-submit {
            background-color: #007bff;
            color: white;
            border: none;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
            border: none;
        }
        
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
                text-decoration: underline; 
            }
            .header-link:hover {
                color: #ffcc00; 
                text-shadow: 0 0 10px rgba(255, 204, 0, 0.5); /* Adjust glow effect */
            }
            .header-link {
                margin: 0 10px;
                color: white;
                text-decoration: none;
                cursor: pointer;
                transition: color 0.3s ease, text-shadow 0.3s ease;
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
                        <a href="logout" class="header-link">Logout</a>
                    </div>
                </div>
            </div>

            <div class="header-container">
                <div class="header-content">
                    <p>MEN'S WEAR</p>
                </div>
            </div> 
        </div>
    
    
    
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
                                <label class="labels">Address</label>
                                <input type="text" class="form-control" placeholder="Address" value="${account.address}" required name="address">
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
