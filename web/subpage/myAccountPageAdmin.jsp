<%-- 
    Document   : myAccountPageAdmin
    Created on : 03 15, 22, 10:33:45 PM
    Author     : Admin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="../assets/logo.svg">
        <link rel="stylesheet" href="../assets/css/asset-sheet.css">
        <link rel="stylesheet" href="../assets/css/navbar-style.css">
        <link rel="stylesheet" href="../assets/css/about-style.css">
        <link rel="stylesheet" href="../assets/css/profile-page-style.css">


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
	<title>UST-TGS</title>

    </head>
    <body>
	<%
	    response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	    String uname = (String) session.getAttribute("username");

	    if (uname == null) {
		response.sendRedirect("home.jsp");
	    }
	%>
        <!-- navbar -->
        <div class="bar"> 
	    <input type="checkbox" id="check">
            <label for="check" class="checkbtn">
                <i class="fas fa-bars"></i>
            </label>
            <div class="nav-content">
                <div class="nav-title">
                    <img class="nav-logo" src="../assets/logo.svg" alt="UST-TGS logo">
                    <a class="" href="/"> 
                        <h1>UST Thomasian Gaming Society</h1>
                    </a>
                </div>
                <div class="nav-options" >
                    <a class="option" href="authenticatedHome.jsp">Home</a>
                    <a class="option" href="authenticatedAbout.jsp">About</a>
                    <a class="option" href="authenticatedEvents.jsp">Events</a>
                    <a class="option" href="authenticatedContacts.jsp">Contact</a>
                    <form style="color:#B92432;" action="myAccountPageAdmin.jsp">

                        <input type="submit" value="ADMIN"  class="button"/>
                    </form>

                </div>
            </div>
        </div>

	<!-- 1st section/ about -->
        <section class="profile-section">
            <div class="profile-container">

		<button type="button" onclick="location.href = '../ViewAllRecord.jsp';" class="button" name="uname" value="<c:out value="${username}"/>">
		    <span class="material-icons">done_all</span>
		    View All Records</button>

		<button type="button" onclick="location.href = '../ViewTodayRecord.jsp';" class="button">
		    <span class="material-icons">event_available</span>
		    View Today's Record</button>

		<button type="button" onclick="location.href = '../addRecordAdmin.jsp';" class="button">
		    <span class="material-icons-outlined">person_add_alt</span>
		    Add Record</button>

		<button type="button" onclick="location.href = '../LogoutServlet';" class="button">
		    <span class="material-icons-outlined">power_settings_new</span>
		    Logout</button>



	    </div>
	</section>
    </body>
</html>
