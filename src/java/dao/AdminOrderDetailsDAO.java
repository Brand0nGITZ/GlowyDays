package dao;

import model.AdminViewOrderDetails;
import java.sql.*;
import model.AdminViewOrderDetailsItem;
import java.util.ArrayList;
import java.util.List;

public class AdminOrderDetailsDAO {

    private String jdbcURL = "jdbc:derby://localhost:1527/Client";
    private String jdbcUsername = "nbuser";
    private String jdbcPassword = "nbuser";

    private static final String SELECT_ORDER_BY_ID
            = "SELECT "
            + "o.\"orderId\", "
            + "o.\"orderDate\", "
            + "o.\"userId\", "
            + "pm.\"methodName\", "
            + "a.\"address\", "
            + "o.\"shippedStatus\", "
            + "t.\"trackingno\", "
            + "t.\"shippingdate\", "
            + "t.\"shippingtime\", "
            + "CASE "
            + "    WHEN o.\"shippedStatus\" = false THEN 'To Ship' "
            + "    WHEN o.\"shippedStatus\" = true "
            + "         AND CURRENT_DATE < t.\"updatedate\" THEN 'In Transit' "
            + "    WHEN o.\"shippedStatus\" = true "
            + "         AND CURRENT_DATE >= t.\"updatedate\" THEN 'Delivered' "
            + "END AS \"arrivalStatus\" "
            + "FROM \"ORDERS\" o "
            + "JOIN APP.\"PAYMENT\" p ON o.\"paymentId\" = p.\"paymentId\" "
            + "JOIN APP.\"PAYMENTMETHOD\" pm ON p.\"methodId\" = pm.\"methodId\" "
            + "JOIN APP.\"SHIPPINGDETAIL\" s ON o.\"shippingId\" = s.\"shippingId\" "
            + "JOIN APP.\"ADDRESS\" a ON s.\"addressId\" = a.\"addressId\" "
            + "LEFT JOIN APP.\"TRACKING\" t ON o.\"orderId\" = t.\"orderId\" "
            + "WHERE o.\"orderId\" = ?";

    private static final String SELECT_ORDER_ITEM
        = "SELECT p.\"PRODUCTNAME\", p.\"PRICE\", p.\"IMAGE_URL\", oi.\"quantity\" "
        + "FROM APP.\"ORDERITEMS\" oi "
        + "JOIN APP.\"PRODUCTS\" p ON oi.\"productId\" = p.\"PRODUCT_ID\" "
        + "WHERE oi.\"orderId\" = ?";
    

    protected Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public AdminViewOrderDetails getOrderDetailsById(String orderId) {
        AdminViewOrderDetails order = null;

        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ORDER_BY_ID)) {

            preparedStatement.setString(1, orderId);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                order = new AdminViewOrderDetails();
                order.setOrderId(rs.getString("orderId"));
                order.setOrderDate(rs.getDate("orderDate"));
                order.setUserId(rs.getInt("userId"));
                order.setAddress(rs.getString("address"));
                order.setPaymentMethod(rs.getString("methodName"));
                order.setShippedStatus(rs.getString("shippedStatus"));
                order.setTrackingNo(rs.getString("trackingno"));
                order.setShipDate(rs.getDate("shippingdate"));
                order.setShipTime(rs.getTime("shippingtime"));
                order.setArrivalStatus(rs.getString("arrivalStatus"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }

    public List<AdminViewOrderDetailsItem> getOrderItemsByOrderId(String orderId) {
        List<AdminViewOrderDetailsItem> items = new ArrayList<>();

        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ORDER_ITEM)) {

            preparedStatement.setString(1, orderId);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                String productName = rs.getString("PRODUCTNAME");
                double price = rs.getDouble("PRICE");
                String imageUrl = rs.getString("IMAGE_URL");
                int quantity = rs.getInt("quantity");

                AdminViewOrderDetailsItem item = new AdminViewOrderDetailsItem(productName, price, imageUrl, quantity);
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }
}