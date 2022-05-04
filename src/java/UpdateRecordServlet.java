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
public class UpdateRecordServlet extends HttpServlet {

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
	try {
	    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("uuuu-MM-dd");
	    LocalDate now = LocalDate.now();
	    String date = dtf.format(now);
	    HttpSession session = request.getSession();
	    String u = (String) session.getAttribute("primaryusername");

	    String butt = request.getParameter("recbutton");
	    String uname = request.getParameter("uname");
	    String name = request.getParameter("myname");
	    String pass = request.getParameter("pass");
	    String email = request.getParameter("email");
	    String age = request.getParameter("age");
	    String birthday = request.getParameter("birthday");
	    String course = request.getParameter("course");
	    String address = request.getParameter("homeaddress");
	    String snumber = request.getParameter("snumber");
	    String cnumber = request.getParameter("cnumber");
	    String favgame = request.getParameter("favgame");
	    String gender = request.getParameter("gender");
	    String role = request.getParameter("userrole");
	    String ePass = Security.encrypt(pass, key);//encrypts the password the user has inputted and compares it to the encrypted password in DB

	    if (butt.equals("update")) {
		String query = "UPDATE APP.VERIFIEDDB set NAME=?, COURSE=?, AGE=?, BIRTHDAY=?, GENDER=?, STUDENTNUMBER=?, "
			+ "FAVORITEGAME=?, CONTACTNUMBER=?, ADDRESS=?, ROLE=?, EMAIL=?, USERNAME=?, PASSWORD=?, DATE=? where USERNAME =?";
		PreparedStatement pst = conn.prepareStatement(query);

		pst.setString(1, name);
		pst.setString(2, course);
		pst.setString(3, age);
		pst.setString(4, birthday);
		pst.setString(5, gender);
		pst.setString(6, snumber);
		pst.setString(7, favgame);
		pst.setString(8, cnumber);
		pst.setString(9, address);
		pst.setString(10, role);
		pst.setString(11, email);
		pst.setString(12, uname);
		pst.setString(13, ePass);
		pst.setString(14, date);
		pst.setString(15, u);
		pst.executeUpdate();
		response.sendRedirect("account/records-all.jsp");
	    } else if (butt.equals("add")) {
		String query = "INSERT INTO APP.VERIFIEDDB(NAME, COURSE, AGE, BIRTHDAY, GENDER, STUDENTNUMBER, "
			+ "FAVORITEGAME, CONTACTNUMBER, ADDRESS, ROLE, EMAIL, USERNAME, PASSWORD, DATE)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement pst = conn.prepareStatement(query);
		pst.setString(1, name);
		pst.setString(2, course);
		pst.setString(3, age);
		pst.setString(4, birthday);
		pst.setString(5, gender);
		pst.setString(6, snumber);
		pst.setString(7, favgame);
		pst.setString(8, cnumber);
		pst.setString(9, address);
		pst.setString(10, role);
		pst.setString(11, email);
		pst.setString(12, uname);
		pst.setString(13, ePass);
		pst.setString(14, date);
		pst.executeUpdate();
		response.sendRedirect("account/addRecordAdmin.jsp");
	    }

	} catch (SQLException sqle) {
	    response.sendRedirect("error404.jsp");
	} catch (IOException ex) {
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
