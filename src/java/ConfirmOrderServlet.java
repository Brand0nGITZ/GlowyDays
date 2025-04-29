import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import dao.OrderDAO;   // You need to create this DAO if you don't have one
import model.*;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        
        try {
            // 1. Get session attributes
            BuyerDetail buyer = (BuyerDetail) session.getAttribute("buyer");
            Address address = (Address) session.getAttribute("address");
            PaymentMethod paymentMethod = (PaymentMethod) session.getAttribute("paymentMethod");
            List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
            CheckoutDetail checkoutDetail = (CheckoutDetail) session.getAttribute("checkoutDetail");

            if (buyer == null || address == null || paymentMethod == null || cartItems == null || checkoutDetail == null) {
                throw new Exception("Missing order details in session.");
            }

            // 2. Create Order and save it
         //   OrderDAO orderDAO = new OrderDAO();
          //  boolean orderSaved = orderDAO.saveOrder(buyer, address, paymentMethod, cartItems, checkoutDetail);
            
          //  if (!orderSaved) {
            //    throw new Exception("Failed to save the order to the database.");
          //  }

            // 3. Clear cart after order confirmed (optional)
            session.removeAttribute("cartItems");

            // 4. Redirect to success page
            response.sendRedirect("orderSuccess.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            try (PrintWriter out = response.getWriter()) {
                out.println("<html><body>");
                out.println("<h2>Order Error</h2>");
                out.println("<p>" + e.getMessage() + "</p>");
                out.println("<a href='checkoutReview.jsp'>Back to Checkout</a>");
                out.println("</body></html>");
            }
        }
    }
}
