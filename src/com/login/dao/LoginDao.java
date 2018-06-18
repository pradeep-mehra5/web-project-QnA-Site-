package com.login.dao;

import first.User;

import javax.xml.transform.Result;
import java.sql.*;

public class LoginDao {

    String sql="select * from users where username=? and password=?";
    String url="jdbc:mysql://localhost:3306/questagram";
    String username= "root";
    String password="MYSQLROOTpassword";
    public boolean checkDetails(String uname, String pass)
    {
        Connection con=null;
        PreparedStatement st=null;
        ResultSet rs=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con= DriverManager.getConnection(url,username,password);
            st=con.prepareStatement(sql);
            st.setString(1,uname);
            st.setString(2,pass);
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
