<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Submit Form to Database</title>

  <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <title></title>
    <script type="text/javascript">


         $(document).ready(function() {
  $('[data-toggle="popover"]').popover({
    html: true // Enables rendering of HTML content inside the popover
  });
}); 


         $(document).ready(function() {
  $('[data-toggle="popover"]').popover({
    html: true // Enables rendering of HTML content inside the popover
  });
});


    </script>


    <style type="text/css">
        header{
    padding: 10px;
    background-color:  #3b26b5;
    color: white;
  }
  .navbar-default{
 
 
  }
  header img{
    margin-top: 15px;
    width: 50px;
    height:50px;
    border-radius: 15px;


  }
  header header{
    color: black;
  }
   
         
         
{
    color: red; 
    text-align: center; 
    font-weight: bold;'

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
          <li ><a href=" adminInterface.jsp">Home</a></li>
          <li ><a href="registration.html">New</a></li>
          <li><a href="remove.html">Remove</a></li>
          <li><a href="report.jsp">Report</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <button style="margin-top: 8px; background-color:black;" class="btn btn-primary dropdown-toggle  " type="button" data-toggle="dropdown"> 
           <span class="caret"></span></button>
            <ul class="dropdown-menu ">
              <li><a href="changePassword.jsp?&action=admin">Reset Password</a></li>
              <li><a href="login.html">Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>
    <div class="container">
        <div class="row">
            <div class="col-md-6 col col-md-offset-4">                 
                <div class="panel panel-default" style="margin-top: 20px;">
                    <div class="panel-heading"style="background-color: #5a03fc; color: white;"> 
                        <div class="row">
                            <div class="col-sm-10"><h2>Change Password</h2></div>                             
                        </div>
                    </div>
                    <div class="panel-body">
                        <form action="changePassword.jsp" method="POST">
                            <div class="form-group">
                                <label for="oldPwd"><b>Old Password </b></label>
                                <input class="form-control" type="password" name="oldPwd" placeholder="Enter Old Password " id="oldPwt" required><br>
                                <label for="newPwd"><b>New Password </b></label>
                                <input class="form-control" type="password" name="newPwd" placeholder="Enter New Password " id="newPwd" required><br>
                                <label for="confirmPwd"><b>Confirm password </b></label>
                                <input class="form-control" type="password" name="confirmPwd" placeholder="Confirm Password " id="confirmPwd" required><br>                           <button type="submit"  class="btn btn-primary btn-block" style="background-color: #5a03fc;">save</button>
                           </div>
                        </form>
                    </div>
                </div>                 
            </div>
        </div>
    </div>
                    
</body>
</html>

<%
if(request.getParameter("oldPwd")!=null){  
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/faculty_info_online";
        String dbUser = "root";
        String dbPassword = "";

        // Establish connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Get user inputs
        String oldPassword = request.getParameter("oldPwd");
        String newPassword = request.getParameter("newPwd");
        String confirmPassword = request.getParameter("confirmPwd");

        if (newPassword == null || confirmPassword == null || oldPassword == null) {
            out.println("<p>All fields are required.</p>");
        } else if (!newPassword.equals(confirmPassword)) {
            out.println("<p>New passwords do not match.</p>");
        } else {
            // Check current password
            String sql = "SELECT password FROM admin"; // Adjust the table as per your logic
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                if (!oldPassword.equals(storedPassword)) {
                    out.println("<p >Failed to update password. Please try again.</p>");
                } else {
                    // Update password
                    String updateSql = "UPDATE admin SET password = ?";
                    pstmt = conn.prepareStatement(updateSql);
                    pstmt.setString(1, newPassword);
                    int rows = pstmt.executeUpdate();

                    if (rows > 0) {
                        out.println("<p style='color: Green; text-align: center; font-weight: bold;'>Password updated successfully.</p>");
                      
                    } 
                }
            } else {
                out.println("<p>No matching record found.</p>");
            }
        }
    }

    catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
        e.printStackTrace(new PrintWriter(out));
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
}
%> 

