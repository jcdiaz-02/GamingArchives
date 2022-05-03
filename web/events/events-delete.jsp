<%-- 
    Document   : events-delete
    Created on : 03 13, 22, 2:16:56 AM
    Author     : Admin
--%>
<%@page import="java.util.List" %>
<%@page import="EventsRecordKeeper.EventRecord" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="../assets/logo.svg">
        <link rel="stylesheet" href="../assets/css/asset-sheet.css">
        <link rel="stylesheet" href="../assets/css/navbar-style.css">
        <link rel="stylesheet" href="../assets/css/events-all-style.css">
        <link rel="stylesheet" href="../assets/css/modal-style.css">


        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Amaranth&family=Quicksand&family=VT323&family=Poppins&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide&effect=anaglyph">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Press+Start+2P&effect=anaglyph">

        <script src="../assets/scripts/sort-table.js"></script>   
        <!--        <script language="JavaScript" type="text/javascript" src="/js/jquery-1.2.6.min.js"></script>
                <script language="JavaScript" type="text/javascript" src="/js/jquery-ui-personalized-1.5.2.packed.js"></script>-->
        <script language="JavaScript" type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
        <script language="JavaScript" type="text/javascript" src="../assets/scripts/modal.js"></script>

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">

        <script src="https://kit.fontawesome.com/db09b338f9.js" crossorigin="anonymous"></script>
        <title>UST-TGS</title>
        <% List<EventRecord> recordList = (List) session.getAttribute("eventList");
        %>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
            String role = (String) session.getAttribute("role");

            if (!role.equalsIgnoreCase("admin")) {
                response.sendRedirect("../home.jsp");
            }
        %>
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
                <div class="nav-options">
                    <a class="option" href="../subpage/authenticatedHome.jsp">Home</a>
                    <a class="option" href="../subpage/authenticatedAbout.jsp">About</a>
                    <a class="option" style="color:#B92432;" href="../EventOverview">Events</a>
                    <a class="option" href="../subpage/authenticatedContacts.jsp">Contact</a>
                    <form class="button-nav-form" action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <button type="submit" value="ADMIN"  class="button"/>ADMIN</button>
                    </form>

                </div>
            </div>
        </div>

        <section class="all-events-section">
            <div class="all-events-container">
                <div class="all-events-head">
                    <h2>Delete Event</h2>          
                </div>

                <div class="table-container">
                    <table class="events-table js-sort-table">
                        <tr>
                            <th class="event-id">Event ID</th>
                            <th>Event Name</th> 
                            <th>Event Description</th>
                            <th>Event Date</th>
                            <th>Select</th>
                        </tr>
                        <% for (int i = 0; i < recordList.size(); i++) {%>
                        <tr>
                            <% try {%>
                            <td>
                                <%= recordList.get(i).getId()%>
                            </td>
                            <td>
                                <%= recordList.get(i).getName()%>
                            </td>
                            <td>
                                <%= recordList.get(i).getDescription()%>
                            </td>
                            <td>
                                <%= recordList.get(i).getDate()%>
                            </td>
                            <td>
                                <form id="myform" action="../DeleteEvent"  method="get">
                                    <label class="checkbox-container">
                                        <input form="myform" type="checkbox" id="rows" name="selectedRows" value="<%= recordList.get(i).getId()%>">
                                        <span class="checkmark"></span>
                                    </label>
                                </form>
                            </td>
                        </tr>
                        <%  } catch (Exception e) {
                                }
                            }%>

                    </table>
                </div>       

                <div class="all-event-buttons"> 
                    <form  action="../subpage/events.jsp">
                        <button type="submit" value="GO BACK"  class="button"/>GO BACK</button>
                    </form>
                    <button id="modalBtn"  class="button"/>DELETE</button>



                    <form  action="../login/login.jsp">
                        <button type="submit" value="LOGOUT"  class="button"/>LOGOUT</button>
                    </form>
                </div>                      
            </div>

        </section>


        <section id="modalSection" class="modal-section">
            <div class="modal-content">
                <h3 class="modal-header">ARE YOU SURE?</h3>
                <p class="modal-msg">Please confirm that you have selected the correct event/s. You cannot reverse this action after pressing the delete button.</p>
                <span class="modal-buttoncon">
                    <span onclick="Close()" class="close modal-button">Cancel</span>
                    <span  onclick="document.getElementById('myform').submit()"class="modal-button">Delete</span> 
                </span>
            </div>
        </section>


    </body>


</html>
