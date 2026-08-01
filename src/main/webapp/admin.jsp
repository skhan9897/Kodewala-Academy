<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.kodewala.academy.model.Student" %>
<html>
<head>
    <title>Kodewala Academy Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <!-- Font Awesome for Delete Icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="header">
        <h1>KODEWALA ACADEMY</h1>
        <div style="display: flex; align-items: center; gap: 20px;">
            <div class="stats-badge">Admin Dashboard</div>
            <form action="admin" method="post" style="margin: 0;">
                <input type="hidden" name="action" value="logout">
                <button type="submit" style="background: transparent; border: 1px solid #FBC02D; color: #FBC02D; padding: 5px 15px; border-radius: 20px; font-weight: bold; cursor: pointer;">
                    Logout
                </button>
            </form>
        </div>
    </div>

    <div class="container">
        <h2 style="color: #FBC02D; font-weight: 900;">Applicants</h2>

        <%
            List<Student> students = (List<Student>) request.getAttribute("students");
            if (students == null || students.isEmpty()) {
        %>
            <div style="text-align: center; margin-top: 50px; opacity: 0.5;">
                <h3>No admissions yet.</h3>
            </div>
        <%
            } else {
                for (Student student : students) {
        %>
            <div class="student-card">
                <div class="card-header">
                    <div class="profile-img">
                        <% if (student.getImageUrl() != null && !student.getImageUrl().isEmpty()) { %>
                            <img src="<%= student.getImageUrl() %>" alt="User">
                        <% } else { %>
                            <i class="fas fa-user" style="color: #666; font-size: 24px;"></i>
                        <% } %>
                    </div>
                    <div class="student-info">
                        <div style="display: flex; align-items: center;">
                            <h3 style="margin: 0;"><%= student.getName() %></h3>
                            <span style="margin-left: 10px; background: rgba(251, 192, 45, 0.2); color: #FBC02D; font-size: 10px; padding: 2px 6px; border-radius: 4px; font-weight: bold;">
                                <%= student.getStudentId() != null ? student.getStudentId() : "N/A" %>
                            </span>
                        </div>
                        <div class="student-id" style="opacity: 0.7;">Batch: <%= student.getBatchNumber() != null ? student.getBatchNumber() : "TBD" %></div>
                        <span class="status-badge <%= "Approved".equals(student.getStatus()) ? "status-approved" : "status-pending" %>">
                            <%= student.getStatus() %>
                        </span>
                    </div>

                    <div style="margin-left: auto;">
                        <form action="admin" method="post" style="margin: 0;">
                            <input type="hidden" name="docId" value="<%= student.getId() %>">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" style="background: transparent; border: none; color: rgba(255,255,255,0.3); cursor: pointer;" onclick="return confirm('Are you sure?')">
                                <i class="fas fa-trash"></i>
                            </button>
                        </form>
                    </div>
                </div>

                <div style="font-size: 14px; opacity: 0.8; line-height: 1.6; margin-bottom: 10px;">
                    <div><strong>Phone:</strong> <%= student.getPhone() %></div>
                    <div><strong>Email:</strong> <%= student.getEmail() != null ? student.getEmail() : "N/A" %></div>
                    <div><strong>Plan:</strong> <%= student.getPaymentMethod() %></div>
                    <div><strong>Qualification:</strong> <%= student.getQualification() %></div>
                </div>

                <div class="actions">
                    <form action="admin" method="post" style="flex: 1; display: flex; gap: 10px;">
                        <input type="hidden" name="docId" value="<%= student.getId() %>">
                        <button type="submit" name="action" value="reject" class="btn btn-reject">Reject</button>
                        <button type="submit" name="action" value="approve" class="btn btn-approve">Approve</button>
                    </form>
                </div>
            </div>
        <%
                }
            }
        %>
    </div>
</body>
</html>
