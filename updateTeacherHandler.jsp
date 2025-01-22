<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Teacher</title>
</head>
<body>
<%
    String role = request.getParameter("id");
    String teacherId = request.getParameter("teacher_id");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String dateOfBirth = request.getParameter("date_of_birth");
    String contactNo = request.getParameter("contact_no");
    String experties = request.getParameter("experties") != null ? String.join(", ", request.getParameterValues("experties")) : "";

     
    String cnic = null, department = null, doj = null, landline = null, degree = null, status = null,gend=null;
    if ("admin".equals(role)) {
        cnic = request.getParameter("cnic");
        department = request.getParameter("department");
        doj = request.getParameter("date_of_joining");
        landline = request.getParameter("landline_no");
        degree = request.getParameter("degree");
        status = request.getParameter("status");
         gend = request.getParameter("gender");
    }

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_info_online", "root", "");

        String sql = "";
        if ("admin".equals(role)) {
            sql = "UPDATE teacher SET name = ?, email = ?, cnic = ?, department = ?, date_of_birth = ?, contact_no = ?, experties = ?, date_of_joining = ?, landline_no = ?, latest_academic_degree = ?, status = ?, gender=? WHERE teacher_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, cnic);
            pstmt.setString(4, department);
            pstmt.setString(5, dateOfBirth);
            pstmt.setString(6, contactNo);
            pstmt.setString(7, experties);
            pstmt.setString(8, doj);
            pstmt.setString(9, landline);
            pstmt.setString(10, degree);
            pstmt.setString(11, status);
            pstmt.setString(12, gend);
            pstmt.setString(13, teacherId);

            int updated = pstmt.executeUpdate();
            if (updated > 0) {
                response.sendRedirect("adminInterface.jsp");
            } else {
                out.println("<div class='alert alert-danger'>Failed to update teacher details.</div>");
            }
            pstmt.close();
        } else if ("teacher".equals(role)) {
            sql = "UPDATE teacher SET name = ?, email = ?, date_of_birth = ?, contact_no = ?, experties = ? WHERE teacher_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, dateOfBirth);
            pstmt.setString(4, contactNo);
            pstmt.setString(5, experties);
            pstmt.setString(6, teacherId);

            int updated = pstmt.executeUpdate();
            if (updated > 0) {
                response.sendRedirect("teacherInterface.jsp?id=" + teacherId);
            } else {
                out.println("<div class='alert alert-danger'>Failed to update teacher details.</div>");
            }
            pstmt.close();
        }
        conn.close();
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    }
%>
</body>
</html>
