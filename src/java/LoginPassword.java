import dao.LoginDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Login;

@WebServlet("/LoginPassword")
public class LoginPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Login login = new Login();
        login.setEmail(email);
        login.setPassword(password);

        LoginDAO dao = new LoginDAO();
        boolean isLogin = dao.loginUser(login, request); // Ensure loginDAO validates user and sets session

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        if (isLogin) {
            // Login successful, fetch the user's role from session
            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role"); // Get the role from session

            if (role != null) {
                out.print(role);  // Send role to the frontend
            } else {
                out.print("Unknown role");
            }
        } else {
            out.print("Not login");
        }
    }
}