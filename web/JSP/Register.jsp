<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
String username = request.getParameter("username");
String email = request.getParameter("email");
String mobileNo = request.getParameter("mobileNo");
String password = request.getParameter("password");
String Rpassword = request.getParameter("Rpassword");


if (username != null && email != null && mobileNo != null && password != null && Rpassword != null) {
    if (!password.equals(Rpassword)) {
        out.println("<h3 style='color:red;'>Passwords do not match!</h3>");
    } else { 
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/user", "root", "admin");

            // Using PreparedStatement to prevent SQL Injection
            String sql = "INSERT INTO user (username, email, mobileNo, password, Rpassword) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, mobileNo);
            pst.setString(4, password);
            pst.setString(5, Rpassword);

            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                response.sendRedirect("../JSP/UserHome.jsp");
            } else {
                out.println("<h3 style='color:red;'>Registration Failed!</h3>");
            }

            pst.close();
            con.close();
        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register</title>
    <link href="../CSS/register.css" rel="stylesheet" type="text/css">
</head>
<body>
    <section id="header">
        <div class="header-left">
            <a href="../JSP/GuestHome.jsp"><img src="../IMG/logo.jpg" alt="Index" width="180" height="70"></a>
        </div>
        <div class="header-right">
            <input type="text" placeholder="Search.."><img src="../ICON/search.svg" width="30" height="30">
            <a href="../JSP/cart.jsp"><img src="../ICON/cart.svg" alt="Cart" width="45" height="45"></a>
            <a href="../JSP/Register.jsp"><img src="../ICON/avatar.svg" alt="Login" width="40" height="40"></a>
        </div>
    </section>
    
    <div id="signup">
        <br />
        <h1>Sign Up</h1>
        <hr>
        <form action="" method="post">
            <fieldset>
                <div class="label">
                    <label for="nameInput">Username:</label>
                </div>
                <div class="input">
                    <input type="text" name="username" placeholder="Username" required><br/>    
                </div>
  
                <div class="label">
                    <label for="birthday">Birth date:</label>
                </div>
                <div class="input">
                    <input type="date" name="birthday" required><br/>    
                </div>
  
                <div class="label">
                    <label for="emailInput">Email:</label>
                </div>
                <div class="input">
                    <input type="email" name="email" placeholder="Email" required><br/>    
                </div>
                
                <div class="label">
                    <label for="phoneInput">Mobile Number:</label>
                </div>
                <div class="input">
                    <input type="tel" name="mobileNo" pattern="[0-9]{3}-[0-9]{7,10}" placeholder="Mobile Number" required><br/>    
                </div>
                
                <div class="label">
                    <label for="passwordInput">Password:</label>
                </div>
                <div class="input">
                    <input type="password" name="password" placeholder="Password" required><br/>    
                </div>
                
                <div class="label">
                    <label for="CpasswordInput">Confirm Password:</label>
                </div>
                <div class="input">
                    <input type="password" name="Cpassword" placeholder="Confirm password" required><br/>    
                </div>
                
                <button type="submit">Register</button>
            </fieldset>
        </form>
    </div>
</body>
</html>

