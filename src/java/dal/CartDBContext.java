/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartDBContext extends DBContext {

    ProductDBContext pdb = new ProductDBContext();
    ProductImgDBContext pidb = new ProductImgDBContext();

    public ArrayList<Cart> getByAid(int aid) {
        ArrayList<Cart> carts = new ArrayList<>();
        try {
            String sql = "Select c.aid,c.soldPrice,p.pid,p.pname,p.price,pi.piid,pi.stockcount,c.cartid,c.amount,color.cname,s.sname,c.soldPrice,d.did,d.[from],d.[to],d.[value],dt.type,c.product_status "
                    + "from Cart c "
                    + "JOIN ProductItem pi on c.piid = pi.piid "
                    + "JOIN Size s on s.sid = pi.sid "
                    + "JOIN Color color on color.cid = pi.cid "
                    + "LEFT JOIN Product p on pi.pid = p.pid "
                    + "LEFT JOIN Discount d on c.did = d.did "
                    + "LEFT JOIN DiscountType dt on dt.dtid = d.dtid "
                    + "WHERE c.aid = ? ORDER BY c.cartid DESC";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, aid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cart c = new Cart();
                c.setAid(rs.getInt("aid"));
                c.setCartid(rs.getInt("cartid"));
                checkValidDiscount(c.getCartid());
                c.setProduct_status(rs.getString("product_status"));
                c.setAmount(rs.getInt("amount"));
                c.setProduct_status(rs.getString("product_status"));
                c.setSoldPrice(rs.getInt("soldPrice"));
                ProductItem pi = new ProductItem();
                pi.setPiid(rs.getInt("piid"));
                pi.setSize(rs.getString("sname"));
                pi.setColor(rs.getString("cname"));
                pi.setStockcount(rs.getInt("stockcount"));
                Discount d = new Discount();
                d.setDid(rs.getInt("did"));
                d.setDtype(rs.getString("type"));
                d.setFrom(rs.getDate("from"));
                d.setTo(rs.getDate("to"));
                d.setValue(rs.getInt("value"));
                pi.setDiscount(d);
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setProductimgs(pidb.getByPid(rs.getInt("pid")));
                pi.setProduct(p);
                c.setProductItem(pi);

                carts.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return carts;
    }

    public boolean updateCartAmount(int cartId, int newAmount) {
        try {
            String sql = "UPDATE Cart SET amount = ? WHERE cartid = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, newAmount);
            stmt.setInt(2, cartId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void addToCart(int amount, int soldPrice, int aid, int piid, int did) {
        // Check if the item already exists in the cart
        String selectSql = "SELECT cartid,amount FROM Cart WHERE aid = ? AND piid = ?";
        String insertSql = "INSERT INTO Cart (amount, soldPrice, aid, piid, did) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement selectStmt = connection.prepareStatement(selectSql)) {
            selectStmt.setInt(1, aid);
            selectStmt.setInt(2, piid);
            ResultSet resultSet = selectStmt.executeQuery();
            if (resultSet.next()) {
                int cartId = resultSet.getInt("cartid");
                int prev_amount = resultSet.getInt("amount");
                updateCartAmount(cartId, prev_amount + amount);
            } else {

                try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, amount);
                    insertStmt.setInt(2, soldPrice);
                    insertStmt.setInt(3, aid);
                    insertStmt.setInt(4, piid);
                    insertStmt.setInt(5, did);

                    insertStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addToCart(int amount, int soldPrice, int aid, int piid) {
        String selectSql = "SELECT cartid,amount FROM Cart WHERE aid = ? AND piid = ?";
        String insertSql = "INSERT INTO Cart (amount, soldPrice, aid, piid) VALUES (?, ?, ?, ?)";
        try (PreparedStatement selectStmt = connection.prepareStatement(selectSql)) {
            selectStmt.setInt(1, aid);
            selectStmt.setInt(2, piid);
            ResultSet resultSet = selectStmt.executeQuery();
            if (resultSet.next()) {
                int cartId = resultSet.getInt("cartid");
                int prev_amount = resultSet.getInt("amount");
                updateCartAmount(cartId, prev_amount + amount);
            } else {
                try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, amount);
                    insertStmt.setInt(2, soldPrice);
                    insertStmt.setInt(3, aid);
                    insertStmt.setInt(4, piid);
                    insertStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeCartItem(int cartid) {
        try {
            String sql = "DELETE FROM Cart WHERE cartid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cartid);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void checkValidDiscount(int cartid) {
        try {
            String sql = "UPDATE Cart "
                    + "SET did = NULL, product_status = 'DiscountEnded' "
                    + "FROM Cart c "
                    + "LEFT JOIN Discount d ON c.did = d.did "
                    + "WHERE c.cartid = ? "
                    + "AND (GETDATE() < d.[from] OR GETDATE() > d.[to])";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cartid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void clearProductStatus(int aid) {
    try {
            String sql = "UPDATE Cart SET product_status = NULL WHERE aid = ? AND product_status <> 'Archived'";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, aid);
            stm.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(BrandDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
}
    public void removeCartByAid(int aid) {
    try {
        String sql = "DELETE FROM Cart WHERE aid = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, aid);
        ps.executeUpdate();
    } catch (SQLException ex) {
        Logger.getLogger(CartDBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
}
}
