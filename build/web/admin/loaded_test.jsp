<%-- 
    Document   : loaded_test
    Created on : May 15, 2024, 6:53:04 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="table">
            <h2>Account</h2>
            <a href="/SWP_G3_main/ChangePass">Change Password</a>
            <table border="1">
                <thead>
                    <tr>
                        <th>username</th>
                        <th>role</th>
                        <th>profile pic</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ac" items="${acs}">
                        <tr>
                            <td>${ac.username}</td>
                            <td>${ac.role}</td>
                            <td><img src="${pageContext.request.contextPath}/${ac.img}" height="100" width="100" alt="Product Image"></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <br>
        <div class="table">
            <h2>Product</h2>
            <table border="1">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Category</th>
                        <th>Brand</th>
                        <th>Image</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${ps}">
                        <tr>
                            <td>${p.pname}</td>
                            <td>${p.price}</td>
                            <td>${p.category.catname}</td>
                            <td>${p.brand.bname}</td>
                            <td>${test} hmm</td>
                            <td>
                                <c:forEach var="img" items="${p.productimgs}">
                                    <img src="${pageContext.request.contextPath}/${img.imgpath}" height="100" width="100" alt="Product Image">
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>





    </body>
</html>
