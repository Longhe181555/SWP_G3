/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.common;

import dal.OrderDBContext;
import entity.Account;
import entity.Cart;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class PaymentProcessController extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            OrderDBContext odb = new OrderDBContext();
         String vnp_Amount =  request.getParameter("vnp_Amount");
         String vnp_BankCode =  request.getParameter("vnp_BankCode");
         String vnp_OrderInfo =  request.getParameter("vnp_OrderInfo");
         String vpn_ResponseCode = request.getParameter("vnp_ResponseCode");
         String vpn_CardType = request.getParameter("vnp_CardType");
         String vnp_PayDate = request.getParameter("vnp_PayDate");
         int responseCode = Integer.parseInt(vpn_ResponseCode);
          if(responseCode == 00) {
              System.out.println(vnp_Amount + " | " + vnp_BankCode + " | " + vnp_OrderInfo);
              ArrayList<Cart> carts =  (ArrayList<Cart>) request.getAttribute("carts");
              
              int amount = Integer.parseInt(vnp_Amount.substring(0, vnp_Amount.length() - 2));
               SimpleDateFormat sdfInput = new SimpleDateFormat("yyyyMMddHHmmss");
               Date date = sdfInput.parse(vnp_PayDate);
               SimpleDateFormat sdfOutput = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
               String formattedDate = sdfOutput.format(date);
               String payment = "Bank: " + vnp_BankCode + " - Type: " + vpn_CardType + " - Pay Date:" + formattedDate;
               Account account = (Account) request.getSession().getAttribute("account");
               String address = (String) request.getSession().getAttribute("orderAddress");
               String note = (String) request.getSession().getAttribute("note");
               odb.createOrder(account.getAid(), note , amount, payment , address, carts);
               response.sendRedirect("common/thankyou.jsp");
          } else if (responseCode == 24) {
              request.getRequestDispatcher("vcart?response=OrderCancelled").forward(request, response);
          }
          
        } catch (ParseException ex) {
            Logger.getLogger(PaymentProcessController.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
