<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Product" %>
<%@ page import="java.util.*, model.Promotion" %>

<html>
<head>
    <title>Promotion Page</title>
      <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/ProductCSS.css?v=4">
</head>
<body>
    <h2>Promotion Products</h2>
    <div class="outer-container">
            <div class="inner-container">
                <div class="cart-container">
                     <a href="<%= request.getContextPath() %>/ProductServlet">Products</a>
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

            
            <%
                double discountedPrice = product.getPrice() * (1 - product.getDiscount());
            %>
<input type="hidden" name="PRICE" value="<%= String.format("%.2f", discountedPrice) %>" />
            <button type="submit">Add to Cart</button>
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
        <p>No products available in this promotion.</p>
    <%
        }
    %>
</body>
</html>
