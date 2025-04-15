/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import model.Product;
/**@
 *
 * @author yapji
 */
@WebServlet("/ProductServlet" )
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();

        // Debugging output (this is fine)
        System.out.println("Product list size: " + productList.size());
        for (Product p : productList) {
            System.out.println(p.getName() + " - " + p.getPrice());
        }

        // Send product list to JSP
        request.setAttribute("products", productList);

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
