package com.multikitchentrading.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtils {

    public static void setSessionAttribute(HttpServletRequest request, String name, Object value) {
        HttpSession session = request.getSession(true); // create if doesn't exist
        session.setAttribute(name, value);
    }

    public static Object getSessionAttribute(HttpServletRequest request, String name) {
        HttpSession session = request.getSession(false); // don't create if doesn't exist
        if (session != null) {
            return session.getAttribute(name);
        }
        return null;
    }

    public static void removeSessionAttribute(HttpServletRequest request, String name) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(name);
        }
    }

    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
