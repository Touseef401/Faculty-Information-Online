<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Form Submission</title>
</head>
<body>
    <h2>Form Submission Result</h2>
<%
    // Retrieve form parameters
    String role = request.getParameter("role");
    String userName = request.getParameter("userName");
    String userPassword = request.getParameter("userPassword");

    // Database credentials
    String dbURL = "jdbc:mysql://localhost:3306/faculty_info_online"; // Update with your actual database URL
    String dbUser = "root"; // Database username
    String dbPassword = ""; // Database password (update as needed)

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    boolean isValidUser = false;
    String teacherId="";
    try {
        // Load MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection to the database
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Create and execute the query based on user role
        stmt = conn.createStatement();
        String sql = "";
       
        if ("Admin".equals(role)) {
            sql = "SELECT Name, Password FROM admin";  // Query for admin
        } else if ("Teacher".equals(role)) {
            sql = "SELECT Name, Password,teacher_id FROM teacher";  // Query for teacher
        }

        // Execute query
        rs = stmt.executeQuery(sql);

        // Process the result set
        while (rs.next()) {
            String Name = rs.getString("Name");
            String Password = rs.getString("Password");
             if ("Teacher".equals(role)) {
                teacherId = rs.getString("teacher_id");
            }

            // Validate user credentials
            if (Name.equals(userName) && Password.equals(userPassword)) {
                isValidUser = true;
                break; // Exit the loop if user is valid
            }
        }

        // Check if user is valid and role matches
        if (isValidUser && "Admin".equals(role)) {
            // Redirect to admin interface
            response.sendRedirect("adminInterface.jsp");
        } else if (isValidUser && "Teacher".equals(role)) {
            // Redirect to teacher interface
            response.sendRedirect("teacherInterface.jsp?id=" + teacherId);
        } else {
            // Invalid credentials
            out.println("<p style='color:red;'>Invalid username or password!</p>");
            response.sendRedirect("login.html");
        }

    } catch (Exception e) {
        // Print the exception for debugging
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            // Close resources safely
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<p style='color:red;'>Error closing resources: " + e.getMessage() + "</p>");
        }
    }
%>
</body>
</html>
