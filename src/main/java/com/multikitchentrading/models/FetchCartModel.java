package com.multikitchentrading.models;

import java.util.List;

public class FetchCartModel {
    private Cart cart;
    private List<CartItem> items;
    private double totalPrice;

    public FetchCartModel() {
    }

    public FetchCartModel(Cart cart, List<CartItem> items, double totalPrice) {
        this.cart = cart;
        this.items = items;
        this.totalPrice = totalPrice;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "FetchCartModel{" +
                "cart=" + cart +
                ", items=" + items +
                ", totalPrice=" + totalPrice +
                '}';
    }
}
