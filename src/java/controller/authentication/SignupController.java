/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authentication;

import dal.AccountDBContext;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
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

/**
 *
 * @author duong
 */
public class SignupController extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
         
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
    String username = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    AccountDBContext db = new AccountDBContext();
    Account account = db.checkAccountExist(username);
    
    if (account != null) {
        String signupError = "Username already existed";
        request.setAttribute("signupError", signupError);
        request.getRequestDispatcher("common/login.jsp").forward(request, response);
    } else {
        String salt = EncryptionHelper.generateSalt();
        String hashedPassword = "";
        try {
            hashedPassword = EncryptionHelper.hashPassword(password, salt);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(SignupController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeySpecException ex) {
            Logger.getLogger(SignupController.class.getName()).log(Level.SEVERE, null, ex);
        }
        String signupSuccess = "Sign up Successfully";
        request.setAttribute("signupSuccess", signupSuccess);
        db.addNewAccount(username, email, hashedPassword, salt);
        request.getRequestDispatcher("common/login.jsp").forward(request, response);
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
