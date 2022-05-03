<%-- 
    Document   : personal-record-0
    Created on : 03 20, 22, 1:17:02 AM
    Author     : Admin
--%>


<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                    <form class="button-nav-form" style="color:#B92432;" action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <button type="submit" value="ADMIN"  class="button"/>ADMIN</button>
                    </form>

                </div>
            </div>
        </div>
        <%
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
            String sessionuname = (String) session.getAttribute("username");

            String role = (String) session.getAttribute("role");
            if (sessionuname == null) {
                response.sendRedirect("home.jsp");
            }
        %>
        <section class="personal-records-section-2">
            <div class="personal-records-container">
                <%
                    try {
                        conn = DriverManager.getConnection(url, username, password);

                        String uname = request.getParameter("uname");
                        session.setAttribute("primaryusername", uname);
                        String query = "SELECT * FROM APP.VERIFIEDDB where USERNAME=?";
                        PreparedStatement pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, uname);
                        ResultSet records = pstmt.executeQuery();
                        if (records.next() == false) {
                            response.sendRedirect("records-all.jsp");
                        } else {
                            do {
                                System.out.println("");

                %>
                <h3> Update Record</h3>
                <form class="personal-records-info-container0" method="POST" action="../UpdateRecordServlet">
                    <div class="personal-records-info-container1">
                        <label for=''>Email:</label>
                        <input type="email" placeholder="<%=records.getString("EMAIL")%>" name="email">
                    </div>

                    <div class="personal-records-info-container1">
                        <label for=''>Username:</label>
                        <input type="text" placeholder="<%=records.getString("USERNAME")%>" name="uname">
                    </div>

                    <div class="personal-records-info-container1">
                        <label for=''>Password:</label>
                        <input type="text" placeholder="Password" name="pass">
                    </div>

                    <div class="personal-records-info-container1">
                        <label for=''>Name:</label>
                        <input type="text" placeholder="<%=records.getString("NAME")%>" name="myname">
                    </div>
                    <div class="personal-records-info-container1">
                        <label for=''>Course:</label>
                        <input type="text" placeholder="<%=records.getString("COURSE")%>" name="course">
                    </div>

                    <div class="personal-records-info-container1">
                        <label for=''>Age:</label>
                        <input type="number" placeholder="<%=records.getString("AGE")%>" name="age">
                    </div>

                    <div class="personal-records-info-container1">

                        <label for=''>Birthday</label><input type="date" placeholder="<%=records.getString("BIRTHDAY")%>" name="birthday">
                    </div>

                    <div class='personal-records-info-container1'>
                        <label for=''>Gender:</label>
                        <select id="gender" name="gender">
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                        </select><br>
                    </div>

                    <div class="personal-records-info-container1">
                        <label for=''>Student Number:</label>
                        <input type="number" placeholder="<%=records.getString("STUDENTNUMBER")%>" name="snumber">
                    </div>

                    <div class="personal-records-info-container1">
                        <label for=''>Favorite Game:</label>
                        <input type="text" placeholder="<%=records.getString("FAVORITEGAME")%>" name="favgame">
                    </div>

                    <div class="personal-records-info-container1">
                        <label for=''>Contact Number:</label>
                        <input type="number" placeholder="<%=records.getString("CONTACTNUMBER")%>" name="cnumber">
                    </div>

                    <div class="personal-records-info-container1">
                        <label for=''>Address:</label>
                        <input type="text" placeholder="<%=records.getString("ADDRESS")%>" name="homeaddress">
                    </div>
                    <div class="personal-records-info-container1">
                        <label for=''>Role:</label>
                        <select id="userrole" name="userrole">
                            <option value="member">Member</option>
                            <option value="admin">Admin</option>
                        </select>
                        <!--<h1>Role: </h1><input type="text" placeholder="<%//=records.getString("ROLE")%>" name="userrole">-->
                    </div>

                    <div class="personal-records-buttons"> 
                        <button type="button" onclick="location.href = 'records-all.jsp';" value="GO BACK" class="button" />GO BACK</button>

                        <button type="submit" id="modalBtn" name="recbutton" value="update" class="button" />UPDATE</button>

                        <button type="button" onclick="location.href = '../LogoutServlet';" class="button"> LOGOUT</button>
                    </div>   
                    <%
                                } while (records.next());

                            }
                            records.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }%>

                </form> 
            </div>
        </section>
    </body>
</html>
