<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Home</title>
    <link href="../CSS/style.css" rel="stylesheet" type="text/css">
</head>
<body>
    <section id="header">
        <div class="header-left">
            <a href="../JSP/UserHome.jsp"><img src="../IMG/logo.png" alt="Index" width="180" height="70"></a>
        </div>
        <div class="header-right">
            <input type="text" placeholder="Search.."><img src="../ICON/search.svg" width="30" height="30">
            <a href="../JSP/Cart.jsp"><img src="../ICON/cart.svg" alt="Cart" width="45" height="45"></a>
            <div class="avatar-container">
                <img src="../ICON/avatar.svg" alt="Login" width="40" height="40">
                <div class="dropdown-menu">
                    <%
                        Long userID = (Long) session.getAttribute("userID");
                        String username = (String) session.getAttribute("username");
                        
                    %>
                    <a style="pointer-events: none;">Username: <%= username %></a>
                    <a href="../JSP/UserProfile.jsp">User Profile</a>
                    <a href="<%= request.getContextPath() %>/LogoutServlet" >Log Out</a>
                </div>
            </div>
        </div>
    </section>

    <!-- 欢迎语区域 -->
    <h1>
            Registration Successfully
    </h1>

    <a href="../JSP/CustomerManagement.jsp">Cust management</a>
</body>
</html>