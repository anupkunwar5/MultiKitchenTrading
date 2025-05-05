package com.MultiKitchenTrading.model;

public class ProductModel {
    private int id;
    private String name;
    private String description;
    private double price;
    private String category;
    private int totalSales;

    // Default Constructor
    public ProductModel() {}

    // Constructor with all parameters
    public ProductModel(int id, String name, String description, double price, String category, int totalSales) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
        this.totalSales = totalSales;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public int getTotalSales() { return totalSales; }
    public void setTotalSales(int totalSales) { this.totalSales = totalSales; }

    @Override
    public String toString() {
        return "ProductModel{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", category='" + category + '\'' +
                ", totalSales=" + totalSales +
                '}';
    }
}
