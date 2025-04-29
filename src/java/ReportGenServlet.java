import dao.ReportGenDAO;
import model.ReportGen;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@WebServlet("/ReportGenServlet")
public class ReportGenServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String jdbcURL = "jdbc:derby://localhost:1527/myderbyDB";
        String dbUser = "user";
        String dbPassword = "pass";

        String filterType = request.getParameter("filterType");
        String filterDate = request.getParameter("filterDate");

        try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            ReportGenDAO dao = new ReportGenDAO();
            List<ReportGen> reportList = dao.getFilteredSalesReport(connection, filterType, filterDate);

            request.setAttribute("reportList", reportList);
            request.getRequestDispatcher("/JSP/ReportGen.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error loading report", e);
        }
    }
}