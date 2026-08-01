package com.kodewala.academy;

import com.kodewala.academy.model.Student;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        FirebaseService.initialize(getServletContext());
        DatabaseSetup.createTables(); // Creates the MySQL table if it doesn't exist
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            List<Student> students = FirebaseService.getAllStudents();
            request.setAttribute("students", students);
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        String docId = request.getParameter("docId");
        
        try {
            if ("logout".equals(action)) {
                session.invalidate();
                response.sendRedirect("login");
                return;
            } else if ("approve".equals(action)) {
                FirebaseService.updateStatus(docId, "Approved");
            } else if ("updateZoom".equals(action)) {
                String zoomLink = request.getParameter("zoomLink");
                String zoomRecordingUrl = request.getParameter("zoomRecordingUrl");
                FirebaseService.updateZoomDetails(docId, zoomLink, zoomRecordingUrl);
            } else if ("reject".equals(action)) {
                FirebaseService.updateStatus(docId, "Rejected");
            } else if ("delete".equals(action)) {
                FirebaseService.deleteStudent(docId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin");
    }
}
