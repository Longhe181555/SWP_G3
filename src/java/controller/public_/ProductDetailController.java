/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.public_;

import dal.FeedbackDBContext;
import dal.ProductDBContext;
import entity.Feedback;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="ProductDetailController", urlPatterns={"/ProductDetailController"})
public class ProductDetailController extends HttpServlet {
   
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
           
        }
    } 

   
    private ProductDBContext productDB = new ProductDBContext();
    private FeedbackDBContext feedbackDB = new FeedbackDBContext();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pidStr = request.getParameter("pid");
        if (pidStr != null) {
            try {
                int pid = Integer.parseInt(pidStr);
                Product product = productDB.get(pid);
                request.setAttribute("product", product);
                ArrayList<Feedback> fs = feedbackDB.getByPid(pid);
                float temp = feedbackDB.getAverageRatingByPid(pid);
                request.setAttribute("avr", temp);
                request.setAttribute("fs", fs);
                request.getRequestDispatcher("public/productdetail.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                // handle error
            }
        } else {
            response.sendRedirect("homepage");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
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
