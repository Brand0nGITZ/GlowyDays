import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 清除 session
        HttpSession session = request.getSession(false); // false 表示不创建新的 session
        if (session != null) {
            session.invalidate(); // 清除所有 session attribute
        }

        // 跳转到 GuestHome.jsp
        response.sendRedirect("JSP/GuestHome.jsp");
    }
}