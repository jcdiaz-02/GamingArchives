<%-- 
    Document   : all-records
    Created on : 03 19, 22, 3:57:41 AM
    Author     : Admin
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page session="true" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    String driver = "org.apache.derby.jdbc.ClientDriver";
    String url = "jdbc:derby://localhost:1527/userDB";
    String username = "app";
    String password = "app";
    Connection conn;
    try {
	Class.forName(driver);

    } catch (ClassNotFoundException e) {
	e.printStackTrace();
    }
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="../assets/logo.svg">
        <link rel="stylesheet" href="../assets/css/asset-sheet.css">
        <link rel="stylesheet" href="../assets/css/navbar-style.css">
        <link rel="stylesheet" href="../assets/css/records-all-style.css">
        <link rel="stylesheet" href="../assets/css/modal-style.css">


        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Amaranth&family=Quicksand&family=VT323&family=Poppins&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide&effect=anaglyph">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Press+Start+2P&effect=anaglyph">

        <script language="JavaScript" type="text/javascript" src="/js/jquery-1.2.6.min.js"></script>
        <script language="JavaScript" type="text/javascript" src="/js/jquery-ui-personalized-1.5.2.packed.js"></script>
        <script language="JavaScript" type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">

        <script language="JavaScript" type="text/javascript" src="../assets/scripts/modal.js"></script>  
        <script src="https://kit.fontawesome.com/db09b338f9.js" crossorigin="anonymous"></script>
        <title>UST-TGS</title>
    </head>
    <body>
        <!--TODO: CONNECT TO DATABASE AND ACCESS ALL RECORDS DATA -->
        <!--TODO: FUNCTIONALITY OF SORT BUTTONS-->
        <!-- navbar -->
        <div class="bar"> 
            <input type="checkbox" id="check">
            <label for="check" class="checkbtn">
                <i class="fas fa-bars"></i>
            </label>
            <div class="nav-content">
                <div class="nav-title">
                    <img class="nav-logo" src="../assets/logo.svg" alt="UST-TGS logo">
                    <a class="" href="../home.jsp"> 
                        <h1>UST Thomasian Gaming Society</h1>
                    </a>
                </div>
                <div class="nav-options" >
                    <a class="option" href="../subpage/authenticatedHome.jsp">Home</a>
                    <a class="option" href="../subpage/authenticatedAbout.jsp">About</a>
                    <a class="option" href="../EventOverview">Events</a>
                    <a class="option" href="../subpage/authenticatedContacts.jsp">Contact</a>
                    <form style="color:#B92432;" action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <input type="submit" value="ADMIN"  class="button"/>
                    </form>
                </div>
            </div>
        </div>
        <%
	    response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	    String uname = (String) session.getAttribute("username");
	    //session.setAttribute("verify", session.getAttribute("verify"));

	    String role = (String) session.getAttribute("role");
	    if (uname == null) {
		response.sendRedirect("home.jsp");
	    }
        %>
        <section class="all-records-section">
            <div class="all-records-container">
                <div class="all-records-head">
                    <h2>Archived Records</h2>        
		    ${sessionScope.notif}

                </div>
                <div class="table-container">
                    <table class="records-table">
			<tr>
			    <td>Name</td>
			    <td>Course</td>
			    <td>Email</td>
			    <td>Username</td>
			    <td>Age</td>
			    <td>Birthday</td>
			    <td>Gender</td>
			    <td>Student Number</td>
			    <td>Favorite Game</td>
			    <td>Contact Number</td>
			    <td>Address</td>
			    <td>Verification</td>
			    <td>Status</td>
			    <td>Select</td>

			</tr>
			<%
			    try {
				conn = DriverManager.getConnection(url, username, password);
				String query = "SELECT * FROM APP.ARCHIVEDB";
				PreparedStatement pstmt = conn.prepareStatement(query);
				ResultSet records = pstmt.executeQuery();

				while (records.next()) {

			%>
			<tr>
			    <td><%=records.getString("NAME")%></td>
			    <td><%=records.getString("COURSE")%></td>
			    <td><%=records.getString("EMAIL")%></td>
			    <td><%=records.getString("USERNAME")%></td>
			    <td><%=records.getString("AGE")%></td>
			    <td><%=records.getString("BIRTHDAY")%></td>
			    <td><%=records.getString("GENDER")%></td>
			    <td><%=records.getString("STUDENTNUMBER")%></td>
			    <td><%=records.getString("FAVORITEGAME")%></td>
			    <td><%=records.getString("CONTACTNUMBER")%></td>
			    <td><%=records.getString("ADDRESS")%></td>
			    <td>VERIFIED</td>	 
			    <td><%=records.getString("STATUS")%></td>
			    <td>
				<form id="myform" action="../ArchiveTransferServlet"  method="get">
				    <label class="checkbox-container">
					<input form="myform" type="checkbox" id="rows" name="selectedRows" value="<%=records.getString("EMAIL")%>">
					<span class="checkmark"></span>
				    </label>
				</form>
			    </td>
			</tr>
			<%
				}
			    } catch (Exception e) {
				e.printStackTrace();
			    }%>

                    </table>
                </div>       

                <div class="all-records-buttons"> 
                    <form  action="records-all.jsp">
                        <input type="submit" value="GO BACK"  class="button"/>
                    </form>
                    <form onclick ="deleteOpenForm()">
                        <button class="button" onclick="">DELETE</button>
                    </form>    
                    <button id="modalBtn"  class="button"/>GENERATE PDF</button>

                    <form  action="../LogoutServlet">
                        <input type="submit" value="LOGOUT"  class="button"/>
                    </form>


		    <button onclick="document.getElementById('myform').submit()"  class="button" >RESTORE</button>



                </div>      
            </div>
        </section>
	<%
	    session.removeAttribute("notif");
	%>

        <div id="deleteForm" class="modal-section">
            <form action="../DeleteRecordServlet" class="modal-content">
                <h3 class="modal-header">Delete Record</h3>
                <%
		    session.setAttribute("ident", "arch");
                %>
                <label class="modal-msg" for="uname"><b>Username of record being deleted</b></label>
                <input class="modal-input" type="text" placeholder="Enter Username" name="uname" required>

                <span class="modal-buttoncon"> 
                    <button  class="close modal-button" type="button" class="cancel" onclick="deleteCloseForm()">Cancel</button>
                    <button  class="modal-button"  type="submit" class="submit">Submit</button>
                </span>
            </form>
        </div>


        <section id="modalSection" class="modal-section">
            <div class="modal-content">
                <h3 class="modal-header">SUCCESS!</h3>
                <p class="modal-msg">Your PDF has been generated.</p>   
                <form class="modal-buttoncon" method="POST" action ="../PDFServlet">
                    <button class="modal-button"  name="pdfbutton" value="archpdf">Download PDF</button>
                </form>
            </div>
        </section> 

        

	<!--        <section id="modalSection" class="modal-section">
		    <div class="modal-content">
			<h3 class="modal-header">ARE YOU SURE?</h3>
			<p class="modal-msg">Please confirm that you have selected the correct event/s. You cannot reverse this action after pressing the delete button.</p>
			<span class="modal-buttoncon">
			    <span onclick="Close()" class="close modal-button">Cancel</span>
			    <span class="modal-button">Delete</span> 
			</span>
		    </div>
		</section>-->
	<script>
	    function openForm() {
		event.preventDefault();
		document.getElementById("myForm").style.display = "block";
	    }
	    ;
	    function closeForm() {
		event.preventDefault();
		document.getElementById("myForm").style.display = "none";

	    }
	    ;
	    function verifyOpenForm() {
		event.preventDefault();
		document.getElementById("verifyForm").style.display = "block";
	    }
	    ;
	    function verifyCloseForm() {
		event.preventDefault();
		document.getElementById("verifyForm").style.display = "none";
	    }
	    ;
	    function deleteOpenForm() {
		event.preventDefault();
		document.getElementById("deleteForm").style.display = "block";
	    }
	    ;
	    function deleteCloseForm() {
		event.preventDefault();
		document.getElementById("deleteForm").style.display = "none";
	    }
	    ;

	    window.onclick = function (event) {
		if (event.target === document.getElementById("myForm")) {
		    document.getElementById("myForm").style.display = "none";
		}
	    };

	</script>
    </body>
</html>
