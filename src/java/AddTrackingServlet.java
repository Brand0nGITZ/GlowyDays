

import dao.OrderDAO;
import model.Order;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AddTrackingServlet")
public class AddTrackingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderId = request.getParameter("orderId");
        String trackingNo = request.getParameter("trackingNo");

        Connection conn = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");
            OrderDAO orderDAO = new OrderDAO(conn);

            // Check if tracking number already exists
            if (orderDAO.isTrackingNumberExists(trackingNo)) {
                HttpSession session = request.getSession();
                session.setAttribute("error", "Tracking number already exists. Please enter a new one.");
                response.sendRedirect("/GlowyDaysProjectNew/OrderServlett");
                return;
            }

            // Get next shipping ID
            String newShippingId = orderDAO.getNextShippingId();

            // Insert into SHIPPING table
            orderDAO.insertShipping(newShippingId, orderId, trackingNo);

            // Update order's shipped status
            orderDAO.updateOrderStatus(orderId);

            response.sendRedirect("/GlowyDaysProjectNew/OrderServlett");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                // Handle error closing connection
            }
        }
    }
}