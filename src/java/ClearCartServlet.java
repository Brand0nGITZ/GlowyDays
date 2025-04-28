import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.CartItem;
import dao.CartDAO;

@WebServlet("/ClearCartServlet")
public class ClearCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        int userId = Integer.parseInt((String) session.getAttribute("user_id")); // Get user ID from session

        // Clear cart from database
        CartDAO cartDAO = new CartDAO();
        boolean isCleared = cartDAO.clearCart(userId);

        if (isCleared) {
            System.out.println("Cart cleared successfully from the database.");

            // Also clear cart from session
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart != null) {
                cart.clear();
            }

            session.setAttribute("cartSize", 0);
        } else {
            System.out.println("Failed to clear cart from the database.");
        }

        // Redirect back to cart page
        response.sendRedirect(request.getContextPath() + "/CartServlet");
    }
} 