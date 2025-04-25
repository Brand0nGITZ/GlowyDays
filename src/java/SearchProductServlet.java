import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import dao.ProductDAO;

@WebServlet("/SearchProductServlet")
public class SearchProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");
        List<Product> result = new ArrayList<>();

        try {
            ProductDAO productDAO = new ProductDAO();

            if (query.matches("\\d+")) {
                // If query is a number, treat it as Product ID
                Product product = productDAO.searchProductById(Integer.parseInt(query));
                if (product != null) {
                    result.add(product);
                }
            } else {
                // Otherwise, search by product name (partial match)
                result = (List<Product>) productDAO.searchProductByName(query);
            }

            request.setAttribute("products", result);
            request.getRequestDispatcher("/JSP/Product.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Search failed");
        }
    }
}
