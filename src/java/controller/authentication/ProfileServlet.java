/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authentication;
;

import dal.AccountDBContext;
import entity.Account;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class ProfileServlet extends BaseRequiredAuthenticationController {
    private AccountDBContext accountDBContext;

    @Override
    public void init() throws ServletException {
        accountDBContext = new AccountDBContext();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response,Account account)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (account != null) {
       
            session.setAttribute("account", account);
            request.getRequestDispatcher("common/AccountPrivate.jsp").forward(request, response);
        } else {
            response.sendRedirect("common/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}