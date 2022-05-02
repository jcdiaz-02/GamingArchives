package EventsRecordServlet;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletConfig;
import java.sql.Connection;
import java.sql.SQLException;

import Database.ConnectToDB;
import java.sql.PreparedStatement;
import javax.servlet.annotation.MultipartConfig;

@WebServlet(name = "LoginCheck", urlPatterns = { "/LoginCheck" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 50, // 50 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class AddEvent extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            

            if ("admin".equalsIgnoreCase(role)) {
                // event input
                String name = request.getParameter("ename");
                String desc = request.getParameter("edescription");
                String date = request.getParameter("edate");
                String endDate = request.getParameter("dateEnd");
               String eventImage = "none";
                if (request.getParameter("imageInput") != "") {
                                   // event image
                response.setContentType("text/plain;charset=UTF-8");
                ServletOutputStream os = response.getOutputStream();
                ServletConfig sc = getServletConfig();
                String buildPath = getServletContext().getRealPath("/");
                String temp = "\\build\\web\\";
                String path = buildPath.replace(temp, "") + "\\web";
                Part eventImageInput = request.getPart("imageInput");
                String imageName = eventImageInput.getSubmittedFileName();
                InputStream is = eventImageInput.getInputStream();
                    try {
                        Files.copy(is, Paths.get(path + "\\Images\\" + imageName), StandardCopyOption.REPLACE_EXISTING);
                        eventImage = "Images/" + imageName;
                    } catch (Exception e) {
                         eventImage = "none";
                    }
                
                } 

 

                String query = "INSERT INTO event_record (event_name, event_description, event_date, event_end_date, event_image) VALUES (?, ?, ?, ?, ?)";
                // List<String> var = new ArrayList<String>();
                db.updateQuery(query, new String[] { name, desc, date, endDate, eventImage }, conn);
                response.sendRedirect("events/events-add.jsp");
            } else {
                // not an admin cant add event
                response.sendRedirect("home.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
          response.sendRedirect("errorPages/Error404.jsp");
        }
    }

    // #region
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
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
