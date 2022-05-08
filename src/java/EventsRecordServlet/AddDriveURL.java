
package EventsRecordServlet;

import Database.ConnectToDB;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

public class AddDriveURL extends HttpServlet {
    
    Connection conn;
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
            System.out.println("went to addriveurl java");
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            role = "admin";
            if ("admin".equalsIgnoreCase(role)) {
                // url input
                String driveURL = request.getParameter("edriveurl");
                int id =Integer.parseInt(request.getParameter("eID"));
                System.out.println(driveURL);
                System.out.println(id);
                String query = "UPDATE event_record SET event_driveurl = ?  WHERE event_record_id = ?";
                        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, driveURL);
            pstmt.setInt(2, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
                response.sendRedirect("EventOverview");
            } else {
                // not an admin cant add url
                response.sendRedirect("home.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("adding url failed");
          response.sendRedirect("errorPages/Error404.jsp");
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
