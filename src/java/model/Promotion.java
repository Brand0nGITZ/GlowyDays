package model;

import java.util.Date;

public class Promotion {
    private int promoId;
    private String title;
    private Date startDate;
    private Date endDate;
    private double discountValue;
    private boolean isActive;

    // Constructors
    public Promotion() {}

    public Promotion(int promoId, String title, Date startDate, Date endDate, double discountValue, boolean isActive) {
        this.promoId = promoId;
        this.title = title;
        this.startDate = startDate;
        this.endDate = endDate;
        this.discountValue = discountValue;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getPromoId() {
        return promoId;
    }

    public void setPromoId(int promoId) {
        this.promoId = promoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
