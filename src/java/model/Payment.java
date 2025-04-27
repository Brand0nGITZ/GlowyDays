package model;

import jakarta.persistence.*;
import java.sql.Date;
import java.sql.Time;

@Entity
@Table(name = "PAYMENT")
public class Payment {

    @Id
    @Column(name = "paymentId")
    private String paymentId;

    @Column(name = "transactionId", nullable = false, unique = true)
    private String transactionId;

    @ManyToOne
    @JoinColumn(name = "methodId", nullable = false)
    private PaymentMethod method;

    @Column(name = "paidDate")
    private Date paidDate;

    @Column(name = "paidTime")
    private Time paidTime;

    // Constructors
    public Payment() {}

    public Payment(PaymentMethod method, Date paidDate, Time paidTime) {
        this.method = method;
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

    public PaymentMethod getMethod() {
        return method;
    }

    public void setMethod(PaymentMethod method) {
        this.method = method;
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