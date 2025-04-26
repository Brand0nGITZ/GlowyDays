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

        String sql = "UPDATE APP.\"USER\" SET \"name\"=?, \"username\"=?, \"birth\"=?, \"email\"=?, \"mobileNo\"=?, \"password\"=?  WHERE \"user_id\"=?";


        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

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
                response.sendRedirect("JSP/AdminPanel.jsp"); // or redirect back to staff list
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