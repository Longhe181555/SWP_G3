/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.ProductImg;
import entity.ProductItem;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductItemDBContext extends DBContext {

    ProductDBContext pdb = new ProductDBContext();

    
    
    
    public ArrayList<ProductItem> getByPid(int pid) {
        ArrayList<ProductItem> pis = new ArrayList<>();
        try {
            String sql = "SELECT  piid\n"
                    + "      ,stockcount\n"
                    + "      ,pid\n"
                    + "	  ,s.sname\n"
                    + "	  ,c.cname\n"
                    + "  FROM ProductItem pi\n"
                    + "  join Color c on pi.cid = c.cid\n"
                    + "  join Size s on s.sid = pi.sid"
                    + "  Where pid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                ProductItem pi = new ProductItem();
                pi.setPiid(rs.getInt("piid"));
                pi.setColor(rs.getString("cname"));
                pi.setSize(rs.getString("sname"));
                pi.setStockcount(rs.getInt("stockcount"));
                pi.setPid(rs.getInt("pid"));
                
                pis.add(pi);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pis;
    }

    

}
