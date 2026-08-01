package com.kodewala.academy;

import com.google.gson.Gson;
import com.kodewala.academy.model.Student;
import com.google.firebase.cloud.FirestoreClient;
import com.google.cloud.firestore.Firestore;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/register")
public class StudentApiServlet extends HttpServlet {
    
    private final Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        FirebaseService.initialize(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // Read JSON from Request Body
            BufferedReader reader = request.getReader();
            Student student = gson.fromJson(reader, Student.class);
            
            // Save to Firebase via Server
            Firestore db = FirestoreClient.getFirestore();
            Map<String, Object> data = new HashMap<>();
            data.put("name", student.getName());
            data.put("phone", student.getPhone());
            data.put("email", student.getEmail());
            data.put("studentId", student.getStudentId());
            data.put("batchNumber", student.getBatchNumber());
            data.put("qualification", student.getQualification());
            data.put("paymentMethod", student.getPaymentMethod());
            data.put("status", "Pending");
            data.put("timestamp", System.currentTimeMillis());

            db.collection("admissions").add(data).get();
            
            response.getWriter().write("{\"status\":\"success\", \"message\":\"Registered successfully via API\"}");
            
        } catch (Exception e) {
            response.setStatus(500);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }
    }
}
