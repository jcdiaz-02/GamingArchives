/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Exceptions.*;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
public class LoginServlet extends HttpServlet {

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
	byte[] key = new byte[16];
	for (int i = 0; i < key.length; i++) {
	    key[i] = (byte) stringKey.charAt(i);
	}
	try {
	    HttpSession httpsession = request.getSession();

	    String uname = (String) httpsession.getAttribute("uname");
	    String pass = (String) httpsession.getAttribute("psw");
	    String code = (String) httpsession.getAttribute("code");
	    String verify = request.getParameter("verify");

	    if (code.equals(verify)) {
		if ((uname.equals("")) || (pass.equals(""))) {
		    //no username or password
		    throw new NullValueException();
		} else {
		    String query = "SELECT PASSWORD FROM APP.USERDB where USERNAME=?";
		    PreparedStatement pstmt = conn.prepareStatement(query);
		    pstmt.setString(1, uname);
		    ResultSet records = pstmt.executeQuery();
		    if (records.next() == false) {

			String query1 = "SELECT PASSWORD,ROLE FROM APP.VERIFIEDDB where USERNAME=?";
			pstmt = conn.prepareStatement(query1);
			pstmt.setString(1, uname);
			records = pstmt.executeQuery();
			if (records.next() == false) {
			    throw new AuthenticationExceptionUsername();
			} else {
			    String dPass = records.getString("PASSWORD");
			    String ePass = Security.decrypt(dPass, key);//encrypts the password the user has inputted and compares it to the encrypted password in DB

//                    System.out.println("password is:" + dPass);
			    if (!ePass.equals(pass)) {
				//password is incorrect
				throw new AuthenticationExceptionPassword();
			    } else if (ePass.equals(ePass)) {

				HttpSession session = request.getSession();
				session.setAttribute("username", uname);
				session.setAttribute("role", records.getString("ROLE"));
				session.setAttribute("verify", "verified");

				response.sendRedirect("subpage/authenticatedHome.jsp");
			    }
			}
		    } else {
			String dPass = records.getString("PASSWORD");
			String ePass = Security.decrypt(dPass, key);//encrypts the password the user has inputted and compares it to the encrypted password in DB

//                    System.out.println("password is:" + dPass);
			if (!ePass.equals(pass)) {
			    response.sendRedirect("login/login.jsp");
			    throw new AuthenticationExceptionPassword();
			} else if (ePass.equals(pass)) {

			    HttpSession session = request.getSession();
			    session.setAttribute("username", uname);
			    session.setAttribute("role", "member");
			    session.setAttribute("verify", "unverified");
			    response.sendRedirect("subpage/authenticatedHome.jsp");

			}
		    }
		}
	    } else {
		request.setAttribute("Incorrect", "Incorrect code");
		request.getRequestDispatcher("verificationPage.jsp").forward(request, response);
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
