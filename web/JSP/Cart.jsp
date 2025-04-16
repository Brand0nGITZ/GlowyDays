<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.CartItem"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/CartCSS.css">
    </head>
    <body>
        <div class="container">
            <h1>Your Shopping Cart</h1>

            <%
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                int cartSize = (cart != null) ? cart.size() : 0;
                if (cart == null || cart.isEmpty()) {
            %>
                <div class="empty-cart">
                    <p>Your cart is empty</p>
                    <a href="<%= request.getContextPath() %>/ProductServlet" class="continue-shopping">Continue Shopping</a>
                </div>
            <%
                } else {
            %>
                <div class="cart-items">
                    <table>
                        <thead>
                            <tr>
                                <th>Product</th> 
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (CartItem item : cart) {
                            %>
                                <tr>
                                    <td>
                                        <div class="product-info">
                                            <div class="product-name"><%= item.getProduct().getName() %></div>
                                        </div>
                                    </td>
                                    <td>RM <%= String.format("%,.2f", item.getProduct().getPrice()) %></td>
                                    <td>
                                        <form action="<%= request.getContextPath() %>/UpdateCartServlet" method="POST" class="quantity-form">
                                            <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                            <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" max="10" class="quantity-input">
                                            <button type="submit" class="update-btn">Update</button>
                                        </form>
                                    </td>
                                    <td>RM <%= String.format("%,.2f", item.getSubtotal()) %></td>
                                    <td>
                                        <form action="<%= request.getContextPath() %>/RemoveFromCartServlet" method="POST">
                                            <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                            <button type="submit" class="remove-btn">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <%
                    double total = 0;
                    for (CartItem item : cart) {
                        total += item.getSubtotal();
                    }
                %>

                <div class="cart-summary">
                    <div class="summary-row">
                        <span>Total Items:</span>
                        <span><%= cartSize %></span>
                    </div>
                    <div class="summary-row total">
                        <span>Total:</span>
                        <span>RM <%= String.format("%,.2f", total) %></span>
                    </div>

                    <div class="cart-actions">
                        <a href="<%= request.getContextPath() %>/ProductServlet" class="continue-shopping">Continue Shopping</a>
                        <a href="<%= request.getContextPath() %>/CheckoutServlet" class="checkout-btn">Proceed to Checkout</a>
                    </div>
                </div>
            <%
                }
            %>
        </div>
    </body>
</html>
