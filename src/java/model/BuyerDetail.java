package model;

public class BuyerDetail {

    private String buyerId;
    private int userId;          
    private String fullName;
    private String email;
    private String mobile;

    // Constructors
    public BuyerDetail() {}

    public BuyerDetail(int userId, String fullName, String email, String mobile) {
        this.userId = userId;
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

    public int getUserId() {          
        return userId;
    }

    public void setUserId(int userId) {  
        this.userId = userId;
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