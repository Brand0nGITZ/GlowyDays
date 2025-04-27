package model;

import jakarta.persistence.*;

@Entity
@Table(name = "ADDRESS")
public class Address {

    @Id
    @Column(name = "addressId")
    private String addressId;

    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "city", nullable = false)
    private String city;

    @Column(name = "state", nullable = false)
    private String state;

    @Column(name = "postcode", nullable = false)
    private String postcode;

    // Constructors
    public Address() {}

    public Address(String address, String city, String state, String postcode) {
        this.address = address;
        this.city = city;
        this.state = state;
        this.postcode = postcode;
    }

    // Getters and Setters
    public String getAddressId() {
        return addressId;
    }

    public void setAddressId(String addressId) {
        this.addressId = addressId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }
}