<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/ProductCSS.css?v=5">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <title>Product</title>
        
        <style>
            .avatar-container {
                position: relative;
                display: inline-block;
            }

            .dropdown-menu {
                display: none;
                position: absolute;
                top: 45px;
                left: -10px;
                z-index: 1000;
            }

            .avatar-container .dropdown-menu a {
                /* 这样写就只影响avatar那边的下拉menu */
                display: block;
                text-decoration: none;
                color: black;
                background-color: white;
                width: 180px;
                border: 1px solid #ccc;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .avatar-container .dropdown-menu a:hover {
                background-color: #F9E075;
                color: black;
            }

            .avatar-container:hover .dropdown-menu {
                display: block;
            }

            .logo img {
                width: 90px; /* Adjust the width according to your design */
                height: 60px; /* Keep aspect ratio */
                display: block;
            }
        </style>
        
    </head>

    <body> 
        <section id="header" class="header">   
            <a href="GuestHome.jsp"><h2 style="font-weight: bolder; font-size: 3rem; color: black;">GLOWY DAYS</h2></a>
            <div class="navbar">
                <a href="UserHome.jsp">Home</a>
                <a href="<%= request.getContextPath() %>/ProductServlet">Product</a>
                <a href="<%= request.getContextPath() %>/PromotionProductsServlet">Promotion</a>              
                <a href="JSP/AboutUs.jsp">About Us</a>                             
            </div>
            <div class="icons">
                
    
                <div class="search-wrapper">
                    <i class="fa-solid fa-magnifying-glass" id="search-icon"></i>
                    <form id="search-box" action="<%= request.getContextPath()%>/SearchProductServlet" method="get">
                        <input type="text" name="query" placeholder="Search by ID or Name">
                    </form>
                </div>
               
                <a href="<%= request.getContextPath() %>/CartServlet" class="cart-icon fa-solid fa-cart-shopping">
                    <%
                        Integer cartSize = (Integer) session.getAttribute("cartSize");
                        if (cartSize != null && cartSize > 0) {
                    %>
                        <span class="cart-badge"><%= cartSize %></span>
                    <%
                        }
                    %>
                </a>    
                <a href="/JSP/AddNewUser.jsp" class="fa-regular fa-user"></a>
            </div>
        </section>

        <div id="productAddedMessage" class="product-added-message">
            <i class="fas fa-check-circle"></i> Product added to cart!
        </div>
            
        <div class="product-container">
            <div class="product-header">
                <h1>Our Products</h1>
                <div class="product-actions">
                    <a href="<%= request.getContextPath() %>/PromotionProductsServlet" class="promotion-btn">
                        <i class="fas fa-tag"></i> Promotions
                    </a>
                </div>
            </div>
            
            <%
                Integer currentPage = (Integer) request.getAttribute("currentPage");
                Integer totalPages = (Integer) request.getAttribute("totalPages");

                if (currentPage != null && totalPages != null) {
            %>
            <div class="pagination">
                <% if (currentPage > 1) { %>
                    <a href="ProductServlet?page=<%= currentPage - 1 %>" class="page-nav">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                <% } %>
                
                <% 
                    int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(totalPages, startPage + 4);
                    
                    if (startPage > 1) { %>
                        <a href="ProductServlet?page=1">1</a>
                        <% if (startPage > 2) { %>
                            <span class="ellipsis">...</span>
                        <% } %>
                    <% } %>
                    
                    <% for (int i = startPage; i <= endPage; i++) { %>
                        <a href="ProductServlet?page=<%= i %>" 
                           class="<%= (i == currentPage) ? "active" : "" %>">
                            <%= i %>
                        </a>
                    <% } %>
                    
                    <% if (endPage < totalPages) { %>
                        <% if (endPage < totalPages - 1) { %>
                            <span class="ellipsis">...</span>
                        <% } %>
                        <a href="ProductServlet?page=<%= totalPages %>"><%= totalPages %></a>
                    <% } %>
                
                <% if (currentPage < totalPages) { %>
                    <a href="ProductServlet?page=<%= currentPage + 1 %>" class="page-nav">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                <% } %>
            </div>
            <%
                }
            %>

            <section class="products">
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    if (products != null && !products.isEmpty()) {
                        for (Product p : products) {
                %>
                    <article class="product-item">
                        <div class="product-image-container">
                            <a href="ProductDetailsServlet?id=<%= p.getId() %>">
                                <img class="product-image" src="<%= request.getContextPath() %>/ProductImages/<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
                            </a>
                        </div>
                        <div class="product-info">
                            <h2 class="product-name"><%= p.getName() %></h2>
                            <p class="product-price">RM <%= String.format("%.2f", p.getPrice()) %></p>
                            <p class="product-description"><%= p.getDescription() %></p>
                            <form action="<%= request.getContextPath() %>/CartServlet" method="POST" class="add-to-cart-form">
                                <input type="hidden" name="PRODUCT_ID" value="<%= p.getId() %>" /> 
                                <input type="hidden" name="PRODUCTNAME" value="<%= p.getName() %>" />
                                <input type="hidden" name="PRICE" value="<%= p.getPrice() %>" />
                                <input type="hidden" name="IMAGE_URL" value="<%= p.getImageUrl() %>" />
                                <input type="hidden" name="quantity" value="1" />
                            <input type="hidden" name="user_id" value="<%= session.getAttribute("user_id") %>" />
                                <button type="submit" class="add-to-cart-btn">
                                    <i class="fas fa-shopping-cart"></i> Add to Cart
                                </button>
                            </form>
                        </div>
                    </article>
                <%
                        }
                    } else {
                %>
                    <div class="no-products">
                        <i class="fas fa-box-open"></i>
                        <p>No products available.</p>
                    </div>
                <%
                    }
                %>
            </section>
            
            <%
                if (currentPage != null && totalPages != null && totalPages > 1) {
            %>
            <div class="pagination bottom-pagination">
                <% if (currentPage > 1) { %>
                    <a href="ProductServlet?page=<%= currentPage - 1 %>" class="page-nav">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                <% } %>
                
                <% 
                    int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(totalPages, startPage + 4);
                    
                    if (startPage > 1) { %>
                        <a href="ProductServlet?page=1">1</a>
                        <% if (startPage > 2) { %>
                            <span class="ellipsis">...</span>
                        <% } %>
                    <% } %>
                    
                    <% for (int i = startPage; i <= endPage; i++) { %>
                        <a href="ProductServlet?page=<%= i %>" 
                           class="<%= (i == currentPage) ? "active" : "" %>">
                            <%= i %>
                        </a>
                    <% } %>
                    
                    <% if (endPage < totalPages) { %>
                        <% if (endPage < totalPages - 1) { %>
                            <span class="ellipsis">...</span>
                        <% } %>
                        <a href="ProductServlet?page=<%= totalPages %>"><%= totalPages %></a>
                    <% } %>
                
                <% if (currentPage < totalPages) { %>
                    <a href="ProductServlet?page=<%= currentPage + 1 %>" class="page-nav">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                <% } %>
            </div>
            <%
                }
            %>
        </div>

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

        <script>
            // Show notification when a product is added to cart
            document.addEventListener('DOMContentLoaded', function() {
                const forms = document.querySelectorAll('.add-to-cart-form');
                const message = document.getElementById('productAddedMessage');
                const searchIcon = document.getElementById('search-icon');
                const searchBox = document.getElementById('search-box');

                forms.forEach(form => {
                    form.addEventListener('submit', function(e) {
                        // Show the message
                        message.style.display = 'block';
 
                        // Hide the message after 3 seconds
                        setTimeout(function() {
                            message.style.display = 'none';
                        }, 3000);
                    });
                });
                
                // Toggle search box visibility
                searchIcon.addEventListener('click', function() {
                    searchBox.classList.toggle('show');
                    if (searchBox.classList.contains('show')) {
                        searchBox.focus();
                    }
                });
            });
        </script>
        
        
       
    </body>
</html>