/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.common;

import dal.CartDBContext;
import dal.ProductItemDBContext;
import entity.Account;
import entity.Cart;
import entity.ProductItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class AddToCartController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ProductItemDBContext pidbc = new ProductItemDBContext();
        Account account = (Account) request.getSession().getAttribute("account");
        CartDBContext cartDB = new CartDBContext();
        int amount = Integer.parseInt(request.getParameter("quantity"));
        int piid = Integer.parseInt(request.getParameter("piid"));
        System.out.println(piid + "| " + amount);
        ProductItem p = pidbc.getByPiid(piid);
        int soldPrice =  p.getDiscountedPrice();
        if(p.getDiscount().getDtype()!=null) {
        cartDB.addToCart(amount, soldPrice, account.getAid(), piid, p.getDiscount().getDid()); 
        } else {
        cartDB.addToCart(amount, soldPrice, account.getAid(), piid);
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
        return "AddToCartController";
    }
}
