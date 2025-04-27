/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import model.Product;
import dao.CartDAO;
import model.CartItem;
/**@
 *
 * @author yapji
 */
@WebServlet("/ProductServlet" )
public class ProductServlet extends HttpServlet {
    
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String userID = (String) request.getSession().getAttribute("user_id");
        
        if (userID == null) {
            // If user is not logged in, maybe redirect to login page or show message
            response.sendRedirect("Login.jsp");
            return; // Stop further processing
        }
        
        
        int page = 1;
        int recordsPerPage = 4;
        
        if (request.getParameter("page") != null) {
             page = Integer.parseInt(request.getParameter("page"));
            }

        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getProductsPaginated((page - 1) * recordsPerPage, recordsPerPage);
        int totalRecords = productDAO.getTotalProductCount();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        
        
        CartDAO cartDAO = new CartDAO();
          int userId = Integer.parseInt(userID); 
        List<CartItem> cartItems = cartDAO.getCartItems(userId);

        
        
        
        
        /* Debugging Purposes 
        System.out.println("Product list size: " + productList.size());
        for (Product p : productList) {
            System.out.println(p.getName() + " - " + p.getPrice());
        }
        */

        // Send product list to JSP
        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("cartItems", cartItems); // Make sure to pass cartItems too
        request.setAttribute("userID", userID);
      

        // Forward to the JSP
        RequestDispatcher rd = request.getRequestDispatcher("/JSP/Product.jsp");
        rd.forward(request, response); 
    }

    @Override
    public String getServletInfo() {
        return "Handles product listing";
    }
    
public static void main(String[] args) {
     ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();

    System.out.println("Products fetched: " + productList.size());

}
  
    
}
