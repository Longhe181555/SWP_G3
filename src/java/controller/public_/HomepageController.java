/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.public_;

import dal.*;
import entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import util.ProductSortHelper;


@WebServlet(name="HomepageController")
public class HomepageController extends HttpServlet {
   
 
  
protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
        ProductDBContext pdb = new ProductDBContext();
        BrandDBContext bdb = new BrandDBContext();
        ProductSortHelper ps = new ProductSortHelper();
        ArrayList<Product> newProduct =  pdb.orderByDate();
        request.setAttribute("newProduct", newProduct);
        ArrayList<Product> discountedProduct = pdb.getDiscountedProducts();
        ArrayList<Product> highRatingProducts = ps.getFirstSixElements(ps.sortByRatingDescending(pdb.list()));
        request.setAttribute("highRatingProducts", highRatingProducts);
        ArrayList<Brand> brands = bdb.list();
        request.setAttribute("brands", brands);   
        request.setAttribute("discountedProduct", discountedProduct);
        request.getRequestDispatcher("/public/homepage.jsp").forward(request, response); 
    }
}

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    Account currentUser = (Account) session.getAttribute("account");
    if(currentUser!=null) {
    request.setAttribute("Account", currentUser);
    }
    processRequest(request, response);
}

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
      
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
