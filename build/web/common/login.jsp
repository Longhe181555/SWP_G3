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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">       
        <title>SWP G3</title>
        
        <style>
                        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap');

            *{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Montserrat', sans-serif;
            }

            body{
                background-color: #c9d6ff;
                background: linear-gradient(to right, #e2e2e2, #c9d6ff);
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                height: 100vh;
            }

            .container{
                background-color: #fff;
                border-radius: 30px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);
                position: relative;
                overflow: hidden;
                width: 768px;
                max-width: 100%;
                min-height: 480px;
            }

            .container p{
                font-size: 14px;
                line-height: 20px;
                letter-spacing: 0.3px;
                margin: 20px 0;
            }

            .container span{
                font-size: 12px;
            }

            .container a{
                color: #333;
                font-size: 13px;
                text-decoration: none;
                margin: 15px 0 10px;
            }

            .container button{
                background-color: #512da8;
                color: #fff;
                font-size: 12px;
                padding: 10px 45px;
                border: 1px solid transparent;
                border-radius: 8px;
                font-weight: 600;
                letter-spacing: 0.5px;
                text-transform: uppercase;
                margin-top: 10px;
                cursor: pointer;
            }

            .container button.hidden{
                background-color: transparent;
                border-color: #fff;
            }

            .container form{
                background-color: #fff;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                padding: 0 40px;
                height: 100%;
            }

            .container input{
                background-color: #eee;
                border: none;
                margin: 8px 0;
                padding: 10px 15px;
                font-size: 13px;
                border-radius: 8px;
                width: 100%;
                outline: none;
            }

            .form-container{
                position: absolute;
                top: 0;
                height: 100%;
                transition: all 0.6s ease-in-out;
            }

            .sign-in{
                left: 0;
                width: 50%;
                z-index: 2;
            }

            .container.active .sign-in{
                transform: translateX(100%);
            }

            .sign-up{
                left: 0;
                width: 50%;
                opacity: 0;
                z-index: 1;
            }

            .container.active .sign-up{
                transform: translateX(100%);
                opacity: 1;
                z-index: 5;
                animation: move 0.6s;
            }

            @keyframes move{
                0%, 49.99%{
                    opacity: 0;
                    z-index: 1;
                }
                50%, 100%{
                    opacity: 1;
                    z-index: 5;
                }
            }

            .social-icons{
                margin: 20px 0;
            }

            .social-icons a{
                border: 1px solid #ccc;
                border-radius: 20%;
                display: inline-flex;
                justify-content: center;
                align-items: center;
                margin: 0 3px;
                width: 40px;
                height: 40px;
            }

            .toggle-container{
                position: absolute;
                top: 0;
                left: 50%;
                width: 50%;
                height: 100%;
                overflow: hidden;
                transition: all 0.6s ease-in-out;
                border-radius: 150px 0 0 100px;
                z-index: 1000;
            }

            .container.active .toggle-container{
                transform: translateX(-100%);
                border-radius: 0 150px 100px 0;
            }

            .toggle{
                background-color: #512da8;
                height: 100%;
                background: linear-gradient(to right, #5c6bc0, #512da8);
                color: #fff;
                position: relative;
                left: -100%;
                height: 100%;
                width: 200%;
                transform: translateX(0);
                transition: all 0.6s ease-in-out;
            }

            .container.active .toggle{
                transform: translateX(50%);
            }

            .toggle-panel{
                position: absolute;
                width: 50%;
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                padding: 0 30px;
                text-align: center;
                top: 0;
                transform: translateX(0);
                transition: all 0.6s ease-in-out;
            }

            .toggle-left{
                transform: translateX(-200%);
            }

            .container.active .toggle-left{
                transform: translateX(0);
            }

            .toggle-right{
                right: 0;
                transform: translateX(0);
            }

            .container.active .toggle-right{
                transform: translateX(200%);
            }
        </style>
    </head>
    
    
    <!--Đây là form để đăng kí tài khoản-->
    <div class="container" id="container">
        <div class="form-container sign-up">
            <form action="signup" method="POST">
                <h1>Create Account</h1>
                <div class="social-icons">
                    <a href="#" class="icon"><i class="fa-brands fa-google-plus-g"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-github"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-linkedin-in"></i></a>
                </div>
                <span>or use your email for registeration</span>
                <input type="text" name="name" placeholder="Name">
                <input type="email" name="email" placeholder="Email">
                <input type="password" name="password" placeholder="Password">
                <button>Sign Up</button>
            </form>
        </div>
        
        
        <div class="form-container sign-in">
            
            <form action="login" method="POST">
                <h1>Sign In</h1>
                <div class="social-icons">
                    <a href="#" class="icon"><i class="fa-brands fa-google-plus-g"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-github"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-linkedin-in"></i></a>
                </div>
                <span>or use your email password</span>
                <input type="text" name="username" placeholder="User name"/>
                <input type="password" placeholder="Password" name="password"/>
                <a href="#">Forget Your Password?</a>
                <input type="submit" value="Login">
            </form>
        </div>
        
        
        
        <div class="toggle-container">
            <div class="toggle">
                <div class="toggle-panel toggle-left">
                    <h1>Look like you are not Logged in</h1>
                    <p>Sign in/Login now</p>
                    <button class="hidden" id="login">Sign In</button>
                </div>
                <div class="toggle-panel toggle-right">
                    <h1>Look like you are not Logged in</h1>
                    <p>Sign in/Login now</p>
                    <button class="hidden" id="register">Sign Up</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        const container = document.getElementById('container');
        const registerBtn = document.getElementById('register');
        const loginBtn = document.getElementById('login');

        registerBtn.addEventListener('click', () => {
            container.classList.add("active");
        });

        loginBtn.addEventListener('click', () => {
            container.classList.remove("active");
        });
        // Check if there's an error and activate sign-up form
        <% if (request.getAttribute("signupError") != null) { %>
        container.classList.add("active");
        <% } %>
    </script>
</body>
    
    
    
    
<!--    <body>
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
        
    </body>-->
</html>
