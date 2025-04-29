package dao;

import model.ReportGen;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;
import java.util.Calendar;

public class ReportGenDAO {

    public List<ReportGen> getProductSalesReport(Connection connection) throws SQLException {
        List<ReportGen> reportList = new ArrayList<>();

        String sql = 
        "SELECT p.\"PRODUCTNAME\", p.\"IMAGE_URL\", SUM(oi.\"quantity\")  AS totalSold " +
        "FROM APP.ORDERITEMS oi " +
        "JOIN APP.PRODUCTS p ON oi.\"productId\" = p.\"PRODUCT_ID\" " +
        "GROUP BY p.\"PRODUCTNAME\", p.\"IMAGE_URL\" " +
        "ORDER BY totalSold DESC ";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString("PRODUCTNAME");
                String imageUrl = rs.getString("IMAGE_URL");
                int qty = rs.getInt("totalSold");
                reportList.add(new ReportGen(name, qty, imageUrl));
            }
        }
        return reportList;
    }

    public List<ReportGen> getFilteredSalesReport(Connection connection, String filterType, String filterDate)
            throws SQLException {

        List<ReportGen> reportList = new ArrayList<>();
        String baseSql = "SELECT p.\"PRODUCTNAME\", p.\"IMAGE_URL\", SUM(oi.\"quantity\") AS totalSold "
                + "FROM APP.ORDERITEMS oi "
                + "JOIN APP.PRODUCTS p ON oi.\"productId\" = p.\"PRODUCT_ID\" "
                + "JOIN APP.ORDERS o ON oi.\"orderId\" = o.\"orderId\" ";

        String whereClause = "";
        PreparedStatement ps;

        if (filterType != null && filterDate != null && !filterDate.isEmpty()) {
            switch (filterType.toLowerCase()) {
                case "daily":
                    whereClause = " WHERE DATE(o.\"orderDate\") = ?";
                    break;
                case "monthly":
                    whereClause = " WHERE MONTH(o.\"orderDate\") = ? AND YEAR(o.\"orderDate\") = ?";
                    break;
                case "yearly":
                    whereClause = " WHERE YEAR(o.\"orderDate\") = ?";
                    break;
                default:
                    whereClause = "";
            }
        }

        String groupOrder = " GROUP BY p.\"PRODUCTNAME\", p.\"IMAGE_URL\" ORDER BY totalSold DESC";
        ps = connection.prepareStatement(baseSql + whereClause + groupOrder);

        // set parameters if needed
        if (!whereClause.isEmpty()) {
            Date sqlDate = Date.valueOf(filterDate); // format: "YYYY-MM-DD"
            Calendar cal = Calendar.getInstance();
            cal.setTime(sqlDate);
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH) + 1;
            
            switch (filterType.toLowerCase()) {
                case "daily":
                    ps.setDate(1, sqlDate);
                    break;
                case "monthly":
                    ps.setInt(1, month);
                    ps.setInt(2, year);
                    break;
                case "yearly":
                    ps.setInt(1, year);
                    break;
            }
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String name = rs.getString("PRODUCTNAME");
            String imageUrl = rs.getString("IMAGE_URL");
            int qty = rs.getInt("totalSold");
            reportList.add(new ReportGen(name, qty, imageUrl));
        }

        return reportList;
    }
}