/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dal.AccountDBContext;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.SQLException;
import util.EncryptionHelper;

/**
 *
 * @author ADMIN
 */
public class UpdateAccountController extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int aid = Integer.parseInt(request.getParameter("aid"));
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");
         String gender = request.getParameter("gender");

        // Generate salt and hash password
        String salt = EncryptionHelper.generateSalt();
        String hashedPassword = null;
        try {
            hashedPassword = EncryptionHelper.hashPassword(password, salt);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
           
        }

        // Create Account object
        Account account = new Account();
        account.setAid(aid);
        account.setFullname(fullname);
        account.setUsername(username);
        account.setPassword(hashedPassword);
        account.setEmail(email);
        account.setPhonenumber(phonenumber);
        account.setSalt(salt);
        account.setGender(gender.equalsIgnoreCase("Male"));

        // Update account in database
        AccountDBContext dbContext = new AccountDBContext();
        
        try {
            dbContext.updateA(account);
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(UpdateAccountController.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
       

        // Redirect to account management page
        response.sendRedirect("../amanagement");
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
        return "UpdateAccountController handles updating accounts";
    }
}