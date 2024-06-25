/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Product;
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
                    + "   ,stockcount\n"
                    + "   ,pid\n"
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
                Product p = pdb.getProductDetail(rs.getInt(pid));
                pi.setProduct(p);

                pis.add(pi);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pis;
    }

    public ArrayList<ProductItem> getStockList() {
        ArrayList<ProductItem> pis = new ArrayList<>();
        try {
            String sql = "SELECT \n"
                    + "    p.pid,\n"
                    + "    p.pname,\n"
                    + "    p.price,\n"
                    + "    p.[description],\n"
                    + "    p.catid,\n"
                    + "    p.bid,\n"
                    + "    p.islisted,\n"
                    + "    p.Date,\n"
                    + "	b.bname,\n"
                    + "	c.catname,\n"
                    + "    SUM(pi.stockcount) AS totalStockcount\n"
                    + "FROM \n"
                    + "    Product p\n"
                    + "LEFT JOIN ProductItem pi ON p.pid = pi.pid\n"
                    + "LEFT JOIN Brand b on p.bid = b.bid\n"
                    + "LEFT JOIN Category c on p.catid = c.catid\n"
                    + "GROUP BY \n"
                    + "    p.pid, \n"
                    + "    p.pname, \n"
                    + "    p.price, \n"
                    + "    p.[description], \n"
                    + "    p.catid, \n"
                    + "    p.bid, \n"
                    + "    p.islisted, \n"
                    + "    p.Date,\n"
                    + "	b.bname,\n"
                    + "	c.catname";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int pid = rs.getInt("pid");
                Product p =  pdb.getProductDetail(pid);
                ProductItem pi = new ProductItem();
                pi.setProduct(p);
                pi.setStockcount(rs.getInt("totalStockcount"));

                pis.add(pi);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pis;
    }

}
