/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import Exceptions.AuthenticationExceptionUsername;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
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
@WebServlet(urlPatterns = {"/LoginVerification"})
public class LoginVerification extends HttpServlet {

    String username;
    String password;
    Connection conn;

    @Override
    public void init(ServletConfig config) throws ServletException {
	username = config.getInitParameter("DBusername");
	password = config.getInitParameter("DBpassword");
	super.init(config);
	try {
	    Class.forName(config.getInitParameter("DBdriver"));
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

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
	try {
	    HttpSession httpsession = request.getSession();

	    String uname = request.getParameter("uname");
	    String pass = request.getParameter("psw");
	    String button = request.getParameter("button");

	    String query = "SELECT * FROM APP.USERDB where USERNAME=?";
	    PreparedStatement pstmt = conn.prepareStatement(query);
	    pstmt.setString(1, uname);
	    ResultSet records = pstmt.executeQuery();
	    if (records.next() == false) {
		query = "SELECT * FROM APP.VERIFIEDDB where USERNAME=?";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, uname);
		records = pstmt.executeQuery();

		if (records.next() == false) {
		    throw new AuthenticationExceptionUsername();
		} else {
		    String email = records.getString("EMAIL");
		    httpsession.setAttribute("uname", uname);
		    httpsession.setAttribute("psw", pass);
		    httpsession.setAttribute("button", button);
		    httpsession.setAttribute("email", email);
		    httpsession.setAttribute("identifier", httpsession.getAttribute("identifier"));
		    response.sendRedirect("UserVerification");
		}
	    } else {
		if (!pass.equals(records.getString("PASSWORD"))) {
		    response.sendRedirect("login/login.jsp");
		}
		String email = records.getString("EMAIL");
		httpsession.setAttribute("uname", uname);
		httpsession.setAttribute("psw", pass);
		httpsession.setAttribute("button", button);
		httpsession.setAttribute("email", email);
		httpsession.setAttribute("identifier", httpsession.getAttribute("identifier"));
		response.sendRedirect("UserVerification");
	    }
	} catch (SQLException e) {
	    System.out.println(" exception: " + e);
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
