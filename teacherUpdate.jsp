<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <title>Update Teacher</title>
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
        a{
            color: white;
        }

        a:hover {
           color: white;
}
    </style>
</head>
<body>
    
<%
    String teacherId =request.getParameter("id");
    String role=request.getParameter("action");
     
    if (teacherId != null) {
        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_info_online", "root", "");

            // Fetch the teacher's details
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM teacher WHERE teacher_id = ?");
            pstmt.setString(1, teacherId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                if("admin".equals(role)){
%>
    <div class="container">
        <div class="panel panel-default" style="margin-top: 20px;">
            <div class="panel-heading"style="background-color: #5a03fc; color: white;"> 
                        <div class="row">
                            <div class="col-sm-10"><h2><%=rs.getString("name")%> : Details</h2></div>
                            <div class="col-sm-2"><a href="adminInterface.jsp" > <h3>Cancel</h3></a> </div>
                        </div>
                </div>
            <div class="panel-body">
                <form action="updateTeacherHandler.jsp?id=admin" method="post">
                    <!-- Hidden field for teacher ID -->
                    <input type="hidden" name="teacher_id" value="<%= rs.getString("teacher_id") %>" />

                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" id="name" name="name" value="<%= rs.getString("name") %>" required>
                    </div>

                    <div class="form-group">
                        <label>Gender</label><br>
                        <input   type="radio" id="male" name="gender" value="male">
                        <label for="male">Male</label>  
                        <input  type="radio" id="female" name="gender" value="female">
                        <label for="female">Female</label>
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" value="<%= rs.getString("email") %>" required>
                    </div>

                    <div class="form-group">
                        <label for="cnic">CNIC:</label>
                        <input type="text" class="form-control" id="cnic" name="cnic" value="<%= rs.getString("cnic") %>" required>
                    </div>

                    <div class="form-group">
                        <label for="department">Department:</label>
                        <input type="text" class="form-control" id="department" name="department" value="<%= rs.getString("department") %>" required>
                    </div>

                    <div class="form-group">
                        <label for="date_of_birth">Date of Birth:</label>
                        <input type="date" class="form-control" id="date_of_birth" name="date_of_birth" value="<%= rs.getString("date_of_birth") %>" required>
                    </div>

                    <div class="form-group">
                        <label for="date_of_birth">Date of Joining:</label>
                        <input type="date" class="form-control" id="date_of_joining" name="date_of_joining" value="<%= rs.getString("date_of_joining") %>" required>
                    </div>

                    <div class="form-group">
                        <label for="contact_no">Contact No:</label>
                        <input type="text" class="form-control" id="contact_no" name="contact_no" value="<%= rs.getString("contact_no") %>" required>
                    </div>

                     <div class="form-group">
                        <label for="landline_no">Landline No:</label>
                        <input type="text" class="form-control" id="landline_no" name="landline_no" value="<%= rs.getString("landline_no") %>" required>
                    </div>

                     <div class="form-group">
                        <label for="contact_no">Degree:</label>
                        <input type="text" class="form-control" id="degree" name="degree" value="<%= rs.getString("latest_academic_degree") %>" required>
                    </div>


                    <div class="form-group">
                        <label for="experties">Expertise:</label>
                        <input type="text" class="form-control" id="experties" name="experties" value="<%= rs.getString("experties") %>" required>
                    </div>

                     <div class="form-group">
                        <label> Status</label><br>
                        <input   type="radio" id="active" name="status" value="active">
                        <label for="active">Active</label>  
                        <input  type="radio" id="Inactive" name="status" value="inactive">
                        <label for="active">InActive</label>
                    </div>


                   <button type="submit" class="btn btn-primary btn-block" style="background-color: #5a03fc;">Update</button>
                     
                </form>
            </div>
        </div>
    </div>
    </body>
</html>

<%
}
else if("teacher".equals(role)){
%>
 <header>
    <div class="row">
      <div class="col-sm-11">
        <h1 style="color: white;">Faculty Information System</h1>
      </div>
       
     <!-- <div class="col-sm-1">
          <a href="#" title="Admin Profile" data-toggle="popover" data-placement="bottom" data-content="Name:    Adnan                                    
                                                                                                       
                                                                                                       ID:    123  

                                                                                                      Email: adnan@gmail.com "  ><img src="images/profile.png"></a>
       >
      </div>
        -->
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
          <li><a href=" teacherInterface.jsp?id=<%=rs.getString("teacher_id")%>">Home</a></li>
          <li class="active"><a href="teacherUpdate.jsp?id=<%=rs.getString("teacher_id")%> &action=teacher">Update</a></li>
          <li><a href="teacherReport.jsp?id=<%=rs.getString("teacher_id")%>">Members</a></li>
          <li><a href="myProfile.jsp?id=<%=rs.getString("teacher_id")%> &action=teacher">My Profile</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a href="login.html" onclick="return Confirm()"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>

<div class="container">
        <div class="panel panel-default" style="margin-top: 20px;">
            <div class="panel-heading"style="background-color: #5a03fc; color: white;"> 
                        
                             <h2><%=rs.getString("name")%> : Details</h2> 
                             
                </div>
            <div class="panel-body">
                <form action="updateTeacherHandler.jsp?id=teacher " method="post">
                    <!-- Hidden field for teacher ID -->
                    <input type="hidden" name="teacher_id" value="<%= rs.getString("teacher_id") %>" />

                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" id="name" name="name" value="<%= rs.getString("name") %>" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" value="<%= rs.getString("email") %>" required>
                    </div>

                    <div class="form-group">
                        <label for="date_of_birth">Date of Birth:</label>
                        <input type="date" class="form-control" id="date_of_birth" name="date_of_birth" value="<%= rs.getString("date_of_birth") %>" required>
                    </div>

                     

                    <div class="form-group">
                        <label for="contact_no">Contact No:</label>
                        <input type="text" class="form-control" id="contact_no" name="contact_no" value="<%= rs.getString("contact_no") %>" required>
                    </div>


                    <div class="form-group">
                        <label for="experties">Expertise:</label>
                        <input type="text" class="form-control" id="experties" name="experties" value="<%= rs.getString("experties") %>" required>
                    </div>

                     


                   <button type="submit" class="btn btn-primary btn-block" style="background-color: #5a03fc;">Update</button>
                     
                </form>
            </div>
        </div>
    </div>
    </body>
</html>


<%

}
  }           else {
                out.println("<div class='alert alert-danger'>No teacher found with ID: " + teacherId + "</div>");
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
        }
    } else {
        out.println("<div class='alert alert-danger'>Teacher ID is missing.</div>");
    }
%>
