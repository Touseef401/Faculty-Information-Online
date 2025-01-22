<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Random" %>
 <%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.Period" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
 
 
<%!
     
 
       
    // Method to generate a random 8-character password
    String generatePassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%^&*!";
        StringBuilder password = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < 8; i++) {
            int index = random.nextInt(chars.length());
            password.append(chars.charAt(index));
        }
        return password.toString();
    }
    %> 


    <%
     String generatedPassword = generatePassword();
    // Database credentials
    String jdbcURL = "jdbc:mysql://localhost:3306/faculty_info_online"; // Replace with your DB name
    String dbUser = "root"; // Replace with your DB username
    String dbPassword = ""; // Replace with your DB password

    // Get parameters from the form
    String name = request.getParameter("Name");
     String gend = request.getParameter("gender");
    String email = request.getParameter("Email");
    String cnic = request.getParameter("CNIC");
    String department = request.getParameter("Department");
    String doj = request.getParameter("DOJ");
    String dob = request.getParameter("DOB");
    String landline = request.getParameter("Landline");
    String contactNo = request.getParameter("ContactNo");
    String degree = request.getParameter("Degree");
     
    String experties = String.join(", ", request.getParameterValues("Experties"));// Handle multiple selections
    String status = request.getParameter("status");

    LocalDate dateOfBirth = LocalDate.parse(dob, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    LocalDate currentDate = LocalDate.now();
    Period age = Period.between(dateOfBirth, currentDate);

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // SQL query to insert data
        String sql = "INSERT INTO teacher (name, email, cnic, department, date_of_joining, Date_of_birth, landline_no, contact_no, latest_academic_degree, experties, status,password,age,gender) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?)";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, cnic);
        pstmt.setString(4, department);
        pstmt.setDate(5, Date.valueOf(doj));
        pstmt.setDate(6, Date.valueOf(dob));
        pstmt.setString(7,landline);
        pstmt.setString(8, contactNo);
        pstmt.setString(9, degree);
        pstmt.setString(10, experties);
        pstmt.setString(11, status);
        pstmt.setString(12,generatedPassword );
        pstmt.setInt(13,age.getYears() );
        pstmt.setString(14, gend);



        // Execute the query
        int rows = pstmt.executeUpdate();

        if (rows > 0) {
             response.sendRedirect("adminInterface.jsp ");
        } else {
            out.println("<h3>Failed to register the teacher. Please try again.</h3>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
