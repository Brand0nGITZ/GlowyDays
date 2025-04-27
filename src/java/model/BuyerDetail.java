package model;

import jakarta.persistence.*;

@Entity
@Table(name = "BUYERDETAIL")
public class BuyerDetail {

    @Id
    @Column(name = "buyerId")
    private String buyerId;

    @Column(name = "fullName", nullable = false)
    private String fullName;

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "mobile", nullable = false)
    private String mobile;

    // Constructors
    public BuyerDetail() {}

    public BuyerDetail(String fullName, String email, String mobile) {
        this.fullName = fullName;
        this.email = email;
        this.mobile = mobile;
    }

    // Getters and Setters
    public String getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(String buyerId) {
        this.buyerId = buyerId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }
}