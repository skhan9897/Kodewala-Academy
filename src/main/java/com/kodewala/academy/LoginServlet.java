package com.kodewala.academy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    // Default Credentials
    private static final String ADMIN_ID = "admin";
    private static final String ADMIN_PASSWORD = "kodewala@admin";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String adminId = request.getParameter("adminId");
        String password = request.getParameter("password");

        if (ADMIN_ID.equals(adminId) && ADMIN_PASSWORD.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", adminId);
            response.sendRedirect("admin");
        } else {
            request.setAttribute("error", "Invalid Admin ID or Password!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
