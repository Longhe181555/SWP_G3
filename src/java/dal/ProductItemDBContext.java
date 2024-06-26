/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Color;
import entity.Product;
import entity.ProductItem;
import entity.Size;
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
                Product p = pdb.getProductDetail(pid);
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
    
   public boolean updateStock(int piid, int newStockCount) {
        try {
            String sql = "UPDATE ProductItem SET stockcount = ? WHERE piid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, newStockCount);
            stm.setInt(2, piid);
            int rowsUpdated = stm.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductItemDBContext.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
   
    public boolean updateStock(int sid,int cid, int pid, int newStockCount) {
        try {
            String sql = "UPDATE ProductItem SET stockcount = ? WHERE sid = ? AND cid = ? AND pid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, newStockCount);
            stm.setInt(2, sid);
            stm.setInt(3, cid);
            stm.setInt(4, pid);
            int rowsUpdated = stm.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductItemDBContext.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public int getCurrentStock(int sid,int cid, int pid) {
       int stockcount = 0;
        try {
            String sql = "SELECT stockcount from ProductItem WHERE sid = ? AND cid = ? AND pid = ? ";
                  
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, sid);
            stm.setInt(2, cid);
            stm.setInt(3, pid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
               stockcount = rs.getInt("stockcount");
               return stockcount;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return stockcount;
    }

   
   
   public ArrayList<Color> colorList() {
        ArrayList<Color> colors = new ArrayList<>();
        try {
            String sql ="Select cid,cname from Color";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
              Color c = new Color();
              c.setCid(rs.getInt("cid"));
              c.setCname(rs.getString("cname"));
              colors.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return colors;
    }
    public ArrayList<Size> sizeList() {
        ArrayList<Size> sizes = new ArrayList<>();
        try {
            String sql ="Select sid,sname from Size where gender = 1";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
              Size s = new Size();
              s.setSid(rs.getInt("sid"));
              s.setSname(rs.getString("sname"));
              sizes.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sizes;
    }
    public void addProductItem(int sid, int cid, int stockcount,int pid) {
        try {
          
            String checkSql = "SELECT piid FROM ProductItem WHERE sid = ? AND cid = ? AND pid = ?";
            PreparedStatement checkStm = connection.prepareStatement(checkSql);
            checkStm.setInt(1, sid);
            checkStm.setInt(2, cid);
            checkStm.setInt(3, pid);
            ResultSet rs = checkStm.executeQuery();
            
            if (rs.next()) {
              
            } else {
           
                String insertSql = "INSERT INTO ProductItem (sid, cid, stockcount,pid) VALUES (?, ?, ?,?)";
                PreparedStatement insertStm = connection.prepareStatement(insertSql);
                insertStm.setInt(1, sid);
                insertStm.setInt(2, cid);
                insertStm.setInt(3, stockcount);
                insertStm.setInt(4, pid);
                insertStm.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductItemDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
   
   public boolean checkProductItemExists(int size, int color,int pid) {
    try {
        String sql = "SELECT * FROM ProductItem WHERE sid = ? AND cid = ? AND pid = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, size);
        stm.setInt(2, color);
        stm.setInt(3, pid);
        ResultSet rs = stm.executeQuery();
        return (rs.next());
    } catch (SQLException ex) {
        Logger.getLogger(ProductItemDBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
}
}
