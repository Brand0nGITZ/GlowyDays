<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Product"%>
<%
    Product p = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= p.getName() %> Details</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/ProductDetails.css?v=3">
</head>
<body>
    <div class="product-detail-container">
        <h1><%= p.getName() %></h1>
        <img src="<%= request.getContextPath() %>/ProductImages/<%= p.getImageUrl() %>" alt="<%= p.getName() %>" width="300">
        <h2>Price: RM<%= String.format("%.2f", p.getPrice()) %></h2>
        <p><%= p.getDescription() %></p>

        <form action="<%= request.getContextPath() %>/CartServlet" method="POST">
            <input type="hidden" name="PRODUCT_ID" value="<%= p.getId() %>" />
            <input type="hidden" name="PRODUCTNAME" value="<%= p.getName() %>" />
            
            <input type="hidden" name="PRICE" value="<%= p.getPrice() %>" />
            <button type="submit">Add to Cart</button>
        </form>

        <a href="<%= request.getContextPath() %>/ProductServlet">← Back to Product List</a>
    </div>
</body>
</html>
