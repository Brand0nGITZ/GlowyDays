package dao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
import model.Login;
import model.User;

public class LoginDAO {

    // 登录功能
    public boolean loginUser(Login login, HttpServletRequest request) {
        boolean isLogin = false;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

            String sql = "SELECT * FROM APP.\"USER\" WHERE \"email\" = ? AND \"password\" = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, login.getEmail());
            pst.setString(2, login.getPassword());

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                isLogin = true;
                String username = rs.getString("username");  // 从数据库取出 username

                HttpSession session = request.getSession();
                session.setAttribute("username", username);
            }

            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isLogin;
    }

    // 🆕 添加：检查 email 是否已注册（Forgot Password 用）
    public boolean isEmailRegistered(String email) {
        boolean exists = false;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

            String sql = "SELECT * FROM APP.\"USER\" WHERE \"email\" = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                exists = true;
            }

            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }
    
    public User getUserByLogin(Login login) {
    User user = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

        String sql = "SELECT * FROM APP\"USER\" WHERE \"email\" = ? AND \"password\" = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, login.getEmail());
        pst.setString(2, login.getPassword());

        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            user = new User();
            user.setId(rs.getLong("user_id"));
            user.setName(rs.getString("name"));
            user.setUsername(rs.getString("username"));
            user.setBirth(rs.getDate("birth").toLocalDate()); // converting SQL Date to LocalDate
            user.setEmail(rs.getString("email"));
            user.setMobileNo(rs.getString("mobileNo"));
            user.setPassword(rs.getString("password"));
            user.setRole(rs.getString("role"));
        }

        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    return user;
}

    public boolean registerUser(User user) {
        boolean isRegistered = false;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

            String sql = "INSERT INTO \"USER\" (\"name\", \"username\", \"birth\", \"email\", \"mobileNo\", \"password\", \"role\") VALUES (?, ?, ?, ?, ?, ?, ?)";
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
    
    public User getUserByEmail(String email) {
    User user = null;
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

        String sql = "SELECT * FROM \"USER\" WHERE \"email\" = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, email);

        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            user = new User();
            user.setId(rs.getLong("user_id"));
            user.setName(rs.getString("name"));
            user.setUsername(rs.getString("username"));
            user.setBirth(rs.getDate("birth").toLocalDate());
            user.setEmail(rs.getString("email"));
            user.setMobileNo(rs.getString("mobileNo"));
            user.setPassword(rs.getString("password"));
            user.setRole(rs.getString("role"));
        }

        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    return user;
}

}