package EventsRecordServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletConfig;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Database.ConnectToDB;
import EventsRecordKeeper.EventRecord;

@WebServlet(name = "ViewAllEvent", urlPatterns = {"/ViewAllEvent"})
public class ViewAllEvent extends HttpServlet {

    Connection conn;
    EventRecord eventRecord;
    ConnectToDB db;

    @Override
    public void init(ServletConfig config) throws ServletException {
        String username = config.getInitParameter("DBusername");
        String password = config.getInitParameter("DBpassword");
        String url = config.getInitParameter("DBurl");
        super.init(config);
        db = new ConnectToDB();
        try {
            conn = db.getConnection(url, username, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");

            if ("admin".equalsIgnoreCase(role)) {
                List<EventRecord> recordList = new ArrayList<EventRecord>();
                String tablename = "event_record";
                ResultSet rs = db.getTableResultSet(tablename, conn);

                while (rs.next()) {
                    EventRecord record = new EventRecord(rs.getInt(1), rs.getString(2), rs.getString(3),
                            rs.getString(4),
                            rs.getString(5),
                            rs.getString(6),
                            rs.getString(7));
                    recordList.add(record);
                }
                session.setAttribute("eventList", recordList);
                response.sendRedirect("events/events-all.jsp");
            } else {
                response.sendRedirect("home.jsp");
            }

        } catch (Exception e) {
            response.sendRedirect("errorPages/Error404.jsp");
        }
    }

    // #region
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
    // #endregion
}
