/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.IEntity;
import entity.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductDBContext extends DBContext {
 ProductImgDBContext pdb = new ProductImgDBContext();
    @Override
    public ArrayList<Product> list() {
        ArrayList<Product> products = new ArrayList<Product>();
        try {
            String sql = "SELECT p.[pid]\n"
                    + "      ,p.[pname]\n"
                    + "      ,p.[price]\n"
                    + "      ,p.[catid]\n"
                    + "	     ,b.bname\n"
                    + "	     ,c.catname\n"
                    + "	     ,c.cattype\n"
                    + "      ,p.[bid]\n"
                    + "      ,p.[islisted]\n"
                    + "  FROM [Product] p\n"
                    + "  join Brand b on b.bid = p.bid\n"
                    + "  join Category c on c.catid = p.catid";
            Statement stm = connection.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getFloat("price"));
                p.setProductimgs(pdb.getByPid(p.getPid()));
                Category c = new Category();
                c.setCatid(rs.getInt("catid"));
                c.setCatname(rs.getString("catname"));
                c.setCattype(rs.getString("cattype"));
                p.setCategory(c);
                Brand b = new Brand();
                b.setBid(rs.getInt("bid"));
                b.setBname(rs.getString("bname"));
                p.setBrand(b);
                products.add(p);
            }
            return products;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
//SELECT [pid]
    //     ,[pname]
    //    ,[price]
    //   ,[catid]
    //  ,[bid]
    //    ,[productimg]
    //    ,[islisted]
    // FROM [Product]

    @Override
    public void insert(IEntity entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(IEntity entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(IEntity entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public IEntity get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
