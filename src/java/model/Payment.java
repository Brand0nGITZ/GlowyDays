package model;

import java.sql.Date;
import java.sql.Time;

public class Payment {

    private String paymentId;
    private String methodId; 
    private int userId;  
    private Date paidDate;
    private Time paidTime;

    // Constructors
    public Payment() {}

    public Payment(String paymentId, String methodId, int userId, Date paidDate, Time paidTime) {
        this.paymentId = paymentId;
        this.methodId = methodId; 
        this.userId = userId;
        this.paidDate = paidDate;
        this.paidTime = paidTime;
    }

    // Getters and Setters
    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }


    public String getMethodId() {
        return methodId;
    }

    public void setMethodId(String methodId) {
        this.methodId = methodId;
    }
    
    public int getUserId() { 
        return userId; 
    } 
    
    public void setUserId(int userId) { 
        this.userId = userId; 
    } 

    public Date getPaidDate() {
        return paidDate;
    }

    public void setPaidDate(Date paidDate) {
        this.paidDate = paidDate;
    }

    public Time getPaidTime() {
        return paidTime;
    }

    public void setPaidTime(Time paidTime) {
        this.paidTime = paidTime;
    }
}