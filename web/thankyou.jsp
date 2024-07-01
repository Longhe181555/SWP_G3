<%-- 
    Document   : productdetail
    Created on : May 22, 2024, 10:30:02 AM
    Author     : biggp
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <title>JSP Page</title>
        <style>

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
                text-decoration: underline; /* Underline the active option */
            }
            .header-link:hover {
                color: #ffcc00; /* Change to any color you like */
                text-shadow: 0 0 10px rgba(255, 204, 0, 0.5); /* Adjust glow effect */
            }
            .header-link {
                margin: 0 10px;
                color: white;
                text-decoration: none;
                cursor: pointer;
                transition: color 0.3s ease, text-shadow 0.3s ease;
            }
            .rating-stars {
                color: gold;
            }
            .d-flex {
                display: flex;
            }

            .align-items-center {
                align-items: center;
            }

            .me-2 {
                margin-right: 0.5rem;
            }

            .me-3 {
                margin-right: 1rem;
            }

            .flex-wrap {
                flex-wrap: wrap;
            }

            .form-check {
                display: flex;
                align-items: center;
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
                        <p class="header-link"> Checkout</p>||
                        <a href="logout" class="header-link">Logout</a>
                    </div>
                </div>
            </div>

        </div>
        <main>
            <div class="mb-4 pb-4"></div>
            <section class="cd-position-relative cd-z-index-1 cd-padding-y-2xl">
                <div class="cd-container cd-max-width-adaptive-sm cd-text-center">
                    <svg class="cd-icon thank-you__icon cd-margin-bottom-sm" viewBox="0 0 96 96" aria-hidden="true">
                    <g fill="currentColor">
                    <circle cx="48" cy="48" r="48" opacity=".1"></circle>
                    <circle cx="48" cy="48" r="31" opacity=".2"></circle>
                    <circle cx="48" cy="48" r="15" opacity=".3"></circle>
                    <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M40 48.5l5 5 11-11"></path>
                    <path transform="rotate(25.474 70.507 8.373)" opacity=".5" d="M68.926 4.12h3.159v8.506h-3.159z"></path>
                    <path transform="rotate(-52.869 17.081 41.485)" opacity=".5" d="M16.097 36.336h1.969v10.298h-1.969z"></path>
                    <path transform="rotate(82.271 75.128 61.041)" opacity=".5" d="M74.144 57.268h1.969v7.547h-1.969z"></path>
                    <circle cx="86.321" cy="41.45" r="2.946" opacity=".5"></circle>
                    <circle cx="26.171" cy="78.611" r="1.473" opacity=".5"></circle>
                    <circle cx="49.473" cy="9.847" r="1.473" opacity=".5"></circle>
                    <circle cx="10.283" cy="63" r="2.946" opacity=".2"></circle>
                    <path opacity=".4" d="M59.948 88.142l10.558-3.603-4.888-4.455-5.67 8.058z"></path>
                    <path opacity=".3" d="M18.512 19.236l5.667 1.456.519-8.738-6.186 7.282z"></path>
                    </g>
                    </svg>

                    <div>
                        <h1 class="cd-margin-bottom-xs">Thank you!</h1>
                        <p class="thank-you__paragraph cd-margin-bottom-xs">Your order has been placed successfully and will be delivered to you soon.</p>

                        <p><a class="cd-link" href="homepage">Continue shopping →</a></p>
                    </div>
                </div>
            </section>
        </main>
        <style>
            /* reset */
            *, *::after, *::before {
                box-sizing: border-box;
            }

            * {
                font: inherit;
                margin: 0;
                padding: 0;
                border: 0;
            }

            html {
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
            }

            body {
                background-color: hsl(0, 0%, 100%);
                font-family: system-ui, sans-serif;
                color: hsl(230, 7%, 23%);
                font-size: 1.125rem; /* 18px */
                line-height: 1.4;
            }

            h1, h2, h3, h4 {
                line-height: 1.2;
                color: hsl(230, 13%, 9%);
                font-weight: 700;
            }

            h1 {
                font-size: 2.5rem; /* 40px */
            }

            h2 {
                font-size: 2.125rem; /* 34px */
            }

            h3 {
                font-size: 1.75rem; /* 28px */
            }

            h4 {
                font-size: 1.375rem; /* 22px */
            }

            ol, ul, menu {
                list-style: none;
            }

            button, input, textarea, select {
                background-color: transparent;
                border-radius: 0;
                color: inherit;
                line-height: inherit;
                -webkit-appearance: none;
                appearance: none;
            }

            textarea {
                resize: vertical;
                overflow: auto;
                vertical-align: top;
            }

            a {
                color: hsl(250, 84%, 54%);
            }

            table {
                border-collapse: collapse;
                border-spacing: 0;
            }

            img, video, svg {
                display: block;
                max-width: 100%;
            }

            /* -------------------------------- 
            
            Icons 
            
            -------------------------------- */

            .cd-icon {
                --size: 1em;
                font-size: var(--size);
                height: 1em;
                width: 1em;
                display: inline-block;
                color: inherit;
                fill: currentColor;
                line-height: 1;
                flex-shrink: 0;
                max-width: initial;
            }

            /* --------------------------------
            
            Component 
            
            -------------------------------- */

            .thank-you__icon {
                --size: 96px;
                color: hsl(170, 78%, 36%);
            }

            .thank-you__paragraph {
                line-height: 1.4;
                color: hsl(225, 4%, 47%);
            }

            /* -------------------------------- 
            
            Utilities 
            
            -------------------------------- */

            .cd-position-relative {
                position: relative;
            }

            .cd-z-index-1 {
                z-index: 1;
            }

            .cd-margin-bottom-xs {
                margin-bottom: 1rem;
            }

            .cd-padding-y-2xl {
                padding-top: 7rem;
                padding-bottom: 7rem;
            }

            .cd-container {
                width: calc(100% - 3rem);
                margin-left: auto;
                margin-right: auto;
            }

            .cd-max-width-adaptive-sm {
                max-width: 32rem;
            }

            @media (min-width: 48rem) {
                .cd-max-width-adaptive-sm {
                    max-width: 48rem;
                }
            }

            .cd-text-center {
                text-align: center;
            }

            /* link */
            .cd-link {
                color: hsl(250, 84%, 54%);
                text-decoration: none;
                background-image: linear-gradient(to right, hsl(250, 84%, 54%) 50%, hsla(250, 84%, 54%, 0.2) 50%);
                background-size: 200% 1px;
                background-repeat: no-repeat;
                background-position: 100% 100%;
                transition: background-position 0.2s;
            }

            .cd-link:hover {
                background-position: 0% 100%;
            }

        </style>
        <div class="mb-5 pb-xl-5"></div>


        <script>
            function goToHomepage() {
                window.location.href = '<%= request.getContextPath() %>/homepage';
            }
        </script>


        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
