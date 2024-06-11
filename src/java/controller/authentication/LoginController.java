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
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.EncryptionHelper;

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
        AccountDBContext adb = new AccountDBContext();

      
        request.getRequestDispatcher("common/login.jsp").forward(request, response);
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
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    AccountDBContext db = new AccountDBContext();
    Account account = db.checkAccountExist(username);

    if (account != null) {
        String storedSalt = account.getSalt();
        String hashedPassword = "";
        try {
            hashedPassword = EncryptionHelper.hashPassword(password, storedSalt);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }

        
        
        if (account.getPassword().equals(hashedPassword)) {
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
            // Setting cookies
            Cookie c_user = new Cookie("username", username);
            c_user.setMaxAge(5000);
            response.addCookie(c_user);
            
            response.sendRedirect("homepage");
            return;
        } else {
            // Password did not match
            request.setAttribute("loginError", "Invalid username or password");
            response.sendRedirect("login");
        }
    } else {
        // Account does not exist
        request.setAttribute("loginError", "Invalid username or password");
        response.sendRedirect("login");
    }
}
}
