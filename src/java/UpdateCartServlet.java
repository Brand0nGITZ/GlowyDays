
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.CartItem;
import model.User;
import dao.CartDAO;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve user ID from the session
        HttpSession session = request.getSession();
        int userId = Integer.parseInt((String) session.getAttribute("user_id"));  // Fetch user_id from session

        // Get the productId and the new quantity from the form submission
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Retrieve the cart from the session
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart != null) {
            // Update the quantity in the cart (session)
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(quantity);  // Update quantity in the cart
                    break;
                }
            }

            // Update the quantity in the database using CartDAO
            CartDAO cartDAO = new CartDAO();
            boolean isUpdated = cartDAO.updateCartItem(userId, productId, quantity);  // Pass userId

            if (isUpdated) {
                System.out.println("Cart item updated successfully in the database.");
            } else {
                System.out.println("Failed to update cart item in the database.");
            }

            // Recalculate total items in the cart and update session attribute
            int totalItems = 0;
            for (CartItem item : cart) {
                totalItems += item.getQuantity();
            }
            session.setAttribute("cartSize", totalItems);

            // Redirect to Cart page (you can redirect to the cart page where the updated cart will be displayed)
            response.sendRedirect(request.getContextPath() + "/CartServlet");
        } else {
            // If cart is empty or not found, redirect to the CartServlet
            response.sendRedirect(request.getContextPath() + "/CartServlet");
        }
    }
}