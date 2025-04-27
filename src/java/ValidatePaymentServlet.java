import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ValidatePaymentServlet")
public class ValidatePaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        
        // Check which field is being validated
        if (request.getParameter("payment_method") != null) {
            validatePaymentMethod(request, response);
        } else if (request.getParameter("cardOwner") != null) {
            validateCardOwner(request, response);
        } else if (request.getParameter("cardNumber") != null) {
            validateCardNumber(request, response);
        } else if (request.getParameter("expMonth") != null) {
            validateExpMonth(request, response);
        } else if (request.getParameter("expYear") != null) {
            validateExpYear(request, response);
        } else if (request.getParameter("cvv") != null) {
            validateCVV(request, response);
        }
    }
    
    private void validatePaymentMethod(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String paymentMethod = request.getParameter("payment_method");
        
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            response.getWriter().write("Payment Method Required");
            return;
        }
        
        // Validate if it's one of accepted methods
        if (paymentMethod.equalsIgnoreCase("cash") || 
            paymentMethod.equalsIgnoreCase("tng") || 
            paymentMethod.equalsIgnoreCase("visa") || 
            paymentMethod.equalsIgnoreCase("master")) {
            response.getWriter().write("Valid Payment Method");
        } else {
            response.getWriter().write("Invalid Payment Method");
        }
    }
    
    private void validateCardOwner(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String cardOwner = request.getParameter("cardOwner");
        
        if (cardOwner == null || cardOwner.trim().isEmpty()) {
            response.getWriter().write("Card Owner Required");
            return;
        }
        
        // Card owner should contain only letters & spaces
        if (cardOwner.matches("^[A-Za-z\\s]+$")) {
            response.getWriter().write("Valid Card Owner");
        } else {
            response.getWriter().write("Invalid Card Owner Name");
        }
    }
    
    private void validateCardNumber(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String cardNumber = request.getParameter("cardNumber");
        
        if (cardNumber == null || cardNumber.trim().isEmpty()) {
            response.getWriter().write("Card Number Required");
            return;
        }
        
        // Card number (15-16 digits)
        if (cardNumber.matches("\\d{15,16}")) {
            response.getWriter().write("Valid Card Number");
        } else {
            response.getWriter().write("Card number must be 15-16 digits");
        }
    }
    
    private void validateExpMonth(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String expMonth = request.getParameter("expMonth");
        
        if (expMonth == null || expMonth.trim().isEmpty()) {
            response.getWriter().write("Expiry Month Required");
            return;
        }
        
        try {
            int month = Integer.parseInt(expMonth);
            if (month >= 1 && month <= 12) {
                response.getWriter().write("Valid Expiry Month");
            } else {
                response.getWriter().write("Expiry month must be 1-12");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("Invalid Expiry Month Format");
        }
    }
    
    private void validateExpYear(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String expYear = request.getParameter("expYear");
        
        if (expYear == null || expYear.trim().isEmpty()) {
            response.getWriter().write("Expiry Year Required");
            return;
        }
        
        try {
            int year = Integer.parseInt(expYear);
            if (year >= 2025 && year <= 2100) {
                response.getWriter().write("Valid Expiry Year");
            } else {
                response.getWriter().write("Invalid Expiry Year");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("Invalid Year Format");
        }
    }
    
    private void validateCVV(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String cvv = request.getParameter("cvv");
        
        if (cvv == null || cvv.trim().isEmpty()) {
            response.getWriter().write("CVV Required");
            return;
        }
        
        if (cvv.matches("\\d{3}")) {
            response.getWriter().write("Valid CVV");
        } else {
            response.getWriter().write("CVV must be 3 digits");
        }
    }
}