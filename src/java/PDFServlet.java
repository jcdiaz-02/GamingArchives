/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.ExceptionConverter;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import static java.time.LocalDateTime.now;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
public class PDFServlet extends HttpServlet {

    String username;
    String password;
    Connection conn;

    @Override
    public void init(ServletConfig config) throws ServletException {
	username = config.getInitParameter("DBusername");//retrieves username from web xml
	password = config.getInitParameter("DBpassword");//retrieves password from web xml
	super.init(config);
	try {
	    Class.forName(config.getServletContext().getInitParameter("DBdriver"));//load driver for DB
	    String url = config.getInitParameter("DBurl");// retrieves the url to be used for establishing a connection to the DB
	    conn = DriverManager.getConnection(url, username, password);//Establishes a connection
	} catch (SQLException sqle) {
	    System.out.println("SQLException error occured - "
		    + sqle.getMessage());
	} catch (ClassNotFoundException nfe) {
	    System.out.println("ClassNotFoundException error occured - "
		    + nfe.getMessage());
	}

    }

    //class for header and footer
    public class HeaderFooterPageEvent extends PdfPageEventHelper {

	DateTimeFormatter dtfGenerated = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");//format for date when report was generated
	LocalDateTime now = LocalDateTime.now();//date and time now
	PdfTemplate pdt;
	Image total;
	HttpSession session;

	public HeaderFooterPageEvent(HttpSession session) {
	    this.session = session;
	}

	public void onStartPage(PdfWriter writer, Document document) {
	    ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase("Generated by: " + session.getAttribute("username")), 385, 588, 0);
	    ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_RIGHT, new Phrase("Generated at: " + dtfGenerated.format(now)), 750, 588, 0);
	}

	@Override
	public void onEndPage(PdfWriter writer, Document document) {
	    PdfPTable table = new PdfPTable(15);
	    try {
		//Table formatting
		float[] columnWidths = new float[]{3f, 8f, 8f, 30f, 20f, 20f, 3f, 8f, 8f, 8f, 8f, 8f, 8f, 8f, 8f};
		table.setWidths(columnWidths);
		table.setTotalWidth(720);
		table.getDefaultCell().setFixedHeight(20);
		table.getDefaultCell().setBorder(Rectangle.BOTTOM);

		//Formatting
		table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_RIGHT);

		//Page Number Formatting
		table.addCell(new Phrase(String.format("Page %d of", writer.getPageNumber())));
		PdfPCell cell = new PdfPCell(total);
		cell.setBorder(Rectangle.BOTTOM);
		table.addCell(cell);
		PdfContentByte canvas = writer.getDirectContent();
		canvas.beginMarkedContentSequence(PdfName.ART);
		table.writeSelectedRows(0, -1, 36, 30, canvas);
		canvas.endMarkedContentSequence();

	    } catch (DocumentException de) {
		throw new ExceptionConverter(de);
	    }
	}

	@Override
	public void onOpenDocument(PdfWriter writer, Document document) {

	    pdt = writer.getDirectContent().createTemplate(50, 40);
	    try {
		total = Image.getInstance(pdt);
		total.setRole(PdfName.ART);

	    } catch (DocumentException de) {
		throw new ExceptionConverter(de);
	    }
	}

	@Override
	public void onCloseDocument(PdfWriter writer, Document document) {
	    ColumnText.showTextAligned(pdt, Element.ALIGN_LEFT,
		    new Phrase(String.valueOf(writer.getPageNumber())),
		    2, 2, 0);
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
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("uuuu-MM-dd");
	LocalDate today = LocalDate.now();
	String todaydate = dtf.format(today);
	SimpleDateFormat fFormat = new SimpleDateFormat("yyyyMMddHHmmss");//format for filename
	HttpSession session = request.getSession();
	Date now = new Date();//date and time now
	String filename = fFormat.format(now);
	response.setContentType("application/pdf;charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename=" + filename + ".pdf");
	String query1 = null;

	String ident = (String) session.getAttribute("ident");

	try (ServletOutputStream sOut = response.getOutputStream();) {

	    String u = (String) session.getAttribute("username");//name to be displayed
	    //String r = (String) session.getAttribute("role");//role to be displayed

	    try {
		String btn = request.getParameter("pdfbutton");//gets value of button pressed to know what form will be printed

		// writes the PDF for the stream output
		ByteArrayOutputStream bOut = new ByteArrayOutputStream();

		// used for the header footer
		HeaderFooterPageEvent event = new HeaderFooterPageEvent(session);

		// used for the PDF
		Document document = new Document();
		Rectangle rect = new Rectangle(PageSize.LETTER.rotate());//landscape
		document.setPageSize(rect);

		PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());//creates pdf file
		writer.setPageEvent(event);

		document.open();

		String query = "SELECT * FROM APP.VERIFIEDDB where USERNAME = ?";//for printing of all records
		PreparedStatement stmt = conn.prepareStatement(query);
		stmt.setString(1, u);
		ResultSet rs1 = stmt.executeQuery();

		PdfPTable table = new PdfPTable(15);

		//table.setSpacingBefore(1f);
		table.addCell(new Phrase("No.", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("NAME", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("COURSE", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("EMAIL", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("UNAME", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("AGE", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("BDAY", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("GENDER", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("SNUM", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("FAVGAME", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("CNUM", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("ADDRESS", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("ROLE", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("VERIFY", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		table.addCell(new Phrase("STATUS", FontFactory.getFont(FontFactory.HELVETICA, 8)));

		int ctr = 1;
		if (btn.equals("ownpdf")) {
		    table.addCell(new Phrase(String.valueOf(ctr), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    rs1.next();
		    table.addCell(new Phrase(rs1.getString("NAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("COURSE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("EMAIL"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("USERNAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("AGE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("BIRTHDAY"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("GENDER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("STUDENTNUMBER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("FAVORITEGAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("CONTACTNUMBER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("ADDRESS"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("ROLE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase("verified", FontFactory.getFont(FontFactory.HELVETICA, 8)));
		    table.addCell(new Phrase(rs1.getString("STATUS"), FontFactory.getFont(FontFactory.HELVETICA, 8)));

		} else if (btn.equals("alluserpdf") || btn.equals("alluserpdftoday")) {
		    if (btn.equals("alluserpdf")) {
			query1 = "SELECT * FROM APP.USERDB";//for printing of all records
			stmt = conn.prepareStatement(query1);
		    } else if (btn.equals("alluserpdftoday")) {
			query1 = "SELECT * FROM APP.USERDB where DATE=?";
			stmt = conn.prepareStatement(query1);
			stmt.setString(1, todaydate);
		    }
		    rs1 = stmt.executeQuery();
		    //print info of everyone in database
		    //print all records in db (put * on the username of logged in user)
		    while (rs1.next()) {

			table.addCell(new Phrase(String.valueOf(ctr), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase((""), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase((""), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("EMAIL"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("USERNAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase((""), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase((""), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase((""), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase((""), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase((""), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase((""), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase((""), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase((""), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase("unverified", FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase((""), FontFactory.getFont(FontFactory.HELVETICA, 8)));

			if (ctr % 30 == 0) {
			    document.add(table);
			    document.newPage();
			    document.add(new Phrase("\n"));
			    table = new PdfPTable(15);
			    table.setSpacingBefore(8f);
			}

			ctr++;
		    }

		    if (btn.equals("alluserpdf")) {
			query1 = "SELECT * FROM APP.VERIFIEDDB";//for printing of all records
			stmt = conn.prepareStatement(query1);
		    } else if (btn.equals("alluserpdftoday")) {
			query1 = "SELECT * FROM APP.VERIFIEDDB where DATE=?";
			stmt = conn.prepareStatement(query1);
			stmt.setString(1, todaydate);
		    }

		    rs1 = stmt.executeQuery();
		    //print info of everyone in database
		    //print all records in db (put * on the username of logged in user)
		    while (rs1.next()) {
			if (u.equals(rs1.getString("USERNAME"))) {
			    table.addCell(new Phrase(String.valueOf(ctr), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("NAME") + "*", FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("COURSE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("EMAIL"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("USERNAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("AGE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("BIRTHDAY"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("GENDER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("STUDENTNUMBER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("FAVORITEGAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("CONTACTNUMBER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("ADDRESS"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("ROLE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase("verified", FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("STATUS"), FontFactory.getFont(FontFactory.HELVETICA, 8)));

			} else {
			    table.addCell(new Phrase(String.valueOf(ctr), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("NAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("COURSE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("EMAIL"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("USERNAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("AGE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("BIRTHDAY"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("GENDER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("STUDENTNUMBER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("FAVORITEGAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("CONTACTNUMBER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("ADDRESS"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("ROLE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase("verified", FontFactory.getFont(FontFactory.HELVETICA, 8)));
			    table.addCell(new Phrase(rs1.getString("STATUS"), FontFactory.getFont(FontFactory.HELVETICA, 8)));

			    if (ctr % 30 == 0) {
				document.add(table);
				document.newPage();
				document.add(new Phrase("\n"));
				table = new PdfPTable(15);
				table.setSpacingBefore(8f);
			    }
			}
			ctr++;
		    }
		} else if (btn.equals("archpdf")) {
		    query1 = "SELECT * FROM APP.ARCHIVEDB";
		    stmt = conn.prepareStatement(query1);
		    rs1 = stmt.executeQuery();
		    while (rs1.next()) {
			table.addCell(new Phrase(String.valueOf(ctr), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("NAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("COURSE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("EMAIL"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("USERNAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("AGE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("BIRTHDAY"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("GENDER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("STUDENTNUMBER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("FAVORITEGAME"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("CONTACTNUMBER"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("ADDRESS"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("ROLE"), FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase("verified", FontFactory.getFont(FontFactory.HELVETICA, 8)));
			table.addCell(new Phrase(rs1.getString("STATUS"), FontFactory.getFont(FontFactory.HELVETICA, 8)));

			if (ctr % 30 == 0) {
			    document.add(table);
			    document.newPage();
			    document.add(new Phrase("\n"));
			    table = new PdfPTable(15);
			    table.setSpacingBefore(8f);
			}
		    }
		    ctr++;

		}
		rs1.close();
		stmt.close();
		document.add(table);
		document.close();
		bOut.writeTo(sOut);
		bOut.close();
	    } catch (SQLException | DocumentException ex) {
		Logger.getLogger(PDFServlet.class.getName()).log(Level.SEVERE, null, ex);
	    }
	    sOut.close();
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
