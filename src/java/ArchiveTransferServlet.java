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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author merki
 */
public class ArchiveTransferServlet extends HttpServlet {

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
	    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("uuuu-MM-dd");
	    LocalDate today = LocalDate.now();
	    String date = dtf.format(today);

	    HttpSession session = request.getSession();

	    String[] selectedrows = request.getParameterValues("selectedRows");

	    for (int x = 0; x < selectedrows.length; x++) {
		String query = "SELECT * FROM APP.ARCHIVEDB where EMAIL = ?";
		PreparedStatement pst = conn.prepareStatement(query);
		pst.setString(1, selectedrows[x]);
		ResultSet records = pst.executeQuery();
		records.next();

		String uname1 = records.getString("USERNAME");
		String name = records.getString("NAME");
		String pass = records.getString("PASSWORD");
		String email = records.getString("EMAIL");
		String age = records.getString("AGE");
		String birthday = records.getString("BIRTHDAY");
		String course = records.getString("COURSE");
		String address = records.getString("ADDRESS");
		String snumber = records.getString("STUDENTNUMBER");
		String cnumber = records.getString("CONTACTNUMBER");
		String favgame = records.getString("FAVORITEGAME");
		String gender = records.getString("GENDER");
		String role = records.getString("ROLE");
		String status = records.getString("STATUS");
		

		query = "INSERT INTO APP.VERIFIEDDB(NAME, COURSE, AGE, BIRTHDAY, GENDER, STUDENTNUMBER, "
			+ "FAVORITEGAME, CONTACTNUMBER, ADDRESS, ROLE, EMAIL, USERNAME, PASSWORD, DATE, STATUS)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		pst = conn.prepareStatement(query);
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
		pst.setString(12, uname1);
		pst.setString(13, pass);
		pst.setString(14, date);
		pst.setString(15, status);
		pst.executeUpdate();

		String query1 = "DELETE FROM APP.ARCHIVEDB where EMAIL = ?";
		pst = conn.prepareStatement(query1);
		pst.setString(1, selectedrows[x]);
		pst.executeUpdate();

	    }
	    response.sendRedirect("account/records-archive.jsp");

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
