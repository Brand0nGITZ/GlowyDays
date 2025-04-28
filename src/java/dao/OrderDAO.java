package dao;

import java.sql.*;
import java.util.*;
import model.Order;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;

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
}