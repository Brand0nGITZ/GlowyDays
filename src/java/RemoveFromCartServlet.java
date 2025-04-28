import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Iterator;
import model.CartItem;
import dao.CartDAO;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = Integer.parseInt((String) session.getAttribute("user_id")); // Get user ID from session

        int productId = Integer.parseInt(request.getParameter("productId")); // Get product ID from form

        // Remove from database
        CartDAO cartDAO = new CartDAO();
        boolean isRemoved = cartDAO.removeCartItem(userId, productId);

        if (isRemoved) {
            System.out.println("Cart item removed successfully from the database.");

            // Also remove from session cart
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart != null) {
                Iterator<CartItem> iterator = cart.iterator();
                while (iterator.hasNext()) {
                    CartItem item = iterator.next();
                    if (item.getProduct().getId() == productId) {
                        iterator.remove();
                        break;
                    }
                }

                // Update cart size in session
                int totalItems = 0;
                for (CartItem item : cart) {
                    totalItems += item.getQuantity();
                }
                session.setAttribute("cartSize", totalItems);
            }
        } else {
            System.out.println("Failed to remove cart item from the database.");
        }

        // Redirect back to cart page
        response.sendRedirect(request.getContextPath() + "/CartServlet");
    }
}