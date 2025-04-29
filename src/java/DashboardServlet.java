
import dao.DashboardDAO;
import model.DashboardStats;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String jdbcURL = "jdbc:derby://localhost:1527/myderbyDB";
        String dbUser = "user";
        String dbPassword = "pass";

        try {
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            DashboardDAO dao = new DashboardDAO();
            DashboardStats stats = dao.getDashboardStats(conn);

            request.setAttribute("stats", stats);
            String role = (String) request.getSession().getAttribute("role"); // Get role from session
            String targetPage;

            switch (role) {
                case "admin":
                    targetPage = "/JSP/AdminPanel.jsp";
                    break;
                case "staff":
                    targetPage = "/JSP/StaffPanel.jsp"; // Assuming you meant a separate JSP for staff
                    break;
                default:
                    targetPage = "/JSP/login.jsp"; // optional: handle unknown roles
                    break;
            }

            request.getRequestDispatcher(targetPage).forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error loading dashboard", e);
        }
    }
}