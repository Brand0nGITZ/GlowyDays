<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/ProductCSS.css?v=4">
        <title>Product</title>
        
    </head>
    
    <form action="<%= request.getContextPath() %>/SearchProductServlet" method="get">
    <input type="text" name="query" placeholder="Search by ID or Name">
    <button type="submit">Search</button>
</form>
    <body> 
        <div id="productAddedMessage" class="product-added-message">
            Product added to cart!
        </div>
            
        <div class="outer-container">
            <div class="inner-container">
                <div class="cart-container">
                    <a href="<%= request.getContextPath() %>/PromotionProductsServlet">Promotion</a>
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
                    
                   
                <%
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");

         if (currentPage != null && totalPages != null) {
                %>
    <div class="pagination">
        <% for (int i = 1; i <= totalPages; i++) { %>
            <a href="ProductServlet?page=<%= i %>" 
               class="<%= (i == currentPage) ? "active" : "" %>">
                <%= i %>
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
                            <form action="<%= request.getContextPath() %>/CartServlet" method="POST" class="add-to-cart-form">
                               <figure>
                                       <a href="ProductDetailsServlet?id=<%= p.getId() %>">
                                        <img class="product-image" src="<%= request.getContextPath() %>/ProductImages/<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
                                        </a>
                                        <figcaption><%= p.getName() %></figcaption>
                                        </figure>
                                <h2><%= p.getName() %></h2>
                                <p class="price">RM<%= String.format("%.2f", p.getPrice()) %></p>
                                <p><%= p.getDescription() %></p>
                                <input type="hidden" name="PRODUCT_ID" value="<%= p.getId() %>" /> 
                                <input type="hidden" name="PRODUCTNAME" value="<%= p.getName() %>" />
                                <input type="hidden" name="PRICE" value="<%= p.getPrice() %>" />
                                <input type="hidden" name="IMAGE_URL" value="<%= p.getImageUrl() %>" />
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
