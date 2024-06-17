/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.IEntity;
import entity.*;
import jakarta.servlet.http.Part;
import java.sql.*;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
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
                    + "      ,p.[description]\n"
                    + "  FROM [Product] p\n"
                    + "  join Brand b on b.bid = p.bid\n"
                    + "  join Category c on c.catid = p.catid \n Where p.isListed = 1";
            Statement stm = connection.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setProductimgs(pdb.getByPid(p.getPid()));
                p.setDescription(rs.getString("description"));
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
    public Product get(int pid) {
        Product product = null;
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
                    + "      ,p.[description]\n"
                    + "      ,p.[Date]\n"
                    + "  FROM [Product] p\n"
                    + "  join Brand b on b.bid = p.bid\n"
                    + "  join Category c on c.catid = p.catid \n"
                    + "  WHERE p.pid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, pid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product();
                product.setPid(rs.getInt("pid"));
                product.setPname(rs.getString("pname"));
                product.setPrice(rs.getInt("price"));
                product.setProductimgs(pdb.getByPid(product.getPid()));
                product.setDescription(rs.getString("description"));
                product.setDate(rs.getDate("Date"));
                Category c = new Category();
                c.setCatid(rs.getInt("catid"));
                c.setCatname(rs.getString("catname"));
                c.setCattype(rs.getString("cattype"));
                product.setCategory(c);
                Brand b = new Brand();
                b.setBid(rs.getInt("bid"));
                b.setBname(rs.getString("bname"));
                product.setBrand(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return product;
    }

    public ArrayList<ArrayList<Product>> listPage() {
        ArrayList<ArrayList<Product>> pages = new ArrayList<>();
        ArrayList<Product> page = new ArrayList<>();
        try {
            String sql = "SELECT p.[pid]\n"
                    + "      ,p.[pname]\n"
                    + "      ,p.[price]\n"
                    + "      ,p.[catid]\n"
                    + "	     ,b.bname\n"
                    + "	     ,c.catname\n"
                    + "	     ,c.cattype\n"
                    + "      ,p.[description]\n"
                     + "      ,p.[Date]\n"
                    + "      ,p.[bid]\n"
                    + "      ,p.[islisted]\n"
                    + "  FROM [Product] p\n"
                    + "  join Brand b on b.bid = p.bid\n"
                    + "  join Category c on c.catid = p.catid \n Where p.isListed = 1";
            Statement stm = connection.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setProductimgs(pdb.getByPid(p.getPid()));
                p.setDescription(rs.getString("description"));
                p.setDate(rs.getDate("Date"));
                Category c = new Category();
                c.setCatid(rs.getInt("catid"));
                c.setCatname(rs.getString("catname"));
                c.setCattype(rs.getString("cattype"));
                p.setCategory(c);
                Brand b = new Brand();
                b.setBid(rs.getInt("bid"));
                b.setBname(rs.getString("bname"));
                p.setBrand(b);
                page.add(p);
                if (page.size() == 16) {
                    pages.add(new ArrayList<>(page));
                    page.clear();
                }
            }

            if (!page.isEmpty()) {
                pages.add(new ArrayList<>(page));
            }
            return pages;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<ArrayList<Product>> listPage(String sort, String filter, String sortByDate) {
    ArrayList<ArrayList<Product>> pages = new ArrayList<>();
    ArrayList<Product> page = new ArrayList<>();
    StringBuilder sql = new StringBuilder();

    try {
        sql.append("SELECT p.[pid], p.[pname], p.[price], p.[catid], b.bname, c.catname, c.cattype, p.[bid], p.[islisted], p.[description], p.[Date] ");
        sql.append("FROM [Product] p ");
        sql.append("JOIN Brand b ON b.bid = p.bid ");
        sql.append("JOIN Category c ON c.catid = p.catid ");
        sql.append("WHERE p.isListed = 1 ");

        if (filter != null && !filter.isEmpty()) {
            sql.append("AND c.cattype = ? ");
        }

        if (sort != null && !sort.isEmpty()) {
            if (sort.equals("asc")) {
                sql.append("ORDER BY p.price ASC ");
            } else if (sort.equals("desc")) {
                sql.append("ORDER BY p.price DESC ");
            }
        } else if (sortByDate != null && !sortByDate.isEmpty()) {
            if (sortByDate.equals("asc")) {
                sql.append("ORDER BY p.Date ASC ");
            } else if (sortByDate.equals("desc")) {
                sql.append("ORDER BY p.Date DESC ");
            }
        }

        PreparedStatement stm = connection.prepareStatement(sql.toString());

        int paramIndex = 1;
        if (filter != null && !filter.isEmpty()) {
            stm.setString(paramIndex++, filter);
        }

        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            Product p = new Product();
            p.setPid(rs.getInt("pid"));
            p.setPname(rs.getString("pname"));
            p.setPrice(rs.getInt("price"));
            p.setProductimgs(pdb.getByPid(p.getPid()));
            p.setDescription(rs.getString("description"));
            p.setDate(rs.getDate("Date")); // Assuming the Product class has a setDateAdded method
            Category c = new Category();
            c.setCatid(rs.getInt("catid"));
            c.setCatname(rs.getString("catname"));
            c.setCattype(rs.getString("cattype"));
            p.setCategory(c);
            Brand b = new Brand();
            b.setBid(rs.getInt("bid"));
            b.setBname(rs.getString("bname"));
            p.setBrand(b);
            page.add(p);
            if (page.size() == 16) {
                pages.add(new ArrayList<>(page));
                page.clear();
            }
        }

        if (!page.isEmpty()) {
            pages.add(new ArrayList<>(page));
        }
        return pages;
    } catch (SQLException ex) {
        Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null;
}
     public void updateProduct(Product product, List<Part> imageParts) {
        
        try {
            String updateQuery = "UPDATE Product SET pname = ?, price = ?, description = ?, bid = ? WHERE pid = ?";
            PreparedStatement stm = connection.prepareStatement(updateQuery);
            stm.setString(1, product.getPname());
            stm.setDouble(2, product.getPrice());
            stm.setString(3, product.getDescription());
            stm.setInt(4, product.getBrand().getBid());
            stm.setInt(5, product.getPid());
            stm.executeUpdate();
            
            // Handle image upload if necessary
            if (!imageParts.isEmpty()) {
                // Implement your logic to save the uploaded images
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
}
}
