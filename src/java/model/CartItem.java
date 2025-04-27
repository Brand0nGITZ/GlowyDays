package model;

import java.io.Serializable;

public class CartItem implements Serializable {
    private int id;
    private Product product;
    private int quantity;
    private String name;
    
    public CartItem() {}
    
    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }
     
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public Product getProduct() {
        return product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public double getSubtotal() {
        return product.getPrice() * quantity;
    }
}