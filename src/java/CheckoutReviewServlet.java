
import dao.CartDAO;
import dao.CheckoutDAO;
import model.CartItem;
import model.CheckoutDetail;
import dao.ShippingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.PaymentDAO;

import java.io.IOException;
import java.util.List;
import model.PaymentMethod;
import model.ShippingDetail;

@WebServlet("/CheckoutReviewServlet")
public class CheckoutReviewServlet extends HttpServlet {

     protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = Integer.parseInt((String) session.getAttribute("user_id")); // your session stores user_id as String
        
        CartDAO cartDAO = new CartDAO();
        CheckoutDAO checkoutDAO = new CheckoutDAO();
        ShippingDAO shippingDAO = new ShippingDAO();
        PaymentDAO paymentDAO = new PaymentDAO();
        

        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        CheckoutDetail checkoutDetail = checkoutDAO.getCheckoutDetailByUserId(userId);
        List<ShippingDetail> shippingList = shippingDAO.getAllShippingDetails(String.valueOf(userId)); // Call method from ShippingDAO
        List<PaymentMethod> paymentMethods = paymentDAO.getAllPaymentMethods(userId);
               
        session.setAttribute("cartItems", cartItems);
        session.setAttribute("checkoutDetail", checkoutDetail);
        session.setAttribute("shippingList", shippingList);
        session.setAttribute("paymentMethod", paymentMethods);
        
        
        
        response.sendRedirect(request.getContextPath() + "/JSP/CheckoutReview.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Not needed but safe
    }
}