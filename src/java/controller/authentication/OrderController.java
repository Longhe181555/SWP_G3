/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authentication;

import dal.CartDBContext;
import dal.OrderDBContext;
import dal.OrderDetailDBContext;
import dto.response.CartResponse;
import entity.Account;
import entity.Order;
import entity.OrderDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author chi
 */
public class OrderController extends HttpServlet {

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

        OrderDBContext db = new OrderDBContext();
        db.insert(new Order(account.getAid(), totalPrice - totalDiscount));
        int orderId = db.getLastOrder();
        
        for (CartResponse item : list) {
            detailDBContext.insert(new OrderDetail(orderId, item.getQuantity(), item.getProductId(), item.getSizeId(), item.getColorId()));
            dbc.deleteCart(item.getCartId());
        }
        
        request.getRequestDispatcher("thankyou.jsp").forward(request, response);

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
