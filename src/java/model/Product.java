package model;

import java.io.Serializable;

public class Product implements Serializable {
    private int id;
    private String name;
    private double price;
    private String description;
    private String category;
    private int stock;
    private String imageUrl; // 
    private String createdAt;
    private String updatedAt;

    // Constructors
    public Product() {}

    public Product(int id, String name, double price, String description, String category, int stock, String imageUrl, String createdAt, String updatedAt) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.category = category;
        this.stock = stock;
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public void setCreatedAt (String createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getCreatedAt () {
        return createdAt;
    }
    
     public void setUpdatedAt (String updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public String getUpdatedAt () {
        return updatedAt;
    }
    
    
    
}
