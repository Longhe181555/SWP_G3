/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Account;
import entity.Feedback;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FeedbackDBContext extends DBContext {

 
    
public void insert(int aid, int pid, String comment, float rating) {
    try {
        String sql = "INSERT INTO Feedback (aid, pid, comment, rating, date) VALUES (?, ?, ?, ?, GETDATE())";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, aid);
        stm.setInt(2, pid);
        stm.setString(3, comment);
        stm.setFloat(4, rating);
        stm.executeUpdate();
    } catch (SQLException ex) {
        Logger.getLogger(FeedbackDBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
}

 

    public ArrayList<Feedback> getByPid(int aid) {
        try {
            ArrayList<Feedback> fs = new ArrayList<Feedback>();
            String sql = "select f.fid\n"
                    + "        ,f.aid\n"
                    + "		,f.comment\n"
                    + "		,f.rating\n"
                    + "		,f.pid\n"
                    + "		,f.date\n"
                    + "		,a.img\n"
                    + "		,a.fullname\n"
                    + "	from Feedback f\n"
                    + "	join Account a on f.aid = a.aid\n"
                    + "	join Product p on f.pid = p.pid\n"
                    + "	Where f.pid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, aid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Feedback f = new Feedback();
                Account a = new Account();
                a.setAid(rs.getInt("aid"));
                a.setFullname(rs.getString("fullname"));
                String img = rs.getString("img");
                if (img == null || img.trim().isEmpty()) {
                    img = "img/profile_picture/placeholder.png";
                }
                a.setImg(img);
                f.setAccount(a);
                f.setComment(rs.getString("comment"));
                f.setRating(rs.getFloat("rating"));
                f.setDate(rs.getDate("Date"));
                fs.add(f);   
            }
            return fs;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    
     public float getAverageRatingByPid(int pid) {
    try {
        String sql = "SELECT AVG(f.rating) as avgRating " +
                     "FROM Feedback f " +
                     "WHERE f.pid = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, pid);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            return rs.getFloat("avgRating");
        }
    } catch (SQLException ex) {
        Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
    return 0;
}

   
}
