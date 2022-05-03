<%-- 
    Document   : all-records
    Created on : 03 19, 22, 3:57:41 AM
    Author     : Admin
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    String driver = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://gamingarchives.mysql.database.azure.com:3306/gamingarchives?useSSL=false&serverTimezone=UTC";
    String username = "gamingarchivesAdmin";
    String password = "zt.sw9\"D6`VjBnhh";
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="../assets/logo.svg">
        <link rel="stylesheet" href="../assets/css/asset-sheet.css">
        <link rel="stylesheet" href="../assets/css/navbar-style.css">
        <link rel="stylesheet" href="../assets/css/records-all-style.css">
        <link rel="stylesheet" href="../assets/css/modal-style.css">


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
                <a href="home.jsp"><img class="nav-logo nav-logo2" src="../assets/logo.svg" ></a>
            </div>

            <div class="nav-content">
                <div class="nav-title">
                    <img class="nav-logo" src="../assets/logo.svg" alt="UST-TGS logo">
                    <a class="" href="../home.jsp"> 
                        <h1>UST Thomasian Gaming Society</h1>
                    </a>
                </div>
                <div class="nav-options" >
                    <a class="option" href="../home.jsp">Home</a>
                    <a class="option" href="../subpage/about.jsp">About</a>
                    <a class="option" href="../subpage/events.jsp">Events</a>
                    <a class="option" href="../subpage/contact.jsp">Contact</a>
                    <form class="button-nav-form" action="../login/login.jsp">
                        <input type="hidden" name="verify" value="${verify}" />
                        <button type="submit" value="ADMIN"  class="button"/>ADMIN</button>
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
        <section class="all-records-section">
            <div class="all-records-container">
                <div class="all-records-head">
                    <h2>All Records</h2>          
                </div>
                <div class="table-container">
                    <table class="records-table">
                        <tr>
                            <th>Name</th>
                            <th>Course</th>
                            <th>Email</th>
                            <th>Username</th>

                            <th>Age</th>
                            <th>Birthday</th>
                            <th>Gender</th>
                            <th>Student Number</th>
                            <th>Favorite Game</th>
                            <th>Contact Number</th>
                            <th>Address</th>
                            <th>Verification</th>
                        </tr>
                        <%
                            try {
                                conn = DriverManager.getConnection(url, username, password);
                                String query = "SELECT * FROM APP.USERDB";
                                PreparedStatement pstmt = conn.prepareStatement(query);
                                ResultSet records = pstmt.executeQuery();
                                while (records.next()) {
                        %>
                        <tr>
                            <td>null</td>
                            <td>null</td>
                            <td><%=records.getString("EMAIL")%></td>
                            <td><%=records.getString("USERNAME")%></td>
                            <td>null</td>
                            <td>null</td>
                            <td>null</td>
                            <td>null</td>
                            <td>null</td>
                            <td>null</td>
                            <td>null</td>
                            <td>UNVERIFIED</td>	 
                        </tr>
                        <%
                            }
                            String query1 = "SELECT * FROM APP.VERIFIEDDB";
                            pstmt = conn.prepareStatement(query1);
                            records = pstmt.executeQuery();
                            while (records.next()) {

                        %>
                        <tr>
                            <td><%=records.getString("NAME")%></td>
                            <td><%=records.getString("COURSE")%></td>
                            <td><%=records.getString("EMAIL")%></td>
                            <td><%=records.getString("USERNAME")%></td>
                            <td><%=records.getString("AGE")%></td>
                            <td><%=records.getString("BIRTHDAY")%></td>
                            <td><%=records.getString("GENDER")%></td>
                            <td><%=records.getString("STUDENTNUMBER")%></td>
                            <td><%=records.getString("FAVORITEGAME")%></td>
                            <td><%=records.getString("CONTACTNUMBER")%></td>
                            <td><%=records.getString("ADDRESS")%></td>
                            <td>VERIFIED</td>	 
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }%>

                    </table>
                </div>       

                <div class="all-records-buttons"> 
                    <span class='all-records-buttons1'>
                        <form  action="profile-page-admin.jsp">
                            <button type="submit" value="GO BACK"  class="button">GO BACK</button>
                        </form>
                        <form onclick ="deleteOpenForm()">
                            <button class="button" onclick="">DELETE</button>
                        </form>
                        <form onclick="verifyOpenForm()" >
                            <button class="button"  onclick="verifyOpenForm()">VERIFY </button>
                        </form>
                    </span>
                    <span class='all-records-buttons2'>
                        <form onclick="openForm()" >
                            <button class="button"  onclick="openForm()">UPDATE</button>
                        </form>
                        <button id="modalBtn"  class="button"/>GENERATE PDF</button>

                        <form  action="../LogoutServlet">
                            <button type="submit" value="LOGOUT"  class="button"/>LOGOUT</button>
                        </form>
                    </span>

                </div>      
            </div>
        </section>


        <div id="deleteForm" class="modal-section">
            <form action="../DeleteRecordServlet" class="modal-content">
                <h3 class="modal-header">Delete Record</h3>
                <%
                    session.setAttribute("ident", "all");
                %>
                <label class="modal-msg" for="uname"><b>Username of record being deleted</b></label>
                <input class="modal-input" type="text" placeholder="Enter Username" name="uname" required>

                <span class="modal-buttoncon"> 
                    <button  class="close modal-button" type="button" class="cancel" onclick="deleteCloseForm()">Cancel</button>
                    <button  class="modal-button"  type="submit" class="submit">Submit</button>
                </span>
            </form>
        </div>

        <div id="verifyForm" class="modal-section">
            <form action="../TransferRecordServlet" class="modal-content">
                <h3 class="modal-header">Verify Record</h3>
                <%
                    session.setAttribute("ident", "all");
                %>
                <label class="modal-msg" for="uname"><b>Username of record being verified</b></label>
                <input class="modal-input"  type="text" placeholder="Enter Username" name="uname" required>
                <span class="modal-buttoncon"> 
                    <button class="close modal-button" type="button" class="cancel" onclick="verifyCloseForm()">Cancel</button>
                    <button class="modal-button" type="submit" class="submit">Submit</button>

                </span>
            </form>
        </div>

        <div id="myForm" class="modal-section" >
            <form action="records-update.jsp" class="modal-content">
                <h3 class="modal-header">Update Record</h3>

                <label class="modal-msg" for="uname"><b>Username of record being updated </b>  <b> (verified usernames only) </b></label>
                <input class="modal-input" type="text" placeholder="Enter Username" name="uname" required>
                <span class="modal-buttoncon"> 
                    <button class="close modal-button" type="button" class="cancel" onclick="closeForm()">Cancel</button>
                    <button class="modal-button" type="submit" class="submit">Submit</button>
                </span>
            </form>
        </div>

        <section id="modalSection" class="modal-section">
            <div class="modal-content">
                <h3 class="modal-header">SUCCESS!</h3>
                <p class="modal-msg">Your PDF has been generated.</p>   
                <form class="modal-buttoncon" method="POST" action ="../PDFServlet">
                    <button class="modal-button"  name="pdfbutton" value="alluserpdf">Download PDF</button>
                </form>
            </div>"
        </section> 

        <!--        <section id="modalSection" class="modal-section">
                    <div class="modal-content">
                        <h3 class="modal-header">ARE YOU SURE?</h3>
                        <p class="modal-msg">Please confirm that you have selected the correct event/s. You cannot reverse this action after pressing the delete button.</p>
                        <span class="modal-buttoncon">
                            <span onclick="Close()" class="close modal-button">Cancel</span>
                            <span class="modal-button">Delete</span> 
                        </span>
                    </div>
                </section>-->
        <script>
            function openForm() {
                event.preventDefault();
                document.getElementById("myForm").style.display = "block";
            }
            ;
            function closeForm() {
                event.preventDefault();
                document.getElementById("myForm").style.display = "none";

            }
            ;
            function verifyOpenForm() {
                event.preventDefault();
                document.getElementById("verifyForm").style.display = "block";
            }
            ;
            function verifyCloseForm() {
                event.preventDefault();
                document.getElementById("verifyForm").style.display = "none";
            }
            ;
            function deleteOpenForm() {
                event.preventDefault();
                document.getElementById("deleteForm").style.display = "block";
            }
            ;
            function deleteCloseForm() {
                event.preventDefault();
                document.getElementById("deleteForm").style.display = "none";
            }
            ;

            window.onclick = function (event) {
                if (event.target === document.getElementById("myForm")) {
                    document.getElementById("myForm").style.display = "none";
                }
            };

        </script>
    </body>
</html>
