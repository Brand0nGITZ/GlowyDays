<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/ProductCSS.css?v=3">
        <title>Product</title>
        <style>
            .cart-container {
                position: relative;
                display: inline-block;
            }

            .cart-badge {
                position: absolute;
                top: -10px;
                right: -10px;
                background-color: red;
                color: white;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 12px;
                font-weight: bold;
            }

            .product-added-message {
                position: fixed;
                top: 20px;
                right: 20px;
                background-color: #4CAF50;
                color: white;
                padding: 15px;
                border-radius: 5px;
                display: none;
                z-index: 1000;
            }
        </style>
    </head>
    <body> 
        <div id="productAddedMessage" class="product-added-message">
            Product added to cart!
        </div>

        <div class="outer-container">
            <div class="inner-container">
                <div class="cart-container">
                    <a href="<%= request.getContextPath() %>/CartServlet">
                        <img src="<%= request.getContextPath() %>/ICON/cart.svg" alt="Cart" width="45" height="45">
                        <%
                            Integer cartSize = (Integer) session.getAttribute("cartSize");
                            if (cartSize != null && cartSize > 0) {
                        %>
                            <span class="cart-badge"><%= cartSize %></span>
                        <%
                            }
                        %>
                    </a>
                </div>

                <section class="products">
                    <%
                        List<Product> products = (List<Product>) request.getAttribute("products");
                        if (products != null && !products.isEmpty()) {
                            for (Product p : products) {
                    %>
                        <article class="product-item">
                            <form action="<%= request.getContextPath() %>/CartServlet" method="POST" class="add-to-cart-form">
                                <figure>
                                    <img class="product-image" src="<%= request.getContextPath() %>/ProductImages/<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
                                    <figcaption><%= p.getName() %></figcaption>
                                </figure>
                                <h2><%= p.getName() %></h2>
                                <p class="price">RM<%= String.format("%.2f", p.getPrice()) %></p>
                                <p><%= p.getDescription() %></p>
                                <input type="hidden" name="PRODUCT_ID" value="<%= p.getId() %>" /> 
                                <input type="hidden" name="PRODUCTNAME" value="<%= p.getName() %>" />
                                <input type="hidden" name="PRICE" value="<%= p.getPrice() %>" />
                                <button type="submit" class="add-to-cart-btn">Add to cart</button>
                            </form>
                        </article>
                    <%
                            }
                        } else {
                    %>
                        <p>No products available.</p>
                    <%
                        }
                    %>
                </section>
            </div>         
        </div>

        <script>
            // Show notification when a product is added to cart
            document.addEventListener('DOMContentLoaded', function() {
                const forms = document.querySelectorAll('.add-to-cart-form');
                const message = document.getElementById('productAddedMessage');

                forms.forEach(form => {
                    form.addEventListener('submit', function(e) {
                        // Submit the form normally

                        // Show the message
                        message.style.display = 'block';

                        // Hide the message after 3 seconds
                        setTimeout(function() {
                            message.style.display = 'none';
                        }, 3000);
                    });
                });
            });
        </script>
    </body>
</html>
