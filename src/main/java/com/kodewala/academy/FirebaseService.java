package com.kodewala.academy;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;
import com.google.cloud.firestore.Firestore;
import com.kodewala.academy.model.Student;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;

import javax.servlet.ServletContext;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

public class FirebaseService {
    private static Firestore db;

    public static void initialize(ServletContext context) {
        try {
            if (FirebaseApp.getApps().isEmpty()) {
                InputStream serviceAccount = context.getResourceAsStream("/WEB-INF/serviceAccountKey.json");
                
                if (serviceAccount == null) {
                    System.err.println("Firebase Error: serviceAccountKey.json not found in WEB-INF");
                    return;
                }

                FirebaseOptions options = new FirebaseOptions.Builder()
                        .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                        .setStorageBucket("com-bank-kodewalaacademy-57959.firebasestorage.app")
                        .build();

                FirebaseApp.initializeApp(options);
            }
            db = FirestoreClient.getFirestore();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<Student> getAllStudents() throws ExecutionException, InterruptedException {
        List<Student> students = new ArrayList<>();
        if (db == null) return students;

        ApiFuture<QuerySnapshot> query = db.collection("admissions").get();
        QuerySnapshot querySnapshot = query.get();
        
        for (QueryDocumentSnapshot doc : querySnapshot.getDocuments()) {
            Student s = new Student();
            s.setId(doc.getId());
            s.setStudentId(doc.getString("studentId"));
            s.setBatchNumber(doc.getString("batchNumber"));
            s.setName(doc.getString("name"));
            s.setPhone(doc.getString("phone"));
            s.setEmail(doc.getString("email"));
            s.setQualification(doc.getString("qualification"));
            s.setPaymentMethod(doc.getString("paymentMethod"));
            s.setImageUrl(doc.getString("imageUrl"));
            s.setStatus(doc.getString("status"));
            students.add(s);
        }
        return students;
    }

    public static void updateStatus(String docId, String newStatus) throws ExecutionException, InterruptedException {
        if (db != null) {
            db.collection("admissions").document(docId).update("status", newStatus).get();
        }
    }

    public static void deleteStudent(String docId) throws ExecutionException, InterruptedException {
        if (db != null) {
            db.collection("admissions").document(docId).delete().get();
        }
    }
}
