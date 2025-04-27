import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;
import dao.*;

@WebServlet("/ValidateShippingServlet")
public class ValidateShippingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        
        // Check which field is being validated
        if (request.getParameter("shippingName") != null) {
            validateName(request, response);
        } else if (request.getParameter("shippingEmail") != null) {
            validateEmail(request, response);
        } else if (request.getParameter("shippingMobile") != null) {
            validateMobile(request, response);
        } else if (request.getParameter("shippingAddress") != null) {
            validateAddress(request, response);
        } else if (request.getParameter("shippingCity") != null) {
            validateCity(request, response);
        } else if (request.getParameter("shippingState") != null) {
            validateState(request, response);
        } else if (request.getParameter("shippingPostcode") != null) {
            validatePostcode(request, response);
        }
    }
    
    private void validateName(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullName = request.getParameter("shippingName");
        
        // NAME VALIDATION: only alphabets(A-Z, a-z), spaces, and '/'
        if (fullName != null && fullName.matches("^[A-Za-z\\s/]+$")) {
            response.getWriter().write("Valid Name");
        } else {
            response.getWriter().write("Invalid Name! Only alphabet, spaces & '/' allowed! ");
        }
    }
    
    private void validateEmail(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("shippingEmail");
        
        // EMAIL VALIDATION: must contain "@" and "."
        if (email != null && email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            response.getWriter().write("Valid Email");
        } else {
            response.getWriter().write("Invalid Email Format! Must contain \"@\" and \".\"");
        }
    }
    
    private void validateMobile(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String mobile = request.getParameter("shippingMobile");
        
        // MOBILE VALIDATION: Malaysia's format (01X-XXXXXXX / 01X-XXXXXXXX)
        if (mobile != null && mobile.matches("^01[0-9]-[0-9]{7,8}$")) {
            response.getWriter().write("Valid Mobile");
        } else {
            response.getWriter().write("Invalid Mobile Format! Pls enter a valid mobile number (01X-XXXXXXX)");
        }
    }
    
    private void validateAddress(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String addressStr = request.getParameter("shippingAddress");
        
        // ADDRESS VALIDATION: at least 5 characters
        if (addressStr != null && addressStr.trim().length() >= 5) {
            response.getWriter().write("Valid Address");
        } else {
            response.getWriter().write("Invalid Address! Pls enter a complete address");
        }
    }
    
    private void validateCity(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String city = request.getParameter("shippingCity");
        
        // CITY VALIDATION: at least 2 characters
        if (city != null && city.trim().length() >= 2) {
            response.getWriter().write("Valid City");
        } else {
            response.getWriter().write("Invalid City! Pls enter a valid city name");
        }
    }
    
    private void validateState(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String state = request.getParameter("shippingState");
        
        // STATE VALIDATION
        // List of valid Malaysian states
        String[] validStates = {
            "Johor", "Kedah", "Kelantan", "Kuala Lumpur", 
            "Labuan", "Melaka", "Negeri Sembilan", "Pahang",
            "Penang", "Perak", "Perlis", "Putrajaya",
            "Sabah", "Sarawak", "Selangor", "Terengganu"
        };
        
        boolean isValid = false;
        for (String validState : validStates) {
            if (validState.equalsIgnoreCase(state)) {
                isValid = true;
                break;
            }
        }
        
        if (isValid) {
            response.getWriter().write("Valid State");
        } else {
            response.getWriter().write("Invalid State! Pls select a valid state");
        }
    }
    
    private void validatePostcode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String postcode = request.getParameter("shippingPostcode");
        
        // POSTCODE VALIDATION: 5 digits
        if (postcode != null && postcode.matches("\\d{5}")) {
            response.getWriter().write("Valid Postcode");
        } else {
            response.getWriter().write("Invalid Postcode! Pls enter a valid postcode");
        }
    }
}