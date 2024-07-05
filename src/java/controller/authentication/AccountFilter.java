/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.authentication;

import dal.CartDBContext;
import entity.Account;
import entity.Cart;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;






@WebFilter("/*") // Apply to all requests
public class AccountFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String url = httpRequest.getRequestURL().toString();
//        System.out.println("URL accessed: " + url);

        HttpSession session = httpRequest.getSession(false);
        if (session != null) {
            Account currentUser = (Account) session.getAttribute("account");
            if (currentUser != null) {
                request.setAttribute("Account", currentUser);
                CartDBContext cdb = new CartDBContext();
                ArrayList<Cart> carts = cdb.getByAid(currentUser.getAid());
                request.setAttribute("carts", carts);
                request.setAttribute("cartcount", carts.size());
            }
        }

        try {
            chain.doFilter(request, response);
        } catch (Throwable t) {
            t.printStackTrace();
            throw new ServletException(t);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}

