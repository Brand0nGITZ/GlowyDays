package dao;

import model.Address;
import model.BuyerDetail;
import model.ShippingDetail;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShippingDAO {
    
    private Connection getConnection() throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        return DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");
    }

    public boolean saveShipping(BuyerDetail buyer, Address address, int userId) {
        Connection con = null;
        PreparedStatement buyerStmt = null;
        PreparedStatement addressStmt = null;
        PreparedStatement shipStmt = null;
        boolean success = false;
        
        try {
            // Get connection
            con = getConnection();
            
            // Start transaction
            con.setAutoCommit(false);

            // 1. Generate format for buyerId, addressId & shippingId
            String nextBuyerId = generateBuyerId(con);
            String nextAddressId = generateAddressId(con);  
            String nextShippingId = generateShippingId(con);
            
            // 1. Insert into BuyerDetail db
            String buyerSql = "INSERT INTO APP.BUYERDETAIL (\"buyerId\", \"user_id\" , \"fullName\", \"email\", \"mobile\") VALUES (?, ?, ?, ?, ?)";
            buyerStmt = con.prepareStatement(buyerSql);
            buyerStmt.setString(1, nextBuyerId);
            buyerStmt.setInt(2, userId);
            buyerStmt.setString(3, buyer.getFullName());
            buyerStmt.setString(4, buyer.getEmail());
            buyerStmt.setString(5, buyer.getMobile());
            buyerStmt.executeUpdate(); 
            
            // 2. Insert into Address db
            String addressSql = "INSERT INTO APP.ADDRESS (\"addressId\", \"user_id\" , \"address\", \"city\", \"state\", \"postcode\") VALUES (?, ?, ?, ?, ?, ?)";
            addressStmt = con.prepareStatement(addressSql);
            addressStmt.setString(1, nextAddressId);
            addressStmt.setInt(2, userId);
            addressStmt.setString(3, address.getAddressId());
            addressStmt.setString(4, address.getCity());
            addressStmt.setString(5, address.getState());
            addressStmt.setString(6, address.getPostcode());
            addressStmt.executeUpdate();

            // 3. Insert into ShippingDetail db (link buyerId & addressId)
            String shipSql = "INSERT INTO APP.SHIPPINGDETAIL (\"shippingId\", \"buyerId\", \"addressId\" , \"user_id\") VALUES (?, ?, ?, ?)";
            shipStmt = con.prepareStatement(shipSql);
            shipStmt.setString(1, nextShippingId);
            shipStmt.setString(2, nextBuyerId);
            shipStmt.setString(3, nextAddressId);
            shipStmt.setInt(4, userId);
            shipStmt.executeUpdate();

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
                    if (shipStmt != null) shipStmt.close();
                    if (addressStmt != null) addressStmt.close();
                    if (buyerStmt != null) buyerStmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
            }
        }
        return success;
    }
    
 public List<ShippingDetail> getAllShippingDetails(String buyerId) {
    List<ShippingDetail> shippingList = new ArrayList<>();
    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        con = getConnection();
        String sql = "SELECT sd.\"shippingId\", sd.\"buyerId\", a.\"addressId\", a.\"city\", a.\"state\", a.\"postcode\" " +
                     "FROM APP.SHIPPINGDETAIL sd " +
                     "JOIN APP.ADDRESS a ON sd.\"addressId\" = a.\"addressId\" " +
                     "WHERE sd.\"buyerId\" = ?";
        stmt = con.prepareStatement(sql);
        stmt.setString(1, buyerId); // Setting the buyerId parameter here
        
        rs = stmt.executeQuery();

        while (rs.next()) {
            
            ShippingDetail shipping = new ShippingDetail();
            shipping.setShippingId(rs.getString("shippingId"));
             BuyerDetail buyer = new BuyerDetail();
             buyer.setBuyerId(rs.getString("buyerId"));
            shipping.setBuyer(buyer);

            // Populate Address object from the result set
            Address address = new Address();
            address.setAddressId(rs.getString("addressId"));
            address.setCity(rs.getString("city"));
            address.setState(rs.getString("state"));
            address.setPostcode(rs.getString("postcode"));

            // Set the populated Address object into the ShippingDetail
            shipping.setAddress(address);

            // Add the shipping detail to the list
            shippingList.add(shipping);
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
    return shippingList;
}

    
    
    // Generate BuyerId like BYR-0001
    private String generateBuyerId(Connection con) throws SQLException {
        String sql = "SELECT MAX(\"buyerId\") AS maxId FROM APP.BUYERDETAIL";
        try (PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next() && rs.getString("maxId") != null) {
                String maxId = rs.getString("maxId");
                int num = Integer.parseInt(maxId.substring(4));
                return String.format("BYR-%04d", num + 1);
            } else {
                return "BYR-0001";
            }
        }
    }
    
    

    // Generate AddressId -> ADS-0001
    private String generateAddressId(Connection con) throws SQLException {
        String sql = "SELECT MAX(\"addressId\") AS maxId FROM APP.ADDRESS";
        try (PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next() && rs.getString("maxId") != null) {
                String maxId = rs.getString("maxId");
                int num = Integer.parseInt(maxId.substring(4));
                return String.format("ADS-%04d", num + 1);
            } else {
                return "ADS-0001";
            }
        }
    }

    // Generate ShippingId -> SHP-0001
    private String generateShippingId(Connection con) throws SQLException {
        String sql = "SELECT MAX(\"shippingId\") AS maxId FROM APP.SHIPPINGDETAIL";
        try (PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next() && rs.getString("maxId") != null) {
                String maxId = rs.getString("maxId");
                int num = Integer.parseInt(maxId.substring(4));
                return String.format("SHP-%04d", num + 1);
            } else {
                return "SHP-0001";
            }
        }
    }
    
 public static void main(String[] args) {
    // Example buyerId, replace with an actual buyerId from your database
    String buyerId = "BYR-0018"; 
    
    // Create instance of the DAO class
    ShippingDAO shippingDetailDAO = new ShippingDAO();
    
    // Get all shipping details for the specified buyerId
    List<ShippingDetail> shippingDetails = shippingDetailDAO.getAllShippingDetails(buyerId);

    // Print the results
    if (shippingDetails.isEmpty()) {
        System.out.println("No shipping details found for buyerId: " + buyerId);
    } else {
        for (ShippingDetail shipping : shippingDetails) {
            System.out.println("Shipping ID: " + shipping.getShippingId());
            System.out.println("Buyer ID: " + shipping.getBuyer().getBuyerId());

            // Access Address details via addressId
            Address address = shipping.getAddress();  // Get the Address object

            // Print the Address details
            System.out.println("Address ID: " + address.getAddressId());
            System.out.println("City: " + address.getCity());
            System.out.println("State: " + address.getState());
            System.out.println("Postcode: " + address.getPostcode());
            System.out.println("----------------------");
        }
    }
 }
 
 public String getLatestShippingId(int userId) {
    String shippingId = null;
    try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass")) {
        String sql = "SELECT shippingId FROM APP.\"ShippingDetail\" WHERE user_Id = ? ORDER BY shippingDate DESC LIMIT 1";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                shippingId = resultSet.getString("shippingId");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return shippingId;
}
}



////FOR TESTING PURPOSE
//package dao;
//
//import model.Address;
//import model.BuyerDetail;
//import model.ShippingDetail;
//
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//
//public class ShippingDAO {
//    
//    private Connection getConnection() throws Exception {
//        Class.forName("org.apache.derby.jdbc.ClientDriver");
//        return DriverManager.getConnection("jdbc:derby://localhost:1527/glowydays", "nbuser", "nbuser");
//    }
//
//    public int getShippingIdByEmailAndMobile(String email, String mobile) throws Exception {
//        int shippingId = 0;
//
//        try (Connection conn = getConnection()) {
//            // Derby-compatible query to get the most recent shippingId
//            String sql = "SELECT sd.\"shippingId\" FROM NBUSER.SHIPPINGDETAIL sd " +
//                        "JOIN NBUSER.BUYERDETAIL bd ON sd.\"buyerId\" = bd.\"buyerId\" " +
//                        "WHERE bd.\"email\" = ? AND bd.\"mobile\" = ? " +
//                        "ORDER BY sd.\"shippingId\" DESC";
//
//            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
//                stmt.setString(1, email);
//                stmt.setString(2, mobile);
//                ResultSet rs = stmt.executeQuery();
//                if (rs.next()) {
//                    shippingId = rs.getInt("shippingId");
//                }
//            }
//        }
//    
//        return shippingId;
//    }
//
//    public static void main(String[] args) {
//        ShippingDAO dao = new ShippingDAO();
//
//        try {
//            // 1. First get a real email/mobile pair from your database
//            Connection conn = dao.getConnection();
//            String getTestDataSql = "SELECT bd.\"email\", bd.\"mobile\", MAX(sd.\"shippingId\") as latestId " +
//                                  "FROM NBUSER.SHIPPINGDETAIL sd " +
//                                  "JOIN NBUSER.BUYERDETAIL bd ON sd.\"buyerId\" = bd.\"buyerId\" " +
//                                  "GROUP BY bd.\"email\", bd.\"mobile\" " +
//                                  "ORDER BY latestId DESC " +
//                                  "FETCH FIRST 1 ROW ONLY";
//
//            String testEmail = null;
//            String testMobile = null;
//            int expectedShippingId = 0;
//
//            try (PreparedStatement stmt = conn.prepareStatement(getTestDataSql);
//                 ResultSet rs = stmt.executeQuery()) {
//
//                if (rs.next()) {
//                    testEmail = rs.getString("email");
//                    testMobile = rs.getString("mobile");
//                    expectedShippingId = rs.getInt("latestId");
//                    System.out.println("Testing with most recent record:");
//                    System.out.println("Email: " + testEmail);
//                    System.out.println("Mobile: " + testMobile);
//                    System.out.println("Expected shippingId: " + expectedShippingId);
//                } else {
//                    System.out.println("No shipping records found in database!");
//                    return;
//                }
//            }
//
//            // 2. Test the method
//            System.out.println("\nCalling getShippingIdByEmailAndMobile()...");
//            int actualShippingId = dao.getShippingIdByEmailAndMobile(testEmail, testMobile);
//
//            // 3. Verify results
//            System.out.println("\nTest Results:");
//            System.out.println("Expected shippingId: " + expectedShippingId);
//            System.out.println("Actual shippingId: " + actualShippingId);
//
//            if (actualShippingId == expectedShippingId) {
//                System.out.println("✅ SUCCESS: Retrieved correct shippingId");
//            } else if (actualShippingId == 0) {
//                System.out.println("❌ FAILURE: No shippingId found");
//            } else {
//                System.out.println("❌ FAILURE: Retrieved wrong shippingId");
//            }
//
//        } catch (Exception e) {
//            System.err.println("Error during testing:");
//            e.printStackTrace();
//        }
//    }
//}