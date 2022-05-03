<%-- 
    Document   : personal-record-0
    Created on : 03 20, 22, 1:17:02 AM
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
        <link rel="stylesheet" href="../assets/css/records-personal-style.css">
        <link rel="stylesheet" href="../assets/css/modal-style.css">


        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Amaranth&family=Quicksand&family=VT323&family=Poppins&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide&effect=anaglyph">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Press+Start+2P&effect=anaglyph">

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">

        <script language="JavaScript" type="text/javascript" src="../assets/scripts/modal.js"></script>  
        <script src="https://kit.fontawesome.com/db09b338f9.js" crossorigin="anonymous"></script>
        <title>UST-TGS</title>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
            String uname = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
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

            <div class="logo-container" >
                <a href="../home.jsp"><img class="nav-logo nav-logo2" src="../assets/logo.svg" ></a>
            </div>

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
                    <%
                        if (role.equalsIgnoreCase("member")) {
                    %>
                    <form class="button-nav-form" action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <button type="submit" value="My Account"  class="button"/>My Account</button>
                    </form>
                    <%    } else if (role.equalsIgnoreCase("admin")) { %>
                    <form class="button-nav-form"  action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <button type="submit" value="ADMIN"  class="button"/>ADMIN</button>
                    </form>
                    <% }%>  

                </div>
            </div>
        </div>

        <section class="personal-records-section-1">
            <div class="personal-records-container">
                <h3> View Personal Record </h3>
                <form class="personal-records-info-container0" action="/">

                    <div class='personal-records-profile-container'>
                        <span class="material-icons personal-records-photo">
                            account_circle
                        </span>

                        <span class='name-container'>
                            <span class='name'>${name}</span>
                            <span class='dpt'>${course}</span>
                        </span>

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Email:</label>
                        <input type='email' id='email' name='email' value='${email}' readonly> 

                    </div>

                    <div class='personal-records-info-container1'> 
                        <label for=''>Username:</label>

                        <div class='personal-records-edit'>
                            <input type='text' id='uname' name='uname' value='${username}' readonly> 
                            <span class="material-icons edit-icon">
                                edit
                            </span>
                        </div>

                    </div>


                    <div class='personal-records-info-container1'> 
                        <label for=''>Password:</label>
                        <div class='personal-records-edit'>
                            <input type='password' id='password' name='password' value='${password}' readonly> 
                            <span class="material-icons edit-icon">
                                edit
                            </span>
                        </div>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Age:</label>
                        <input type='text' id='age' name='age' value='${age}' readonly> 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Birthday</label>
                        <input type='text' id='birthday' name='birthday' value='${birthday}' readonly> 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Gender:</label>
                        <input type='text' id='gender' name='gender' value='${gender}' readonly> 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Student Number:</label>
                        <input type='text' id='studentnum' name='studentnum' value='${snumber}' readonly> 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Favorite Game:</label>
                        <input type='text' id='favgame' name='favgame' value='${favgame}' readonly> 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Contact Number:</label>
                        <input type='text' id='contactnum' name='contactnum' value='${cnumber}' readonly> 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Address:</label>
                        <input type='text' id='address' name='address' value='${address}' readonly> 

                    </div>


                    <span class='verification-container'>
                        <span class="material-icons verification-icon" style="color:green;">
                            check_circle
                        </span> 
                        Your account has been verified.
                    </span>

                    <div class="personal-records-buttons"> 
                        <%
                            if (role.equalsIgnoreCase("member")) {
                        %>
                        <button type="button" onclick="location.href = 'profile-page.jsp';" value="GO BACK" class="button" >GO BACK</button>
                        <%
                        } else if (role.equalsIgnoreCase("admin")) {
                        %>
                        <button type="button" onclick="location.href = 'profile-page-admin.jsp';" value="GO BACK" class="button" />GO BACK</button>
                        <%}%>
                        <button type="button" id="modalBtn" value="GENERATE PDF" class="button" />GENERATE PDF</button>
                        <button type="button" onclick="location.href = '../LogoutServlet';" value="LOGOUT" class="button" />LOGOUT</button>
                    </div>   
                </form> 
            </div>
        </section>

        <section id="modalSection" class="modal-section">
            <div class="modal-content">
                <h3 class="modal-header">SUCCESS!</h3>
                <p class="modal-msg">Your PDF has been generated.</p>   
                <span class="modal-buttoncon">
                    <!--                        <span onclick="Home()" class="close modal-button">Home</span>-->
                    <form method="POST" action ="../PDFServlet">
                        <button class="modal-button"  name="pdfbutton" value="ownpdf">Download PDF</button>
                    </form>
                </span>
            </div>
        </section>
    </body>
</html>
