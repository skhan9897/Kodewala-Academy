<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.kodewala.academy.model.Student" %>
<%@ page import="com.kodewala.academy.model.Placement" %>
<%@ page import="com.kodewala.academy.model.Batch" %>
<html>
<head>
    <title>Kodewala Academy Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <%
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
    %>
    <div class="header">
        <div style="display: flex; align-items: center; gap: 15px;">
            <img src="images/logo.png" style="width: 45px; height: 45px; filter: drop-shadow(0 0 5px rgba(251,192,45,0.3));" alt="Logo">
            <h1>KODEWALA ACADEMY</h1>
        </div>
        <div style="display: flex; align-items: center; gap: 15px;">
            <div class="stats-badge">
                <i class="fas fa-user-shield" style="margin-right: 5px;"></i> Admin Dashboard
            </div>
            <form action="admin" method="post" style="margin: 0; display: flex; gap: 10px;">
                <a href="https://web.whatsapp.com/" target="_blank" style="background: #25D366; color: white; padding: 6px 15px; border-radius: 50px; text-decoration: none; font-weight: bold; font-size: 13px; display: flex; align-items: center; gap: 5px;">
                    <i class="fab fa-whatsapp"></i> Official WhatsApp
                </a>
                <input type="hidden" name="action" value="logout">
                <button type="submit" style="background: rgba(229, 57, 53, 0.1); border: 1px solid #E53935; color: #E53935; padding: 6px 20px; border-radius: 50px; font-weight: bold; cursor: pointer; transition: 0.3s;">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
    </div>

    <div class="container">
        <!-- New Navigation for Admin Sections -->
        <div style="display: flex; gap: 15px; margin-bottom: 30px;">
            <a href="#admissions" style="color: #FBC02D; text-decoration: none; font-weight: bold; background: rgba(255,255,255,0.05); padding: 10px 20px; border-radius: 10px;">Admissions</a>
            <a href="#placements" style="color: #FBC02D; text-decoration: none; font-weight: bold; background: rgba(255,255,255,0.05); padding: 10px 20px; border-radius: 10px;">Placement Gallery</a>
            <a href="#batches" style="color: #FBC02D; text-decoration: none; font-weight: bold; background: rgba(255,255,255,0.05); padding: 10px 20px; border-radius: 10px;">Batch Links</a>
        </div>

        <!-- Dashboard Summary -->
        <%
            List<Student> students = (List<Student>) request.getAttribute("students");
            int total = (students != null) ? students.size() : 0;
            long pending = (students != null) ? students.stream().filter(s -> !"Approved".equals(s.getStatus()) && !"Rejected".equals(s.getStatus())).count() : 0;
            long approved = (students != null) ? students.stream().filter(s -> "Approved".equals(s.getStatus())).count() : 0;
        %>
        <div class="dashboard-summary">
            <div class="summary-card" style="border-bottom: 4px solid #FBC02D; display: flex; flex-direction: column; align-items: center; gap: 10px;">
                <img src="images/logo.png" style="width: 30px; height: 30px; opacity: 0.6;" alt="Total">
                <div>
                    <div style="font-size: 11px; opacity: 0.6; text-transform: uppercase; letter-spacing: 1px;">Total Applicants</div>
                    <div style="font-size: 32px; font-weight: 900; color: #FBC02D; margin-top: 5px;"><%= total %></div>
                </div>
            </div>
            <div class="summary-card" style="border-bottom: 4px solid #4CAF50; display: flex; flex-direction: column; align-items: center; gap: 10px;">
                <img src="images/logo.png" style="width: 30px; height: 30px; opacity: 0.6;" alt="Approved">
                <div>
                    <div style="font-size: 11px; opacity: 0.6; text-transform: uppercase; letter-spacing: 1px;">Approved</div>
                    <div style="font-size: 32px; font-weight: 900; color: #4CAF50; margin-top: 5px;"><%= approved %></div>
                </div>
            </div>
            <div class="summary-card" style="border-bottom: 4px solid #E53935; display: flex; flex-direction: column; align-items: center; gap: 10px;">
                <img src="images/logo.png" style="width: 30px; height: 30px; opacity: 0.6;" alt="Pending">
                <div>
                    <div style="font-size: 11px; opacity: 0.6; text-transform: uppercase; letter-spacing: 1px;">Pending</div>
                    <div style="font-size: 32px; font-weight: 900; color: #E53935; margin-top: 5px;"><%= pending %></div>
                </div>
            </div>
        </div>

        <h2 id="admissions" style="color: #FBC02D; font-weight: 900; margin-bottom: 25px; display: flex; align-items: center; gap: 10px;">
            <i class="fas fa-list-ul"></i> Admission Requests
        </h2>

        <% if (students == null || students.isEmpty()) { %>
            <div style="text-align: center; margin-top: 100px; background: rgba(255,255,255,0.03); padding: 50px; border-radius: 20px; border: 1px dashed rgba(255,255,255,0.1);">
                <i class="fas fa-folder-open" style="font-size: 50px; opacity: 0.2; margin-bottom: 20px;"></i>
                <h3 style="opacity: 0.5;">No admissions found in database.</h3>
            </div>
        <% } else {
                for (Student student : students) {
        %>
            <div class="student-card">
                <div class="card-header" style="display: flex; align-items: center; margin-bottom: 20px;">
                    <div class="profile-img" style="width: 70px; height: 70px; border: 2px solid rgba(251,192,45,0.3); padding: 3px; display: flex; align-items: center; justify-content: center; background: rgba(255,255,255,0.05); border-radius: 50%;">
                        <% if (student.getImageUrl() != null && !student.getImageUrl().isEmpty()) { %>
                            <img src="<%= student.getImageUrl() %>" alt="User" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                        <% } else { %>
                            <img src="images/kodewala.png" alt="Default" style="width: 80%; height: auto; opacity: 0.5;">
                        <% } %>
                    </div>
                    <div class="student-info" style="margin-left: 20px;">
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <h3 style="margin: 0; font-size: 22px;"><%= student.getName() %></h3>
                            <span style="background: #FBC02D; color: #0D1B3E; font-size: 11px; padding: 2px 10px; border-radius: 5px; font-weight: 900;">
                                <%= student.getStudentId() != null ? student.getStudentId() : "NEW" %>
                            </span>
                        </div>
                        <div style="color: #FBC02D; font-size: 13px; font-weight: bold; margin-top: 5px;">Batch: <%= student.getBatchNumber() != null ? student.getBatchNumber() : "TBD" %></div>
                        <div style="font-size: 11px; opacity: 0.5; margin-top: 3px;">
                            <i class="far fa-calendar-alt"></i> Applied: <%= student.getTimestamp() > 0 ? sdf.format(new Date(student.getTimestamp())) : "N/A" %>
                        </div>
                    </div>

                    <div style="margin-left: auto; display: flex; align-items: center; gap: 15px;">
                        <span class="status-badge <%= "Paid".equals(student.getPaymentStatus()) ? "status-paid" : "status-awaiting" %>">
                            <i class="fas <%= "Paid".equals(student.getPaymentStatus()) ? "fa-money-bill-check" : "fa-wallet" %>"></i>
                            <%= student.getPaymentStatus() != null ? student.getPaymentStatus() : "Awaiting Verification" %>
                        </span>
                        <span class="status-badge <%= "Approved".equals(student.getStatus()) ? "status-approved" : "status-pending" %>">
                            <i class="fas <%= "Approved".equals(student.getStatus()) ? "fa-check-circle" : "fa-clock" %>"></i> <%= student.getStatus() %>
                        </span>
                        <form action="admin" method="post" style="margin: 0;">
                            <input type="hidden" name="docId" value="<%= student.getId() %>">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" style="background: rgba(229, 57, 53, 0.1); border: none; color: #E53935; width: 35px; height: 35px; border-radius: 10px; cursor: pointer; transition: 0.3s;" onclick="return confirm('Delete student record?')">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </form>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; font-size: 14px; background: rgba(0,0,0,0.2); padding: 20px; border-radius: 15px; margin-bottom: 20px;">
                    <div><i class="fas fa-phone-alt" style="color: #FBC02D; width: 20px;"></i> <strong>Phone:</strong> <%= student.getPhone() %>
                        <a href="https://wa.me/<%= student.getPhone().replaceAll("[^0-9]", "") %>" target="_blank" style="margin-left: 10px; color: #25D366; text-decoration: none;">
                            <i class="fab fa-whatsapp"></i> Chat
                        </a>
                    </div>
                    <div><i class="fas fa-envelope" style="color: #FBC02D; width: 20px;"></i> <strong>Email:</strong> <%= student.getEmail() != null ? student.getEmail() : "N/A" %></div>
                    <div><i class="fas fa-credit-card" style="color: #FBC02D; width: 20px;"></i> <strong>Plan:</strong> <%= student.getPaymentMethod() %></div>
                    <div><i class="fas fa-graduation-cap" style="color: #FBC02D; width: 20px;"></i> <strong>Qualification:</strong> <%= student.getQualification() %></div>

                    <% if (student.getZoomLink() != null && !student.getZoomLink().isEmpty()) { %>
                        <div style="grid-column: span 2; padding-top: 10px; border-top: 1px solid rgba(255,255,255,0.05);">
                            <i class="fas fa-video" style="color: #FBC02D; width: 20px;"></i> <strong>Class Link:</strong>
                            <a href="<%= student.getZoomLink() %>" target="_blank" style="color: #FBC02D; text-decoration: none;"><%= student.getZoomLink() %></a>
                        </div>
                    <% } %>
                </div>

                <!-- Zoom Management Section -->
                <div style="background: rgba(251, 192, 45, 0.03); padding: 20px; border-radius: 20px; border: 1px dashed rgba(251, 192, 45, 0.2);">
                    <h4 style="margin: 0 0 15px 0; color: #FBC02D; font-size: 15px;">
                        <i class="fas fa-link"></i> Update Access Details
                    </h4>
                    <form action="admin" method="post" style="margin: 0; display: flex; flex-direction: column; gap: 15px;">
                        <input type="hidden" name="docId" value="<%= student.getId() %>">
                        <input type="hidden" name="action" value="updateZoom">

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                            <input type="text" name="zoomLink" placeholder="Zoom Meeting URL"
                                   value="<%= student.getZoomLink() != null ? student.getZoomLink() : "" %>"
                                   style="width: 100%; padding: 12px; border-radius: 10px; border: 1px solid rgba(255,255,255,0.1); background: rgba(0,0,0,0.4); color: white; font-size: 13px;">

                            <input type="text" name="zoomRecordingUrl" placeholder="Recording URL"
                                   value="<%= student.getZoomRecordingUrl() != null ? student.getZoomRecordingUrl() : "" %>"
                                   style="width: 100%; padding: 12px; border-radius: 10px; border: 1px solid rgba(255,255,255,0.1); background: rgba(0,0,0,0.4); color: white; font-size: 13px;">
                        </div>

                        <div style="display: flex; gap: 12px;">
                            <% if (!"Paid".equals(student.getPaymentStatus())) { %>
                            <button type="submit" name="action" value="verifyPayment" class="btn btn-verify" style="flex: 1; background: #2196F3; color: white; border: none; padding: 10px; border-radius: 10px; cursor: pointer;">
                                <i class="fas fa-check"></i> Verify Pay
                            </button>
                            <% } %>
                            <button type="submit" class="btn btn-approve" style="flex: 2;">
                                <i class="fas fa-check-double"></i> Update & Approve
                            </button>
                            <button type="submit" formmethod="post" name="action" value="reject" class="btn btn-reject" style="flex: 1;">
                                Reject
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        <%
                }
            }
        %>

        <hr style="border: 0; border-top: 1px solid rgba(255,255,255,0.1); margin: 50px 0;">

        <!-- Placement Gallery Management -->
        <h2 id="placements" style="color: #FBC02D; font-weight: 900; margin-bottom: 25px; display: flex; align-items: center; gap: 10px;">
            <i class="fas fa-trophy"></i> Placement Success Stories
        </h2>

        <div class="student-card">
            <h4 style="color: #FBC02D; margin-bottom: 20px;">Upload New Placement</h4>
            <form action="admin" method="post" style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                <input type="hidden" name="action" value="addPlacement">
                <input type="text" name="name" placeholder="Student Name" required style="padding: 12px; border-radius: 10px; background: rgba(0,0,0,0.3); border: 1px solid #333; color: white;">
                <input type="text" name="ctc" placeholder="CTC (e.g. 21.15 LPA)" required style="padding: 12px; border-radius: 10px; background: rgba(0,0,0,0.3); border: 1px solid #333; color: white;">
                <input type="text" name="role" placeholder="Job Role" style="padding: 12px; border-radius: 10px; background: rgba(0,0,0,0.3); border: 1px solid #333; color: white;">
                <input type="text" name="education" placeholder="Education" style="padding: 12px; border-radius: 10px; background: rgba(0,0,0,0.3); border: 1px solid #333; color: white;">
                <input type="text" name="imageUrl" placeholder="Image URL (Link)" required style="grid-column: span 2; padding: 12px; border-radius: 10px; background: rgba(0,0,0,0.3); border: 1px solid #333; color: white;">
                <label style="display: flex; align-items: center; gap: 10px; color: white; font-size: 14px;">
                    <input type="checkbox" name="isHighest"> Mark as Highest CTC
                </label>
                <button type="submit" class="btn btn-approve" style="grid-column: span 2;">Add to Wall of Fame</button>
            </form>
        </div>

        <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 15px;">
            <%
                List<Placement> placements = (List<Placement>) request.getAttribute("placements");
                if (placements != null) {
                    for (Placement p : placements) {
            %>
            <div style="background: rgba(255,255,255,0.05); padding: 15px; border-radius: 15px; position: relative;">
                <img src="<%= p.getImageUrl() %>" style="width: 100%; height: 120px; object-fit: cover; border-radius: 10px; margin-bottom: 10px;">
                <div style="font-weight: bold;"><%= p.getName() %></div>
                <div style="color: #FBC02D; font-size: 12px;"><%= p.getCtc() %></div>
                <form action="admin" method="post" style="position: absolute; top: 10px; right: 10px;">
                    <input type="hidden" name="action" value="deletePlacement">
                    <input type="hidden" name="id" value="<%= p.getId() %>">
                    <button type="submit" style="background: rgba(229, 57, 53, 0.8); border: none; color: white; width: 25px; height: 25px; border-radius: 5px; cursor: pointer;">&times;</button>
                </form>
            </div>
            <%
                    }
                }
            %>
        </div>

        <hr style="border: 0; border-top: 1px solid rgba(255,255,255,0.1); margin: 50px 0;">

        <!-- Batch Management -->
        <h2 id="batches" style="color: #FBC02D; font-weight: 900; margin-bottom: 25px; display: flex; align-items: center; gap: 10px;">
            <i class="fas fa-layer-group"></i> Active Batch Links
        </h2>

        <div class="student-card">
            <form action="admin" method="post" style="display: flex; gap: 15px; align-items: center;">
                <input type="hidden" name="action" value="addBatch">
                <input type="text" name="batchName" placeholder="Batch Name (e.g. JAVA-FEB25)" required style="flex: 1; padding: 12px; border-radius: 10px; background: rgba(0,0,0,0.3); border: 1px solid #333; color: white;">
                <input type="text" name="zoomLink" placeholder="Zoom/Meeting Link" required style="flex: 2; padding: 12px; border-radius: 10px; background: rgba(0,0,0,0.3); border: 1px solid #333; color: white;">
                <button type="submit" class="btn btn-approve">Create Batch Link</button>
            </form>
        </div>

        <div class="student-card" style="padding: 0; overflow: hidden;">
            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                <thead>
                    <tr style="background: rgba(251, 192, 45, 0.1); color: #FBC02D;">
                        <th style="padding: 15px;">Batch Name</th>
                        <th style="padding: 15px;">Meeting Link</th>
                        <th style="padding: 15px;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Batch> batches = (List<Batch>) request.getAttribute("batches");
                        if (batches != null) {
                            for (Batch b : batches) {
                    %>
                    <tr style="border-bottom: 1px solid rgba(255,255,255,0.05);">
                        <td style="padding: 15px;"><%= b.getBatchName() %></td>
                        <td style="padding: 15px;"><a href="<%= b.getZoomLink() %>" target="_blank" style="color: #2196F3;"><%= b.getZoomLink() %></a></td>
                        <td style="padding: 15px;">
                            <form action="admin" method="post" style="margin: 0;">
                                <input type="hidden" name="action" value="deleteBatch">
                                <input type="hidden" name="id" value="<%= b.getId() %>">
                                <button type="submit" style="background: none; border: none; color: #E53935; cursor: pointer;"><i class="fas fa-trash"></i></button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
