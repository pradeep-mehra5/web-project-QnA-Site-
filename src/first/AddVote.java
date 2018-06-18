package first;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "AddVote", urlPatterns = ("/AddVote"))
public class AddVote extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter printWriter=response.getWriter();
        Connection con= null;
        PreparedStatement preparedStatement=null;
        PreparedStatement preparedStatement1=null;
        PreparedStatement preparedStatement2=null;
        ResultSet resultSet=null;

        User a=(User) request.getSession().getAttribute("user");
        int a_id=Integer.parseInt(request.getParameter("a_id"));
        String sql="insert into Upvotes values(?,?)";
        String url="jdbc:mysql://localhost:3306/questagram";
        String username= "root";
        String password="MYSQLROOTpassword";
        try{
            Class.forName("com.mysql.jdbc.Driver");
             con= DriverManager.getConnection(url,username,password);
             preparedStatement=con.prepareStatement(sql);
            preparedStatement.setInt(1,a.user_id);
            preparedStatement.setInt(2,a_id);
            preparedStatement.executeUpdate();
             preparedStatement1=con.prepareStatement("update answers set upvotes = upvotes+1 where a_id=?");
            preparedStatement1.setInt(1,a_id);
            preparedStatement1.executeUpdate();
             preparedStatement2=con.prepareStatement("select upvotes from answers where a_id=?");
            preparedStatement2.setInt(1,a_id);
             resultSet=preparedStatement2.executeQuery();
            while (resultSet.next()){
                response.setContentType("text/html");  // Set content type of the response so that jQuery knows what it can expect.
                response.setCharacterEncoding("UTF-8");
                printWriter.write(String.valueOf(resultSet.getInt("upvotes")));}
        }catch (Exception e){e.printStackTrace();}finally {
            try{resultSet.close();}catch (SQLException e){e.printStackTrace();}
            try{preparedStatement.close();preparedStatement1.close();preparedStatement2.close();}catch (SQLException e){}
            try{con.close();}catch (SQLException e){}
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter printWriter=response.getWriter();
        Connection con= null;
        PreparedStatement preparedStatement=null;
        PreparedStatement preparedStatement1=null;
        PreparedStatement preparedStatement2=null;
        ResultSet resultSet=null;
        User a=(User) request.getSession().getAttribute("user");
        int a_id=Integer.parseInt(request.getParameter("a_id"));
        String sql="delete from Upvotes where user_id=? and a_id=?";
        String url="jdbc:mysql://localhost:3306/questagram";
        String username= "root";
        String password="MYSQLROOTpassword";
        try{
            Class.forName("com.mysql.jdbc.Driver");
             con= DriverManager.getConnection(url,username,password);
             preparedStatement=con.prepareStatement(sql);
            preparedStatement.setInt(1,a.user_id);
            preparedStatement.setInt(2,a_id);
            preparedStatement.executeUpdate();
             preparedStatement1=con.prepareStatement("update answers set upvotes = upvotes-1 where a_id=?");
            preparedStatement1.setInt(1,a_id);
            preparedStatement1.executeUpdate();
             preparedStatement2=con.prepareStatement("select upvotes from answers where a_id=?");
            preparedStatement2.setInt(1,a_id);
             resultSet=preparedStatement2.executeQuery();
            while (resultSet.next()){
                response.setContentType("text/html");  // Set content type of the response so that jQuery knows what it can expect.
                response.setCharacterEncoding("UTF-8");
                printWriter.write(String.valueOf(resultSet.getInt("upvotes")));}

        }catch (Exception e){e.printStackTrace();}finally {
            try{resultSet.close();}catch (SQLException e){e.printStackTrace();}
            try{preparedStatement.close();preparedStatement1.close();preparedStatement2.close();}catch (SQLException e){}
            try{con.close();}catch (SQLException e){}
        }
    }
}