/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.public_;

import dal.FeedbackDBContext;
import dal.ProductDBContext;
import dal.ProductItemDBContext;
import entity.Account;
import entity.Feedback;
import entity.Product;
import entity.ProductItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import util.ProductSortHelper;

/**
 *
 * @author ADMIN
 */
public class ProductDetailController extends HttpServlet {
  private ProductDBContext productDB = new ProductDBContext();
    private FeedbackDBContext feedbackDB = new FeedbackDBContext();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pidStr = request.getParameter("pid");
        if (pidStr != null) {
            try {
                request.setAttribute("allSizes", new String[]{"S", "M", "L", "XL"});
                ProductSortHelper ph = new ProductSortHelper();
                int pid = Integer.parseInt(pidStr);
                Product product = productDB.get(pid);
                request.setAttribute("product", product);

                ProductItemDBContext pidb = new ProductItemDBContext();
                ArrayList<ProductItem> productItems = pidb.getByPid(pid);
                Map<String, List<ProductItem>> groupedByColor = new HashMap<>();
                for (ProductItem item : productItems) {
                    groupedByColor.computeIfAbsent(item.getColor(), k -> new ArrayList<>()).add(item);
                }
               
                request.setAttribute("productItems", productItems);
                request.setAttribute("groupedByColor", groupedByColor);

                ArrayList<Feedback> fs = feedbackDB.getByPid(pid);
                float temp = feedbackDB.getAverageRatingByPid(pid);
                request.setAttribute("avr", temp);
                request.setAttribute("fs", ph.getFirstAmountElements(fs, 3));
                request.getRequestDispatcher("public/productdetail.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                // handle error
            }
        } else {
            response.sendRedirect("homepage");
        }
    } 
  @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        int pid = Integer.parseInt(request.getParameter("pid"));     
        ProductItemDBContext pidb = new ProductItemDBContext();
        ProductItem item = pidb.getByPidSizeColor(pid, size, color); 
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if(item.getDiscount()!= null){
           out.print("{\"discountedPrice\": " + item.getDiscountedPrice() + ", \"piid\": " + item.getPiid() + ", \"value\": " + item.getDiscount().getValue() + "}");
        } else {
            out.print("{\"discountedPrice\": " + item.getDiscountedPrice() + ", \"piid\": " + item.getPiid() + ", \"value\": " + null + "}");
        }
        
        out.flush();
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
