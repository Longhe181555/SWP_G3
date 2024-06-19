/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package dal;

import entity.ProductImg;
import entity.IEntity;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class ProductImgDBContext extends DBContext{

 
    public ArrayList<ProductImg> list() {
        ArrayList<ProductImg> imgs = new ArrayList<>();
        try {
            String sql = "SELECT iid,pid,imgpath FROM ProductImg";
            Statement stm = connection.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            while (rs.next()) {
                ProductImg img = new ProductImg();
                img.setIid(rs.getInt("iid"));
                img.setPid(rs.getInt("pid"));
                img.setImgpath(rs.getString("imgpath"));
                imgs.add(img);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return imgs;
    }

    
    public IEntity get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    public ArrayList<ProductImg> getByPid(int pid) {
        ArrayList<ProductImg> imgs = new ArrayList<>();
        try {
            String sql = "SELECT iid,pid,imgpath FROM ProductImg Where pid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                ProductImg img = new ProductImg();
                img.setIid(rs.getInt("iid"));
                img.setPid(rs.getInt("pid"));
                img.setImgpath(rs.getString("imgpath"));
                imgs.add(img);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return imgs;
    } 
}
