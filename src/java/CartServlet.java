import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.Product;
import dao.CartDAO;
import java.sql.*;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userID = Integer.parseInt((String) request.getSession().getAttribute("user_id"));

        // Get or create cart in session
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // Get product info from form
        int productId = Integer.parseInt(request.getParameter("PRODUCT_ID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String productName = request.getParameter("PRODUCTNAME");
        double price = Double.parseDouble(request.getParameter("PRICE"));

        // Create a product object from the form data
        Product product = new Product();
        product.setId(productId);
        product.setName(productName);
        product.setPrice(price);
        product.setQuantity(quantity);

        CartItem item = new CartItem(product, quantity);

        // Add image URL to the product (we'll get this from a hidden field in the form)
        String imageUrl = request.getParameter("IMAGE_URL");
        if (imageUrl != null && !imageUrl.isEmpty()) {
            product.setImageUrl(imageUrl);
        } else {
            // Default image if not provided
            product.setImageUrl("default.jpg");
        }

        // Check if product already exists in cart
        boolean found = false;
        for (CartItem existingItem : cart) {
            if (existingItem.getProduct().getId() == productId) {
                existingItem.setQuantity(existingItem.getQuantity() + quantity);  // Update quantity
                found = true;
                break;
            }
        }

        // If product is not in cart, add it
        if (!found) {
            cart.add(item);  // Add new item to cart
        }

        CartDAO cartDAO = new CartDAO();
        try {
            boolean isInserted = cartDAO.upsertCartItem(userID, item);
            // Insert into database
            if (!isInserted) {
                throw new ServletException("Failed to insert item into database.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error: " + e.getMessage());
        }

        // Calculate total items in cart
        int totalItems = 0;
        for (CartItem existingItem : cart) {
            totalItems += existingItem.getQuantity();
        }
        session.setAttribute("cartSize", totalItems);

        // Redirect back to product page
        response.sendRedirect(request.getContextPath() + "/ProductServlet");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        int userID = Integer.parseInt((String) request.getSession().getAttribute("user_id"));
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        // If the cart is null, initialize it
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        CartDAO cartDAO = new CartDAO();

        List<CartItem> cartItems = cartDAO.getCartItems(userID);

        // Forward to a JSP page to display the cart (or send a response in some other way)
        request.setAttribute("UserID", userID);
        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("/JSP/Cart.jsp").forward(request, response);
    }

}