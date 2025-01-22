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
		body{
	  background-image: url('images/login7.jpeg');
	  background-repeat: no-repeat;
	  background-size: cover;
	  height: 100%;
		display: flex;
		align-items: center;
		justify-content: center;
		}
		a{
			color: white;
		}

		a:hover {
           color: white;
}
#profileImg
{
	margin-top: 10px;
	 width: 50px;
    height:50px;
    border-radius: 15px;

}
		 

	</style>
</head>

<%
    String teacherId = request.getParameter("id");

    if (teacherId != null) {
        try {
            // Database connection setup
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_info_online", "root", "");

            // Query to fetch details based on `id`
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM teacher WHERE teacher_id = ?");
            pstmt.setString(1, teacherId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
            %> 
            <div class="panel panel-default" style="margin-top: 20px;">
            	<div class="panel-heading"style="background-color: #5a03fc; color: white;"> 
						<div class="row">
							<div class="col-sm-1"><img id="profileImg" src="images/<%=rs.getString("teacher_id")%>.jpeg"></div> 
							<div class="col-sm-9"><h2><%=rs.getString("name")%> profile</h2></div>
							
							<div class="col-sm-2"><a href="adminInterface.jsp" > <h3>back</h3></a></div>
						</div>
				</div>
	            <div class="container">
	            	<div class="row">
	            		<div class=col-sm-6>
	            			<ul>
	            				<li><h5><b>ID: </b><%=rs.getString("teacher_id")%></h5></li>
	            				<li><h5><b>Name: </b><%=rs.getString("name")%></h5></li>
	            				<li><h5><b>Gender: </b><%=rs.getString("gender")%></h5></li>
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
	            				<li><h5><b>Password:</b><%=rs.getString("password")%></h5></li><br>
	            				<button type="submit" style=" background-color: grey;"> <a href="teacherUpdate.jsp?id=<%= rs.getString("teacher_id") %> &action=admin" ><span class="glyphicon glyphicon-edit"></span> Update</a></button>
	            			</ul>

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
