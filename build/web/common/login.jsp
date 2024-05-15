<%-- 
    Document   : login
    Created on : May 15, 2024, 6:54:00 PM
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
        <p style="color: red;font: 40px;text-align: center">Connection:[ ${connection} ]- If empty sql is not connected</p>
        <div style="text-align: center">
            
            <form action="login" method="POST" class="login-form">
            <div class="input-container">
                Username: <input type="text" name="username"/>
            </div>
            <div class="input-container">
                Password: <input type="password" name="password"/>
            </div>
            <div class="button-container">
                <input type="submit" value="Login">
            </div>
        </form>
        </div>
        
    </body>
</html>
