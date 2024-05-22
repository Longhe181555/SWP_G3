/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.authentication;

import dal.AccountDBContext;
import entity.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.EncryptionHelper;


public abstract class BaseRequiredAuthenticationController extends HttpServlet {
    
    private Account getAuthenticatedAccount(HttpServletRequest req) throws NoSuchAlgorithmException, InvalidKeySpecException {
    Account account = (Account) req.getSession().getAttribute("account");
    if (account == null) {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            String username = null;
            String hashedPassword = null;
            String salt = null;
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username"))
                    username = cookie.getValue();

                if (cookie.getName().equals("hashedPassword"))
                    hashedPassword = cookie.getValue();

                if (username != null && hashedPassword != null)
                    break;
            }

            if (username != null && hashedPassword != null) {
                AccountDBContext db = new AccountDBContext();
                account = db.checkAccountExist(username);
                if (account != null) {
                    salt = db.getSaltForUser(account.getAid());
                    String hashedPasswordWithSalt = EncryptionHelper.hashPassword(hashedPassword, salt);
                    // Check if the retrieved account exists and if the hashed password matches
                    if (hashedPasswordWithSalt.equals(account.getPassword())) {
                        req.getSession().setAttribute("account", account);
                    } else {
                        account = null; // Reset account if authentication fails
                    }
                }
            }
        }
    }
    return account;
}
    
    protected abstract void doPost(HttpServletRequest req, HttpServletResponse resp, Account account)
            throws ServletException, IOException; 
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account account = null;
        try {
            account = getAuthenticatedAccount(req);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(BaseRequiredAuthenticationController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeySpecException ex) {
            Logger.getLogger(BaseRequiredAuthenticationController.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(account!=null)
        {
     
            doPost(req, resp, account);
        }
        else
        {
          
            req.getSession().setAttribute("loginResult", "Session timer run out/ Access denied please try again!");
            resp.sendRedirect(req.getContextPath() +"/login");
        }
    
    }

    protected abstract void doGet(HttpServletRequest req, HttpServletResponse resp, Account account)
            throws ServletException, IOException; 
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    Account account = null;
        try {
            account = getAuthenticatedAccount(req);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(BaseRequiredAuthenticationController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeySpecException ex) {
            Logger.getLogger(BaseRequiredAuthenticationController.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(account!=null)
        {
            doGet(req, resp, account);
        }
        else
        {
            req.getSession().setAttribute("loginResult", "Session timer run out/ Access denied please try again!");
            resp.sendRedirect(req.getContextPath() +"/login");
        }
    }
    
}
