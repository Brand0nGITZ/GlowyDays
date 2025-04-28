<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Product List</title>
  <link href="../CSS/List.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
      
    .product-list-container {
        width: 95%;
        margin: 20px auto;
        padding: 10px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    .table-container { 
        text-align: center; 
    }
    
    table { 
        width: 100%; 
        border-collapse: collapse; 
    }
    
    th, td { 
        padding: 12px; 
        border: 1px solid #ddd; 
        text-align: center;
    }
    
    th { 
        background-color: #f2f2f2; 
        font-weight: bold; 
    }
    
    tr:hover { 
        background-color: #f9f9f9; 
    }
    
    img { 
        max-width: 80px; 
        border-radius: 4px; 
    }
    
    .btn { 
        padding: 6px 8px; 
        text-decoration: none; 
        border-radius: 4px; margin: 0 5px; 
        display: inline-block; 
        text-align: center; 
    }
    
    .edit-btn { 
        background-color: #4CAF50; 
        color: white; 
    }
    
    .edit-btn:hover { 
        background-color: #45a049; 
    }
    
    .delete-btn { 
        background-color: #f44336; 
        color: white; 
    }
    
    .delete-btn:hover { 
        background-color: #da190b; 
    }
    
    .delete-btn:active { 
        background-color: #b71c1c; 
    }
  </style>
</head>
<body>
  <h2 style="text-align:center; margin-top:20px;">All Products</h2>
  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Category</th>
          <th>Price (RM)</th>
          <th>Stock</th>
          <th>Image</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
      <% 
        String driver   = "org.apache.derby.jdbc.ClientDriver";
        String url      = "jdbc:derby://localhost:1527/myderbyDB";
        String dbUser   = "user";
        String dbPass   = "pass";
        Connection conn = null;
        Statement stmt  = null;
        ResultSet rs    = null;
        try {
          Class.forName(driver);
          conn = DriverManager.getConnection(url, dbUser, dbPass);
          stmt = conn.createStatement();
          String sql = 
            "SELECT PRODUCT_ID, PRODUCTNAME, CATEGORY, PRICE, STOCK_QUANTITY, IMAGE_URL " +
            "FROM APP.\"PRODUCTS\"";
          rs = stmt.executeQuery(sql);
          while (rs.next()) {
            int    id     = rs.getInt("PRODUCT_ID");
            String name   = rs.getString("PRODUCTNAME");
            String cat    = rs.getString("CATEGORY");
            double price  = rs.getDouble("PRICE");
            int    stock  = rs.getInt("STOCK_QUANTITY");
            String imgUrl = rs.getString("IMAGE_URL");
      %>
        <tr>
          <td><%= id %></td>
          <td><%= name %></td>
          <td><%= cat %></td>
          <td><%= String.format("%.2f", price) %></td>
          <td><%= stock %></td>
          <td>
            <% if (imgUrl != null && !imgUrl.isEmpty()) { %>
              <img src="<%= imgUrl %>" alt="img">
            <% } else { %>
              No Image
            <% } %>
          </td>
          <td>
            <a href="EditProduct.jsp?id=<%= id %>" class="btn edit-btn"><i class="fas fa-pen"></i></a>
            <a href="<%= request.getContextPath() %>/RemoveProductServlet?id=<%= id %>" class="btn delete-btn" onclick="return confirm('Are you sure you want to delete this product?');">
              <i class="fas fa-trash"></i>
            </a>
          </td>
        </tr>
      <%    }
        } catch (Exception e) {
          out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
        } finally {
          if (rs   != null) try { rs.close();   } catch (Exception ignore) {}
          if (stmt != null) try { stmt.close(); } catch (Exception ignore) {}
          if (conn != null) try { conn.close(); } catch (Exception ignore) {}
        }
      %>
      </tbody>
    </table>
  </div>
</body>
</html>