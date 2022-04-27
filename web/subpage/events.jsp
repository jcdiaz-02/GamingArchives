<%-- 
    Document   : events
    Created on : 03 6, 22, 6:53:20 PM
    Author     : Admin
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="EventsRecordKeeper.EventRecord;"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="../assets/logo.svg">
        <link rel="stylesheet" href="../assets/css/asset-sheet.css">
        <link rel="stylesheet" href="../assets/css/navbar-style.css">
        <link rel="stylesheet" href="../assets/css/events-style.css">
        <link rel="stylesheet" href="../assets/css/calendar-style.css">

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
        <%
            List<EventRecord> recordList = (List) session.getAttribute("eventList");
            String datenow = java.time.LocalDate.now().toString();
        %>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
            String role = (String) session.getAttribute("role");
            if (role == null) {
                role = "guest";
            }
        %>
        <!-- TODO: ALLOW TO ACCESS DATABASE FOR CALENDAR -->
        <!-- TODO: ALLOW TO ACCESS DATABASE ITEMS TO LIST PLANNED AND ORGANIZED EVENTS -->
        <!-- TODO: MAKE ADD AND DELETE BUTTONS ONLY AVAILABLE TO ADMIN -->
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
                    <%
                        if (role.equalsIgnoreCase("member")) {
                    %>
                    <a class="option" href="authenticatedHome.jsp">Home</a>
                    <a class="option" href="authenticatedAbout.jsp">About</a>
                    <a class="option" style="color:#B92432;" href="../EventOverview">Events</a>
                    <a class="option" href="authenticatedContacts.jsp">Contact</a>
                    <form action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <input type="submit" value="My Account"  class="button"/>
                    </form>
                    <%    } else if (role.equalsIgnoreCase("admin")) { %>
                    <a class="option" href="authenticatedHome.jsp">Home</a>
                    <a class="option" href="authenticatedAbout.jsp">About</a>
                    <a class="option" style="color:#B92432;" href="../EventOverview">Events</a>
                    <a class="option" href="authenticatedContacts.jsp">Contact</a>
                    <form action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <input type="submit" value="ADMIN"  class="button"/>
                    </form>
                    <% } else {%> 
                    <a class="option" href="../home.jsp">Home</a>
                    <a class="option" href="../subpage/about.jsp">About</a>
                    <a class="option" style="color:#B92432;" href="../EventOverview">Events</a>
                    <a class="option" href="../subpage/contact.jsp">Contact</a>
                    <form class="button-nav-form" action="../login/login.jsp">
                        <input type="submit" value="Login"  class="button"/>
                    </form>
                    <%}%>

                </div>
            </div>
        </div>


        <section class="events-section">
            <div class="events-container">
                <div class="events-list-container">
                    <h2>Planned Events</h2>
                    <ul class="planned-events">
                        <%
                            
                            for (int i = 0; i < recordList.size(); i++) {
                                try {
                                    DateTimeFormatter f = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                    LocalDate eventDate = LocalDate.parse(recordList.get(i).getDate(), f);
                                    LocalDate currentDate = LocalDate.parse(datenow, f);
                                    if (eventDate.isAfter(currentDate)) {
                                        out.println("<li>" + recordList.get(i).getName() + "</li>");
                                    }
                                } catch (Exception e) {
                                }
                            }
                        %>
                    </ul>
                </div>

                <div class="events-list-container">
                    <h2>Organized Events</h2>
                    <ul class="organized-events">
                        <%
                            for (int i = 0; i < recordList.size(); i++) {
                        %>
                        <li>
                            <% try {
                                    
                               
                            %>
                            <div>
                                <p><%= recordList.get(i).getName()%></p>
                                <%if (recordList.get(i).getImgURL().contains("Images")) {
                                        out.println("<img src=" + "\"../" + recordList.get(i).getImgURL() + "\">");
                                    }%>
                            </div>
                            <% } catch (Exception e) {
                                }%>
                        </li>    
                        <% }%>
                    </ul>
                </div>  

                <div class="upcoming-events-container">
                    <h2>Upcoming Events</h2>
                    <%
                        if (role.equalsIgnoreCase("admin")) {
                    %>
                    <h3><a href="../ViewAllEvent">View All Events</a></h3>
                    <%}%>
                    <div class="calendar-container"><div id="calendar"></div></div>
                        <%

                            if (role.equalsIgnoreCase("admin")) {
                        %>
                    <div class="event-buttons"> 
                        <form  action="../events/events-add.jsp">
                            <input type="submit" value="Add Event"  class="button"/>
                        </form>
                        <form  action="../events/events-delete.jsp">
                            <input type="submit" value="Delete Event"  class="button"/>
                        </form>
                    </div>
                    <% }%>
                </div>
            </div>     
        </section>

        <script language="JavaScript" type="text/javascript">
            !function () {
                var today = moment();

                function Calendar(selector, events) {
                    this.el = document.querySelector(selector);
                    this.events = events;
                    this.current = moment().date(1);
                    this.draw();
                    var current = document.querySelector('.today');
                    if (current) {
                        var self = this;
                        window.setTimeout(function () {
                            self.openDay(current);
                        }, 500);
                    }
                }

                Calendar.prototype.draw = function () {
                    //Create Header
                    this.drawHeader();

                    //Draw Month
                    this.drawMonth();

                    this.drawLegend();
                };

                Calendar.prototype.drawHeader = function () {
                    var self = this;
                    if (!this.header) {
                        //Create the header elements
                        this.header = createElement('div', 'header');
                        this.header.className = 'header';

                        this.title = createElement('h1');

                        var right = createElement('div', 'right');
                        right.addEventListener('click', function () {
                            self.nextMonth();
                        });

                        var left = createElement('div', 'left');
                        left.addEventListener('click', function () {
                            self.prevMonth();
                        });

                        //Append the Elements
                        this.header.appendChild(this.title);
                        this.header.appendChild(right);
                        this.header.appendChild(left);
                        this.el.appendChild(this.header);
                    }

                    this.title.innerHTML = this.current.format('MMMM YYYY');
                };

                Calendar.prototype.drawMonth = function () {
                    var self = this;

                    this.events.forEach(function (ev) {
                        ev.date = moment(ev.date);
                    });


                    if (this.month) {
                        this.oldMonth = this.month;
                        this.oldMonth.className = 'month out ' + (self.next ? 'next' : 'prev');
                        this.oldMonth.addEventListener('webkitAnimationEnd', function () {
                            self.oldMonth.parentNode.removeChild(self.oldMonth);
                            self.month = createElement('div', 'month');
                            self.backFill();
                            self.currentMonth();
                            self.fowardFill();
                            self.el.appendChild(self.month);
                            window.setTimeout(function () {
                                self.month.className = 'month in ' + (self.next ? 'next' : 'prev');
                            }, 16);
                        });
                    } else {
                        this.month = createElement('div', 'month');
                        this.el.appendChild(this.month);
                        this.backFill();
                        this.currentMonth();
                        this.fowardFill();
                        this.month.className = 'month new';
                    }
                };

                Calendar.prototype.backFill = function () {
                    var clone = this.current.clone();
                    var dayOfWeek = clone.day();

                    if (!dayOfWeek) {
                        return;
                    }

                    clone.subtract(dayOfWeek + 1, 'days');

                    for (var i = dayOfWeek; i > 0; i--) {
                        this.drawDay(clone.add(1, 'days'));
                    }
                };

                Calendar.prototype.fowardFill = function () {
                    var clone = this.current.clone().add(1, 'months').subtract(1, 'days');
                    var dayOfWeek = clone.day();

                    if (dayOfWeek === 6) {
                        return;
                    }

                    for (var i = dayOfWeek; i < 6; i++) {
                        this.drawDay(clone.add(1, 'days'));
                    }
                };

                Calendar.prototype.currentMonth = function () {
                    var clone = this.current.clone();

                    while (clone.month() === this.current.month()) {
                        this.drawDay(clone);
                        clone.add(1, 'days');
                    }
                };

                Calendar.prototype.getWeek = function (day) {
                    if (!this.week || day.day() === 0) {
                        this.week = createElement('div', 'week');
                        this.month.appendChild(this.week);
                    }
                };

                Calendar.prototype.drawDay = function (day) {
                    var self = this;
                    this.getWeek(day);

                    //Outer Day
                    var outer = createElement('div', this.getDayClass(day));
                    outer.addEventListener('click', function () {
                        self.openDay(this);
                    });

                    //Day Name
                    var name = createElement('div', 'day-name', day.format('ddd'));

                    //Day Number
                    var number = createElement('div', 'day-number', day.format('DD'));


                    //Events
                    var events = createElement('div', 'day-events');
                    this.drawEvents(day, events);

                    outer.appendChild(name);
                    outer.appendChild(number);
                    outer.appendChild(events);
                    this.week.appendChild(outer);
                };

                Calendar.prototype.drawEvents = function (day, element) {
                    if (day.month() === this.current.month()) {
                        var todaysEvents = this.events.reduce(function (memo, ev) {
                            if (ev.date.isSame(day, 'day')) {
                                memo.push(ev);
                            }
                            return memo;
                        }, []);

                        todaysEvents.forEach(function (ev) {
                            var evSpan = createElement('span', ev.color);
                            element.appendChild(evSpan);
                        });
                    }
                };

                Calendar.prototype.getDayClass = function (day) {
                    classes = ['day'];
                    if (day.month() !== this.current.month()) {
                        classes.push('other');
                    } else if (today.isSame(day, 'day')) {
                        classes.push('today');
                    }
                    return classes.join(' ');
                };

                Calendar.prototype.openDay = function (el) {
                    var details, arrow;
                    var dayNumber = +el.querySelectorAll('.day-number')[0].innerText || +el.querySelectorAll('.day-number')[0].textContent;
                    var day = this.current.clone().date(dayNumber);

                    var currentOpened = document.querySelector('.details');

                    //Check to see if there is an open detais box on the current row
                    if (currentOpened && currentOpened.parentNode === el.parentNode) {
                        details = currentOpened;
                        arrow = document.querySelector('.arrow');
                    } else {
                        //Close the open events on differnt week row
                        //currentOpened && currentOpened.parentNode.removeChild(currentOpened);
                        if (currentOpened) {
                            currentOpened.addEventListener('webkitAnimationEnd', function () {
                                currentOpened.parentNode.removeChild(currentOpened);
                            });
                            currentOpened.addEventListener('oanimationend', function () {
                                currentOpened.parentNode.removeChild(currentOpened);
                            });
                            currentOpened.addEventListener('msAnimationEnd', function () {
                                currentOpened.parentNode.removeChild(currentOpened);
                            });
                            currentOpened.addEventListener('animationend', function () {
                                currentOpened.parentNode.removeChild(currentOpened);
                            });
                            currentOpened.className = 'details out';
                        }

                        //Create the Details Container
                        details = createElement('div', 'details in');

                        //Create the arrow
                        var arrow = createElement('div', 'arrow');

                        //Create the event wrapper

                        details.appendChild(arrow);
                        el.parentNode.appendChild(details);
                    }

                    var todaysEvents = this.events.reduce(function (memo, ev) {
                        if (ev.date.isSame(day, 'day')) {
                            memo.push(ev);
                        }
                        return memo;
                    }, []);

                    this.renderEvents(todaysEvents, details);

                    arrow.style.left = el.offsetLeft - el.parentNode.offsetLeft + 27 + 'px';
                };

                Calendar.prototype.renderEvents = function (events, ele) {
                    //Remove any events in the current details element
                    var currentWrapper = ele.querySelector('.events');
                    var wrapper = createElement('div', 'events in' + (currentWrapper ? ' new' : ''));

                    events.forEach(function (ev) {
                        var div = createElement('div', 'event');
                        var square = createElement('div', 'event-category ' + ev.color);
                        var span = createElement('span', '', ev.eventName);

                        div.appendChild(square);
                        div.appendChild(span);
                        wrapper.appendChild(div);
                    });

                    if (!events.length) {
                        var div = createElement('div', 'event empty');
                        var span = createElement('span', '', 'No Events');

                        div.appendChild(span);
                        wrapper.appendChild(div);
                    }

                    if (currentWrapper) {
                        currentWrapper.className = 'events out';
                        currentWrapper.addEventListener('webkitAnimationEnd', function () {
                            currentWrapper.parentNode.removeChild(currentWrapper);
                            ele.appendChild(wrapper);
                        });
                        currentWrapper.addEventListener('oanimationend', function () {
                            currentWrapper.parentNode.removeChild(currentWrapper);
                            ele.appendChild(wrapper);
                        });
                        currentWrapper.addEventListener('msAnimationEnd', function () {
                            currentWrapper.parentNode.removeChild(currentWrapper);
                            ele.appendChild(wrapper);
                        });
                        currentWrapper.addEventListener('animationend', function () {
                            currentWrapper.parentNode.removeChild(currentWrapper);
                            ele.appendChild(wrapper);
                        });
                    } else {
                        ele.appendChild(wrapper);
                    }
                };

//            Calendar.prototype.drawLegend = function() {
//              var legend = createElement('div', 'legend');
//              var calendars = this.events.map(function(e) {
//                return e.calendar + '|' + e.color;
//              }).reduce(function(memo, e) {
//                if(memo.indexOf(e) === -1) {
//                  memo.push(e);
//                }
//                return memo;
//              }, []).forEach(function(e) {
//                var parts = e.split('|');
//                var entry = createElement('span', 'entry ' +  parts[1], parts[0]);
//                legend.appendChild(entry);
//              });
//              this.el.appendChild(legend);
//            };

                Calendar.prototype.nextMonth = function () {
                    this.current.add('months', 1);
                    this.next = true;
                    this.draw();
                };

                Calendar.prototype.prevMonth = function () {
                    this.current.subtract(1, 'months');
                    this.next = false;
                    this.draw();
                };

                window.Calendar = Calendar;

                function createElement(tagName, className, innerText) {
                    var ele = document.createElement(tagName);
                    if (className) {
                        ele.className = className;
                    }
                    if (innerText) {
                        ele.innderText = ele.textContent = innerText;
                    }
                    return ele;
                }
            }();

            !function () {
                         <% if(!recordList.isEmpty()) {  %>
                var data = [
   
            <%
                
                for (int i = 0; i < recordList.size() - 1; i++) {
            %>
                    {date: "<%= recordList.get(i).getDate()%>", eventName: "<%= recordList.get(i).getName()%>", calendar: 'Work', color: 'orange'},
            <% }%>
                    {date: "<%= recordList.get(recordList.size() - 1).getDate()%>", eventName: "<%= recordList.get(recordList.size() - 1).getName()%>", calendar: 'Work', color: 'orange'}];
                                <%        
                } else {%>
                        var data =[];
              <%  }%>
 //    { eventName: 'Game vs Portalnd', calendar: 'Sports', color: 'blue' },
                //    { eventName: 'Game vs Houston', calendar: 'Sports', color: 'blue' },
                //    { eventName: 'Game vs Denver', calendar: 'Sports', color: 'blue' },
                //    { eventName: 'Game vs San Degio', calendar: 'Sports', color: 'blue' },
                //
                //    { eventName: 'School Play', calendar: 'Kids', color: 'yellow' },
                //    { eventName: 'Parent/Teacher Conference', calendar: 'Kids', color: 'yellow' },
                //    { eventName: 'Pick up from Soccer Practice', calendar: 'Kids', color: 'yellow' },
                //    { eventName: 'Ice Cream Night', calendar: 'Kids', color: 'yellow' },
                //
                //    { eventName: 'Free Tamale Night', calendar: 'Other', color: 'green' },
                //    { eventName: 'Bowling Team', calendar: 'Other', color: 'green' },
                //    { eventName: 'Teach Kids to Code', calendar: 'Other', color: 'green' },
                //    { eventName: 'Startup Weekend', calendar: 'Other', color: 'green' }
                //  ];


                function addDate(ev) {

                }


                var calendar = new Calendar('#calendar', data);

            }();
        </script>
        <!--        <script language="JavaScript" type="text/javascript"src="../assets/scripts/calendar.js"></script>-->
    </body>
</html>
