package dao;

import model.Payment;
import model.PaymentMethod;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    private Connection getConnection() throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        return DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");
    }

    public boolean savePayment(PaymentMethod method , int userId) {
        Connection con = null;
        PreparedStatement methodStmt = null;
        PreparedStatement payStmt = null;
        boolean success = false;
        
        try {
            // Get connection
            con = getConnection();
            
            // Start transaction
            con.setAutoCommit(false);
                        
            // 1. Generate format for paymentMethodId & paymentId
            String nextMethodId = generateMethodId(con);
            String nextPaymentId = generatePaymentId(con);     

            // 2. Insert into PaymentMethod db
            String methodSql = "INSERT INTO APP.PAYMENTMETHOD (\"methodId\", \"methodName\", \"cardOwner\", \"cardNumber\", \"expMonth\", \"expYear\", \"cvv\", \"user_id\") VALUES (?, ?, ?, ?, ?, ?, ? ,?)";
            methodStmt = con.prepareStatement(methodSql);
            methodStmt.setString(1, nextMethodId);
            methodStmt.setString(2, method.getMethodName());
            methodStmt.setString(3, method.getCardOwner());
            methodStmt.setString(4, method.getCardNumber());
            methodStmt.setString(5, method.getExpMonth());
            methodStmt.setString(6, method.getExpYear());
            methodStmt.setString(7, method.getCvv());
            methodStmt.setInt(8, userId);
            
            
            methodStmt.executeUpdate();

            // 3. Insert into Payment db
            String paySql = "INSERT INTO APP.PAYMENT (\"paymentId\", \"methodId\", \"user_id\" , \"paidDate\", \"paidTime\" ) VALUES (?, ?, ?, ?, ?)";
            payStmt = con.prepareStatement(paySql);
            payStmt.setString(1, nextPaymentId);
            payStmt.setString(2, nextMethodId); 
            payStmt.setInt(3, userId);
            payStmt.setDate(4, Date.valueOf(LocalDate.now()));
            payStmt.setTime(5, Time.valueOf(LocalTime.now()));
            payStmt.executeUpdate();

            // Commit transaction
            con.commit();
            success = true;
            
        } catch (Exception e) {
            // Rollback transaction on error
            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (payStmt != null) payStmt.close();
                if (methodStmt != null) methodStmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
   public List<PaymentMethod> getAllPaymentMethods(int userId) {
    List<PaymentMethod> paymentMethods = new ArrayList<>();
    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        con = getConnection();
        
        // Here you JOIN PAYMENTMETHOD and PAYMENT table
        String sql = "SELECT m.* FROM APP.PAYMENTMETHOD m " +
                     "JOIN APP.PAYMENT p ON m.\"methodId\" = p.\"methodId\" " +
                     "WHERE p.\"user_id\" = ?";
                     
        stmt = con.prepareStatement(sql);
        stmt.setInt(1, userId);
        
        rs = stmt.executeQuery();

        while (rs.next()) {
            PaymentMethod method = new PaymentMethod();
            method.setMethodId(rs.getString("methodId"));
            method.setMethodName(rs.getString("methodName"));
            method.setCardOwner(rs.getString("cardOwner"));
            method.setCardNumber(rs.getString("cardNumber"));
            method.setExpMonth(rs.getString("expMonth"));
            method.setExpYear(rs.getString("expYear"));
            method.setCvv(rs.getString("cvv"));
            method.setUserId(rs.getInt("user_Id"));
            paymentMethods.add(method);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    return paymentMethods;
}
    
    // Generate for methodId -> PMD-0001
    private String generateMethodId(Connection con) throws SQLException {
        String sql = "SELECT MAX(\"methodId\") AS maxId FROM APP.PAYMENTMETHOD";
        try (PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next() && rs.getString("maxId") != null) {
                String maxId = rs.getString("maxId"); 
                int num = Integer.parseInt(maxId.substring(4)); 
                return String.format("PMD-%04d", num + 1);
            } else {
                return "PMD-0001"; 
            }
        }
    }

    // Generate for paymentId -> PYT-0001
    private String generatePaymentId(Connection con) throws SQLException {
        String sql = "SELECT MAX(\"paymentId\") AS maxId FROM APP.PAYMENT";
        try (PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next() && rs.getString("maxId") != null) {
                String maxId = rs.getString("maxId");
                int num = Integer.parseInt(maxId.substring(4));
                return String.format("PYT-%04d", num + 1);
            } else {
                return "PYT-0001";
            }
        }
    }
    
    
    
     public static void main(String[] args) {
        PaymentDAO paymentDAO = new PaymentDAO();
        
        String buyerId = "BYR-0018"; // Use an actual buyerId from your database
        int userId = 8;

        List<PaymentMethod> paymentMethods = paymentDAO.getAllPaymentMethods(userId);

        if (paymentMethods.isEmpty()) {
            System.out.println("No payment methods found for userId: " + userId);
        } else {
            for (PaymentMethod payment : paymentMethods) {
                System.out.println("Method ID: " + payment.getMethodId());
                System.out.println("Method Name: " + payment.getMethodName());
                System.out.println("Card Owner: " + payment.getCardOwner());
                System.out.println("Card Number: " + payment.getCardNumber());
                System.out.println("Expiration Month: " + payment.getExpMonth());
                System.out.println("Expiration Year: " + payment.getExpYear());
                System.out.println("CVV: " + payment.getCvv());
                System.out.println("----------------------");
            }
        }
    }
    
    
}




// FOR TESTING PURPOSE
//    public List<PaymentMethod> getAllPaymentMethods() {
//        List<PaymentMethod> methods = new ArrayList<>();
//        Connection con = null;
//        PreparedStatement stmt = null;
//        ResultSet rs = null;
//
//        try {
//            con = getConnection();
//            String sql = "SELECT * FROM APP.PAYMENTMETHOD";
//            stmt = con.prepareStatement(sql);
//            rs = stmt.executeQuery();
//
//            while (rs.next()) {
//                PaymentMethod method = new PaymentMethod();
//                method.setMethodId(rs.getInt("methodId"));
//                method.setMethodName(rs.getString("methodName"));
//                method.setCardOwner(rs.getString("cardOwner"));
//                method.setCardNumber(rs.getString("cardNumber"));
//                method.setExpMonth(rs.getString("expMonth"));
//                method.setExpYear(rs.getString("expYear"));
//                method.setCvv(rs.getString("cvv"));
//                methods.add(method);
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                if (rs != null) rs.close();
//                if (stmt != null) stmt.close();
//                if (con != null) con.close();
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }
//
//        return methods;
//    }
//
//    public static void main(String[] args) {
//        PaymentDAO dao = new PaymentDAO();
//
//        // Test: Retrieve and print all payment methods
//        List<PaymentMethod> methodList = dao.getAllPaymentMethods();
//        if (methodList.isEmpty()) {
//            System.out.println("No payment methods found.");
//        } else {
//            for (PaymentMethod method : methodList) {
//                System.out.println("Method ID: " + method.getMethodId());
//                System.out.println("Method Name: " + method.getMethodName());
//                System.out.println("Card Owner: " + method.getCardOwner());
//                System.out.println("Card Number: " + method.getCardNumber());
//                System.out.println("Expiry: " + method.getExpMonth() + "/" + method.getExpYear());
//                System.out.println("CVV: " + method.getCvv());
//                System.out.println("---------------------------");
//            }
//        }
//    }