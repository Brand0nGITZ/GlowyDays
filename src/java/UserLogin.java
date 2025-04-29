import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.LoginDAO;
import model.Login;
import model.User;

@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Login login = new Login();
            login.setEmail(email);
            login.setPassword(password);

            LoginDAO loginDAO = new LoginDAO();
            User user = loginDAO.getUserByLogin(login); // returns full user info if successful

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                 session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());
                
                String role = user.getRole().trim().toLowerCase();

                switch (role) {
                    case "manager":
                       response.sendRedirect(request.getContextPath() + "/JSP/AdminPanel.jsp");
                        break;
                    case "staff":
                        response.sendRedirect(request.getContextPath() + "/JSP/StaffPanel.jsp");
                        break;
                    default:
                       response.sendRedirect(request.getContextPath() + "/JSP/UserHome.jsp");
                        break;
                }
            } else {
                out.println("Login Failed! Invalid email or password.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Handle both GET and POST requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}