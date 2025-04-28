package dao;

import model.CheckoutDetail;
import java.sql.*;

public class CheckoutDAO {

    private static final String JDBC_URL = "jdbc:derby://localhost:1527/myderbyDB"; 
    private static final String USERNAME = "user";
    private static final String PASSWORD = "pass";

    public CheckoutDetail getCheckoutDetailByUserId(int userId) {
        CheckoutDetail checkoutDetail = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            String sql = "SELECT * FROM APP.CheckoutDetails WHERE userId = ? ORDER BY checkoutDate DESC FETCH FIRST 1 ROWS ONLY";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                checkoutDetail = new CheckoutDetail();
                checkoutDetail.setCheckoutId(rs.getInt("checkoutId"));
                checkoutDetail.setUserId(rs.getInt("userId"));
                checkoutDetail.setSubtotal(rs.getBigDecimal("subtotal"));
                checkoutDetail.setTaxAmount(rs.getBigDecimal("taxAmount"));
                checkoutDetail.setDeliveryFee(rs.getBigDecimal("deliveryFee"));
                checkoutDetail.setTotalAmount(rs.getBigDecimal("totalAmount"));
                checkoutDetail.setCheckoutDate(rs.getTimestamp("checkoutDate"));
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return checkoutDetail;
    }
}
