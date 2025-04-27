package dao;

import java.sql.*;
import model.User;
import java.util.List;
import java.util.ArrayList;


public class UserDAO {

    
    public boolean registerUser(User user) {
        boolean isRegistered = false;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

            String sql = "INSERT INTO APP.\"USER\" (\"name\", \"username\", \"birth\", \"email\", \"mobileNo\", \"password\", \"role\") VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, user.getName());
            pst.setString(2, user.getUsername());
            pst.setDate(3, java.sql.Date.valueOf(user.getBirth()));
            pst.setString(4, user.getEmail());
            pst.setString(5, user.getMobileNo());
            pst.setString(6, user.getPassword());
            pst.setString(7, user.getRole()); // 👈 this should be "staff"

            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                isRegistered = true;
                System.out.println("✅ Registered user with role: " + user.getRole());
            } else {
                System.out.println("⚠️ No rows inserted!");
            }

            pst.close();
            con.close();
        } catch (Exception e) {
            System.out.println("❌ Exception during registration:");
            e.printStackTrace(System.out);

        }

        return isRegistered;
    }
    
    public List<User> getAllStaff() {
    List<User> staffList = new ArrayList<>();
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

        String sql = "SELECT * FROM APP.\"USER\" WHERE \"role\" = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, "staff");
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            User user = new User();
                user.setId(rs.getLong("id"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("username"));
                user.setBirth(rs.getDate("birth").toLocalDate());
                user.setEmail(rs.getString("email"));
                user.setMobileNo(rs.getString("mobileNo"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
            
            staffList.add(user);
        }

        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    return staffList;
}
    
    public boolean editUser(User user) {
        boolean isSuccess = false;
        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "nbuser");
            
            String query = "UPDATE APP.USER SET name=?, username=?, birth=?, email=?, mobileNo=? WHERE cust_id=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1,user.getName());
            pst.setString(2,user.getUsername());
            pst.setDate(3, Date.valueOf(user.getBirth())); 
            pst.setString(4,user.getEmail());
            pst.setString(5,user.getName());
            pst.setLong(6, user.getId());
            
            int rowsAffected = pst.executeUpdate();
            if(rowsAffected > 0){
                isSuccess = true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return isSuccess;
    }
}