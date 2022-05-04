package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ConnectToDB {

    public Connection getConnection(String dbUrl, String dbUser, String dbPassword) throws SQLException {

//            "jdbc:mysql://gamingarchives.mysql.database.azure.com:3306/{your_database}?useSSL=true";
//            DriverManager.getConnection(url, "gamingarchivesAdmin", "{your_password}");
//            final String url = "jdbc:mysql://gamingarchives.mysql.database.azure.com:3306/gamingarchives?useSSL=false&serverTimezone=UTC";
//            final String user = "gamingarchivesAdmin";
//            final String password = "zt.sw9\"D6`VjBnhh";
        try {
            String DBdriver = "com.mysql.cj.jdbc.Driver";
            Class.forName(DBdriver);
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            System.out.println("Connected to Azure Database");
            return conn;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw new SQLException(e);
        }
    }

    public ResultSet getTableResultSet(String tablename, Connection conn) throws SQLException {
        try {
            String query = "SELECT * FROM " + tablename;
            Statement pstmt = conn.createStatement();
            ResultSet rs = pstmt.executeQuery(query);
            return rs;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw e;
        }
    }

    public ResultSet getSortedTableRS(String tablename, Connection conn) throws SQLException {
        try {
            String query = "SELECT * FROM " + tablename + " ORDER BY event_date DESC";
            Statement pstmt = conn.createStatement();
            ResultSet rs = pstmt.executeQuery(query);
            return rs;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw e;
        }
    }

    public ResultSet getResultSet(String query, String[] var, Connection conn) throws SQLException {
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            int count = 1;
            for (String i : var) {
                pstmt.setString(count, i);
                count++;
            }
            ResultSet rs = pstmt.executeQuery();
            return rs;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw e;
        }
    }

    public ResultSet getResultSet(String query, String var, Connection conn) throws SQLException {
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, var);
            ResultSet rs = pstmt.executeQuery();
            return rs;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw e;
        }
    }

    public int updateQuery(String query, String[] var, Connection conn) throws SQLException {
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            int count = 1;
            for (String i : var) {
                pstmt.setString(count, i);
                count++;
            }
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw e;
        }
    }

    public int updateQuery(String query, String var, Connection conn) throws SQLException {
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, var);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw e;
        }
    }

    public List<String> resultSetToList(ResultSet rs, String columnName) throws SQLException {
        List<String> list = new ArrayList<>();
        while (rs.next()) {
            list.add(rs.getString(columnName));
        }
        return list;
    }
}
