
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.*;
import dao.ViewUserOrderDAO;
import model.ViewOrderItem;
import model.ShippingInfo;

@WebServlet("/ViewUserOrderServlet")
public class ViewUserOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("/NewNew/JSP/Login.jsp");
            return;
        }
        int userId = Integer.parseInt((String) session.getAttribute("user_id"));
        try (Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/myderbyDB", "user", "pass")) {
            ViewUserOrderDAO orderDAO = new ViewUserOrderDAO();
            Map<String, List<ViewOrderItem>> ordersByOrderId = orderDAO.getOrdersByUserId(conn, userId);
            Map<String, Map<String, String>> orderStatusMap = orderDAO.getOrderStatus(conn, userId);
            Map<String, ShippingInfo> shippingInfoMap = orderDAO.getShippingInfo(conn, userId);
            
            request.setAttribute("shippingInfoMap", shippingInfoMap);
            request.setAttribute("ordersByOrderId", ordersByOrderId);
            request.setAttribute("orderStatusMap", orderStatusMap);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/UserJSP/UserOrder.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database access error", e);
        }
    }

}
