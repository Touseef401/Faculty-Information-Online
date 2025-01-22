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
	<title>Report</title>
	<script> 
     $(document).ready(function() {
  $('[data-toggle="popover"]').popover({
    html: true // Enables rendering of HTML content inside the popover
  });
});
$(document).ready(function(){
  $(".report-flip").click(function(){
    $(this).next(".report-bar").slideToggle("slow");
  });
});
</script>
	<style>
		 
		.report-flip {
			padding: 5px;
			margin: 10px;
			border-radius: 5px;
			background-color:#babfe0;
			color: black;
		}
		.report-bar {
			padding: 20px;
			display: none;
		}
		header{
    padding: 10px;
    background-color:  #3b26b5;
    color: white;
  }
  .navbar-default{
 
 
  }
  header header{
    color: black;
  }
   
  header img{
    margin-top: 15px;
    width: 50px;
    height:50px;
    border-radius: 15px;


  }
   
	</style>
</head>
 <header>
    <div class="row">
      <div class="col-sm-11">
        <h1>Faculty Information System</h1>
      </div>
       <div class="col-sm-1"> 
          <a  href="#" title="Admin Profile" data-toggle="popover" data-placement="bottom" data-content="Name:Touseef<br>ID:123<br>  Email: adnan@gmail.com "><img src="images/20.jpg"></a>
       
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
          <li><a href="adminInterface.jsp">Home</a></li>
          <li><a href="registration.html">New</a></li>
          <li><a href="remove.html">Remove</a></li>
          <li class="active"><a href="report.jsp">Report</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <button style="margin-top: 8px; background-color:black;" class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"> 
           <span class="caret"></span></button>
            <ul class="dropdown-menu">
              <li><a href="changePassword.jsp?&action=admin">Reset Password</a></li>
              <li><a href="login.html">Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>

<body>
	
	<div class="container">
		<div class="panel panel-info" style="margin-top: 10px;">
			<div class="panel-heading" style="background-color: #3b26b5; color: white;">  
			  <div class="row">
			  	<div class="col-md-10">
			  		<h1>Report</h1>
			  </div>
			  <div class="col-md-2">
          <form method="get" action="">
             <select name="filter" class="form-control" onchange="this.form.submit()" style="margin-top: 25px;">
               <option value="ALL" <% if ("ALL".equals(request.getParameter("filter"))) out.print("selected"); %>>ALL</option>
               <option value="active" <% if ("active".equals(request.getParameter("filter"))) out.print("selected"); %>>Active</option>
               <option value="inactive" <% if ("inactive".equals(request.getParameter("filter"))) out.print("selected"); %>>Inactive</option>
             </select>
          </form>
			  </div>
			  </div>
		  </div> 
			<div class="panel-body">
				<%
        // Database credentials
        String jdbcURL = "jdbc:mysql://localhost:3306/faculty_info_online"; 
        String dbUser = "root"; 
        String dbPassword = "";

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        String filter = request.getParameter("filter");
        if (filter == null) {
          filter = "ALL";
        }

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL query to fetch data from the database
            String sql = "SELECT * FROM teacher";
            if ("active".equals(filter)) {
                sql += " WHERE status = '" + filter + "'";
            }
            if ("inactive".equals(filter)) {
                sql += " WHERE status = '" + filter + "'";
            }
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            // Loop through the result set and display each teacher in a panel
            while (rs.next()) {
            %>

						<ul>
							<li>
								<div class="report-flip">
									<div class="row">
										<div class="col-sm-4"> <b>Name:</b><%= rs.getString("name")%> </div>
										<div class="col-sm-4"> <b>Status:</b><%= rs.getString("status")%> </div>
									</div>
								</div>
								<div class="report-bar">
									<div class="row">
										<div class="col-sm-6">
                      <p><b>ID:</b><%= rs.getString("teacher_id")%> </p><br>
                      <p><b>Date of joining:</b><%= rs.getString("date_of_joining")%> </p><br>
                      <p><b>Department:</b><%= rs.getString("department")%></p><br>
                      <p><b>Degree:</b><%= rs.getString("latest_academic_degree")%> </p><br>
                      <p><b>Gender:</b> <%= rs.getString("gender")%></p><br>
											
										</div>
										<div class="col-sm-6">
                      <p><b>Email:</b> <%= rs.getString("email")%></p><br>  
											<p><b>CNIC:</b> <%= rs.getString("cnic")%></p><br>
										  <p><b>Date of Birth:</b><%= rs.getString("date_of_birth")%> </p><br>
                      <p><b>Contact No:</b><%= rs.getString("contact_no")%> </p><br>
											<p><b>Experties:</b><%= rs.getString("experties")%> </p><br>
											<p><b>Age:</b><%= rs.getString("age")%> </p><br>

										</div>
									</div>
								</div>
							</li>
						</ul>
						 <%
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
	</div>
</body>
</html>
