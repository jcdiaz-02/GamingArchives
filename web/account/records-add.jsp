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
                    <form class="button-nav-form"  style="color:#B92432;" action="../MyAccountServlet">
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

        <section class="personal-records-section-2">
            <div class="personal-records-container">
                <h3> Add Record</h3>
                <form class="personal-records-info-container0" action="/">

                    <!--                    <div class='personal-records-profile-container'>
                                            <span class="material-icons personal-records-photo">
                                                account_circle
                                            </span>
                                            
                                            <span class='name-container'>
                                                <span class='name'>NAME</span>
                                                <span class='dpt'>COMPUTER SCIENCE</span>
                                            </span>
                    
                                        </div>-->

                    <div class='personal-records-info-container1'>
                        <label for=''>Email:</label>
                        <input type='email' id='email' name='email' placeholder='email (ust.edu.ph)'> 

                    </div>

                    <div class='personal-records-info-container1'> 
                        <label for=''>Username:</label>

                        <input type='text' id='uname' name='uname' placeholder='username'> 
                        <!--                        <span class="material-icons edit-icon">
                                                    edit
                                                </span>-->

                    </div>


                    <div class='personal-records-info-container1'>
                        <label for=''>Name:</label>
                        <input type='text' id='name' name='email' placeholder='Juan Dela Cruz' > 

                    </div>


                    <div class='personal-records-info-container1'>
                        <label for=''>Course:</label>
                        <input type='text' id='course' name='email' placeholder='Computer Science' > 

                    </div>


                    <div class='personal-records-info-container1'>
                        <label for=''>Age:</label>
                        <input type='number' id='age' name='age' placeholder='00'> 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Birthday</label>
                        <input type='date' id='birthday' name='birthday' placeholder='2001-01-01' > 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Gender:</label>
                        <input type='text' id='gender' name='gender' placeholder='male' > 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Student Number:</label>
                        <input type='number' id='studentnum' name='studentnum' placeholder='2019123456' > 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Favorite Game:</label>
                        <input type='text' id='favgame' name='favgame' placeholder='among us' > 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Contact Number:</label>
                        <input type='number' id='contactnum' name='contactnum' placeholder='09161234567'> 

                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Address:</label>
                        <input type='text' id='address' name='address' placeholder='address' > 

                    </div>




                    <!--                    <span class='verification-container'>
                                            <span class="material-icons verification-icon" style="color:green;">
                                                check_circle
                                            </span> 
                                            Your account has been verified.
                                        </span>-->

                    <div class="personal-records-buttons"> 
                        <input type="button" onclick="location.href = '../account/profile-page.jsp';" value="GO BACK" class="button" />
                        <input type="submit" id="modalBtn" value="SAVE" class="button" />
                        <input type="button" onclick="location.href = '../home.jsp';" value="LOGOUT" class="button" />
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
                    <span onclick="Home()" class="modal-button">Download</span> 
                </span>
            </div>
        </section>
    </body>
</html>
