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

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Get or create cart in session
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        
        // Get product info from form
        int productId = Integer.parseInt(request.getParameter("PRODUCT_ID"));
        String productName = request.getParameter("PRODUCTNAME");
        double price = Double.parseDouble(request.getParameter("PRICE"));
        
        // Create a product object from the form data
        Product product = new Product();
        product.setId(productId);
        product.setName(productName);
        product.setPrice(price);
        
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
        for (CartItem item : cart) {
            if (item.getProduct().getName().equals(productName))  {
                item.setQuantity(item.getQuantity() + 1);
                found = true;
                break;
            }
        }
        
        // If product is not in cart, add it
        if (!found) {
            CartItem newItem = new CartItem(product, 1);
            cart.add(newItem);
        }
        
        // Calculate total items in cart
        int totalItems = 0;
        for (CartItem item : cart) {
            totalItems += item.getQuantity();
        }
        session.setAttribute("cartSize", totalItems);
        
        // Redirect back to product page
        response.sendRedirect(request.getContextPath() + "/ProductServlet");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the cart JSP page
        request.getRequestDispatcher("/JSP/Cart.jsp").forward(request, response);
    }
}