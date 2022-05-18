/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
public class SignUpServlet extends HttpServlet {

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
	for (int i = 0; i < key.length; i++) {
	    key[i] = (byte) stringKey.charAt(i);
	}
	HttpSession httpsession = request.getSession();
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("uuuu-MM-dd");
	LocalDate now = LocalDate.now();
	String date = dtf.format(now);

	String uname = (String) httpsession.getAttribute("uname");
	String psw = (String) httpsession.getAttribute("psw");
	String email = (String) httpsession.getAttribute("email");
	String code = (String) httpsession.getAttribute("code");
	String ePass = Security.encrypt(psw, key);//encrypts the password the user has inputted and compares it to the encrypted password in DB

	String verify = request.getParameter("verify");
	try {

	    if (code.equals(verify)) {
		String query = "SELECT * FROM APP.USERDB where EMAIL =?";
		PreparedStatement pst = conn.prepareStatement(query);
		pst.setString(1, email);
		ResultSet records = pst.executeQuery();
		if (records.next() == false) {
		    query = "SELECT * FROM APP.VERIFIEDDB where EMAIL =?";
		    pst = conn.prepareStatement(query);
		    pst.setString(1, email);
		    records = pst.executeQuery();
		    if (records.next() == false) {
			query = "INSERT INTO APP.USERDB(username,password,email,role,date)VALUES(?,?,?,?,?)";
			pst = conn.prepareStatement(query);
			pst.setString(1, uname);
			pst.setString(2, ePass);
			pst.setString(3, email);
			pst.setString(4, "member");
			pst.setString(5, date);
			pst.executeUpdate();
			response.sendRedirect("home.jsp");
		    } else {
			httpsession.setAttribute("notif", "Email Already Exists");
			response.sendRedirect("signup/signup.jsp");
			out.print("verified failed");
		    }
		} else {
		    httpsession.setAttribute("notif", "Email Already Exists");
		    response.sendRedirect("signup/signup.jsp");
			out.print("userdb failed");

		}
	    } else {
		httpsession.setAttribute("Incorrect", "Incorrect code");
		request.getRequestDispatcher("verificationPage.jsp").forward(request, response);
	    }

	} catch (Exception e) {
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
