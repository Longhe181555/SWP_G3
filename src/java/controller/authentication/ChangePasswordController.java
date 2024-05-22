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
import jakarta.servlet.annotation.WebServlet;
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
 * @author ADMIN
 */
@WebServlet(name="ChangePasswordController")
public class ChangePasswordController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
      
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

 
 @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    String oldpass = request.getParameter("oldpass");
    String newpass = request.getParameter("newpass");
    String renewpass = request.getParameter("renewpass");
    Account u = (Account) session.getAttribute("account");
     System.out.println("Lmaaoooooo" + u.getPassword());

    String hashedOldPass = "";
    try {
        hashedOldPass = EncryptionHelper.hashPassword(oldpass, u.getSalt());
    } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
        Logger.getLogger(ChangePasswordController.class.getName()).log(Level.SEVERE, null, ex);
    }
    if (!hashedOldPass.equals(u.getPassword())) {
        request.setAttribute("mess", "Old password is incorrect. Try again!");
        request.getRequestDispatcher("common/changepass.jsp").forward(request, response);
    } else if (!newpass.equals(renewpass)) {
        request.setAttribute("mess", "New password and confirm password do not match. Try again!");
        request.getRequestDispatcher("common/changepass.jsp").forward(request, response);
    } else {
        AccountDBContext dao = new AccountDBContext();
        String newSalt = EncryptionHelper.generateSalt();
        String hashedNewPass = "";
        try {
            hashedNewPass = EncryptionHelper.hashPassword(newpass, newSalt);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            Logger.getLogger(ChangePasswordController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        // Update the account with the new hashed password and salt
        dao.changePassword(String.valueOf(u.getAid()), hashedNewPass, newSalt);
        
        request.setAttribute("mess", "Password changed successfully!");
        request.getRequestDispatcher("common/changepass.jsp").forward(request, response);
    }
}

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
