/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 *
 * @author tsm11
 */
@WebServlet("/StaffListServlet")
public class StaffListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/myderbyDB", "user", "pass");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT user_id, name, birth, email, mobileNo FROM APP.USER WHERE ROLE = 'staff'");

            out.println("<h2>Staff Listing</h2>");
            out.println("<table border='1'>");
            out.println("<tr><th>User ID</th><th>Name</th><th>Birthdate</th><th>Email</th><th>Mobile</th></tr>");

            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("user_id") + "</td>");
                out.println("<td>" + rs.getString("name") + "</td>");
                out.println("<td>" + rs.getDate("birth").toLocalDate() + "</td>");
                out.println("<td>" + rs.getString("email") + "</td>");
                out.println("<td>" + rs.getString("mobileNo") + "</td>");
                out.println("</tr>");
            }

            out.println("</table>");
            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}
