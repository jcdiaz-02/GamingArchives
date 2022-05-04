

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
public class UserVerification extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession httpsession = request.getSession();

        String uname = "";
        String psw = "";
        String button = "";
        String email = "";
        String identifier = (String) httpsession.getAttribute("identifier");
        System.out.println(identifier);
        if (identifier.equals("login")) {
            uname = (String) httpsession.getAttribute("uname");
            psw = (String) httpsession.getAttribute("psw");
            button = (String) httpsession.getAttribute("button");
            email = (String) httpsession.getAttribute("email");
        } else if (identifier.equals("signup")) {
            uname = request.getParameter("uname");
            psw = request.getParameter("psw");
            String cpsw = request.getParameter("cpsw");
            button = request.getParameter("button");
            email = request.getParameter("email");
            if (psw != null & cpsw != null) {
                if (!cpsw.equals(psw)) {
                    httpsession.setAttribute("error", "1");
                    response.sendRedirect("signup/signup.jsp");
                }
            }
        }

        Random r = new Random();
        String randomNumber = String.format("%04d", r.nextInt(1001));

        String subject = "verification";
        String messageText = "Verification code is: " + randomNumber;//messageString;
        String fromemail = "noreplytgs.cics@gmail.com";//sender email & pas
        String frompassword = "6&&kPGUhp/RwQvjn";
        try {

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
            session.setDebug(true);

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

            httpsession.setAttribute("code", randomNumber);
            httpsession.setAttribute("uname", uname);
            httpsession.setAttribute("pass", psw);
            httpsession.setAttribute("email", email);
            httpsession.setAttribute("button", button);
            response.sendRedirect(
                    "verificationPage.jsp");
        } catch (MessagingException mex) {
            System.out.println("send failed, exception: " + mex);
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
