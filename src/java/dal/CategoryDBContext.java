/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package dal;

import entity.Category;
import entity.IEntity;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class CategoryDBContext extends DBContext {


    public ArrayList list() {
        ArrayList<Category> cats = new ArrayList<>();
        try {
            String sql = "SELECT catid,catname,cattype from Category WHERE catid != 0";
            Statement stm = connection.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            while (rs.next()) {
                Category c = new Category();
                c.setCatid(rs.getInt("catid"));
                c.setCatname(rs.getString("catname"));
                c.setCattype(rs.getString("cattype"));
                cats.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cats;
    }

  
  
}
