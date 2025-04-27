package model;

import jakarta.persistence.*;

@Entity
@Table(name = "SHIPPINGDETAIL")
public class ShippingDetail {

    @Id
    @Column(name = "shippingId")
    private String shippingId;

    @ManyToOne
    @JoinColumn(name = "buyerId", nullable = false)
    private BuyerDetail buyer;

    @ManyToOne
    @JoinColumn(name = "addressId", nullable = false)
    private Address address;

    // Constructors
    public ShippingDetail() {}

    public ShippingDetail(BuyerDetail buyer, Address address) {
        this.buyer = buyer;
        this.address = address;
    }

    // Getters and Setters
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