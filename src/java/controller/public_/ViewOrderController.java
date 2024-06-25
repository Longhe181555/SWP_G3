/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.public_;

import dal.OrderDBContext;
import entity.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author duong
 */
public class ViewOrderController extends HttpServlet {

 
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewOrderController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewOrderController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private OrderDBContext orderDB = new OrderDBContext();
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        List<Order> orders = orderDB.getOrders();
//        System.out.println("Orders retrieved: " + orders.size());
//          for (Order order : orders) {
//            System.out.println("Order ID: " + order.getOrid());
//        }
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("public/orderlist.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        String orderid = request.getParameter("orid");
//        String aid = request.getParameter("aid");
//        String date = request.getParameter("date");
//        String status = request.getParameter("status");
//        String description = request.getParameter("description");
//        String pmid = request.getParameter("pmid");
//            System.out.println("Order ID: " + orderid);
//    System.out.println("User ID: " + aid);
//    System.out.println("Date: " + date);
//    System.out.println("Description: " + description);
//    System.out.println("Status: " + status);
//    System.out.println("Payment Method ID: " + pmid);
//         Order order = new Order();
//    order.setOrid(Integer.parseInt(orderid));
//    order.setAid(Integer.parseInt(aid));
//    order.setDate(date);
//    order.setStatus(status);
//    order.setDescription(description);
//    order.setPmid(Integer.parseInt(pmid));
//
//    request.setAttribute("order", order);
//    request.getRequestDispatcher("orderdetails.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
