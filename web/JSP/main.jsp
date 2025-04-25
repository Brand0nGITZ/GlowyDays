<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Promotion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Homepage</title>
        <!-- Font Awesome CDN Link -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <!-- CSS -->
        <link rel="stylesheet" href="../CSS/home.css?v=3">
     

    </head>
    <body>
         <section id="header" class="header">   
             <a href="GuestHome.jsp"><h2 style="font-weight: bolder; font-size: 3rem; color: black;">GLOWY DAYS</h2></a>
               <div class="navbar">
                    <a href="">Home</a>
                    <div class="dropdown">
                        <a href="<%= request.getContextPath() %>/ProductServlet">Product</a>
                        <div class="dropdown-content">
                            <a href="<%= request.getContextPath() %>/PromotionProductsServlet">Promotion</a>
                            <a href="#">Makeup</a>
                            <a href="#">Hair Care</a>
                            <a href="#">Body Care</a>
                            <a href="#">Fragrance</a>
                            <a href="#">Tools</a>
                            <a href="#">Men's Care</a>
                            <a href="#">Sets & Gifts</a>
                        </div>
                            
                            
                            
                            
                    </div>
                    <a href="">About Us</a>               
                    <a href="">Contact Us</a>                             
               </div>
               <div class="icons">
                    <div class="search-wrapper">
                        <i class="fa-solid fa-magnifying-glass" id="search-icon"></i>
                        <input type="text" id="search-box" placeholder="Search..." />
                    </div>
                    <a href="" class="fa-solid fa-cart-shopping"></a>    
                    <a href="" class="fa-regular fa-user"></a>
               </div>
        </section>
      
        <section class="home" id="home">
            <div class="slide active" style="background:url(../Slides/Slide_1.png); background-size: cover; 
            background-position: center;">
            <div class="content" >
                <span>Keep Your Beauty</span>
                <h3>Discover the essence of true beauty with our carefully curated skincare 
                    collection. where every product is designed to nourish, rejuvenate, and 
                    bring out your natural glow. Embrace confidence, radiance, and self-love 
                    in every step of your routine.
                </h3>
                <a href="#" class="btn">Read More</a>
            </div>    
            </div>
            
            <div class="slide" style="background:url(../Slides/Slide_2.png); background-size: cover; 
            background-position: center;">
            <div class="content" >
                <span>Keep Your Beauty</span>
                <h3>Discover the essence of true beauty with our carefully curated skincare 
                    collection. where every product is designed to nourish, rejuvenate, and 
                    bring out your natural glow. Embrace confidence, radiance, and self-love 
                    in every step of your routine.
                </h3>
                <a href="#" class="btn">Read More</a>
            </div>    
            </div>
            
            <div class="slide" style="background:url(../Slides/Slide_11.png); background-size: cover; 
            background-position: center;">
            <div class="content">
                <span>Keep Your Beauty</span>
                <h3>Discover the essence of true beauty with our carefully curated skincare 
                    collection. where every product is designed to nourish, rejuvenate, and 
                    bring out your natural glow. Embrace confidence, radiance, and self-love 
                    in every step of your routine.
                </h3>
                <a href="#" class="btn">Read More</a>
            </div>    
            </div>
            
            <div id="next-slide" onclick="next()" class="fas fa-angle-right"></div>
            <div id="prev-slide" onclick="prev()" class="fas fa-angle-left"></div>
        </section>  
        
        <section class="category">
            <div class="box-container">
                
                <a href="#" class="box">
                    <img src="../Category/Category_moisturizer.png">
                    <h3>moisturizer</h3>
                </a>
                
                <a href="#" class="box">
                    <img class="img" src="../Category/Category_eyecream.png">
                    <h3>eye cream</h3>
                </a>
                
                <a href="#" class="box">
                    <img class="img" src="../Category/Category_sunscreen.png">
                    <h3>sun screen</h3>
                </a>
                
                <a href="#" class="box">
                    <img class="img" src="../Category/Category_cleanser.png">
                    <h3>cleanser</h3>
                </a>
                
                <a href="#" class="box">
                    <img class="img" src="../Category/Category_ExfoliatingToner.png">
                    <h3>Exfoliating Toner</h3>
                </a>
                
                <a href="#" class="box">
                    <img class="img" src="../Category/Category_Retinol.png">
                    <h3>Retinol</h3>
                </a>                
            </div>
        </section>
        
        <section class="featured-section">
            <h2 class="section-title">Top Selling Products</h2>
            <div class="container">

              <!-- Cleanser Card -->
              <div class="card">
                <img src="../ProductImages/GlowyCleanser.jpg?height=200&width=400" alt="Glowy Cleanser" class="card__image">
                <div class="card__content">
                  <h2 class="card__title">Glowy Gentle Cleanser</h2>
                  <p class="card__description">A soothing facial cleanser that removes dirt and impurities without stripping your skin’s natural moisture. Perfect for daily use on all skin types.</p>
                  <button class="card__button">View Details</button>
                </div>
              </div>

              <!-- Toner Card -->
              <div class="card">
                <img src="../ProductImages/GlowyToner.jpg?height=200&width=400" alt="Glowy Toner" class="card__image">
                <div class="card__content">
                  <h2 class="card__title">Glowy Hydrating Toner</h2>
                  <p class="card__description">Refresh and rebalance your skin with our alcohol-free toner enriched with botanical extracts. Helps tighten pores and prepare your skin for the next steps.</p>
                  <button class="card__button">View Details</button>
                </div>
              </div>

              <!-- Vitamin C Serum Card -->
              <div class="card">
                <img src="../ProductImages/GlowyVitaminC.jpg?height=200&width=400" alt="Glowy Vitamin C Serum" class="card__image">
                <div class="card__content">
                  <h2 class="card__title">Glowy Vitamin C Serum</h2>
                  <p class="card__description">Brighten and even out your skin tone with this powerful antioxidant-rich serum. Helps reduce dark spots and gives your skin a radiant glow.</p>
                  <button class="card__button">View Details</button>
                </div>
              </div>

              <!-- Sunscreen Card -->
              <div class="card">
                <img src="../ProductImages/GlowySunscreen.jpg?height=200&width=400" alt="Glowy Sunscreen" class="card__image">
                <div class="card__content">
                  <h2 class="card__title">Glowy UV Defense Sunscreen</h2>
                  <p class="card__description">Protect your skin from harmful UVA & UVB rays with our lightweight, non-greasy sunscreen. Ideal for daily wear with no white cast.</p>
                  <button class="card__button">View Details</button>
                </div>
              </div>

            </div>
        </section>

        
        <section class="services">
  
            <div class="box">
              <i class="fa-solid fa-truck-fast"></i>
              <h3>Free Delivery</h3>
              <p>Enjoy fast and free nationwide shipping on all orders with no minimum <br> purchase required. Shop more, worry less.</p>
            </div>

            <div class="box">
              <i class="fa-solid fa-user-shield"></i>
              <h3>Secure Payment</h3>
              <p>Your transactions are encrypted and protected. We offer multiple trusted <br> payment options to keep your information safe.</p>
            </div>

            <div class="box">
              <i class="fa-solid fa-business-time"></i>
              <h3>24/7 Support</h3>
              <p>Need help? Our friendly customer support team is available around the clock <br> to assist you with any questions or issues.</p>
            </div>

        </section>
        
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

</html>
