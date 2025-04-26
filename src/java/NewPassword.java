import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.ResetPasswordDAO;


@WebServlet("/NewPassword")
public class NewPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
                String password = request.getParameter("password");
                ResetPasswordDAO dao = new ResetPasswordDAO();
                boolean updated = dao.updatePasswordByEmail(email, password);

                if (updated) {
                    request.setAttribute("status", "resetSuccess");
                    response.sendRedirect("JSP/Login.jsp");
                } else {
                    session.setAttribute("message", "<span style='color:red;'>Reset Password Failed. Please try again</span>");
                    response.sendRedirect("JSP/ForgotPassword.jsp");
                }
		}
}
