<%-- 
    Document   : login
    Created on : 02 28, 22, 12:46:41 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="../assets/logo.svg">
        <link rel="stylesheet" href="../assets/css/asset-sheet.css">
        <link rel="stylesheet" href="../assets/css/navbar-style.css">
        <link rel="stylesheet" href="../assets/css/login-style.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Amaranth&family=Quicksand&family=VT323&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide&effect=anaglyph">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Press+Start+2P&effect=anaglyph">

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
        <title>UST-TGS</title>


    </head>
    <body>


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
                    <a class="option" href="../home.jsp">Home</a>
                    <a class="option" href="../subpage/about.jsp">About</a>
                    <a class="option" href="../subpage/events.jsp">Events</a>
                    <a class="option" href="../subpage/contact.jsp">Contact</a>
                    <form  action="../login/login.jsp">
                        <input type="submit" value="Login"  class="button"/>
                    </form>

                </div>
            </div>
        </div>

	<%
	    response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	    String uname = (String) session.getAttribute("username");
	    if (uname != null) {
		response.sendRedirect("subpage/authenticatedHome.jsp");
	    }
        %>
        <section class="login-section">
            <form class="login-container" method="post" action="../ForgotPass">
                <h2>Forgot Password</h2>
		<!--                <h3>Don't have an account yet? <a href="../signup/signup.jsp">Sign up</a></h3>-->


                <div class="input-container">
                    <label for="uname"><b>Email</b></label>    
                    <div class="input">
			<!--                        <span class="material-icons input-icon" style="color:#FF5757;">&#xe887;</span>-->
                        <input type="email" pattern="[a-z0-9._%+-]+@ust.edu.ph$" placeholder="Enter Email (ust.edu.ph)" name="email" required>
                    </div>

                </div>


                <button type="submit" class="button" name="button" value="forgot">SEND</button>
                <a href="/">Go Back to Login</a>
            </form>
        </section>       
    </body>
</html>



