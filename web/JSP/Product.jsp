<%-- 
    Document   : Product
    Created on : 14 Mar 2025, 11:45:45
    Author     : yapji
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/ProductCSS.css?v=2">

        <title>Product</title>
    </head>
    <body> 
        
        <div class="outer-container">
            <div class="inner-container">
                 <a href="${pageContext.request.contextPath}/JSP/cart.jsp"><img src="${pageContext.request.contextPath}/ICON/cart.svg" alt="Cart" width="45" height="45"></a>
               
<section class="products">
<c:choose>
    <c:when test="${not empty products}">
        <c:forEach var="p" items="${products}">
            <article class="product-item">
                <form action="${pageContext.request.contextPath}/CartServlet" method="POST">
                    <figure>
                            <img class="product-image" src="${pageContext.request.contextPath}/ProductImages/${p.getImageUrl()}" alt="${p.getName()}">
                        <figcaption>${p.getName()}</figcaption>
                    </figure>
                    <h2>${p.getName()}</h2>
                    <p class="price">RM${p.getPrice()}</p>
                    <p>${p.getDescription()}</p>
                    <input type="hidden" name="PRODUCT_ID" value="${p.getId()}" /> 
                    <input type="hidden" name="PRODUCTNAME" value="${p.getName()}" />
                    <input type="hidden" name="PRICE" value="${p.getPrice()}" />
                    <button type="submit">Add to cart</button>
                </form>
            </article>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <p>No products available.</p>
    </c:otherwise>
</c:choose>

</section>
                 
            </div>         
           
        </div>
       
    </body>
</html>
