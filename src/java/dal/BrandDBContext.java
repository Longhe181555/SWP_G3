package dal;

import entity.Brand;
import entity.IEntity;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BrandDBContext extends DBContext {

    @Override
    public ArrayList<Brand> list() {
        ArrayList<Brand> brands = new ArrayList<>();
        try {
            String sql = "SELECT bid,bname,img FROM Brand WHERE bid != 0";
            Statement stm = connection.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setImg(rs.getString("img"));
                brand.setBid(rs.getInt("bid"));
                brand.setBname(rs.getString("bname"));
                brands.add(brand);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return brands;
    }

    @Override
    public void insert(IEntity entity) {
        Brand brand = (Brand) entity;
        try {
            String sql = "INSERT INTO Brand (bname) VALUES (?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, brand.getBname());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void update(IEntity entity) {
        Brand brand = (Brand) entity;
        try {
            String sql = "UPDATE Brand SET bname=? WHERE bid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, brand.getBname());
            stm.setInt(2, brand.getBid());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void delete(IEntity entity) {
        Brand brand = (Brand) entity;
        try {
            String sql = "DELETE FROM Brand WHERE bid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, brand.getBid());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public IEntity get(int id) {
        try {
            String sql = "SELECT bid,bname FROM Brand WHERE bid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Brand brand = new Brand();
                brand.setBid(rs.getInt("bid"));
                brand.setBname(rs.getString("bname"));
                return brand;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
