/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.common;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.ProductItemDBContext;
import entity.Account;
import entity.Cart;
import entity.ProductItem;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
public class ViewCartController extends BaseRequiredAuthenticationController {
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response,Account account)
            throws ServletException, IOException {
        
        ArrayList<Cart> cs =  (ArrayList<Cart>) request.getAttribute("carts");
        if(cs != null) {
        int totalBill = 0;
        for(Cart c : cs) {
            totalBill += c.getProductItem().getDiscountedPrice() * c.getAmount();
            
        }
        request.setAttribute("totalBill", totalBill);
        }
        ProductItemDBContext pidb = new ProductItemDBContext();
        
        ArrayList<ProductItem> productItems = pidb.getRecentBoughtProductItems(account.getAid());
            request.setAttribute("recentbought", productItems);
        request.getRequestDispatcher("/common/viewcart.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response,Account account)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
