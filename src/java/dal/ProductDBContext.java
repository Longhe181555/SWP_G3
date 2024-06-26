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

    
    
    
    public ArrayList<Product> list() {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT  p.pid,\n"
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
                    + "       p.isListed, \n"
                    + "       b.bname \n"
                    + "FROM Product p \n"
                    + "LEFT JOIN ProductItem pi ON p.pid = pi.pid \n"
                    + "LEFT JOIN Discount d ON pi.piid = d.piid \n"
                    + "LEFT JOIN DiscountType dt ON d.dtid = dt.dtid \n"
                    + "LEFT JOIN Feedback f ON p.pid = f.pid \n"
                    + "JOIN Category c ON p.catid = c.catid \n"
                    + "JOIN Brand b ON p.bid = b.bid \n"
                    + "Where \n"
                    + "(GETDATE() BETWEEN d.[from] AND d.[to] OR d.[from] IS NULL OR d.[to] IS NULL)\n"
                    + "GROUP BY p.pid, \n"
                    + "         p.pname, \n"
                    + "         p.price, \n"
                    + "         p.description, \n"
                    + "         p.Date, \n"
                    + "         p.catid, \n"
                    + "         c.catname, \n"
                    + "         p.isListed, \n"
                    + "         c.cattype, \n"
                    + "         p.bid, \n"
                    + "         b.bname\n";
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
                p.setIsListed(rs.getBoolean("isListed"));
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

    public ArrayList<Product> listFilter(String search, String category, String brand, int minPrice, int maxPrice) {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT p.pid, p.pname, p.price, "
                    + "MIN(CASE "
                    + "    WHEN dt.type = 'percentage' THEN p.price - (p.price * d.value / 100) "
                    + "    WHEN dt.type = 'fixedAmount' THEN p.price - d.value "
                    + "    ELSE p.price "
                    + "END) AS discountedPrice, "
                    + "CASE "
                    + "    WHEN MIN(dt.type) = 'percentage' THEN CONCAT(MIN(d.value), '%') "
                    + "    WHEN MIN(dt.type) = 'fixedAmount' THEN CONCAT('-', MIN(d.value), 'đ') "
                    + "    ELSE NULL "
                    + "END AS discountDescription, "
                    + "AVG(f.rating) AS avgRating, "
                    + "p.description, p.Date, "
                    + "p.catid, c.catname, c.cattype, "
                    + "p.bid, b.bname "
                    + "FROM Product p "
                    + "LEFT JOIN ProductItem pi ON p.pid = pi.pid "
                    + "LEFT JOIN Discount d ON pi.piid = d.piid "
                    + "LEFT JOIN DiscountType dt ON d.dtid = dt.dtid "
                    + "LEFT JOIN Feedback f ON p.pid = f.pid "
                    + "JOIN Category c ON p.catid = c.catid "
                    + "JOIN Brand b ON p.bid = b.bid "
                    + "WHERE p.isListed != 0 ";

            // Add filters based on parameters
            if (search != null && !search.isEmpty()) {
                sql += "AND p.pname LIKE ? ";
            }
            if (category != null && !category.isEmpty()) {
                sql += "AND p.catid = ? ";
            }
            if (brand != null && !brand.isEmpty()) {
                sql += "AND p.bid = ? ";
            }
            if (minPrice > 0) {
                sql += "AND p.price >= ? ";
            }
            if (maxPrice > 0) {
                sql += "AND p.price <= ? ";
            }
            sql += "AND (GETDATE() BETWEEN d.[from] AND d.[to] OR d.[from] IS NULL OR d.[to] IS NULL) "
                    + "GROUP BY p.pid, p.pname, p.price, p.description, p.Date, p.catid, c.catname, c.cattype, p.bid, b.bname";

            PreparedStatement pstmt = connection.prepareStatement(sql);
            int index = 1;
            // Set parameters
            if (search != null && !search.isEmpty()) {
                pstmt.setString(index++, "%" + search + "%");
            }
            if (category != null && !category.isEmpty()) {
                pstmt.setString(index++, category);
            }
            if (brand != null && !brand.isEmpty()) {
                pstmt.setString(index++, brand);
            }
            if (minPrice > 0) {
                pstmt.setInt(index++, minPrice);
            }
            if (maxPrice > 0) {
                pstmt.setInt(index++, maxPrice);
            }
            ResultSet rs = pstmt.executeQuery();
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
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public void insert(String pname, int price, String description, int catid, int bid, boolean isListed, ArrayList<String> imgpath) {
        try {
            String sql = "INSERT INTO Product(pname,price,description,catid,bid,isListed,Date) values(?,?,?,?,?,?,GETDATE())";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, pname);
            stm.setInt(2, price);
            stm.setString(3, description);
            stm.setInt(4, catid);
            stm.setInt(5, bid);
            stm.setBoolean(6, isListed);
            stm.executeUpdate();
            int pid = getPidByPname(pname);
            for (String path : imgpath) {
            insertImagePath(pid, path);
        }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    private void insertImagePath(int pid, String imagePath) {
    try {
        String sql = "INSERT INTO ProductImg(pid, imgpath) VALUES (?, ?)";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, pid);
        stm.setString(2, imagePath);
        stm.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
    public int getPidByPname(String pname) {
    int pid = -1; // Default value if pname is not found or query fails
    try {
        String sql = "SELECT pid FROM Product WHERE pname = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, pname);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            pid = rs.getInt("pid");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return pid;
}
   
    public Product get(int pid) {
        Product p = new Product();
        try {
            String sql = "SELECT\n"
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
                    + "Where p.pid = ?\n"
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
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, pid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

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

            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return p;
    }
    
    
    
    

    public Product getProductDetail(int pid) {
        Product p = new Product();
        try {
            String sql = "SELECT\n"
                    + "       p.pid, \n"
                    + "       p.pname, \n"
                    + "       price, \n"
                    + "       p.description, \n"
                    + "       p.Date, \n"
                    + "       p.catid, \n"
                    + "       c.catname, \n"
                    + "       c.cattype, \n"
                    + "       p.bid, \n"
                    + "       p.isListed, \n"
                    + "       b.bname \n"
                    + "FROM Product p \n"
                    + "JOIN Category c ON p.catid = c.catid \n"
                    + "JOIN Brand b ON p.bid = b.bid \n"
                    + "Where p.pid = ?\n";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, pid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDescription(rs.getString("description"));
                p.setDate(rs.getDate("Date"));
                p.setIsListed(rs.getBoolean("isListed"));
                Category c = new Category();
                c.setCatid(rs.getInt("catid"));
                c.setCatname(rs.getString("catname"));
                c.setCattype(rs.getString("cattype"));
                p.setCategory(c);
                Brand b = new Brand();
                b.setBid(rs.getInt("bid"));
                b.setBname(rs.getString("bname"));
                p.setBrand(b);
                ArrayList<ProductImg> productImages = pdb.getByPid(p.getPid());
                p.setProductimgs(productImages);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return p;
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
            String sql = "SELECT\n"
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
            String sql = "SELECT\n"
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
                    + "Where p.isListed != 0\n"
                    + "AND d.did is not null \n"
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

    public boolean updateIsListed(int pid, boolean isListed) {
        boolean success = false;
        try {
            String sql = "UPDATE Product SET isListed = ? WHERE pid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, isListed);
            ps.setInt(2, pid);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                success = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return success;
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

    public boolean productNameExists(String productName) {
        try {
        String sql = "SELECT * from Product WHERE pname = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, productName);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                return true;
            }
             } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
