

import dao.AdminOrderDetailsDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.AdminViewOrderDetails;
import model.AdminViewOrderDetailsItem;
import java.util.List;

@WebServlet("/OrderDetailsServlet")
public class OrderDetailsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get order ID from request parameter
        String orderIdParam = request.getParameter("orderId"); // It's a String!

        if (orderIdParam != null) {
            String orderId = orderIdParam; // Keep it as a String

            // Call DAO to get order details
            AdminOrderDetailsDAO dao = new AdminOrderDetailsDAO();
            AdminViewOrderDetails order = dao.getOrderDetailsById(orderId); // No need to parse to int

            // Fetch the items associated with the order
            List<AdminViewOrderDetailsItem> items = dao.getOrderItemsByOrderId(orderId);

            // Set order object into request
            request.setAttribute("order", order);
            // Set order items list into request
            request.setAttribute("items", items);
        }

        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/OrderDetails.jsp");
        dispatcher.forward(request, response);
    }

}