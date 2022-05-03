<%-- 
    Document   : contacts
    Created on : 03 18, 22, 1:32:48 AM
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
        <link rel="stylesheet" href="../assets/css/contact-style.css">


        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Amaranth&family=Quicksand&family=VT323&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide&effect=anaglyph">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Press+Start+2P&effect=anaglyph">

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">

        <script src="https://kit.fontawesome.com/db09b338f9.js" crossorigin="anonymous"></script>
        <title>UST-TGS</title>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
            String uname = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            if (role == null) {
                role = "guest";
            }
        %>
        <!-- navbar -->
        <div class="bar"> 
            <input type="checkbox" id="check">
            <label for="check" class="checkbtn">
                <i class="fas fa-bars"></i>
            </label>

            <div class="logo-container" >
                <a href="../home.jsp"><img class="nav-logo nav-logo2" src="../assets/logo.svg" ></a>
            </div>

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
                    <a class="option" href="../EventOverview">Events</a>
                    <a class="option" style="color:#B92432;" href="authenticatedContacts.jsp">Contact</a>
                    <%
                        if (role.equalsIgnoreCase("member")) {
                    %>
                    <form class="button-nav-form" action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <button type="submit" value="My Account"  class="button"/>My Account</button>
                    </form>
                    <%    } else if (role.equalsIgnoreCase("admin")) { %>
                    <form class="button-nav-form" action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <button type="submit" value="ADMIN"  class="button"/>ADMIN</button>
                    </form>
                    <% }%>  

                </div>
            </div>
        </div>

        <!-- 1st section/ about -->
        <section class="contact-section">
            <div class="contact-panel1">
                <h2>Stay Connected with us.</h2>

                <div class="contact-list">
                    <div class="contact-link">
                        <i class="fa-solid fa-envelope"></i>
                        <span>thomasiangamingsociety@gmail.com </span>

                    </div>                              

                    <div class="contact-link">
                        <i class="fa-brands fa-facebook"></i>
                        <span> @ThomasianGamingSociety</span>
                    </div>

                    <div class="contact-link">
                        <i class="fa-brands fa-twitter"></i>
                        <span>@UST_TGS</span>
                    </div>

                    <div class="contact-link">
                        <i class="fa-brands fa-instagram"></i>
                        <span>@UST_TGS</span>
                    </div>

                    <div class="contact-link">
                        <i class="fa-solid fa-location-dot"></i> 
                        <span>España Blvd, Sampaloc, Manila, 1008 Metro Manila</span>
                    </div>
                </div>                           
            </div>

            <div class="contact-panel2">
                <form class="contact-form" method="post" action="../AddComment" >
                    <div class="panel-container">
                        <div class="panel">
                            <label for="fname">First Name <span style="color:red;">*</span></label>
                            <input type="text" name="fname" autocomplete="chrome-off" required >

                            <label for="lname">Last Name <span style="color:red;">*</span></label>
                            <input type="text" name="lname" autocomplete="chrome-off" required>

                        </div>

                        <div class="panel">
                            <label for="email">Email <span style="color:red;">*</span></label>
                            <input type="email" name="email" required>

                            <label for="course">Course <span style="color:red;">*</span></label>
                            <input type="text" name="course" autocomplete="chrome-off" required>

                        </div>
                    </div>

                    <div class="panel1">
                        <label for="comments">Comments/Suggestions <span style="color:red;">*</span></label>
                        <input type="text" name="comments" placeholder="Write your message here" required>
                    </div>

                    <div class="panel2">
                        <button type="submit" value="SUBMIT"  class="button">SUBMIT</button>
                        <a href="../ViewCommentBox">Comments/Suggestions Box <span class="material-icons-outlined"> &#xe8af;</span></a>

                    </div>
                </form>

            </div>
        </section>
    </body>
</html>
