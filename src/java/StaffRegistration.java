import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.UserDAO;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/StaffRegistration")
public class StaffRegistration extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");

    try (PrintWriter out = response.getWriter()) {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String mobileNo = request.getParameter("mobileNo");
        String birth = request.getParameter("birth");

        // Always use "Admin123" as the fixed password
        String fixedPassword = "Admin123";
        String role = "staff";

        // Create the User object with fixed password and role
        User user = new User(name, username, java.time.LocalDate.parse(birth), email, mobileNo, fixedPassword, role);

        // Register the staff user
        UserDAO userDAO = new UserDAO();
        boolean isRegistered = userDAO.registerUser(user);

        if (isRegistered) {
            System.out.println("✅ Registration successful for: " + username);
            HttpSession session = request.getSession();
            session.setAttribute("userID", user.getId());
            session.setAttribute("username", user.getUsername());
            response.sendRedirect("JSP/Login.jsp");
        } else {
            System.out.println("❌ Registration failed for: " + username);
            out.println("Staff registration failed!");
        }
    }
}
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

    @Override
    public String getServletInfo() {
        return "Staff Registration Servlet";
    }
}