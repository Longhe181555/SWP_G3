<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Your JSP Page</title>
</head>
<body>
    <script>
        function redirectToDisplay() {
            window.location.href = "login_auth";
        }

        // Call the function when the page loads
        redirectToDisplay();
    </script>
</body>
</html>