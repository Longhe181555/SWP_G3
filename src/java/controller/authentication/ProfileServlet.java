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

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private AccountDBContext accountDBContext;

    @Override
    public void init() throws ServletException {
        accountDBContext = new AccountDBContext();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");

        if (currentUser != null) {
            Account userFromDb = (Account) accountDBContext.get(currentUser.getAid());
            session.setAttribute("account", userFromDb);
            request.getRequestDispatcher("common/AccountPrivate.jsp").forward(request, response);
        } else {
            response.sendRedirect("common/login.jsp");
        }
    }
}