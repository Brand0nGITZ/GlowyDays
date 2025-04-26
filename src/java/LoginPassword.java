import dao.LoginDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
        boolean isLogin = dao.loginUser(login,request);
        
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        if (isLogin){
            out.print("OK");
        } else {
            out.print("Not login");
        }
        
    }
}