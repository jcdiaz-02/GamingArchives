/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
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
import static java.lang.System.out;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
public class AddRecordServlet extends HttpServlet {

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {

	try {

	    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("uuuu-MM-dd");
	    LocalDate now = LocalDate.now();
	    String date = dtf.format(now);

	    HttpSession session = request.getSession();
	    String u = (String) session.getAttribute("username");

	    String name = request.getParameter("myname");
	    String course = request.getParameter("course");

	    String birthday = request.getParameter("birthday");
	    String gender = request.getParameter("gender");
	    String snumber = request.getParameter("snumber");
	    String favgame = request.getParameter("favgame");
	    String cnumber = request.getParameter("cnumber");
	    String address = request.getParameter("address");

	    out.print(birthday);
	    int yr = Integer.parseInt(birthday.substring(0, 4));
	    int mm = Integer.parseInt(birthday.substring(5, 7));
	    int dd = Integer.parseInt(birthday.substring(8));
	    out.print("date" + yr);
	    out.print(mm);
	    out.print(dd);

	    long currentTime = System.currentTimeMillis();
	    Calendar today = Calendar.getInstance();
	    today.setTimeInMillis(currentTime);
	    int age = today.get(Calendar.YEAR) - yr;
	    if (today.get(Calendar.MONTH) < mm) {
		age -= 1;
	    }
	    if (today.get(Calendar.MONTH) <= mm) {
		if (today.get(Calendar.DATE) < dd) {
		    age -= 1;

		}
	    }
	    String a = String.valueOf(age);

	    String query = "UPDATE APP.VERIFIEDDB set NAME=?, COURSE=?, AGE=?, BIRTHDAY=?, GENDER=?,"
		    + "STUDENTNUMBER=?, FAVORITEGAME=?, CONTACTNUMBER=?, ADDRESS=?, ROLE=?, DATE=? where USERNAME=?";

	    PreparedStatement pst = conn.prepareStatement(query);

	    pst.setString(1, name);
	    pst.setString(2, course);
	    pst.setString(3, a);
	    pst.setString(4, birthday);
	    pst.setString(5, gender);
	    pst.setString(6, snumber);
	    pst.setString(7, favgame);
	    pst.setString(8, cnumber);
	    pst.setString(9, address);
	    pst.setString(10, "member");
	    pst.setString(11, date);
	    pst.setString(12, u);

	    pst.executeUpdate();
	    response.sendRedirect("account/profile-page.jsp");

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
