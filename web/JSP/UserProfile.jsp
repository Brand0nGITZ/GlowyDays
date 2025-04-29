<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Homepage</title>
        <!-- Font Awesome CDN Link -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <!-- CSS -->
        <link rel="stylesheet" href="../CSS/home.css?v=4">
        <link rel="stylesheet" href="../CSS/UserProfile.css?v=4">
        <!-- <link rel="stylesheet" href="../CSS/home.css?v=2"> -->
            <style>
        .logo img {
            width: 90px; /* Adjust the width according to your design */
            height: 60px; /* Keep aspect ratio */
            display: block;
        }
    </style>
    </head>
    <body>
         <section id="header" class="header">
    <a href="UserHome.jsp" class="logo">
        <img src="../ICON/logo2.png" alt="Glowy Days Logo">
    </a>
    <div class="navbar">
        <a href="UserHome.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/ProductServlet">Product</a>
        <a href="<%= request.getContextPath() %>/PromotionProductsServlet">Promotion</a>              
        <a href="AboutUs.jsp">About Us</a>                           
    </div>
    <div class="icons">
        <div class="search-wrapper">
            <i class="fa-solid fa-magnifying-glass" id="search-icon"></i>
            <input type="text" id="search-box" placeholder="Search..." />
        </div>
        <a href="<%= request.getContextPath() %>/LoadCartServlet" class="fa-solid fa-cart-shopping"></a>    
        <div class="avatar-container">
            <i class="fa-regular fa-user" style="font-size:18px; cursor:pointer;"></i> 
            <div class="dropdown-menu">
              
             
                <a class="dropdown-item" href="UserProfile.jsp">User Profile</a>
                <a class="dropdown-item" href="<%= request.getContextPath() %>/LogoutServlet">Log Out</a>
            </div>
        </div>
    </div>
</section>
       <%
            String name = (String) session.getAttribute("name");
            String username = (String) session.getAttribute("username");
            String birth = (String) session.getAttribute("birth");
            String email = (String) session.getAttribute("email");
            String mobileNo = (String) session.getAttribute("mobileNo");
        %>

        <div class="profile-container">
            <div class="profile-box">
                <!-- Navbar (Left Side) -->
                <div class="profile-nav">
                    <ul>
                        <!-- User Dropdown -->
                        <li class="dropdown">
                            <h1 style="font-size: 1.8rem; margin-bottom: 14px;">User Details</h1>
                            <ul class="dropdown-content">
                                <li><a href="UserDetails.jsp">Edit User Details</a></li>
                                <li><a href="NewPassword.jsp">Change Password</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                            <!-- User Details Content (Right Side) -->
                <div class="profile-content">
                    <div id="userDetails" class="profile-section">
                        <fieldset>
                            <!-- Name Field -->
                            <div class="form-group">
                                <label for="name">Full Name:</label>
                                <input type="text" id="name" name="name" value="<%= name %>" readonly>
                            </div>

                            <!-- Username Field -->
                            <div class="form-group">
                                <label for="username">Username:</label>
                                <input type="text" id="username" name="username" value="<%= username %>" readonly>
                            </div>

                            <!-- Birth -->
                            <div class="form-group">
                                <label for="birthday">Birth date:</label>
                             <input type="date" id="birth" name="birth" value="<%= birth %>" readonly>
                            </div>

                            <!-- Email Field -->
                            <div class="form-group">
                                <label for="emailInput">Email:</label>
                                <input type="email" id="email" name="email" value="<%= email %>" readonly>
                            </div>

                            <!-- Mobile Number Field -->
                            <div class="form-group">
                                <label for="phoneInput">Mobile Number:</label>
                                <input type="tel" id="mobileNo" name="mobileNo" value="<%= mobileNo %>" readonly>
                            </div>
                            
                            <p id="message" style="color: gray; font-size: 13px; text-align: center;">This page is for display purposes only. Click the edit option to modify your user profile.</p>
                        </fieldset>
                    </div>
                </div>
                            
            </div>
                            
                            
        </div>
                            
                            
                        
    </body>
</html>