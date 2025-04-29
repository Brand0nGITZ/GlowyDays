import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/UpdateStaffServlet")
public class UpdateStaffServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String birth = request.getParameter("birth");
        String email = request.getParameter("email");
        String mobileNo = request.getParameter("mobileNo");
        String password = request.getParameter("password");
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

            // 先检查 password 有没有新输入
            if (password == null || password.isEmpty()) {
                String fetchSql = "SELECT \"password\" FROM APP.\"USER\" WHERE \"user_id\"=?";
                PreparedStatement fetchPs = conn.prepareStatement(fetchSql);
                fetchPs.setString(1, id);
                ResultSet rs = fetchPs.executeQuery();
                if (rs.next()) {
                    password = rs.getString("password"); // 用原来的 password
                }
                rs.close();
                fetchPs.close();
            }

            // 更新用户资料
            String sql = "UPDATE APP.\"USER\" SET \"name\"=?, \"username\"=?, \"birth\"=?, \"email\"=?, \"mobileNo\"=?, \"password\"=? WHERE \"user_id\"=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, username);
            ps.setString(3, birth);
            ps.setString(4, email);
            ps.setString(5, mobileNo);
            ps.setString(6, password);
            ps.setString(7, id);

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("JSP/AdminPanel.jsp");
            } else {
                response.getWriter().println("No record updated.");
            }

            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
