<%-- 
    Document   : AboutUs
    Created on : Apr 28, 2025, 10:47:37 AM
    Author     : tsm11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Homepage</title>
        <!-- Font Awesome CDN Link -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <!-- CSS -->
        <link rel="stylesheet" href="../CSS/home.css?v=3">
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
            <a href="GuestHome.jsp" class="logo">
                <img src="../ICON/logo2.png" alt="Glowy Days Logo">
            </a>
            <div class="navbar">
                <a href="GuestHome.jsp">Home</a>
                <a href="<%= request.getContextPath()%>/ProductServlet">Product</a>
                <a href="<%= request.getContextPath()%>/PromotionProductsServlet">Promotion</a>              
                <a href="AboutUs.jsp">About Us</a>                           
            </div>
            <div class="icons">
                <div class="search-wrapper">
                    <i class="fa-solid fa-magnifying-glass" id="search-icon"></i>
                    <input type="text" id="search-box" placeholder="Search..." />
                </div>
                <a href="<%= request.getContextPath()%>/LoadCartServlet" class="fa-solid fa-cart-shopping"></a>    
                <div class="avatar-container">
                    <i class="fa-regular fa-user" style="font-size:18px; cursor:pointer;"></i> 
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="AddNewUser.jsp">Register</a>
                        <a class="dropdown-item" href="Login.jsp">Log In</a>
                    </div>
                </div>
            </div>
        </section>  
                    
       <!-- About Us Section -->
<section class="about-us">
    <div class="about-container">
        <div class="about-flex-container">
            <!-- Video Section (Left Side) -->
            <div class="about-video">
                <video controls autoplay muted>
                    <source src="../Video/AboutUs.mp4" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
            </div>
            
            <!-- About Us Content (Right Side) -->
            <div class="about-text">
                <div class="story-section">
                    <h2>Our Story</h2>
                    <p>Founded in 2020, GLOWY DAYS was born from a passion for creating effective, affordable skincare that delivers real results. Our journey began when our founder, struggling with skin issues herself, couldn't find products that were both gentle and effective.</p>
                </div>
                
                <div class="mission-section">
                    <h2>Our Mission</h2>
                    <p>At GLOWY DAYS, we believe everyone deserves to feel confident in their skin. Our mission is to provide high-quality skincare products that are accessible to all, formulated with clean ingredients that deliver visible results.</p>
                </div>
                
                <div class="mission-section">
                    <h2>Our Products</h2>
                     <p>Each GLOWY DAYS product is thoughtfully formulated to address specific skin concerns while maintaining the skin's natural balance. From our hydrating moisturizers to our gentle cleansers, every product is designed to help you achieve your best skin.</p>
                </div>
                
                <div class="mission-section">
                    <h2>Join Our Journey</h2>
                    <p>We're more than just a skincare brand—we're a community. Follow us on social media to stay updated on skincare tips, product launches, and special promotions. Your skin's journey to radiance starts with GLOWY DAYS!</p>
                </div>
                
            </div>
        </div>
        
        <!-- Additional Content -->
        <div class="about-content">
            <div class="values-container">
                <div class="value-box">
                    <i class="fas fa-leaf"></i>
                    <h3>Clean Ingredients</h3>
                    <p>We carefully select ingredients that are effective yet gentle on your skin.</p>
                </div>
                
                <div class="value-box">
                    <i class="fas fa-ban"></i>
                    <h3>Cruelty-Free</h3>
                    <p>We never test on animals and are committed to ethical practices.</p>
                </div>
                
                <div class="value-box">
                    <i class="fas fa-recycle"></i>
                    <h3>Eco-Friendly</h3>
                    <p>Our packaging is designed with sustainability in mind.</p>
                </div>
            </div>
        </div>
    </div>
</section>
    
    <section class="footer">
        <div class="box-container">

          <div class="box">
            <h3>Quick Links</h3>
            <a href="GuestHome.jsp"><i class="fas fa-angle-right"></i> Home</a>
            <a href="<%= request.getContextPath() %>/ProductServlet"><i class="fas fa-angle-right"></i> Product</a>
            <a href="<%= request.getContextPath() %>/PromotionProductsServlet"><i class="fas fa-angle-right"></i> Promotion</a>
            <a href="AboutUs.jsp"><i class="fas fa-angle-right"></i> About Us</a>
          </div>

          <div class="box">
            <h3>Extra Links</h3>
            <a href="#"><i class="fas fa-angle-right"></i> My Favorite</a>
            <a href="#"><i class="fas fa-angle-right"></i> My Orders</a>
            <a href="#"><i class="fas fa-angle-right"></i> Wishlist</a>
            <a href="#"><i class="fas fa-angle-right"></i> Terms of Use</a>
          </div>

          <div class="box">
            <h3>Contact Info</h3>
            <a href="#"><i class="fas fa-phone"></i> +6018-9064828</a>
            <a href="#"><i class="fas fa-phone"></i> +6012-3456789</a>
            <a href="mailto:glowydays05@gmail.com"><i class="fas fa-envelope"></i> glowydays05@gmail.com</a>
            <a href="#"><i class="fas fa-map-marker-alt"></i> Kuala Lumpur, Malaysia</a>

            <div class="share">
              <a href="https://www.facebook.com/" class="fab fa-facebook-f"></a>
              <a href="https://www.instagram.com/" class="fab fa-instagram"></a>
              <a href="https://x.com/" class="fab fa-twitter"></a>
            </div>
          </div>

          <div class="box">
            <h3>Newsletter</h3>
            <p>Subscribe for Latest Updates</p>
            <form action="">
              <input type="email" placeholder="Enter your email" class="email">
              <input type="submit" value="Subscribe" class="btn">
            </form>
          </div>

        </div>
     </section>
    </body>
    <script src="../JavaScript/main.js"></script>
</html>