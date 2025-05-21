package com.multikitchentrading.utils;

import java.util.regex.Pattern;

public class ValidationUtils {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_]{4,20}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^.{8,}$"); // at least 8 characters

    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    public static boolean isValidUsername(String username) {
        return username != null && USERNAME_PATTERN.matcher(username).matches();
    }

    public static boolean isValidPassword(String password) {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }

    public static String validateSignupForm(String username, String password, String email,
                                            String firstName, String lastName) {
        if (isNullOrEmpty(firstName)) return "First name is required.";
        if (isNullOrEmpty(lastName)) return "Last name is required.";
        if (isNullOrEmpty(username)) return "Username is required.";
        if (!isValidUsername(username)) return "Username must be 4-20 characters (letters, numbers, underscores).";
        if (isNullOrEmpty(email)) return "Email is required.";
        if (!isValidEmail(email)) return "Invalid email format.";
        if (isNullOrEmpty(password)) return "Password is required.";
        if (!isValidPassword(password)) return "Password must be at least 8 characters.";

        return null; // All fields are valid
    }
}
