package dao;

import java.sql.*;
import java.util.*;
import model.Order;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import model.Address;
import model.BuyerDetail;
import model.CartItem;
import model.CheckoutDetail;
import model.PaymentMethod;

public class OrderDAO {

    private Connection conn;

    public OrderDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        try {
            // Corrected with "" for attributes
            String sql = "SELECT o.\"orderId\", o.\"orderDate\", o.\"shippedStatus\", "
                    + "s.\"trackingno\" "
                    + "FROM APP.\"ORDERS\" o "
                    + "LEFT JOIN APP.\"TRACKING\" s ON o.\"orderId\" = s.\"orderId\" "
                    + "ORDER BY o.\"orderDate\" DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String id = rs.getString("orderId");
                Timestamp orderDateTs = rs.getTimestamp("orderDate");
                String date = (orderDateTs != null) ? orderDateTs.toLocalDateTime().toString() : null;
                boolean shipped = rs.getBoolean("shippedStatus");
                String tracking = rs.getString("trackingno"); // can be null

                orders.add(new Order(id, date, shipped, tracking));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public boolean insertShipping(String shippingId, String orderId, String trackingNo) throws SQLException {
        // Correct with double quotes
        String insertSQL = "INSERT INTO APP.\"TRACKING\" (\"trackingid\", \"orderId\", \"trackingno\", \"shippingdate\", \"shippingtime\", \"updatedate\") "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement insertShippingStmt = conn.prepareStatement(insertSQL)) {
            insertShippingStmt.setString(1, shippingId);
            insertShippingStmt.setString(2, orderId);
            insertShippingStmt.setString(3, trackingNo);
            insertShippingStmt.setDate(4, Date.valueOf(LocalDate.now()));
            insertShippingStmt.setTime(5, Time.valueOf(LocalTime.now()));
            insertShippingStmt.setDate(6, Date.valueOf(LocalDate.now().plusDays(7)));
            return insertShippingStmt.executeUpdate() > 0;
        }
    }

    public boolean updateOrderStatus(String orderId) throws SQLException {
        String updateSQL = "UPDATE APP.\"ORDERS\" SET \"shippedStatus\" = TRUE WHERE \"orderId\" = ?";
        try (PreparedStatement updateOrderStmt = conn.prepareStatement(updateSQL)) {
            updateOrderStmt.setString(1, orderId);
            return updateOrderStmt.executeUpdate() > 0;
        }
    }

    public boolean isTrackingNumberExists(String trackingNo) throws SQLException {
        String sql = "SELECT COUNT(*) FROM APP.\"TRACKING\" WHERE \"trackingno\" = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, trackingNo);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public String getNextShippingId() throws SQLException {
        String sql = "SELECT \"trackingid\" FROM APP.\"TRACKING\" ORDER BY \"trackingid\" DESC FETCH FIRST ROW ONLY";
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString("trackingid"); // e.g., "SID5"
                int num = Integer.parseInt(lastId.substring(3)); // extract numeric part
                return "SID" + (num + 1); // increment and return
            }
        }
        return "SID1"; // default if no shipping IDs exist yet
    }
    
    public boolean saveOrder(BuyerDetail buyer, Address address, PaymentMethod payment, List<CartItem> cartItems, CheckoutDetail checkoutDetail) throws Exception {
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
        
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");
            
            // 1. Insert into ORDERS table
            String orderSql = "INSERT INTO ORDERS (user_id, total_amount, payment_method_id, shipping_address_id, order_date) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
            ps = conn.prepareStatement(orderSql, PreparedStatement.RETURN_GENERATED_KEYS);
            
            ps.setInt(1, buyer.getUserId());
            ps.setDouble(2, checkoutDetail.getTotalAmount());
            ps.setString(3, payment.getMethodId());
            ps.setInt(4, address.getAddressId());  // Assuming Address already has ID
            
            int rows = ps.executeUpdate();
            
            if (rows == 0) {
                throw new SQLException("Failed to insert order.");
            }
            
            // 2. Get generated order_id
            int orderId = 0;
            try (var rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    orderId = rs.getInt(1);
                } else {
                    throw new SQLException("Failed to retrieve order ID.");
                }
            }

            // 3. Insert each CartItem into ORDER_ITEMS
            String itemSql = "INSERT INTO ORDER_ITEMS (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement itemPs = conn.prepareStatement(itemSql);
            
            for (CartItem item : cartItems) {
                itemPs.setInt(1, orderId);
                itemPs.setString(2, item.getProduct().getProductId());
                itemPs.setInt(3, item.getQuantity());
                itemPs.setDouble(4, item.getProduct().getPrice());
                itemPs.addBatch();
            }
            
            itemPs.executeBatch();
            itemPs.close();

            return true;
            
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }
    
    
    
    
    
    
}