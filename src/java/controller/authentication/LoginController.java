/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authentication;

import dal.AccountDBContext;
import entity.Account;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author sonnt
 */
public class LoginController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int testing = 10;
        request.setAttribute("testnum", testing);
        request.getRequestDispatcher("login/login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    AccountDBContext db = new AccountDBContext();
    Account account = db.getByUsernamePassword(username, password);

    if (account != null) {
        HttpSession session = request.getSession();
        session.setAttribute("account", account);

        // Setting cookies
        Cookie c_user = new Cookie("username", username);
        Cookie c_pass = new Cookie("password", password);
        c_user.setMaxAge(10);
        c_pass.setMaxAge(10);
        response.addCookie(c_pass);
        response.addCookie(c_user);

        // Redirect based on role
        if ("Teacher".equals(account.getRole())) {
            response.sendRedirect("teacher?id=" + account.getId());
        } else if ("Student".equals(account.getRole())) {
            response.sendRedirect("student?id=" + account.getId());
        } else if ("Admin".equals(account.getRole())) {
            response.sendRedirect("admin?id=" + account.getId());
        } 
        else {
            // Handle other roles or provide a default URL
            response.sendRedirect(""); // Redirect to the default URL
        }
    } else {
        response.sendRedirect("https://www.youtube.com/watch?v=2qBlE2-WL60");
    }
}

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
