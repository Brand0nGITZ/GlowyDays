import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ValidateOtp")
public class ValidateOtp extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession mySession = request.getSession();
        // 获取用户输入的 OTP
        int value = Integer.parseInt(request.getParameter("otp"));

        // 获取 session 中存储的 OTP
        HttpSession session = request.getSession();
        int otp = (int) session.getAttribute("otp");

        // 验证 OTP
        if (value == otp) {
            // 如果 OTP 匹配，跳转到 NewPassword.jsp
            request.setAttribute("email", request.getParameter("email"));
            request.setAttribute("status", "success");
            response.sendRedirect("JSP/NewPassword.jsp");  // 使用重定向
        } else {
            // 如果 OTP 不匹配，返回 EnterOTP.jsp 并显示错误消息
            mySession.setAttribute("message", "<span style='color:red;'>OTP Wrong. Please try again</span>");
            response.sendRedirect("JSP/EnterOTP.jsp");
        }
    }
}