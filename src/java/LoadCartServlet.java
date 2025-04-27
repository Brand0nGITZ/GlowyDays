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

@WebServlet("/LoadCartServlet")
public class LoadCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        CartDAO cartDAO = new CartDAO();

        try {
            int userID = Integer.parseInt((String) session.getAttribute("user_id"));

            List<CartItem> cartItems = cartDAO.getCartItems(userID);
            session.setAttribute("cart", cartItems);

            int totalItems = 0;
            for (CartItem item : cartItems) {
                totalItems += item.getQuantity();
            }
            session.setAttribute("cartSize", totalItems);

            response.sendRedirect(request.getContextPath() + "/ProductServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}