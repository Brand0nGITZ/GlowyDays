package model;

import java.sql.Timestamp;
import java.util.List;

public class Orders {
    private String orderId;
    private boolean shippedStatus;
    private String userId;
    private Timestamp orderDate;
    private String paymentId;
    private String shippingId;
    private double subtotal;
    private double taxAmount;
    private double deliveryFee;
    private double totalAmount;
    private List<OrderItems> orderItems;
    
    // Constructors
    public Orders() {}
    
    public Orders(String orderId, String userId, Timestamp orderDate, 
                String paymentId, String shippingId, double subtotal, 
                double taxAmount, double deliveryFee, double totalAmount) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.paymentId = paymentId;
        this.shippingId = shippingId;
        this.subtotal = subtotal;
        this.taxAmount = taxAmount;
        this.deliveryFee = deliveryFee;
        this.totalAmount = totalAmount;
    }
    
    // Getters and Setters
    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }
    
    public boolean isShippedStatus() { return shippedStatus; }
    public void setShippedStatus(boolean shippedStatus) { this.shippedStatus = shippedStatus; }
    
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    
    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
    
    public String getPaymentId() { return paymentId; }
    public void setPaymentId(String paymentId) { this.paymentId = paymentId; }
    
    public String getShippingId() { return shippingId; }
    public void setShippingId(String shippingId) { this.shippingId = shippingId; }
    
    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }
    
    public double getTaxAmount() { return taxAmount; }
    public void setTaxAmount(double taxAmount) { this.taxAmount = taxAmount; }
    
    public double getDeliveryFee() { return deliveryFee; }
    public void setDeliveryFee(double deliveryFee) { this.deliveryFee = deliveryFee; }
    
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    
    public List<OrderItems> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderItems> orderItems) { this.orderItems = orderItems; }
}