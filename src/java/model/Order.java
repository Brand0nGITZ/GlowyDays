package model;

public class Order {

    private String orderId;
    private String orderDate;
    private boolean shipped;
    private String trackingNo;

    public Order(String orderId, String orderDate, boolean shipped, String trackingNo) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.shipped = shipped;
        this.trackingNo = trackingNo;
    }

    // Add getters if you're using them in JSP
    public String getOrderId() {
        return orderId;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public boolean isShipped() {
        return shipped;
    }

    public String getTrackingNo() {
        return trackingNo;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public void setShipped(boolean shipped) {
        this.shipped = shipped;
    }

    public void setTrackingNo(String trackingNo) {
        this.trackingNo = trackingNo;
    }
}