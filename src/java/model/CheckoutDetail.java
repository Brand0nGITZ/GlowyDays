package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class CheckoutDetail {
    private int checkoutId;
    private int userId;
    private BigDecimal subtotal;
    private BigDecimal taxAmount;
    private BigDecimal deliveryFee;
    private BigDecimal totalAmount;
    private Timestamp checkoutDate; // optional

    // Constructors
    public CheckoutDetail() {}

    public CheckoutDetail(BigDecimal subtotal, BigDecimal taxAmount, BigDecimal deliveryFee, BigDecimal totalAmount) {
        this.subtotal = subtotal;
        this.taxAmount = taxAmount;
        this.deliveryFee = deliveryFee;
        this.totalAmount = totalAmount;
    }

    // Getters and Setters
    public int getCheckoutId() {
        return checkoutId;
    }

    public void setCheckoutId(int checkoutId) {
        this.checkoutId = checkoutId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public BigDecimal getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(BigDecimal taxAmount) {
        this.taxAmount = taxAmount;
    }

    public BigDecimal getDeliveryFee() {
        return deliveryFee;
    }

    public void setDeliveryFee(BigDecimal deliveryFee) {
        this.deliveryFee = deliveryFee;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Timestamp getCheckoutDate() {
        return checkoutDate;
    }

    public void setCheckoutDate(Timestamp checkoutDate) {
        this.checkoutDate = checkoutDate;
    }
}