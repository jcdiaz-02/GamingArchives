/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author merki
 */
@WebServlet(name = "DeleteRecordServlet", urlPatterns = {"/DeleteRecordServlet"})
public class DeleteRecordServlet extends HttpServlet {

    String username;
    String password;

    Connection conn;

    @Override
    public void init(ServletConfig config) throws ServletException {
	username = config.getInitParameter("DBusername");
	password = config.getInitParameter("DBpassword");
        super.init(config);
        try {
            Class.forName(config.getServletContext().getInitParameter("DBdriver"));
            String url = config.getInitParameter("DBurl");
	    conn = DriverManager.getConnection(url, username, password);
        } catch (SQLException sqle) {
	    System.out.println("SQLException error occured - "
		    + sqle.getMessage());
        } catch (ClassNotFoundException nfe) {
	    System.out.println("ClassNotFoundException error occured - "
		    + nfe.getMessage());
        }

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {

	try {
	    HttpSession session = request.getSession();
	    String uname = request.getParameter("uname");
	    String ident = (String) session.getAttribute("ident");
	    String primaryuname = (String) session.getAttribute("uname");

	    if (uname.isEmpty()) {
		if (ident.equals("all")) {
		    response.sendRedirect("account/records-all.jsp");
		} else if (ident.equals("today")) {
		    response.sendRedirect("account/records-today.jsp");
		} else if (ident.equals("arch")) {
		    response.sendRedirect("account/records-archive.jsp");
		}
	    }


	    if (ident.equals("arch")) {
		String query = "DELETE FROM APP.ARCHIVEDB where USERNAME = ?";
		PreparedStatement pst = conn.prepareStatement(query);
                pst.setString(1, uname);
                pst.executeUpdate();

	    } else {
		if (uname.equals(primaryuname)) {
		    if (ident.equals("all")) {
			response.sendRedirect("account/records-all.jsp");
		    } else if (ident.equals("today")) {
			response.sendRedirect("account/records-today.jsp");
		    }
		} else {
		    String query = "DELETE FROM APP.USERDB where USERNAME = ?";
		    PreparedStatement pst = conn.prepareStatement(query);
		    pst.setString(1, uname);
		    pst.executeUpdate();

		    query = "DELETE FROM APP.VERIFIEDDB where USERNAME = ?";
		    pst = conn.prepareStatement(query);
		    pst.setString(1, uname);
		    pst.executeUpdate();

		}
	    }

	    if (ident.equals("all")) {
		response.sendRedirect("account/records-all.jsp");
	    } else if (ident.equals("today")) {
		response.sendRedirect("account/records-today.jsp");
	    } else if (ident.equals("arch")) {
		response.sendRedirect("account/records-archive.jsp");
	    }
	} catch (SQLException sqle) {
	    response.sendRedirect("errPages/Error404.jsp");
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
