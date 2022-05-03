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

        <script src="https://kit.fontawesome.com/db09b338f9.js" crossorigin="anonymous"></script>
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
                        <button type="submit" value="My Account"  class="button"/>My Account</button>
                    </form>

                </div>
            </div>
        </div>

        <section class="personal-records-section-2">
            <div class="personal-records-container">


                <form class="personal-records-info-container0" method="POST" action="../AddRecordServlet">
                    <div class='personal-records-info-container1'>
                        <label for=''>Name:</label>
                        <input required type="text" placeholder="Enter Name" name="myname"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Course:</label>
                        <input required type="text" placeholder="Enter Course" name="course"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Age:</label>
                        <input required type="number" placeholder="Enter Age" name="age"><br>
                    </div>

                     <div class='personal-records-info-container1'>
                        <label for=''>Birthday</label>
                        <input required type="date" placeholder="Enter Birthday" name="birthday"><br>
                    </div>

                     <div class='personal-records-info-container1'>
                        <label for=''>Gender:</label>
                        <select id="gender" name="gender">
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                        </select><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Student Number:</label>
                        <input required type="number" placeholder="Enter Student Number" name="snumber"><br>
                    </div>


                    <div class='personal-records-info-container1'>
                        <label for=''>Contact Number:</label>
                        <input required type="number" placeholder="Enter Contact Number" name="cnumber"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Favorite Game:</label>
                        <input required type="text" placeholder="Enter Favorite Game" name="favgame"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Address:</label>
                        <input required type="text" placeholder="Enter Address" name="address"><br>
                    </div>

                    <div class="personal-records-buttons"> 
                        <button onclick="location.href = 'profile-page.jsp';" value="GO BACK" class="button" >GO BACK</button>

                        <button type="submit" value="SAVE"  class="button">SAVE</button>

                        <button type="button" onclick="location.href = '../LogoutServlet';" value="LOGOUT" class="button" >LOGOUT</button>
                    </div>   

                </form>
            </div>
        </section>       
    </body>
</html>
