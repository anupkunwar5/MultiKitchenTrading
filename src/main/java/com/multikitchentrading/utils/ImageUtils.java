package com.multikitchentrading.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

public class ImageUtils {

    public static String saveProfileImage(InputStream imageStream, String uploadPath, String fileExtension) throws IOException {
        String fileName = UUID.randomUUID().toString() + fileExtension;
        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File outputFile = new File(uploadDir, fileName);
        try (FileOutputStream out = new FileOutputStream(outputFile)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = imageStream.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }

        return "uploads/user/" + fileName;
    }

    public static String saveProfileImage(InputStream imageStream, String uploadPath, String fileExtension, int userId) throws IOException {
        String fileName = "user_" + userId + "_" + UUID.randomUUID().toString() + fileExtension;
        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File outputFile = new File(uploadDir, fileName);
        try (FileOutputStream out = new FileOutputStream(outputFile)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = imageStream.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }

        return "uploads/user/" + fileName;
    }

    public static String saveProductImage(InputStream imageStream, String uploadPath, String fileExtension) throws IOException {
        String fileName = "product_"  + "_" + UUID.randomUUID().toString() + fileExtension;
        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File outputFile = new File(uploadDir, fileName);
        try (FileOutputStream out = new FileOutputStream(outputFile)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = imageStream.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }

        return fileName;
    }

    public static String getFileExtension(String fileName) {
        if (fileName != null && fileName.contains(".")) {
            return fileName.substring(fileName.lastIndexOf("."));
        }
        return "";
    }
}
