package first;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "Register" , urlPatterns = ("/Register"))
public class Register extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Connection con=null;
        PreparedStatement ps=null;
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try{

            //loading drivers for mysql
            Class.forName("com.mysql.jdbc.Driver");

            //creating connection with the database
             con= DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram","root","MYSQLROOTpassword");

             ps=con.prepareStatement
                    ("insert into users(name,email,username,password) values(?,?,?,?)");

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, username);
            ps.setString(4,password);
            int i=ps.executeUpdate();

            if(i>0)
            {
//                out.println("You are sucessfully registered");
                HttpSession session=request.getSession();
                session.setAttribute("successful_registration","yes");
                session.setAttribute("username",username);
                session.setAttribute("name",name);
                response.sendRedirect("index.jsp");
            }

        }
        catch(SQLException se)
        {   if(se.getMessage().indexOf("Duplicate entry")!=-1){
            HttpSession session=request.getSession();
            session.setAttribute("name",name);
            session.setAttribute("email",email);
            session.setAttribute("duplicate","yes");
            response.sendRedirect("register.jsp");
            }
            else
        {
            System.out.println("Unable to register due to an SQL Exception.Please try again later");
            HttpSession session=request.getSession();
            session.setAttribute("sqlexception","yes");
            response.sendRedirect("register.jsp");
        }
        } catch (Exception e) {
            System.out.println("Unable to register due to an Exception.Please try again later");
            HttpSession session=request.getSession();
            session.setAttribute("exception","yes");
            response.sendRedirect("register.jsp");
        }finally {
            try{ps.close();}catch (SQLException e){}
            try{con.close();}catch (SQLException e){}
        }

    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
