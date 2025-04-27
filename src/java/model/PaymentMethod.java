package model;

import jakarta.persistence.*;

@Entity
@Table(name = "PAYMENTMETHOD")
public class PaymentMethod {

    @Id
    @Column(name = "methodId")
    private String methodId;

    @Column(name = "methodName", nullable = false)
    private String methodName;

    @Column(name = "cardOwner")
    private String cardOwner;

    @Column(name = "cardNumber")
    private String cardNumber;

    @Column(name = "expMonth")
    private String expMonth;

    @Column(name = "expYear")
    private String expYear;

    @Column(name = "cvv")
    private String cvv;

    // Constructors
    public PaymentMethod() {}

    public PaymentMethod(String methodName, String cardOwner, String cardNumber, String expMonth, String expYear, String cvv) {
        this.methodName = methodName;
        this.cardOwner = cardOwner;
        this.cardNumber = cardNumber;
        this.expMonth = expMonth;
        this.expYear = expYear;
        this.cvv = cvv;
    }

    // Getters and Setters
    public String getMethodId() {
        return methodId;
    }

    public void setMethodId(String methodId) {
        this.methodId = methodId;
    }

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    public String getCardOwner() {
        return cardOwner;
    }

    public void setCardOwner(String cardOwner) {
        this.cardOwner = cardOwner;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getExpMonth() {
        return expMonth;
    }

    public void setExpMonth(String expMonth) {
        this.expMonth = expMonth;
    }

    public String getExpYear() {
        return expYear;
    }

    public void setExpYear(String expYear) {
        this.expYear = expYear;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }
}