<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <title>Faculty Information System</title>
</head>
<script type="text/javascript">
  function Confirm()
  {
    return window.confirm("! Are you Sure  ")
  }

   $(document).ready(function() {
    $('[data-toggle="popover"]').popover();
  });

</script>

<style type="text/css">
   
  header{
    padding: 10px;
    background-color:  #3b26b5;
     
   
  }
   
  header img{
     margin-top: 15px;
    width: 50px;
    height:50px;
    border-radius: 15px;
    margin-bottom: 10px;


  }
   
   
    
  
  #profileImg
  {
    border-radius: 15px;
    width: 100px;
    height:120px;
 border: 3px solid grey;


  }
 .popover {
    margin: 20px  ;
  }
   
</style>

<body>
  <header>
    <div class="row">
      <div class="col-sm-11">
        <h1 style="color:white;">Faculty Information System</h1>
      </div>
       
      <div class="col-sm-1">
          <a  href="#" title="Admin Profile" data-toggle="popover"id="popover" data-html="true"  data-placement="bottom"
           data-content= '<p>Name: Sheikh Muhammad Tuseef</p>     <p>ID: bc230201216</p>      <p>Email: touseefmuhammad719@gmail.com</p>' >
    <img src="images/20.jpg" alt="Profile"></a>
       
      </div>
        
  </header>

  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
      </div>
      <div class="collapse navbar-collapse" id="myNavbar">
        <ul class="nav navbar-nav">
          <li class="active"><a href=" #">Home</a></li>
          <li><a href="registration.html">New</a></li>
          <li><a href="remove.html">Remove</a></li>
          <li><a href="report.jsp? &action=admin">Report</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
         <button style="margin-top: 8px; background-color:black;" class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"> 
           <span class="caret"></span></button>
            <ul class="dropdown-menu">
              <li><a href="changePassword.jsp?&action=admin">Reset Password</a></li>
              <li><a href="?&action=logout" >Logout</a></li>               
            </ul>
        </ul>
      </div>
    </div>
  </nav>
<%
    // Handle logout action
    String action = request.getParameter("action");
    if ("logout".equals(action)) {

        if (session != null) {
            session.invalidate(); // Invalidate the session
        }
        response.sendRedirect("login.html"); // Redirect to the login page
  }    
%>
  <div class="container">
    <div class="row">
      <%
        // Database credentials
        String jdbcURL = "jdbc:mysql://localhost:3306/faculty_info_online"; 
        String dbUser = "root"; 
        String dbPassword = "";

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL query to fetch data from the database
            String sql = "SELECT * FROM teacher";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

           int rsNo=1;
            while (rs.next()) {
      %>
      <div class="col-sm-4">
         <div class="panel panel-default custom-shadow">
            <div class="panel-heading" style="background-color:#3b26b5 ; color: white;">
              <h4>Faculty Member:<%= rsNo %></h4>
            </div>
            <div class="panel-body">
              <div class="row">
                <div class="col-sm-5">
                  <%
                    String imageName = rs.getString("teacher_id");  
                    String imagePath = application.getRealPath("/images/" + imageName+".jpeg");  
                    File imageFile = new File(imagePath);
                    String imageToShow = imageFile.exists() ? "images/" + imageName+".jpeg" : "images/profile.png";
                  %>

                 <img id="profileImg"src="<%= imageToShow %>" alt="Image not available">

                </div>
                <div class="col-sm-4" style="margin-top: 20px;">
                <p><b><%= rs.getString("name") %></b><br><%= rs.getString("latest_academic_degree") %></p>
                </div>
                <div class="col-sm-2">
                  <span class="label label-info"><%=rs.getString("status")%></span>
                </div>
              </div>
              <hr>
               
              <nav class="navbar navbar-default">
                <ul class="nav navbar-nav">
                  <li><a href="teacherUpdate.jsp?id=<%= rs.getString("teacher_id") %> &action=admin" ><span class="glyphicon glyphicon-edit"></span> Update</a>
                  </li>
                  <li><a href="teacherDetail.jsp?id=<%= rs.getString("teacher_id") %>&action=view" ><span class="glyphicon glyphicon-list-alt"></span> View Info</a></li>
                  <li><a href="teacherRemove.jsp?id=<%= rs.getString("teacher_id") %>&action=remove"onclick="return Confirm()" ><span class="glyphicon glyphicon-trash"></span> Remove
                  </a></li>
                </ul>
              </nav>
            </div>
          </div>
      </div>
      <%
      rsNo++;
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
    </div>
  </div>
</body>
</html>
