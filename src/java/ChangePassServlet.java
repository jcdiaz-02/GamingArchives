/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import Exceptions.AuthenticationExceptionUsername;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChangePassServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        byte[] key = new byte[16];
	//converts each character of the public key into a byte and inserts it into a array.
        for (int i = 0; i < key.length; i++) {
	    key[i] = (byte) stringKey.charAt(i);
        }
        try {
            HttpSession httpsession = request.getSession();
            String email = (String) httpsession.getAttribute("email");
            String psw = request.getParameter("psw");
            String cpsw = request.getParameter("cpsw");

	    if (psw != null & cpsw != null) {
                if (!cpsw.equals(psw)) {
                    httpsession.setAttribute("error", "1");
                    response.sendRedirect("login/password-change.jsp");
                } else {
		   String ePass = Security.encrypt(psw, key);//encrypts the password that the new user has inputted

                    String query = "SELECT PASSWORD FROM APP.USERDB where EMAIL=?";
		    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, email);
                    ResultSet records = pstmt.executeQuery();
		    if (records.next() == false) {

                        query = "SELECT PASSWORD FROM APP.VERIFIEDDB where EMAIL=?";
			pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, email);
                        records = pstmt.executeQuery();
			if (records.next() == false) {
                            throw new AuthenticationExceptionUsername();
			} else {
                        query = "UPDATE APP.VERIFIEDDB set PASSWORD=? where EMAIL=?";
			    pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, ePass);
                        pstmt.setString(2, email);
                        pstmt.executeUpdate();
                        response.sendRedirect("home.jsp");

			}
                    } else {
                        query = "UPDATE APP.USERDB set PASSWORD=? where EMAIL=?";
			pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, psw);
                        pstmt.setString(2, email);
                        pstmt.executeUpdate();
                        response.sendRedirect("home.jsp");
                    }
                }
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
