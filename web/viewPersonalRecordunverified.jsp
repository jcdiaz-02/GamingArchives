<%-- Document : viewPersonalRecordunverified Created on : 02 28, 22, 12:46:41 AM Author : Admin --%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="assets/logo.svg">
        <link rel="stylesheet" href="assets/css/asset-sheet.css">
        <link rel="stylesheet" href="assets/css/navbar-style.css">
        <link rel="stylesheet" href="assets/css/about-style.css">
        <link rel="stylesheet" href="assets/css/records-personal-style.css">


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

        <script src="https://kit.fontawesome.com/db09b338f9.js" crossorigin="anonymous"></script>
        <title>UST-TGS</title>

    </head>

    <body>
        <!-- navbar -->
        <div class="bar">
            <div class="nav-content">
                <div class="nav-title">
                    <img class="nav-logo" src="assets/logo.svg" alt="UST-TGS logo">
                    <a class="" href="/">
                        <h1>UST Thomasian Gaming Society</h1>
                    </a>
                </div>
                <div class="nav-options">
                    <a class="option" href="subpage/authenticatedHome.jsp">Home</a>
                    <a class="option" href="subpage/authenticatedAbout.jsp">About</a>
                    <a class="option" href="EventOverview">Events</a>
                    <a class="option" href="subpage/authenticatedContacts.jsp">Contact</a>
                    <form style="color:#B92432;" action="myAccountPage.jsp">
                        <input type="hidden" name="verify" value="${verify}" />
                        <input type="submit" value="My Account" class="button" />
                    </form>

                </div>
            </div>
        </div>

	<!-- 1st section/ about -->
        <section class="personal-records-section-0">
            <div class="personal-records-container">
                <%
		    response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
		    String uname = (String) session.getAttribute("username");
		    session.setAttribute("verify", session.getAttribute("verify"));
		    session.setAttribute("username", uname);
		    if (uname == null) {
			response.sendRedirect("home.jsp");
		    }
                %>
                <h3>View Personal Record</h3>
		<form class="personal-records-info-container0" action="/">
                    <div class='personal-records-info-container1'>
                        <label for=''>Email:</label>
                        <input type='email' id='email' name='email' value='<c:out value="${email}"/>' readonly> 

                    </div>

                    <div class='personal-records-info-container1'> 
                        <label for=''>Username:</label>

                        <input type='text' id='uname' name='uname' value='<c:out value="${username}"/>' readonly> 
                        <span class="material-icons edit-icon">
                            edit
                        </span>

                    </div>


                    <div class='personal-records-info-container1'> 
                        <label for=''>Password:</label>

                        <input type='text' id='password' name='password' value='<c:out value="${password}"/>' readonly> 
                        <span class="material-icons edit-icon">
                            edit
                        </span>

                    </div>

                    <span class='verification-container'>
                        <span class="material-icons verification-icon" style="color:red;">
			    cancel
                        </span> 
                        Your account has not been verified.
                    </span>

                    <div class="personal-records-buttons"> 
			<input type="button" onclick="location.href = 'subpage/myAccountPage.jsp';" value="GO BACK" class="button" />
			<input type="button" onclick="location.href = 'LogoutServlet';" value="LOGOUT" class="button" />
                    </div>   
                </form> 

            </div>
        </section>
    </body>

</html>