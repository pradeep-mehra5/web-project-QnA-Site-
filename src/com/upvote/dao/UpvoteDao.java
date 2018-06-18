package com.upvote.dao;

import first.User;

import javax.xml.transform.Result;
import java.sql.*;

public class UpvoteDao {

   static String sql="SELECT * from Upvotes where user_id=? and a_id=?";
   static String url="jdbc:mysql://localhost:3306/questagram";
   static String username= "root";
   static String password="MYSQLROOTpassword";
    public static boolean hasUpvoted(int user_id,int a_id)
    {
        Connection con=null;
        PreparedStatement st=null;
        ResultSet rs=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con= DriverManager.getConnection(url,username,password);
            st=con.prepareStatement(sql);
            st.setInt(1,user_id);
            st.setInt(2,a_id);
            rs= st.executeQuery();
            if (rs.next()) {
                return true;
            }
        }catch (Exception e){e.printStackTrace();}
        finally {
            try {
                rs.close();
            }catch (SQLException e){e.printStackTrace();}
            try {
                st.close();
            }catch (SQLException e){e.printStackTrace();}
            try {
                con.close();
            }catch (SQLException e){e.printStackTrace();}
        }
        return false;
    }
}
