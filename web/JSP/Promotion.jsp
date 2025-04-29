<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Product" %>
<%@ page import="java.util.*, model.Promotion" %>
<%@ page import="java.time.LocalDate" %>

<html>
<head>
    <title>Promotion Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    
    <%
        // Get current month (1-12)
        int currentMonth = LocalDate.now().getMonthValue();
        
        // Define promotion months
        final int HARI_RAYA_MONTH = 4; // April
        final int CHRISTMAS_MONTH = 12; // December
        
        // Set flag for promotion availability
        boolean hasPromotion = (currentMonth == HARI_RAYA_MONTH || currentMonth == CHRISTMAS_MONTH);
        
        // Load appropriate CSS based on month
        if (currentMonth == HARI_RAYA_MONTH) {
    %>
            <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/Promotion-HariRaya.css?v=2">
    <%
        } else if (currentMonth == CHRISTMAS_MONTH) {
    %>
            <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/Promotion-Christmas.css?v=2">
    <%
        }
    %>
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
               <form action="<%= request.getContextPath() %>/SearchProductServlet" method="get">
    <input type="text" name="query" placeholder="Search by ID or Name">
    <button type="submit">Search</button>
</form>
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
            <a href="AddNewUser.jsp" class="fa-regular fa-user"></a>
        </div>
    </section>

    <% if (!hasPromotion) { %>
        <div style="text-align: center; padding: 100px 20px; background-color: #f8f9fa; margin: 50px auto; max-width: 800px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1);">
            <h2 style="color: #333; margin-bottom: 20px; font-size: 2rem;">No Promotion Found</h2>
            <p style="color: #666; font-size: 1.2rem;">Please check back during our promotional periods:</p>
            <p style="color: #666; font-size: 1.1rem; margin-top: 10px;">
                <strong>April:</strong> Hari Raya Promotions<br>
                <strong>December:</strong> Christmas Promotions
            </p>
        </div>
    <% } else { %>
        <div class="outer-container">
            <h2>Promotion Products</h2> 
            <div class="inner-container">
            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
                if (products != null && !products.isEmpty()) {
                    for (Product product : products) {
            %>
                    <div style="border:1px solid #ccc; padding:10px; margin:10px;">
                        <h3><%= product.getName() %> (PROMO)</h3>
                        <img src="<%= request.getContextPath() %>/ProductImages/<%= product.getImageUrl() %>" alt="<%= product.getName() %>" width="300">
                        
                        <form action="<%= request.getContextPath() %>/CartServlet" method="POST">
                            <input type="hidden" name="PRODUCT_ID" value="<%= product.getId() %>" />
                            <input type="hidden" name="IMAGE_URL" value="<%= product.getImageUrl() %>" />
                            <input type="hidden" name="PRODUCTNAME" value="<%= product.getName() + " (PROMO)" %>" />
                            <input type="hidden" name="PRICE" value="<%= product.getPrice() %>" />
                            <input type="hidden" name="quantity" value="1" />
                            <input type="hidden" name="user_id" value="<%= session.getAttribute("user_id") %>" />
                            
                            <%
                                double discountedPrice = product.getPrice() * (1 - product.getDiscount());
                            %>
                            <input type="hidden" name="PRICE" value="<%= String.format("%.2f", discountedPrice) %>" />
                            <button type="submit" class="add-to-cart-btn">
                                    <i class="fas fa-shopping-cart"></i> Add to Cart
                                </button>
                        </form>
                        <p>Original Price: RM <%= product.getPrice() %></p>
                        <%
                            double discounted = product.getPrice() * (1 - product.getDiscount());
                        %>
                        <p style="color:red;">Promo Price: RM <%= String.format("%.2f", discounted) %></p>
                    </div>
            <%
                    }
                } else {
            %>
                </div>
                </div>    
                <p>No products available in this promotion.</p>
            <%
                }
            %>
    <% } %>
    
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            // Get current month (0-11, where 0 is January)
            const currentMonth = new Date().getMonth() + 1; // +1 to match Java's 1-12 format
            
            // Define seasonal themes
            const HARI_RAYA_MONTH = 4; // April
            const CHRISTMAS_MONTH = 12; // December
            
            // Only proceed if we're in a promotion month
            if (currentMonth === HARI_RAYA_MONTH || currentMonth === CHRISTMAS_MONTH) {
                // Add appropriate banner
                const header = document.querySelector(".header");
                const banner = document.createElement("div");
                
                if (currentMonth === CHRISTMAS_MONTH) {
                    // Christmas banner
                    banner.className = "hari-raya-banner"; // Using same class for styling
                    banner.innerHTML = `
                        <h1>Merry Christmas!</h1>
                        <p>Celebrate this festive season with our special Christmas promotions. Enjoy exclusive discounts on our premium products!</p>
                        <div class="ketupat-decoration ketupat-1"></div>
                        <div class="ketupat-decoration ketupat-2"></div>
                    `;
                    
                    // Add Christmas decorative elements
                    addChristmasDecorations();
                } else {
                    // Hari Raya banner
                    banner.className = "hari-raya-banner";
                    banner.innerHTML = `
                        <h1>Selamat Hari Raya Aidilfitri</h1>
                        <p>Celebrate this festive season with our special Raya promotions. Enjoy exclusive discounts on our premium products!</p>
                        <div class="ketupat-decoration ketupat-1"></div>
                        <div class="ketupat-decoration ketupat-2"></div>
                    `;
                    
                    // Add Hari Raya decorative elements
                    addHariRayaDecorations();
                }
                
                header.after(banner);
                
                // Transform product cards
                transformProductCards(currentMonth);
                
                // Add footer
                addFooter();
                
                // Add search functionality
                setupSearch();
            }
        });
        
        function addHariRayaDecorations() {
            const body = document.querySelector("body");
            
            const moon = document.createElement("div");
            moon.className = "decoration moon";
            body.appendChild(moon);
            
            const star1 = document.createElement("div");
            star1.className = "decoration star star-1";
            body.appendChild(star1);
            
            const star2 = document.createElement("div");
            star2.className = "decoration star star-2";
            body.appendChild(star2);
            
            const star3 = document.createElement("div");
            star3.className = "decoration star star-3";
            body.appendChild(star3);
        }
        
        function addChristmasDecorations() {
            const body = document.querySelector("body");
            
            // Add Christmas-specific decorations
            // Note: These will use the CSS classes from the Christmas CSS file
            const star1 = document.createElement("div");
            star1.className = "decoration star star-1";
            body.appendChild(star1);
            
            const star2 = document.createElement("div");
            star2.className = "decoration star star-2";
            body.appendChild(star2);
            
            const star3 = document.createElement("div");
            star3.className = "decoration star star-3";
            body.appendChild(star3);
        }
        
        function transformProductCards(month) {
            const innerContainer = document.querySelector(".inner-container");
            const productDivs = document.querySelectorAll(".inner-container > div");
            
            // Create a wrapper for products
            const productsContainer = document.createElement("div");
            productsContainer.className = "products-container";
            
            // Move the inner container into the products container
            if (innerContainer) {
                innerContainer.parentNode.insertBefore(productsContainer, innerContainer);
                productsContainer.appendChild(innerContainer);
            }
            
            productDivs.forEach((div) => {
                div.className = "product-card";
                
                // Add discount tag
                const discountTag = document.createElement("div");
                discountTag.className = "discount-tag";
                
                // Restructure product info
                const h3 = div.querySelector("h3");
                const img = div.querySelector("img");
                
                // Ensure image displays properly
                if (img) {
                    img.removeAttribute("width"); // Remove fixed width attribute
                    img.style.maxWidth = "100%";
                }
                
                const form = div.querySelector("form");
                const originalPrice = div.querySelector("p:nth-of-type(1)");
                const promoPrice = div.querySelector("p:nth-of-type(2)");
                
                // Extract discount percentage from the product
                if (originalPrice && promoPrice) {
                    const originalPriceText = originalPrice.textContent;
                    const promoPriceText = promoPrice.textContent;
                    
                    const originalPriceValue = Number.parseFloat(originalPriceText.replace("Original Price: RM ", ""));
                    const promoPriceValue = Number.parseFloat(promoPriceText.replace("Promo Price: RM ", ""));
                    
                    if (!isNaN(originalPriceValue) && !isNaN(promoPriceValue)) {
                        const discountPercentage = Math.round((1 - promoPriceValue / originalPriceValue) * 100);
                        discountTag.textContent = `-${discountPercentage}%`;
                        div.appendChild(discountTag);
                    }
                }
                
                // Add promo badge with appropriate text
                const promoBadge = document.createElement("div");
                promoBadge.className = "promo-badge";
                
                if (month === 12) { // December
                    promoBadge.textContent = "CHRISTMAS SPECIAL";
                } else { // April
                    promoBadge.textContent = "RAYA SPECIAL";
                }
                
                div.appendChild(promoBadge);
                
                // Clear the div and rebuild it
                div.innerHTML = "";
                div.appendChild(discountTag);
                div.appendChild(promoBadge);
                div.appendChild(img);
                
                const productInfo = document.createElement("div");
                productInfo.className = "product-info";
                
                if (h3) productInfo.appendChild(h3);
                
                const priceContainer = document.createElement("div");
                priceContainer.className = "price-container";
                
                if (originalPrice) {
                    originalPrice.className = "original-price";
                    priceContainer.appendChild(originalPrice);
                }
                
                if (promoPrice) {
                    promoPrice.className = "promo-price";
                    priceContainer.appendChild(promoPrice);
                }
                
                productInfo.appendChild(priceContainer);
                
                if (form) productInfo.appendChild(form);
                
                div.appendChild(productInfo);
            });
            
            // Handle empty state
            if (innerContainer && !innerContainer.children.length) {
                const emptyState = document.createElement("div");
                emptyState.className = "empty-state";
                
                if (month === 12) { // December
                    emptyState.innerHTML = `
                        <p>No products available in this promotion.</p>
                        <p>Please check back later for our Christmas special offers!</p>
                    `;
                } else { // April
                    emptyState.innerHTML = `
                        <p>No products available in this promotion.</p>
                        <p>Please check back later for our Hari Raya special offers!</p>
                    `;
                }
                
                innerContainer.appendChild(emptyState);
            }
        }
        
        function addFooter() {
            const footer = document.createElement("footer");
            footer.className = "footer";
            
            footer.innerHTML = `
                <div class="footer-content">
                    <div class="footer-section">
                        <h3>Quick Links</h3>
                        <a href="#">Home</a>
                        <a href="#">Products</a>
                        <a href="#">About Us</a>
                        <a href="#">Contact Us</a>
                    </div>
                    <div class="footer-section">
                        <h3>Contact Info</h3>
                        <p><i class="fa-solid fa-location-dot"></i> 123 Jalan Raya, Kuala Lumpur</p>
                        <p><i class="fa-solid fa-phone"></i> +60 12-345 6789</p>
                        <p><i class="fa-solid fa-envelope"></i> info@glowydays.com</p>
                        <div class="social-icons">
                            <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                            <a href="#"><i class="fa-brands fa-instagram"></i></a>
                            <a href="#"><i class="fa-brands fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
            `;
            
            document.body.appendChild(footer);
        }
        
        function setupSearch() {
            const searchBox = document.getElementById("search-box");
            if (searchBox) {
                searchBox.addEventListener("keyup", (e) => {
                    if (e.key === "Enter") {
                        const query = searchBox.value.trim().toLowerCase();
                        if (query) {
                            const productCards = document.querySelectorAll(".product-card");
                            let found = false;
                            
                            productCards.forEach((card) => {
                                const productName = card.querySelector("h3").textContent.toLowerCase();
                                if (productName.includes(query)) {
                                    card.style.display = "block";
                                    found = true;
                                } else {
                                    card.style.display = "none";
                                }
                            });
                            
                            if (!found) {
                                alert("No products found matching your search.");
                                productCards.forEach((card) => {
                                    card.style.display = "block";
                                });
                            }
                        }
                    }
                });
            }
        }
    </script>
</body>
</html>