import dao.PaymentDAO;
import dao.ShippingDAO;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.PaymentMethod;
import model.BuyerDetail;
import model.Address;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.ShippingDetail;

@WebServlet("/PaymentShippingServlet")
public class PaymentShippingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        
        int userId = Integer.parseInt((String) request.getSession().getAttribute("user_id"));
        
        try {
            // 1. Get shipping inputs from form
            String fullName = request.getParameter("shippingName");
            String email = request.getParameter("shippingEmail");
            String mobile = request.getParameter("shippingMobile");
            String addressStr = request.getParameter("shippingAddress");
            String city = request.getParameter("shippingCity");
            String state = request.getParameter("shippingState");
            String postcode = request.getParameter("shippingPostcode");
           

            // 2. Get payment inputs from form
            String methodId = request.getParameter("payment_methodId");
            String methodName = request.getParameter("payment_method");
            String cardOwner = request.getParameter("cardOwner");
            String cardNumber = request.getParameter("cardNumber");
            String expMonth = request.getParameter("expMonth");
            String expYear = request.getParameter("expYear");
            String cvv = request.getParameter("cvv");
            
                 //(String methodId, String methodName, String cardOwner, String cardNumber,
                        // String expMonth, String expYear, String cvv, int userId)
                // public BuyerDetail(int userId, String fullName, String email, String mobile) {
            // 3. Create model objects
            BuyerDetail buyer = new BuyerDetail(userId, fullName, email, mobile);
            Address address = new Address ( addressStr,  city, state, postcode);
            PaymentMethod paymentMethod = new PaymentMethod(methodId, methodName, cardOwner, cardNumber, expMonth, expYear, cvv , userId);

            // 4. Save both to database
            ShippingDAO shippingDAO = new ShippingDAO();
            String shippingId = shippingDAO.getLatestShippingId(userId); 
            PaymentDAO paymentDAO = new PaymentDAO();
          
            boolean shippingSaved = shippingDAO.saveShipping(buyer, address , userId);
            boolean paymentSaved = paymentDAO.savePayment(paymentMethod , userId);
            //This works
            if (!shippingSaved){
               throw new Exception("Failed to save shipping information to database");
            }
            
            if (!paymentSaved){
               throw new Exception("Failed to save payment information to database");
           }
            // public ShippingDetail(int userId, String shippingId, BuyerDetail buyer, Address address) {
       // this.shippingId = shippingId;
            // 5. Store in session for orderConfirmedServlet page
            ShippingDetail shippingDetail = new ShippingDetail(userId, shippingId, buyer, address);
            session.setAttribute("shippingDetail", shippingDetail);
            session.setAttribute("paymentMethods", List.of(paymentMethod));
            session.setAttribute("buyer", buyer);
            session.setAttribute("address", address);
            session.setAttribute("paymentMethod", paymentMethod);
                    
            // 6. Redirect to OrderConfirmedServlet to complete order
            response.sendRedirect(request.getContextPath() + "/CheckoutReviewServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<html><head><title>Error</title></head><body>");
                out.println("<h2>An error occurred during payment</h2>");
                out.println("<p>" + e.getMessage() + "</p>");
                out.println("<a href='" + request.getContextPath() + "/PaymentShippingForm.jsp'>Go Back</a>");
                out.println("</body></html>");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}