package com.kodewala.academy;

import com.google.gson.Gson;
import com.google.firebase.cloud.FirestoreClient;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.api.core.ApiFuture;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/api/placements")
public class PlacementsApiServlet extends HttpServlet {
    private final Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        FirebaseService.initialize(getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            Firestore db = FirestoreClient.getFirestore();
            ApiFuture<QuerySnapshot> query = db.collection("placements").get();
            List<Map<String, Object>> placements = new ArrayList<>();
            
            for (QueryDocumentSnapshot document : query.get().getDocuments()) {
                Map<String, Object> data = document.getData();
                data.put("id", document.getId());
                placements.add(data);
            }

            response.getWriter().write(gson.toJson(placements));
        } catch (Exception e) {
            response.setStatus(500);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}
