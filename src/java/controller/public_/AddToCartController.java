/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.public_;

import dal.CartDBContext;
import dal.OrderDBContext;
import dal.OrderDetailDBContext;
import dal.ProductDBContext;
import dto.response.CartResponse;
import entity.Account;
import entity.Cart;
import entity.Order;
import entity.OrderDetail;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;


public class AddToCartController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        
        if (account == null) {
            // Redirect to login page or display an error message
            response.sendRedirect("login");
            return;
        }
        
        int pId = Integer.parseInt(request.getParameter("productId"));
        int colorId = Integer.parseInt(request.getParameter("color"));
        int sizeId = Integer.parseInt(request.getParameter("size"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String action = request.getParameter("action");

        CartDBContext db = new CartDBContext();
        int availableStock = db.checkQuantity(pId, colorId, sizeId);

        if (quantity > availableStock) {
            request.setAttribute("message", "Số lượng vượt quá kho");
            request.getRequestDispatcher("ListCart").forward(request, response);
            return;
        }

        ProductDBContext pdb = new ProductDBContext();
        Product product = pdb.get(pId);

        if ("buyNow".equals(action)) {
            db.insert(new Cart(quantity, quantity * product.getPrice(), account.getAid(), colorId, pId, sizeId));
            List<CartResponse> list = new ArrayList<>();
            CartDBContext dbc = new CartDBContext();
            list = dbc.getAllCartByAccountId(account.getAid());

            OrderDetailDBContext detailDBContext = new OrderDetailDBContext();

            double totalPrice = 0;
            double totalDiscount = 0;

            for (CartResponse item : list) {
                double itemTotalPrice = item.getPrice() * item.getQuantity();
                double itemDiscount = 0;

                if ("percentage".equals(item.getDiscountType())) {
                    itemDiscount = (item.getValue() * itemTotalPrice) / 100;
                } else if ("fixedAmount".equals(item.getDiscountType())) {
                    itemDiscount = item.getValue();
                }

                totalPrice += itemTotalPrice;
                totalDiscount += itemDiscount;
            }

            OrderDBContext dbd = new OrderDBContext();
            dbd.insert(new Order(account.getAid(), totalPrice - totalDiscount));
            int orderId = dbd.getLastOrder();

            for (CartResponse item : list) {
                detailDBContext.insert(new OrderDetail(orderId, item.getQuantity(), item.getProductId(), item.getSizeId(), item.getColorId()));
                dbc.deleteCart(item.getCartId());
            }

            request.getRequestDispatcher("thankyou.jsp").forward(request, response);

        } else {
            db.insert(new Cart(quantity, quantity * product.getPrice(), account.getAid(), colorId, pId, sizeId));

            response.sendRedirect("ListCart");
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
