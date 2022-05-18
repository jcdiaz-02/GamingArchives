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
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
@WebServlet(urlPatterns = {"/ForgotPass"})
public class ForgotPass extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        Random r = new Random();
        String randomNumber = String.format("%04d", r.nextInt(1001));
        String email = request.getParameter("email");
        String button = request.getParameter("button");

        String subject = "verification";
        String messageText = "Verification code is: " + randomNumber;//messageString;
        String fromemail = "noreplytgs.cics@gmail.com";//sender email & pas
        String frompassword = "6&&kPGUhp/RwQvjn";

        //session.setDebug(true);
        try {
            String query = "SELECT EMAIL FROM APP.USERDB where EMAIL=?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            ResultSet records = pstmt.executeQuery();
            if (records.next() == false) {
                query = "SELECT EMAIL FROM APP.VERIFIEDDB where EMAIL=?";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, email);
                records = pstmt.executeQuery();
                if (records.next() == false) {
                    throw new AuthenticationExceptionUsername();
                }
            } else {

            }
            Properties properties = new Properties();
            properties.setProperty("mail.transport.protocol", "smtp");
            properties.setProperty("mail.smtp.host", "smtp.gmail.com");
            properties.put("mail.debug", "true");
            properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.port", "587");

            Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromemail, frompassword);
                }
            });
            Transport transport = session.getTransport();
            InternetAddress addressFrom = new InternetAddress(fromemail);
            MimeMessage message = new MimeMessage(session);
            message.setSender(addressFrom);
            message.setSubject(subject);
            message.setContent(messageText, "text/plain");
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

            transport.connect();
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();

            HttpSession httpsession = request.getSession();

            httpsession.setAttribute("code", randomNumber);
            httpsession.setAttribute("email", email);
            httpsession.setAttribute("button", button);
            response.sendRedirect(
                    "verificationPage.jsp");
        } catch (MessagingException mex) {
            System.out.println("send failed, exception: " + mex);
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
