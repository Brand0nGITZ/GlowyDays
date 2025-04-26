package dao;
import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ResetPasswordDAO {

    private final String jdbcURL = "jdbc:derby://localhost:1527/myderbyDB";
    private final String jdbcUsername = "user";
    private final String jdbcPassword = "pass";

    public boolean updatePasswordByEmail(String email, String password) {
        String sql = "UPDATE APP.\"USER\" SET \"password\" = ? WHERE \"email\" = ?";
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, password);
            statement.setString(2, email);

            int result = statement.executeUpdate();

            statement.close();
            connection.close();

            return result > 0;

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}