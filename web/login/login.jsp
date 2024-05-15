<%-- 
    Document   : login
    Created on : May 14, 2024, 11:46:00 PM
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
         <form action="login_auth" method="POST" class="login-form">
                    <div class="input-container">
                        Username: <input type="text" name="username"/>
                    </div>
                    <div class="input-container">
                        Password: <input type="password" name="password"/>
                    </div>
                    <div class="button-container">
                        <input type="submit" value="Login" style="background-color: #337ab7;
                               background-image: linear-gradient(rgb(51, 122, 183), rgb(51, 122, 183));
                               color: #fff; border: none; border-radius: 4px; box-shadow: #ffffff 0px 1px 0px 0px;padding: 4px 10px;  cursor: pointer;">
                    </div>
          </form>
    </body>
</html>
