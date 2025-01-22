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
	<title></title>
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
	  
		a{
			color: white;
		}

		a:hover {
           color: white;
}
		 

	</style>
</head>

<%
    String teacherID = request.getParameter("id");
%>
<header>
    <div class="row">
      <div class="col-sm-11">
        <h1 style="color:white;">Faculty Information System</h1>
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
          <li><a href=" teacherInterface.jsp?id=<%= teacherID%> &action=teacher">Home</a></li>
          <li><a href="teacherUpdate.jsp?id=<%= teacherID%> &action=teacher">Update</a></li>
          <li><a href="teacherReport.jsp?id=<%= teacherID%> &action=teacher">Members</a></li>
          <li class="active"><a href="myProfile.jsp?id=<%= teacherID%> &action=teacher">My Profile</a></li>
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
            <body>
            <div class="panel panel-default" style="margin: 20px;">
            	<div class="panel-heading"style="background-color: #5a03fc; color: white;"> 
						 
					<h2><%=rs.getString("name")%> profile</h2></div> 
				</div>
	            <div class="container">
	            	<div class="row">
	            		<div class=col-sm-6>
	            			<ul>
	            				<li><h5><b>ID: </b><%=rs.getString("teacher_id")%></h5></li>
	            				<li><h5><b>Name: </b><%=rs.getString("name")%></h5></li>
	            				<li><h5><b>Email: </b><%=rs.getString("email")%></h5></li>
	            				<li><h5><b>CNIC:</b><%=rs.getString("cnic")%></h5></li>
	            				<li><h5><b>Department:</b><%=rs.getString("department")%></h5></li>
	            				<li><h5><b>Date of Joining:</b><%=rs.getString("date_of_joining")%></h5></li>
	            				<li><h5><b>Date of Birth:</b><%=rs.getString("date_of_birth")%></h5></li>
	            			</ul>
	            		</div>
	            		<div class=col-sm-6>
	            			<ul>
	            				<li><h5><b>Landline No:</b><%=rs.getString("landline_no")%></h5></li>
	            				<li><h5><b>Contact No:</b><%=rs.getString("contact_no")%></h5></li>
	            				<li><h5><b> Current Degree:</b><%=rs.getString("latest_academic_degree")%></h5></li>
	            				<li><h5><b>Experties:</b><%=rs.getString("experties")%></h5></li>
	            				<li><h5><b>Status:</b><%=rs.getString("status")%></h5></li>
	            				<li><h5><b>Age:</b><%=rs.getString("age")%></h5></li>
	            				<li><h5><b>Password:</b><%=rs.getString("password")%></h5></li>
	            			</ul>	
	            		</div>
	            	</div>
	            </div>
            </div>
        </body>
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
