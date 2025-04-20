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

/**
 *
 * @author yapji
 */ 
@WebServlet("/PromotionProductsServlet")    
public class PromotionProductsServlet extends HttpServlet {
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String promoIdParam = request.getParameter("id");
    int promoId = -1;

    try {
        if (promoIdParam != null) {
            promoId = Integer.parseInt(promoIdParam);
        } else {
            ProductDAO productDAO = new ProductDAO();
            promoId = productDAO.getActivePromotionId(); // fetch dynamically
        }

        if (promoId != -1) {
            ProductDAO productDAO = new ProductDAO();
            List<Product> promoProducts = productDAO.getProductsByPromotion(promoId);

            if (promoProducts != null && !promoProducts.isEmpty()) {
                request.setAttribute("products", promoProducts);
                request.getRequestDispatcher("/JSP/Promotion.jsp").forward(request, response);
                return;
            }
        }

        // If no promo found
        response.sendRedirect("/JSP/Promotion.jsp");

    } catch (NumberFormatException e) {
        response.sendRedirect("/JSP/Product.jsp");
    }
}
}
