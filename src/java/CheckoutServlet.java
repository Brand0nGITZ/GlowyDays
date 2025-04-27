import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import model.CartItem;
import java.util.List;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the session data for the cart
        HttpSession session = request.getSession();
        double subtotal = (double) session.getAttribute("subtotal");
        double taxAmount = (double) session.getAttribute("taxAmount");
        double deliveryFee = (double) session.getAttribute("deliveryFee");
        double totalAmount = (double) session.getAttribute("totalAmount");

        // Get the user ID from the session
        int userId = Integer.parseInt((String) request.getSession().getAttribute("user_id"));
        
        // Initialize DB connection and PreparedStatement
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Step 1: Establish DB connection
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/myderbyDB", "user", "pass");

            // Step 2: Insert the checkout details into the CheckoutDetails table
            String insertCheckoutSQL = "INSERT INTO APP.CheckoutDetails (UserId, subtotal, taxAmount, deliveryFee, totalAmount, checkoutDate) "
                                      + "VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(insertCheckoutSQL);

            // Set values for the INSERT statement
            ps.setInt(1, userId);
            ps.setDouble(2, subtotal);
            ps.setDouble(3, taxAmount);
            ps.setDouble(4, deliveryFee);
            ps.setDouble(5, totalAmount);
            ps.setTimestamp(6, new Timestamp(System.currentTimeMillis())); // Current timestamp

            // Execute the INSERT statement
            ps.executeUpdate();

            // Redirect to a confirmation page (you can customize this page)
            response.sendRedirect(request.getContextPath() + "/JSP/PaymentShippingForm.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL exception properly, redirect to an error page
            response.sendRedirect("error.jsp");
        } finally {
            // Close resources
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}