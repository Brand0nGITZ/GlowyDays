<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter OTP</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="../CSS/OTP.css?v=3" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
    <!-- Header - Keeping as is -->
    <section id="header" class="header">   
        <a href="GuestHome.jsp"><h2 style="font-weight: bolder; font-size: 3rem; color: black;">GLOWY DAYS</h2></a>
        <div class="navbar">
            <a href="GuestHome.jsp">Home</a>
            <a href="Product.jsp">Product</a>
            <a href="">About Us</a>               
            <a href="">Contact Us</a>                             
        </div>
        <div class="icons">
            <div class="search-wrapper">
                <i class="fa-solid fa-magnifying-glass" id="search-icon"></i>
                <input type="text" id="search-box" placeholder="Search..." />
            </div>
            <a href="" class="fa-solid fa-cart-shopping"></a>    
            <a href="UserRegister.jsp" class="fa-regular fa-user"></a>
        </div>
    </section>

    <div class="otp-container">
        <div class="otp-card">
            <h1 class="otp-title">Enter OTP</h1>
           
            
            <%
                String message = (String) session.getAttribute("message");
                if (message != null) {
            %>
                <p class="success-message"><%= message %></p>
            <%
                    session.removeAttribute("message");
                } else {
            %>
                <p class="info-message">OTP is sent to your email.</p>
            <%
                }
            %>
            
            <form action="<%= request.getContextPath() %>/ValidateOtp" method="post" autocomplete="off" class="otp-form">
                <div class="input-group">
                    <input id="otp" name="otp" placeholder="Enter OTP" type="text" required>
                </div>
                
                <input type="hidden" name="email" value="<%= session.getAttribute("email") %>">
                
                <button type="submit" class="reset-btn">Reset Password</button>
            </form>
        </div>
    </div>
    
    <!-- Footer - Keeping as is -->
    <section class="footer">
        <div class="box-container">
            <div class="box">
                <h3>Quick Links</h3>
                <a href="#"><i class="fas fa-angle-right"></i> Home</a>
                <a href="#"><i class="fas fa-angle-right"></i> Product</a>
                <a href="#"><i class="fas fa-angle-right"></i> About Us</a>
                <a href="#"><i class="fas fa-angle-right"></i> Contact Us</a>
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
                <a href="#"><i class="fas fa-envelope"></i> tansm-wm23@student.tarc.edu.my</a>
                <a href="#"><i class="fas fa-map-marker-alt"></i> Kuala Lumpur, Malaysia</a>

                <div class="share">
                    <a href="#" class="fab fa-facebook-f"></a>
                    <a href="#" class="fab fa-instagram"></a>
                    <a href="#" class="fab fa-twitter"></a>
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
    
    <script src="../JavaScript/main.js"></script>
</body>
</html>