package com.MultiKitchenTrading.util;



public class ValidationUtil {

    // Check if input is null or empty
    public static boolean isNullOrEmpty(String input) {
        return input == null || input.trim().isEmpty();
    }

    // Validate email format
    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }

    // Validate username: starts with a letter and is alphanumeric
    public static boolean isAlphanumericStartingWithLetter(String username) {
        return username != null && username.matches("^[A-Za-z][A-Za-z0-9_]{4,}$");
    }

    // Validate password: must contain at least one uppercase letter, one number, and one special character
    public static boolean isValidPassword(String password) {
        return password != null && password.matches("^(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$");
    }
}
