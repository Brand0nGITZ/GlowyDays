package model;

public class ShippingDetail {

    private int userId;  
    private String shippingId;
    private BuyerDetail buyer;
    private Address address; 

    // Constructors
    public ShippingDetail() {}

    public ShippingDetail(int userId, String shippingId, BuyerDetail buyer, Address address) {
        this.shippingId = shippingId;
        this.buyer = buyer;
        this.address = address;
    }

    // Getters and Setters
    public int getUserId() { 
        return userId; 
    } 
    
    public void setUserId(int userId) { 
        this.userId = userId; 
    } 
    
    public String getShippingId() {
        return shippingId;
    }

    public void setShippingId(String shippingId) {
        this.shippingId = shippingId;
    }

    public BuyerDetail getBuyer() {
        return buyer;
    }

    public void setBuyer(BuyerDetail buyer) {
        this.buyer = buyer;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }
}