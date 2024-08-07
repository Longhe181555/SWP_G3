/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.common;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.OrderDBContext;
import dal.ProductItemDBContext;
import entity.Account;
import entity.Order;
import entity.ProductItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public class ViewOrderHistoyController extends BaseRequiredAuthenticationController {
   
  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Account account = (Account) request.getSession().getAttribute("account");
            OrderDBContext odb = new OrderDBContext();
            ArrayList<Order> orders = odb.getByAid(account.getAid());
            System.out.println(orders.size());
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("common/orderhistory.jsp").forward(request, response);
        }
    } 

  

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response,Account account)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response,Account account)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
