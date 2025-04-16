import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import model.CartItem;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        if (cart != null) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            Iterator<CartItem> iterator = cart.iterator();
            while (iterator.hasNext()) {
                CartItem item = iterator.next();
                if (item.getProduct().getId() == productId) {
                    iterator.remove();
                    break;
                }
            }
            
            // Recalculate total items in cart
            int totalItems = 0;
            for (CartItem item : cart) {
                totalItems += item.getQuantity();
            }
            session.setAttribute("cartSize", totalItems);
        }
        
        response.sendRedirect(request.getContextPath() + "/CartServlet");
    }
}