<%-- 
    Document   : main
    Created on : 12 Mar 2025, 21:49:03
    Author     : yapji
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Homepage</title>
       <link  rel="stylesheet" type="text/css" href="style.css"> 
       <link  rel="stylesheet" type="text/css" href="register.css"> 
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
      
        <h1>Main page</h1>
        <ul><li><a href="Product.jsp">Product</a></li>
      <li><a href="Cart.jsp">Cart</a></li>
      <a href="${pageContext.request.contextPath}/ProductServlet" target="_blank">View Products</a>
       <li><a href="Register.jsp">Register</a></li>
       
        </ul>
        
        <a href="../../../../../AppData/Local/Temp/GuestHome.jsp"></a>
       
    
    
    
    </body>
</html>
