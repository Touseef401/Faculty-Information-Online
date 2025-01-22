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

   $(document).ready(function(){
  $('[data-toggle="popover"]').popover();   
});

</script>

<style type="text/css">
     
   
  header{
    padding: 10px;
    background-color:  #3b26b5;
   
  }
  .navbar-default{
 
 
  }
  header img{
    width: 50px;
    height:50px;
    border-radius: 15px;


  }
  img{
    margin-top: 15px;
    height: 100px;
    width: 100px;
  }
   #profileImg
  {
    border-radius: 15px;
    width: 100px;
    height:120px;
 border: 3px solid grey;


  }
   
</style>
 <%

    String teacherID = request.getParameter("id");
     
%>
  

  <header>
    <div class="row">
      <div class="col-sm-11">
        <h1 style="color:white;">Faculty Information System</h1>
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
          <li><a href="teacherUpdate.jsp?id=<%= teacherID%> &action=teacher">Update</a></li>
          <li><a href="teacherReport.jsp?id=<%= teacherID%> &action=teacher">Members</a></li>
          <li><a href="myProfile.jsp?id=<%= teacherID%> &action=teacher">My Profile</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a href="login.html" onclick="return Confirm()"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>
<%
     
    

    if (teacherID != null) {
        try {
            // Database connection setup
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_info_online", "root", "");

            // Query to fetch details based on `id`
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM teacher WHERE teacher_id = ?");
            pstmt.setString(1, teacherID);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
            %> 
            <body > 
              <div class="container">
                <div class="row">
                  <div class="col-md-6 col col-md-offset-0">
                    <div class="panel panel-default"  >
                      <div class="panel-heading" style="background-color:#3b26b5 ; color: white;">
                        <h4>TeacherID:<%= rs.getString("teacher_id") %></h4>
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
                        <div class="col-sm-4">
                          <p><b><%= rs.getString("name") %></b><br><%= rs.getString("latest_academic_degree") %></p>
                        </div>
                        <div class="col-sm-2">
                          <span class="label label-info"><%=rs.getString("status")%></span>
                        </div>
                      </div>
                  </div>
                </div>
              </div>

            <%
                }
            %>

            <%
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Teacher ID is missing.</p>");
    }
%>

  
</body>
</html>
