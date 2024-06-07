/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.IEntity;
import entity.*;
import java.sql.*;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductDBContext extends DBContext {

    ProductImgDBContext pdb = new ProductImgDBContext();

    public ArrayList<Product> list() {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT p.pid, p.pname, p.price, "
                    + "MIN(CASE "
                    + "    WHEN dt.type = 'percentage' THEN p.price - (p.price * d.value / 100) "
                    + "    WHEN dt.type = 'fixedAmount' THEN p.price - d.value "
                    + "    ELSE p.price "
                    + "END) AS discountedPrice, "
                    + "CASE "
                    + "    WHEN dt.type = 'percentage' THEN CONCAT(d.value, '%') "
                    + "    WHEN dt.type = 'fixedAmount' THEN CONCAT('-', d.value, 'đ') "
                    + "    ELSE NULL "
                    + "END AS discountDescription, "
                    + "AVG(f.rating) AS avgRating, "
                    + "p.description, p.Date, p.catid, c.catname, c.cattype, "
                    + "p.bid, b.bname "
                    + "FROM Product p "
                    + "LEFT JOIN ProductItem pi ON p.pid = pi.pid "
                    + "LEFT JOIN Discount d ON pi.piid = d.piid "
                    + "LEFT JOIN DiscountType dt ON d.dtid = dt.dtid "
                    + "LEFT JOIN Feedback f ON p.pid = f.pid "
                    + "JOIN Category c ON p.catid = c.catid "
                    + "JOIN Brand b ON p.bid = b.bid "
                    + "GROUP BY p.pid, p.pname, p.price, "
                    + "p.description, p.Date, p.catid, c.catname, c.cattype, "
                    + "p.bid, b.bname";
            Statement stm = connection.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDiscountedPrice(rs.getObject("discountedPrice") != null ? rs.getInt("discountedPrice") : null);
                p.setDiscountDescription(rs.getString("discountDescription"));
                p.setAvarageRating(rs.getObject("avgRating") != null ? rs.getFloat("avgRating") : null);
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

                // Fetch product images
                ArrayList<ProductImg> productImages = pdb.getByPid(p.getPid());
                p.setProductimgs(productImages);

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

    public ArrayList<Product> orderByDate() {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT Top 6\n"
                    + "       p.pid, \n"
                    + "       p.pname, \n"
                    + "       p.price, \n"
                    + "       MIN(CASE \n"
                    + "              WHEN dt.type = 'percentage' THEN p.price - (p.price * d.value / 100) \n"
                    + "              WHEN dt.type = 'fixedAmount' THEN p.price - d.value \n"
                    + "              ELSE p.price \n"
                    + "           END) AS discountedPrice, \n"
                    + "       CASE \n"
                    + "           WHEN MIN(dt.type) = 'percentage' THEN CONCAT(MIN(d.value), '%') \n"
                    + "           WHEN MIN(dt.type) = 'fixedAmount' THEN CONCAT('-', MIN(d.value), 'đ') \n"
                    + "           ELSE NULL \n"
                    + "       END AS discountDescription, \n"
                    + "       AVG(f.rating) AS avgRating, \n"
                    + "       p.description, \n"
                    + "       p.Date, \n"
                    + "       p.catid, \n"
                    + "       c.catname, \n"
                    + "       c.cattype, \n"
                    + "       p.bid, \n"
                    + "       b.bname \n"
                    + "FROM Product p \n"
                    + "LEFT JOIN ProductItem pi ON p.pid = pi.pid \n"
                    + "LEFT JOIN Discount d ON pi.piid = d.piid \n"
                    + "LEFT JOIN DiscountType dt ON d.dtid = dt.dtid \n"
                    + "LEFT JOIN Feedback f ON p.pid = f.pid \n"
                    + "JOIN Category c ON p.catid = c.catid \n"
                    + "JOIN Brand b ON p.bid = b.bid \n"
                    + "Where p.pid != 0\n"
                    + "GROUP BY p.pid, \n"
                    + "         p.pname, \n"
                    + "         p.price, \n"
                    + "         p.description, \n"
                    + "         p.Date, \n"
                    + "         p.catid, \n"
                    + "         c.catname, \n"
                    + "         c.cattype, \n"
                    + "         p.bid, \n"
                    + "         b.bname\n"
                    + "ORDER BY [Date] DESC";
            Statement stm = connection.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            while (rs.next()) {
               Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDiscountedPrice(rs.getInt("discountedPrice"));
                p.setDiscountDescription(rs.getString("discountDescription"));
                p.setAvarageRating(rs.getFloat("avgRating"));
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

                // Fetch product images
                ArrayList<ProductImg> productImages = pdb.getByPid(p.getPid());
                p.setProductimgs(productImages);

                products.add(p);
            }
            return products;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Product> getDiscountedProducts() {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT p.pid, p.pname, p.price, "
                    + "MIN(CASE "
                    + "    WHEN dt.type = 'percentage' THEN p.price - (p.price * d.value / 100) "
                    + "    WHEN dt.type = 'fixedAmount' THEN p.price - d.value "
                    + "    ELSE p.price "
                    + "END) AS discountedPrice, "
                    + "MIN(CASE "
                    + "    WHEN dt.type = 'percentage' THEN CONCAT('-', d.value, '%') "
                    + "    WHEN dt.type = 'fixedAmount' THEN CONCAT('-', d.value) "
                    + "    ELSE '' "
                    + "END) AS discountDescription, "
                    + "p.description, p.Date, p.catid, c.catname, c.cattype, "
                    + "p.bid, b.bname "
                    + "FROM Product p "
                    + "JOIN ProductItem pi ON p.pid = pi.pid "
                    + "LEFT JOIN Discount d ON pi.piid = d.piid "
                    + "LEFT JOIN DiscountType dt ON d.dtid = dt.dtid "
                    + "JOIN Category c ON p.catid = c.catid "
                    + "JOIN Brand b ON p.bid = b.bid "
                    + "WHERE d.piid IS NOT NULL "
                    + "AND GETDATE() BETWEEN d.[from] AND d.[to] "
                    + "GROUP BY p.pid, p.pname, p.price, "
                    + "p.description, p.Date, p.catid, c.catname, c.cattype, "
                    + "p.bid, b.bname";
            Statement stm = connection.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDiscountedPrice(rs.getInt("discountedPrice"));
                p.setDiscountDescription(rs.getString("discountDescription"));
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

                // Fetch product images
                ArrayList<ProductImg> productImages = pdb.getByPid(p.getPid());
                p.setProductimgs(productImages);

                products.add(p);
            }
            return products;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
