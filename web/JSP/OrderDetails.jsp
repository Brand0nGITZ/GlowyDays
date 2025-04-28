<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="model.AdminViewOrderDetails" %>
<%@ page import="model.AdminViewOrderDetailsItem" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Details Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <<link rel="stylesheet" href="/AdminPanel/CSS/OrderDetailsCSS.css"/>
    </head>
    <body>
        <div class="order-details-container">
            <%
                // Fetch the order object from the request
                AdminViewOrderDetails order = (AdminViewOrderDetails) request.getAttribute("order");
                List<AdminViewOrderDetailsItem> items = (List<AdminViewOrderDetailsItem>) request.getAttribute("items");
                if (order != null) {
            %>


            <p><strong>Order ID:</strong> <%= order.getOrderId()%></p>
            <p><strong>Order Date:</strong> <%= order.getOrderDate()%></p>
            <p><strong>User ID:</strong> <%= order.getUserId()%></p>
            <p><strong>Address:</strong> <%= order.getAddress()%></p>
            <p><strong>Payment Method:</strong> <%= order.getPaymentMethod()%></p>
            <p><strong>Shipped Status:</strong> <%= order.getShippedStatus()%></p>
            <p><strong>Tracking No:</strong> <%= order.getTrackingNo()%></p>
            <p><strong>Ship Date:</strong> <%= order.getShipDate()%></p>
            <p><strong>Ship Time:</strong> <%= order.getShipTime()%></p>
            <p><strong>Arrival Status:</strong> <%= order.getArrivalStatus()%></p>    

            <% } else { %>
            <p>No order found.</p>
            <% }%>

            <a href="OrderServlet" class="green-button">Back to Orders</a>

            <div>
                <% if (items != null && !items.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Image</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (AdminViewOrderDetailsItem item : items) {%>
                        <tr>
                            <td><%= item.getProductName()%></td>
                            <td><%= item.getPrice()%></td>
                            <td><%= item.getQuantity()%></td>
                            <td><img src="<%= item.getImageUrl()%>" alt="Product Image" width="50" height="50"></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <p>Error found for this order.</p>
                <% }%>
            </div>
        </div>
    </div>
</div>
</body>
</html>