/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import Exceptions.AuthenticationExceptionPassword;
import Exceptions.AuthenticationExceptionUsername;
import Exceptions.NullValueException;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
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
@WebServlet(name = "PersonalRecordServlet", urlPatterns = {"/PersonalRecordServlet"})
public class PersonalRecordServlet extends HttpServlet {

    String username;
    String password;
    String stringKey;

    Connection conn;

    @Override
    public void init(ServletConfig config) throws ServletException {
	username = config.getInitParameter("DBusername");
	password = config.getInitParameter("DBpassword");
	stringKey = config.getInitParameter("publicKey");//retrieves the public key (hutaocomehomepls) from web xml

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
	byte[] key = new byte[16];
	//converts each character of the public key into a byte and inserts it into a array.
	for (int i = 0; i < key.length; i++) {
	    key[i] = (byte) stringKey.charAt(i);
	}
	try {
	    HttpSession session = request.getSession();

	    String uname = (String) session.getAttribute("uname");
	    String query = "SELECT * FROM APP.USERDB where USERNAME=?";
	    PreparedStatement pstmt = conn.prepareStatement(query);
	    pstmt.setString(1, uname);
	    ResultSet records = pstmt.executeQuery();
	    if (records.next() == false) {

		String query1 = "SELECT * FROM APP.VERIFIEDDB where USERNAME=?";
		pstmt = conn.prepareStatement(query1);
		pstmt.setString(1, uname);
		records = pstmt.executeQuery();

		if (records.next() == false) {
		    throw new AuthenticationExceptionUsername();
		} else {
		    String dPass = Security.decrypt(records.getString("PASSWORD"), key);//encrypts the password that the new user has inputted
		    session.setAttribute("verify", "verified");
		    session.setAttribute("name", records.getString("NAME"));
		    session.setAttribute("course", records.getString("COURSE"));
		    session.setAttribute("email", records.getString("EMAIL"));
		    session.setAttribute("username", uname);
		    session.setAttribute("password", dPass);
		    session.setAttribute("age", records.getString("AGE"));
		    session.setAttribute("birthday", records.getString("BIRTHDAY"));
		    session.setAttribute("gender", records.getString("GENDER"));
		    session.setAttribute("snumber", records.getString("STUDENTNUMBER"));
		    session.setAttribute("favgame", records.getString("FAVORITEGAME"));
		    session.setAttribute("cnumber", records.getString("CONTACTNUMBER"));
		    session.setAttribute("address", records.getString("ADDRESS"));
		    session.setAttribute("status", records.getString("STATUS"));

		    response.sendRedirect("account/records-personal-1.jsp");
		}
	    } else {

		String toemail = records.getString("EMAIL");
		String dPass = Security.decrypt(records.getString("PASSWORD"), key);//encrypts the password that the new user has inputted

		session.setAttribute("email", toemail);
		session.setAttribute("username", uname);
		session.setAttribute("password", dPass);
		response.sendRedirect("account/records-personal-0.jsp");
	    }

	} catch (SQLException sqle) {
	    response.sendRedirect("error404.jsp");
	} catch (Exception ex) {
	    ex.printStackTrace();
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
