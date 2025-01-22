<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String teacherCnic = request.getParameter("cnic");
    String teacherId = request.getParameter("id");
    out.println(teacherCnic);
    out.println(teacherId);
     
    String jdbcURL = "jdbc:mysql://localhost:3306/faculty_info_online"; 
    String dbUser = "root"; 
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // SQL query to delete the record
        String sql = "DELETE FROM teacher WHERE teacher_id = ? ";

        // Use PreparedStatement to set the parameter
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, teacherId);
         


        // Execute the DELETE query
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            out.println("Record deleted successfully.");
            response.sendRedirect("adminInterface.jsp");
        } else {
            out.println("Record not found or couldn't be deleted.");
             response.sendRedirect("remove.html");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Redirect to the admin interface
        
    }
%>
