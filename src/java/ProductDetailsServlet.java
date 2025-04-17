import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.ProductDAO;
import model.Product;

@WebServlet("/ProductDetailsServlet")
public class ProductDetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.getProductById(id); 

                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/JSP/ProductDetails.jsp").forward(request, response);
                } else {
                    response.sendRedirect("/JSP/Product.jsp"); // Product not found, redirect back
                }

            } catch (NumberFormatException e) {
                response.sendRedirect("/JSP/Product.jsp"); // Invalid ID
            }
        } else {
            response.sendRedirect("/JSP/Product.jsp"); // No ID provided
        }
    }
    
  
    
}
