<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="model.ViewOrderItem" %>
<%@ page import="model.ShippingInfo" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View User Order</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="/NewNew/UserJSP/UserOrder.css?v=3">
        <link rel="stylesheet" type="text/css" href="/NewNew/CSS/home.css?v=2">

    </head>
    <body>
        <section id="header" class="header">
            <a href="UserHome.jsp">
                <h2 style="font-weight: bolder; font-size: 3rem; color: black;">GLOWY DAYS</h2>
            </a>
            <div class="navbar">
                <a href="UserHome.jsp">Home</a>
                <a href="<%= request.getContextPath()%>/ProductServlet">Product</a>
                <a href="<%= request.getContextPath()%>/PromotionProductsServlet">Promotion</a>              
                <a href="">About Us</a>                           
            </div>
            <div class="icons">
                <div class="search-wrapper">
                    <i class="fa-solid fa-magnifying-glass" id="search-icon"></i>
                    <input type="text" id="search-box" placeholder="Search..." />
                </div>
                <a href="" class="fa-solid fa-cart-shopping"></a>    
                <div class="avatar-container">
                    <i class="fa-regular fa-user" style="font-size:18px; cursor:pointer;"></i> 
                    <div class="dropdown-menu">
                        <%
                            Long userID = (Long) session.getAttribute("userID");
                            String username = (String) session.getAttribute("username");

                        %>
                        <a style="pointer-events: none;">Username: <%= username%></a>
                        <a class="dropdown-item" href="../JSP/UserProfile.jsp">User Profile</a>
                        <a class="dropdown-item" href="<%= request.getContextPath()%>/LogoutServlet">Log Out</a>
                    </div>
                </div>
            </div>
        </section>

        <section class="body-section">
            <%
                Map<String, List<ViewOrderItem>> ordersByOrderId = (Map<String, List<ViewOrderItem>>) request.getAttribute("ordersByOrderId");
                Map<String, Map<String, String>> orderStatusMap = (Map<String, Map<String, String>>) request.getAttribute("orderStatusMap");
                Map<String, ShippingInfo> shippingInfoMap = (Map<String, ShippingInfo>) request.getAttribute("shippingInfoMap");
            %>

            <% if (ordersByOrderId == null || ordersByOrderId.isEmpty()) { %>
            <div class="no-order">
                <p>No Orders Found.</p>
            </div>
            <% } else {
                for (Map.Entry<String, List<ViewOrderItem>> entry : ordersByOrderId.entrySet()) {
                    String orderId = entry.getKey();
                    List<ViewOrderItem> orderItems = entry.getValue();
                    Map<String, String> statusAndTracking = orderStatusMap.get(orderId);
                    String status = statusAndTracking.get("status");
                    String trackingNo = statusAndTracking.get("trackingNo");  // Fetch trackingNo
            %>


            <div class="order-container">
                <div class="table-header">
                    <div class="order-info">
                        <p>Order ID : <%= orderId%></p><br>
                        <p>Tracking No : <% if ("In Transit".equals(status) || "Delivered".equals(status)) {%>
                            <%= trackingNo != null ? trackingNo : "-"%>
                            <% } else { %>
                            - 
                            <% } %>
                        </p>
                    </div>
                    <div class="status-info">
                        <% if ("To Ship".equals(status)) { %>
                        <i class="fas fa-box"></i>
                        <span class="to-ship">To Ship</span>
                        <% } else if ("In Transit".equals(status)) { %>
                        <i class="fas fa-truck-moving"></i>
                        <span class="in-transit">In Transit</span>
                        <% } else if ("Delivered".equals(status)) { %>
                        <i class="fas fa-check-circle"></i>
                        <span class="delivered">Delivered</span>
                        <% } %>
                    </div>
                </div>

                <div class="separator"></div>

                <div class="shipping-info">
                    <%
                        ShippingInfo shipping = shippingInfoMap.get(orderId);
                        if (shipping != null) {
                    %>
                    <p><strong>Receiver:</strong> <%= shipping.getFullName()%></p>
                    <p><strong>Email:</strong> <%= shipping.getEmail()%></p>
                    <p><strong>Mobile:</strong> <%= shipping.getMobile()%></p>
                    <p><strong>Address:</strong> <%= shipping.getFullAddress()%></p>
                    <p><strong>Payment Method:</strong> <%= shipping.getPaymentMethod()%></p>
                    <% } %>
                </div>



                <div class="separator"></div>

                <div class="items">
                    <% double total = 0;
                        for (ViewOrderItem item : orderItems) {
                            total += item.getPrice() * item.getQuantity();
                    %>
                    <div class="item">
                        <div class="item-image">
                            <img src="<%= item.getImageUrl()%>" alt="<%= item.getTitle()%>">
                        </div>
                        <div class="item-details">
                            <div class="item-info">
                                <p class="item-title"><%= item.getTitle()%></p>
                                <p class="item-quantity">x<%= item.getQuantity()%></p>
                            </div>
                            <div class="item-price">
                                <p class="original-price">RM<%= String.format("%.2f", item.getPrice())%></p>
                            </div>
                        </div>
                    </div>
                    <% }%>
                </div>

                <div class="separator"></div>
                <div class="order-total">
                    <p class="total-label">Order Total:</p>
                    <p class="total-amount">RM<%= String.format("%.2f", total)%></p>
                </div>
            </div>
            <%
                    }
                }
            %>
        </section>
    </body>
</html>