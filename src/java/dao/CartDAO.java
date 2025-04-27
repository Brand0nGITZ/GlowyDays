package dao;

import model.CartItem;
import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Login;

public class CartDAO {

    private static final String JDBC_URL = "jdbc:derby://localhost:1527/myderbyDB";
    private static final String USERNAME = "user";
    private static final String PASSWORD = "pass";

    // Method to update the quantity of an existing cart item
    public boolean updateCartItemQuantity(ResultSet rs, CartItem item) throws SQLException {
        boolean result = false;

        int cartDetailsId = rs.getInt("CartDetailID");
        int currentQuantity = rs.getInt("Quantity");
        int newQuantity = currentQuantity + item.getQuantity();
        Connection conn = null;
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

        String updateQuery = "UPDATE APP.CartDetails SET Quantity = ? WHERE CartDetailID = ?";
        PreparedStatement stmt = conn.prepareStatement(updateQuery);
        stmt.setInt(1, newQuantity);
        stmt.setInt(2, cartDetailsId);
        stmt.executeUpdate();
        result = true;  // Update was successful

        return result;
    }

    // Method to insert a new cart item
    public boolean insertCartItem(int userId, CartItem item) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Establish database connection
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            // Insert cart detail into the CartDetails table
            String insertQuery = "INSERT INTO APP.CartDetails (UserID, ProductID, Quantity) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, userId);
            stmt.setInt(2, item.getProduct().getId());
            stmt.setInt(3, item.getQuantity());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    int cartDetailId = rs.getInt(1);
                    item.setId(cartDetailId); // Set generated CartDetailID
                    return true;
                }
            }

            return false;

        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error inserting item into cart: " + e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    // Get all cart items for a user
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            // Get cart items with product information filtered by UserID
            String itemsQuery = "SELECT cd.CartDetailID, cd.ProductID, cd.Quantity, "
                    + "p.PRODUCTNAME, p.DESCRIPTION, p.CATEGORY, p.PRICE, p.STOCK_QUANTITY, p.IMAGE_URL "
                    + "FROM APP.CartDetails cd "
                    + "JOIN APP.PRODUCTS p ON cd.ProductID = p.PRODUCT_ID "
                    + "WHERE cd.UserID = ?";
            stmt = conn.prepareStatement(itemsQuery);
            stmt.setInt(1, userId); // Pass userId to fetch cart items for that user
            rs = stmt.executeQuery();

            while (rs.next()) {
                // Create Product object
                Product product = new Product();
                product.setId(rs.getInt("ProductID"));
                product.setName(rs.getString("PRODUCTNAME"));
                product.setDescription(rs.getString("DESCRIPTION"));
                product.setCategory(rs.getString("CATEGORY"));
                product.setPrice(rs.getDouble("PRICE"));
                product.setStock(rs.getInt("STOCK_QUANTITY"));
                product.setImageUrl(rs.getString("IMAGE_URL"));

                // Create CartItem object
                CartItem item = new CartItem();
                item.setProduct(product);
                item.setQuantity(rs.getInt("Quantity"));  // Corrected to "Quantity" from the query

                cartItems.add(item);
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return cartItems;
    }

    // Update cart item quantity
    public boolean updateCartItem(int cartDetailsId, int quantity) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            String updateQuery = "UPDATE APP.CartDetails SET Quantity = ? WHERE CartDetailID = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartDetailsId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Remove item from cart
    public boolean removeCartItem(int cartDetailsId) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            String deleteQuery = "DELETE FROM APP.CartDetails WHERE CartDetailID = ?";
            stmt = conn.prepareStatement(deleteQuery);
            stmt.setInt(1, cartDetailsId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Clear all items from a user's cart
    public boolean clearCart(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            // Get cart ID for user
            String cartQuery = "SELECT CartID FROM APP.Cart WHERE UserID = ?";
            stmt = conn.prepareStatement(cartQuery);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int cartId = rs.getInt("CartID");

                // Delete all items in the cart
                String deleteQuery = "DELETE FROM APP.CartDetails WHERE CartID = ?";
                stmt = conn.prepareStatement(deleteQuery);
                stmt.setInt(1, cartId);
                stmt.executeUpdate();

                return true;
            }

            return false;

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Get cart count for a user
    public int getCartItemCount(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int itemCount = 0;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            // Get cart ID for user
            String cartQuery = "SELECT CartID FROM APP.Cart WHERE UserID = ?";
            stmt = conn.prepareStatement(cartQuery);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int cartId = rs.getInt("CartID");

                // Count items in cart
                String countQuery = "SELECT SUM(Quantity) as TotalItems FROM APP.CartDetails WHERE CartID = ?";
                stmt = conn.prepareStatement(countQuery);
                stmt.setInt(1, cartId);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    itemCount = rs.getInt("TotalItems");
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return itemCount;
    }
    // Get the cart ID for a given user

    public int getCartIdForUser(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            String query = "SELECT CartID FROM APP.Cart WHERE UserID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("CartID");
            } else {
                return -1;  // No cart found
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

// Create a new cart for a user
    public int createCartForUser(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            String insertQuery = "INSERT INTO APP.Cart (UserID) VALUES (?)";
            stmt = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, userId);
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);  // Return generated CartID
            } else {
                return -1;  // Failed to create cart
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

// Check if the product is already in the cart
    public boolean isItemInCart(int cartId, int productId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            String query = "SELECT * FROM APP.CartDetails WHERE CartID = ? AND ProductID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            rs = stmt.executeQuery();

            return rs.next();  // If there's any row, the product is already in the cart

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean upsertCartItem(int userId, CartItem item) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            // First, check if the product already exists in cart
            String selectQuery = "SELECT quantity FROM APP.CartDetails WHERE UserId = ? AND ProductId = ?";
            stmt = conn.prepareStatement(selectQuery);
            stmt.setInt(1, userId);
            stmt.setInt(2, item.getProduct().getId());
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Product exists → Update quantity
                int existingQuantity = rs.getInt("quantity");
                int newQuantity = existingQuantity + item.getQuantity();

                String updateQuery = "UPDATE APP.CartDetails SET Quantity = ? WHERE UserId = ? AND ProductId = ?";
                stmt = conn.prepareStatement(updateQuery);
                stmt.setInt(1, newQuantity);
                stmt.setInt(2, userId);
                stmt.setInt(3, item.getProduct().getId());

                int rowsUpdated = stmt.executeUpdate();
                return rowsUpdated > 0;
            } else {
                // Product does not exist → Insert new
                String insertQuery = "INSERT INTO APP.CartDetails (UserID, ProductID, Quantity) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(insertQuery);
                stmt.setInt(1, userId);
                stmt.setInt(2, item.getProduct().getId());
                stmt.setInt(3, item.getQuantity());

                int rowsInserted = stmt.executeUpdate();
                return rowsInserted > 0;
            }

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

}