<%-- 
    Document   : addRecord
    Created on : 03 13, 22, 12:46:41 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="assets/logo.svg">
        <link rel="stylesheet" href="../assets/css/asset-sheet.css">
        <link rel="stylesheet" href="../assets/css/navbar-style.css">
        <link rel="stylesheet" href="../assets/css/records-personal-style.css">


        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Amaranth&family=VT323&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide&effect=anaglyph">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Press+Start+2P&effect=anaglyph">

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
        <title>UST-TGS</title>
    </head>
    <body>
	<%
	    response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	    String uname = (String) session.getAttribute("username");
	    //session.setAttribute("verify", session.getAttribute("verify"));

	    String role = (String) session.getAttribute("role");
	    if (uname == null) {
		response.sendRedirect("home.jsp");
	    }
	%>         
	<!-- navbar -->
        <div class="bar"> 
            <div class="nav-content">
                <div class="nav-title">
                    <img class="nav-logo" src="../assets/logo.svg" alt="UST-TGS logo">
                    <a class="" href="/"> 
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
                        <input type="submit" value="My Account"  class="button"/>
                    </form>

                </div>
            </div>
        </div>

	<section class="personal-records-section-2">
            <div class="personal-records-container">


		<form class="personal-records-info-container0" method="POST" action="../AddRecordServlet">
                    <div class='personal-records-info-container1'>
			<h1>Name: </h1><input required type="text" placeholder="Enter Name" name="myname"><br>

                    </div>

		    <div class='personal-records-info-container1'>
			<h1>Course: </h1>
			<select id="gender" name="course">
			    <option value="Computer Science">Computer Science</option>
			    <option value="Information Technology">Information Technology</option>
			    <option value="Data Science">Data Science</option>

			</select><br>
                    </div>

		    <div class='personal-records-info-container1'>
			<h1>Birthday(Age reflects given birth date): </h1><input required type="date" placeholder="Enter Birthday" name="birthday"><br>
                    </div>

		    <div class='personal-records-info-container1'>
			<h1>Gender: </h1>
			<select id="gender" name="gender">
			    <option value="male">Male</option>
			    <option value="female">Female</option>
			</select><br>
                    </div>

		    <div class='personal-records-info-container1'>
			<h1>Student Number: </h1><input required type="number" placeholder="Enter Student Number" name="snumber" minlength="10" maxlength="10"><br>
                    </div>

		    <div class='personal-records-info-container1'>
			<h1>Contact Number: </h1><input required type="number" placeholder="Enter Conatct Number(+63)" name="cnumber" minlength="10" maxlength="10"><br>
                    </div>

		    <div class='personal-records-info-container1'>
			<h1>Favorite Game: </h1><input required type="text" placeholder="Enter Favorite Game" name="favgame"><br>
                    </div>

		    <div class='personal-records-info-container1'>
			<h1>Address: </h1><input required required type="text" placeholder="Enter Address" name="address"><br>
                    </div>

		    <div class="personal-records-buttons"> 
			<input type="button" onclick="location.href = 'profile-page.jsp';" value="GO BACK" class="button" />

			<input type="submit" value="SAVE"  class="button"/>

			<input type="button" onclick="location.href = '../LogoutServlet';" value="LOGOUT" class="button" />
		    </div>   

		</form>
            </div>
        </section>       
    </body>
</html>
