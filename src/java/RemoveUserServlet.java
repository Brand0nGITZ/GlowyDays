import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/RemoveUserServlet")
public class RemoveUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("id");

        if (userId != null) {
            String driverName = "org.apache.derby.jdbc.ClientDriver";
            String connectionUrl = "jdbc:derby://localhost:1527/myderbyDB";
            String dbUserId = "user";
            String dbPassword = "pass";

            Connection connection = null;
            PreparedStatement preparedStatement = null;

            try {
                Class.forName(driverName);
                connection = DriverManager.getConnection(connectionUrl, dbUserId, dbPassword);
                connection.setAutoCommit(false);  // Disable auto-commit

                String sql = "DELETE FROM APP.\"USER\" WHERE \"user_id\" = ?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, userId);

                int result = preparedStatement.executeUpdate();

                if (result > 0) {
                    connection.commit();  // Commit the transaction
                    response.sendRedirect("/JSP/CustomerManagement.jsp");
                } else {
                    connection.rollback();  // Rollback in case of failure
                    response.sendRedirect("/JSP/UserHome.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
                try {
                    if (connection != null) {
                        connection.rollback();  // Ensure rollback on error
                    }
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
                response.sendRedirect("ErrorPage.jsp");  // Redirect to an error page in case of exception
            } finally {
                try {
                    if (preparedStatement != null) preparedStatement.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            response.sendRedirect("ErrorPage.jsp");  // Redirect to error page if no ID is provided
        }
    }
}