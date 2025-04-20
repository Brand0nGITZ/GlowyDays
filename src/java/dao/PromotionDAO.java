package dao;

import model.Product;
import model.Promotion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;  

public class PromotionDAO {
    
    private static final String host = "jdbc:derby://localhost:1527/myderbyDB";
    private static final String user =  "user";
    private static final String password = "pass";
     
    public List<Promotion> getAllPromotions() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM PROMOTION";

        try (Connection conn = DriverManager.getConnection(host, user, password);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Promotion promo = new Promotion();
                promo.setPromoId(rs.getInt("PROMO_ID"));
                promo.setTitle(rs.getString("PRODUCTNAME"));
                promo.setStartDate(rs.getDate("START_DATE"));
                promo.setEndDate(rs.getDate("END_DATE"));
                promo.setDiscountValue(rs.getDouble("DISCOUNT_VALUE"));
                promo.setActive(rs.getBoolean("IS_ACTIVE"));

                promotions.add(promo);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return promotions;
    }

    public Promotion getPromotionById(int promoId) {
        Promotion promo = null;
        String sql = "SELECT * FROM PROMOTION WHERE PROMO_ID = ?";

        try (Connection conn = DriverManager.getConnection(host, user, password);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, promoId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                promo = new Promotion();
                promo.setPromoId(rs.getInt("PROMO_ID"));
                promo.setTitle(rs.getString("PROMO_NAME"));
                promo.setStartDate(rs.getDate("START_DATE"));
                promo.setEndDate(rs.getDate("END_DATE"));
                promo.setDiscountValue(rs.getDouble("DISCOUNT_VALUE"));
                promo.setActive(rs.getBoolean("IS_ACTIVE"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return promo;
    }
    public int getActivePromotionId() {
    String sql = "SELECT PROMO_ID FROM PROMOTION WHERE CURRENT_DATE BETWEEN START_DATE AND END_DATE AND IS_ACTIVE = TRUE";
    try (Connection conn = DriverManager.getConnection(host, user, password);
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt("PROMO_ID");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return -1; // No active promotion found
}
}
