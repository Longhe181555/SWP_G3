/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.response.CartResponse;
import entity.Account;
import entity.Brand;
import entity.Cart;
import entity.Category;
import entity.Product;
import entity.Size;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author chi
 */
public class CartDBContext extends DBContext<Cart> {

    @Override
    public ArrayList<Cart> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Cart cart) {
        try {
            String sql = "INSERT INTO [Cart] "
                    + "([amount], [totalprice], [aid], [color_id], [pid], [size_id]) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cart.getAmount());
            stm.setDouble(2, cart.getTotalPrice());
            stm.setInt(3, cart.getAccountId());
            stm.setInt(4, cart.getColorId());
            stm.setInt(5, cart.getProductId());
            stm.setInt(6, cart.getSizeId());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDBContext.class.getName()).log(Level.SEVERE, "SQL Exception: " + ex.getMessage(), ex);
        }
    }

    public int checkQuantity(int pid, int cid, int sid) {
        int stockCount = 0; 
        try {
            String sql = "SELECT [stockcount] FROM [SWP_G3].[dbo].[ProductItem] WHERE pid = ? AND sid = ? AND cid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            stm.setInt(2, sid);
            stm.setInt(3, cid);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                stockCount = rs.getInt("stockcount");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDBContext.class.getName()).log(Level.SEVERE, "SQL Exception: " + ex.getMessage(), ex);
        }
        return stockCount;
    }

    public List<CartResponse> getAllCartByAccountId(int aid) {
        List<CartResponse> response = new ArrayList<>();
        String sql = "SELECT DISTINCT c.cartid,\n"
                + "                c.amount,\n"
                + "                c.totalprice,\n"
                + "                c.pid,\n"
                + "                c.size_id,\n"
                + "                s.sname,\n"
                + "                c.color_id,\n"
                + "                co.cname,\n"
                + "                pm.imgpath,\n"
                + "                p.pname,\n"
                + "                p.price,\n"
                + "                d.value,\n"
                + "                dt.type,\n"
                + "                pi.stockcount \n"
                + "FROM [SWP_G3].[dbo].[Cart] c\n"
                + "JOIN [Product] p ON c.pid = p.pid\n"
                + "JOIN Size s ON s.sid = c.size_id\n"
                + "JOIN Color co ON co.cid = c.color_id\n"
                + "LEFT JOIN ProductItem pi ON pi.pid = c.pid AND pi.sid = c.size_id AND pi.cid = c.color_id\n"
                + "LEFT JOIN Discount d ON d.piid = pi.piid \n"
                + "LEFT JOIN DiscountType dt ON dt.dtid = d.dtid\n"
                + "JOIN (\n"
                + "    SELECT pid, MIN(imgpath) AS imgpath\n"
                + "    FROM [ProductImg]\n"
                + "    GROUP BY pid\n"
                + ") pm ON p.pid = pm.pid\n"
                + "WHERE c.aid = ?;";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, aid);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartResponse s = new CartResponse();
                    s.setCartId(rs.getInt(1));
                    s.setColorId(rs.getInt(7));
                    s.setColorName(rs.getString(8));
                    s.setQuantity(rs.getInt(2));
                    s.setTotalPrice(rs.getDouble(3));
                    s.setProductId(rs.getInt(4));
                    s.setSizeId(rs.getInt(5));
                    s.setSizeName(rs.getString(6));
                    s.setImgPath(rs.getString(9));
                    s.setProductName(rs.getString(10));
                    s.setPrice(rs.getDouble(11));
                    s.setValue(rs.getDouble(12));
                    s.setDiscountType(rs.getString(13));
                    s.setStock(rs.getInt(14));
                    response.add(s);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response;
    }

    public static void main(String[] args) {
        CartDBContext d = new CartDBContext();
        System.out.println(d.checkQuantity(1, 2, 2));
    }

    @Override
    public void update(Cart entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Cart entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Cart get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Cart checkCartExist(int aid, int productId) {
        Cart cart = null;
        try {
            String sql = "SELECT * FROM Cart WHERE aid = ? AND pid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(2, productId);
            ps.setInt(1, aid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                cart = new Cart();
                cart.setCartId(rs.getInt(1));
                cart.setAmount(rs.getInt(2));
                cart.setTotalPrice(rs.getDouble(3));
                cart.setAccountId(rs.getInt(4));
                cart.setColorId(rs.getInt(5));
                cart.setProductId(rs.getInt(6));
                cart.setSizeId(rs.getInt(7));

            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cart;
        //throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void updateToCart(int cartId, int quantity, double amount) {
        String query = "UPDATE [dbo].[Cart]\n"
                + "   SET [amount] = ?\n"
                + "      ,[totalprice] = ?\n"
                + " WHERE cartid =?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setDouble(2, amount);
            ps.setInt(1, quantity);
            ps.setInt(3, cartId);
            ps.executeUpdate();
        } catch (Exception e) {
            // Xử lý exception, có thể log hoặc throw ra ngoài để báo lỗi
            return;
        }
    }

    public void deleteCart(int cartId) {
        String query = "DELETE FROM [dbo].[Cart]\n"
                + "      WHERE cartid = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (Exception e) {
            // Xử lý exception, có thể log hoặc throw ra ngoài để báo lỗi
            return;
        }
    }

}
