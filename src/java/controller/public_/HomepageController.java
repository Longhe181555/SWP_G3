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
import java.util.ArrayList;


@WebServlet(name="HomepageController")
public class HomepageController extends HttpServlet {
   
 
  
protected void processRequest(HttpServletRequest request, HttpServletResponse response, int activePage)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
        ProductDBContext pdb = new ProductDBContext();
        
        // Get sorting and filtering parameters from request
        String sort = request.getParameter("sort");
        String filter = request.getParameter("filter");
        
        ArrayList<ArrayList<Product>> productpage = pdb.listPage(sort, filter); // List of products paginated into pages
        request.setAttribute("productpaged", productpage); // Set the attribute for paginated products
        request.setAttribute("activePage", activePage); // Set the activePage attribute
        request.getRequestDispatcher("../public/homepage.jsp").forward(request, response); // Forward the request to the JSP
    }
}

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String pageParam = request.getParameter("page");
    int activePage = 1; // Default to first page if parameter is not provided
    if (pageParam != null && !pageParam.isEmpty()) {
        activePage = Integer.parseInt(pageParam);
    }
    processRequest(request, response, activePage);
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
