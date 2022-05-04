/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package EventsRecordServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Database.ConnectToDB;
import EventsRecordKeeper.EventRecord;
import Exceptions.NullValueException;
import java.io.PrintWriter;
import java.util.Arrays;

/**
 *
 * @author Oracle
 */
public class EventOverview extends HttpServlet {

    Connection conn;
    EventRecord eventRecord;
    ConnectToDB db;

    @Override
    public void init(ServletConfig config) throws ServletException {
        try {
            String DBdriver = "com.mysql.cj.jdbc.Driver";
            Class.forName(DBdriver);
            String username = config.getInitParameter("DBusername");
            String password = config.getInitParameter("DBpassword");
            String url = config.getInitParameter("DBurl");
            super.init(config);
            db = new ConnectToDB();
            conn = db.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            List<EventRecord> recordList = new ArrayList<>();
            String datenow;
            String tablename = "event_record";
            ResultSet rs = db.getSortedTableRS(tablename, conn);

            while (rs.next()) {
                EventRecord record = new EventRecord(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4),
                        rs.getString(5));
                recordList.add(record);
            }
            // recordList.get(1).getEventName(); sample
            datenow = java.time.LocalDate.now().toString();
            session.setAttribute("date", datenow);
            session.setAttribute("eventList", recordList);
            // give list of event to jsp
            response.sendRedirect("subpage/events.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

// trace code
// PrintWriter out = response.getWriter();
//        try {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ListenerTester</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<center>");
//            out.println("<h1> DOG SERVLET </h1>");
//            out.println("<h2> test context attributes set by listener<br> </h2>");
//            out.println("<br>");
//
////            db = new ConnectToDB();
////            conn = db.getConnection(url, username, password);
//            out.println("<h3> create statement </h3>");
//            Statement stmt = conn.createStatement();
//            out.println("<h3> statement created </h3>");
//            List<EventRecord> recordList = new ArrayList<>();
//            String tablename = "event_record";
//            ResultSet rs = db.getSortedTableRS(tablename, conn);
//
//            while (rs.next()) {
////                EventRecord record = new EventRecord(rs.getInt(1), rs.getString(2), rs.getString(3),
////                        rs.getString(4),
////                        rs.getString(5));
//                out.println("<h3> " + rs.getInt(1) + "</h3>");
//            }
//            out.println("<h3> " + username + "</h3>");
////            out.println("<h3> "+ password + "</h3>");
//            out.println("<h3> " + url + "</h3>");
//
//            out.println("</body>");
//            out.println("</html>");
//        } catch (SQLException e) {
//            out.println("<h3> error occured</h3>");
//            out.println("<h3> " + e.getMessage() + "</h3>");
//            throw new ServletException(e);
//        }
