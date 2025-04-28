package model;

public class Address {
    private String addressId;
    private String city;
    private String state;
    private String postcode;

    // Constructors
    public Address() {}

    public Address(String addressId, String city, String state, String postcode) {
        this.addressId = addressId;
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