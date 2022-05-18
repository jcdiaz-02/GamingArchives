<%-- 
    Document   : addRecordAdmin
    Created on : 03 16, 22, 12:46:41 AM
    Author     : Admin
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>

<!DOCTYPE html>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="../assets/logo.svg">
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
            <input type="checkbox" id="check">
            <label for="check" class="checkbtn">
                <i class="fas fa-bars"></i>
            </label>

            <div class="logo-container" >
                <a href="../subpage/authenticatedHome.jsp"><img class="nav-logo nav-logo2" src="../assets/logo.svg" ></a>
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
                    <form class="button-nav-form" style="color:#B92432;" action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <button type="submit" value="ADMIN"  class="button"/>ADMIN</button>
                    </form>

                </div>
            </div>
        </div>

        <section class="personal-records-section-2">
            <div class="personal-records-container">
                <h3> Add Record</h3>
                <form class="personal-records-info-container0" method="POST" action="../UpdateRecordServlet">
                    ${sessionScope.notif}

                    <div class='personal-records-info-container1'>
                        <label for=''>Email:</label>
                        <input required  pattern="[a-z0-9._%+-]+@ust.edu.ph$" type="text" placeholder="Enter Email (@ust.edu.ph)" name="email"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Name:</label>
                        <input required type="text" placeholder="Enter Name" name="myname"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Username:</label>
                        <input required type="text" placeholder= "Enter Username (minimum of 5 characters)" name="uname" minlength="5"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Password:</label>
                        <input required type="text" placeholder="Enter Password (minimum of 8 characters)" name="pass" minlength="8"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Course:</label>
                        <select id="course" name="course">
                            <option value="Computer Science">Computer Science</option>
                            <option value="Information Technology">Information Technology</option>
                            <option value="Data Science">Data Science</option>
                        </select><br>
                    </div>


                    <div class='personal-records-info-container1'>
                        <label for=''>Birthday(Age reflects given birth date):</label>
                        <input required type="date" placeholder="Enter Birthday" name="birthday"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label>Gender: </label>
                        <select id="gender" name="gender">
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                        </select><br>
                    </div>


                    <div class='personal-records-info-container1'>
                        <label for=''>Student Number:</label>
                        <input required type="number" placeholder="Enter Student Number" name="snumber" minlength="10" maxlength="10"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label>Contact Number: </label>
                        <input required type="number" placeholder="Enter Contact Number(+63)" name="cnumber" minlength="10" maxlength="10"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label>Favorite Game: </label>
                        <input required type="text" placeholder="Enter Favorite Game" name="favgame"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                       <label>Address: </label>
                       <input required type="text" placeholder="Enter Address" name="address"><br>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label>Role: </label>
                        <select id="userrole" name="userrole">
                            <option value="member">Member</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>

                    <div class='personal-records-info-container1'>
                        <label>Status: </label>
                        <select id="userrole" name="status">
                            <option value="student">Student</option>
                            <option value="alumni">Alumni</option>
                        </select>
                    </div>


                    <div class="personal-records-buttons"> 
                        <button onclick="location.href = 'profile-page-admin.jsp';" value="GO BACK" class="button" >GO BACK</button>

                        <button type="submit" name="recbutton" value="add" class ="button">SAVE</button>

                        <button type="button" onclick="location.href = '../LogoutServlet';" value="LOGOUT" class="button" >LOGOUT</button>  
                    </div>   

                </form>

                <%
                    session.removeAttribute("notif");
                %>

            </div>
        </section>       
    </body>
</html>
