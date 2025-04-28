<%@ page import="model.CartItem" %>
<%@ page import="model.Product" %>
<%@ page import="model.CheckoutDetail" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%@ page import="model.ShippingDetail" %>
<%@ page import="model.PaymentMethod" %>
<%@ page import="dao.*" %> 

<%@ page import="model.Address" %>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout Review</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        .summary { margin-top: 20px; }
        .summary div { margin: 5px 0; }
        .confirm-btn { margin-top: 20px; padding: 10px 20px; background-color: green; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>

<h1>Review Your Order</h1>

<h2>Purchased Items:</h2>

<%
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
    CheckoutDetail checkoutDetail = (CheckoutDetail) session.getAttribute("checkoutDetail");
    
    if (cartItems != null && !cartItems.isEmpty()) {
%>
    <table>
        <thead>
            <tr>
                <th>Product Image</th>
                <th>Product Name</th>
                <th>Price (each)</th>
                <th>Quantity</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
<%
            for (CartItem item : cartItems) {
                Product p = item.getProduct();
%>
            <tr>
                <td><img src="<%= p.getImageUrl() %>" alt="Product Image" style="width: 80px; height: 80px;"></td>
                <td><%= p.getName() %></td>
                <td>RM<%= String.format("%.2f", p.getPrice()) %></td>
                <td><%= item.getQuantity() %></td>
                <td>RM<%= String.format("%.2f", p.getPrice() * item.getQuantity()) %></td>
            </tr>
<%
            }
%>
        </tbody>
    </table>
<%
    } else {
%>
    <p>No items found in your cart.</p>
<%
    }
%>

<% 
    List<ShippingDetail> shippingList = (List<ShippingDetail>) session.getAttribute("shippingList");
   
    
    List<PaymentMethod> paymentMethods = (List<PaymentMethod>) session.getAttribute("paymentMethods");
%>



<!-- Shipping List -->

    <%
    // Get the ShippingDetail object from the session
    ShippingDetail shippingDetail = (ShippingDetail) session.getAttribute("shippingDetail");
    
    if (shippingDetail != null) {
%>

<!-- Display Shipping Information -->
<h3>Shipping Information</h3>
<table>
    <tr>
        <th>Shipping ID</th>
        <th>Buyer Name</th>
        <th>Address</th>
    </tr>
    <tr>
        <td><%= shippingDetail.getShippingId() %></td>
        <td><%= shippingDetail.getBuyer().getFullName() %></td>
        <td>
            <%= shippingDetail.getAddress().getAddressId() %>, 
            <%= shippingDetail.getAddress().getCity() %>, 
            <%= shippingDetail.getAddress().getState() %>, 
            <%= shippingDetail.getAddress().getPostcode() %>
        </td>       
    </tr>
</table>

<%
    } else {
        out.println("<p>No shipping information available.</p>");
    }
%>
</table>

<!-- Payment Methods List -->
<h3>Payment Methods</h3>
<table>
    <tr>
        <th>Payment ID</th>
        <th>Method</th>
        <th>Card Owner</th>
    </tr>
    <%
        if (paymentMethods != null) {
            for (PaymentMethod payment : paymentMethods) {
    %>
    <tr>
        <td><%= payment.getMethodId() %></td>
        <td><%= payment.getMethodName() %></td>
        <td><%= payment.getCardOwner() %></td>
    </tr>
    <%
            }
        }
    %>
</table>



<div class="summary">
    <h2>Payment Summary:</h2>
    <div>Subtotal: RM<%= checkoutDetail != null ? checkoutDetail.getSubtotal() : "0.00" %></div>
    <div>Tax Amount: RM<%= checkoutDetail != null ? checkoutDetail.getTaxAmount() : "0.00" %></div>
    <div>Delivery Fee: RM<%= checkoutDetail != null ? checkoutDetail.getDeliveryFee() : "0.00" %></div>
    <div><strong>Total Amount: RM<%= checkoutDetail != null ? checkoutDetail.getTotalAmount() : "0.00" %></strong></div>
</div>

<form action="<%= request.getContextPath()%>/ClearCartServlet" method="POST">
    <button type="submit" class="submitBtn">Pay Now</button>
</form>

</body>
</html>
