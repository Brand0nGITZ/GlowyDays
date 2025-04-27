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
import dao.LoginDAO;
/**@
 *
 * @author yapji
 */
@WebServlet("/ProductServlet" )
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int page = 1;
        int recordsPerPage = 4;
        
        if (request.getParameter("page") != null) {
             page = Integer.parseInt(request.getParameter("page"));
            }

        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getProductsPaginated((page - 1) * recordsPerPage, recordsPerPage);
        int totalRecords = productDAO.getTotalProductCount();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        
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
