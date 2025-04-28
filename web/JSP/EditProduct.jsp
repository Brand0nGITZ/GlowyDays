<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="model.Product" %>
<%@page import="dao.ProductDAO" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Product</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="../CSS/EditProduct.css" rel="stylesheet" type="text/css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
<body>
    <a href="AdminPanel.jsp" class="back-button">
                <i class="fas fa-arrow-left"></i> Back
            </a>
    
<%
    String driver = "org.apache.derby.jdbc.ClientDriver";
    String url = "jdbc:derby://localhost:1527/myderbyDB";
    String dbUser = "user";
    String dbPass = "pass";
    
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String message = "";

    // If form submitted (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            // Retrieve parameters from the request
            int id = Integer.parseInt(request.getParameter("id"));
            String productName = request.getParameter("PRODUCTNAME");
            String description = request.getParameter("DESCRIPTION");  // Assuming there's a 'DESCRIPTION' parameter
            String category = request.getParameter("CATEGORY");
            double price = Double.parseDouble(request.getParameter("PRICE"));
            int stockQuantity = Integer.parseInt(request.getParameter("STOCK_QUANTITY"));
            String imageUrl = request.getParameter("IMAGE_URL");
            double discount = Double.parseDouble(request.getParameter("DISCOUNT"));  // Assuming there's a 'DISCOUNT' parameter
            String updatedAt = request.getParameter("UPDATED_AT");  // Assuming 'UPDATED_AT' parameter is provided

            // Database connection setup
            Class.forName(driver);
            conn = DriverManager.getConnection(url, dbUser, dbPass);

            // Prepare SQL query to update product details
            String sql = "UPDATE APP.PRODUCTS SET PRODUCTNAME= ?, DESCRIPTION= ?, CATEGORY = ?, PRICE = ?, STOCK_QUANTITY =?, IMAGE_URL = ? , UPDATED_AT = CURRENT_TIMESTAMP WHERE PRODUCT_ID = ?";
            stmt = conn.prepareStatement(sql);

            // Set the values for the prepared statement
            stmt.setString(1, productName);
            stmt.setString(2, description);
            stmt.setString(3, category);
            stmt.setDouble(4, price);
            stmt.setInt(5, stockQuantity);
            stmt.setString(6, imageUrl);
            stmt.setDouble(7, discount);
            stmt.setString(8, updatedAt);
            stmt.setInt(9, id);

            // Execute the update query
            int updated = stmt.executeUpdate();

            // Check if the update was successful and set the message accordingly
            if (updated > 0) {
                message = "✅ Product updated successfully!";
            } else {
                message = "⚠️ Failed to update product!";
            }

        } catch (Exception e) {
            // Handle exceptions and print the error message
            message = "❌ Error: " + e.getMessage();
            e.printStackTrace();
        } finally {
            // Close the resources
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    // Retrieve product to edit (GET)
    int PRODUCT_ID = 0;  // Default value for PRODUCT_ID
    Product product = null;

    try {
        // If the "id" parameter is present in the request
        if (request.getParameter("id") != null) {
            PRODUCT_ID = Integer.parseInt(request.getParameter("id"));
            
            Class.forName(driver);
            conn = DriverManager.getConnection(url, dbUser, dbPass);
            
            // SQL query to retrieve product details by ID
            String sql = "SELECT * FROM APP.PRODUCTS WHERE PRODUCT_ID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, PRODUCT_ID);
            rs = stmt.executeQuery();

            // If product exists, populate the Product object
            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("PRODUCT_ID"));
                product.setName(rs.getString("PRODUCTNAME"));
                product.setDescription(rs.getString("DESCRIPTION"));
                product.setCategory(rs.getString("CATEGORY"));
                product.setPrice(rs.getDouble("PRICE"));
                product.setStock(rs.getInt("STOCK_QUANTITY"));
                product.setImageUrl(rs.getString("IMAGE_URL"));
                product.setDiscount(rs.getDouble("DISCOUNT"));
                product.setUpdatedAt(rs.getString("UPDATED_AT"));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
                    
        <div id="details">
            <br />
            <div class="wrap">
               
                
            <h1>Edit Product</h1>
                <% if (!message.isEmpty()) { %>
                    <p style="color: green;"><%= message %></p>
                <% } %>

                <% if (product != null) { %>   
                <div>
                    
                <form action="/product/UpdateProductServlet" method="post">
                    <input type="hidden" name="id" value="<%= product.getId() %>" />

                    <div class="form-row">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" id="name" name="PRODUCTNAME" value="<%= product.getName() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="category">Category</label>
                            <input type="text" id="category" name="CATEGORY" value="<%= product.getCategory() %>" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="price">Price</label>
                            <input type="number" id="price" name="PRICE" value="<%= product.getPrice() %>" required step="0.01">
                        </div>

                        <div class="form-group">
                            <label for="stock">Stock</label>
                            <input type="number" id="stock" name="STOCK_QUANTITY" value="<%= product.getStock() %>" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="image">Image URL</label>
                            <input type="text" id="image" name="IMAGE_URL" value="<%= product.getImageUrl() %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="description">Description</label>
                            <input type="text" id="description" name="DESCRIPTION" value="<%= product.getDescription() %>" required>
                        </div>
                    </div>

                    <button type="submit" class="register-btn" style="border-radius:10px;">Update Product</button>
                </form>

        </div>
                </div>
        </div>
    <% } else { %>
        <p style="color: red;">⚠️ Product not found.</p>
    <% } %>
    
</body>
</html>