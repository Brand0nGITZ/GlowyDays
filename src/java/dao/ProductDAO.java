package dao;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;  

public class ProductDAO {
    
    private static final String host = "jdbc:derby://localhost:1527/myderbyDB";
    private static final String user =  "user";
    private static final String password = "pass";
     
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String selectAll = "SELECT * FROM APP.PRODUCTS";
        
        try {
            
            Class.forName("org.apache.derby.jdbc.ClientDriver"); 
 

            try (Connection conn = DriverManager.getConnection(host, user, password);
                 PreparedStatement stmt = conn.prepareStatement(selectAll);
                 ResultSet rs = stmt.executeQuery()) {
            
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("PRODUCT_ID"));
                    product.setName(rs.getString("PRODUCTNAME"));
                    product.setDescription(rs.getString("DESCRIPTION"));
                    product.setCategory(rs.getString("CATEGORY"));
                    product.setPrice(rs.getDouble("PRICE"));
                    product.setStock(rs.getInt("STOCK_QUANTITY"));
                    product.setImageUrl(rs.getString("IMAGE_URL"));  
                  
                    products.add(product);                  }
            }
        } catch (ClassNotFoundException e) {
            System.out.println("Derby JDBC Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public Product getProductByName(String name) {
    Product product = null;
    
    String sql = "SELECT * FROM products WHERE name = ?";
    
    try (Connection conn = DriverManager.getConnection(host, user, password);
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, name);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            product = new Product();
            product.setId(rs.getInt("id"));
            product.setName(rs.getString("name"));
            product.setPrice(rs.getDouble("price"));
            product.setDescription(rs.getString("description"));
            product.setImageUrl(rs.getString("image_url"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return product;
}
    
    
   public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> products = dao.getAllProducts();
        for (Product p : products) {
            System.out.println(p.getName() + " - RM" + p.getPrice());
        }
    }
    
    
    
    
    
}
