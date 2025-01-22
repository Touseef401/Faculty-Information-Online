<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.net.URLEncoder" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
        // Database credentials
        String jdbcURL = "jdbc:mysql://localhost:3306/faculty_info_online"; 
        String dbUser = "root"; 
        String dbPassword = "";

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL query to fetch data from the database
            String sql = "SELECT * FROM admin ";
             
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

          if(rs.next())
          {
              // Loop through the result set and display each teacher in a panel
            String adminName=rs.getString("name");
              String adminId=rs.getString("admin_id");
                String adminEmail=rs.getString("email");
                response.sendRedirect("adminInterface.jsp?admin_id=" +adminId  + "&name=" + URLEncoder.encode(adminName, "UTF-8")+ "&email=" + URLEncoder.encode(adminEmail, "UTF-8"));
          }
          else
          {
            out.println("No admin data found");
          }


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
      %>
