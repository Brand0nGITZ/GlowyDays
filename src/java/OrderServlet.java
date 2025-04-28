

import dao.OrderDAO;
import model.Order;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

            // 🔽 Add this block here BEFORE setting attributes or forwarding
            HttpSession session = request.getSession();
            String error = (String) session.getAttribute("error");
            if (error != null) {
                request.setAttribute("error", error);
                session.removeAttribute("error");
            }

            OrderDAO orderDAO = new OrderDAO(conn);
            List<Order> orders = orderDAO.getAllOrders();
            request.setAttribute("orderList", orders);

            RequestDispatcher rd = request.getRequestDispatcher("/JSP/OrderManagement.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}