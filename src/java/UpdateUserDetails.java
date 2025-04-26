import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import model.User;

@WebServlet("/UpdateUserDetails")
public class UpdateUserDetails extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String field = request.getParameter("field");
        String value = request.getParameter(field);
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username"); // assuming username is unique

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

            String sql = "UPDATE APP.\"USER\" SET \"" + field + "\" = ? WHERE \"username\" = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, value);
            stmt.setString(2, username);
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                session.setAttribute(field, value);
                response.sendRedirect("JSP/UserDetails.jsp");
            } else {
                response.getWriter().println("Failed to update.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}