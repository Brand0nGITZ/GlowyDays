package dao;

import model.DashboardStats;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DashboardDAO {

    public DashboardStats getDashboardStats(Connection conn) throws SQLException {
        int totalOrders = 0;
        int totalCustomers = 0;
        int totalItemsSold = 0;

        try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM ORDERS")) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalOrders = rs.getInt(1);
            }
        }

        // Count distinct customers (userId)
        try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(DISTINCT \"userId\") FROM ORDERS")) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalCustomers = rs.getInt(1);
            }
        }

        // Sum quantity from ORDERITEMS
        try (PreparedStatement ps = conn.prepareStatement("SELECT SUM(\"quantity\") FROM ORDERITEMS")) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalItemsSold = rs.getInt(1);
            }
        }

        return new DashboardStats(totalOrders, totalCustomers, totalItemsSold);
    }
}