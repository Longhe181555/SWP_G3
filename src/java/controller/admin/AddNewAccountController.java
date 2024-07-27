/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dal.AccountDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import util.EncryptionHelper;

/**
 *
 * @author ADMIN
 */
public class AddNewAccountController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");
        String role = request.getParameter("role");

        // Generate salt and hash password
        String salt = EncryptionHelper.generateSalt();
        String hashedPassword = null;
        try {
            hashedPassword = EncryptionHelper.hashPassword(password, salt);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Password encryption error.");
            return;
        }

        // Create an instance of AccountDBContext and add the new account
        AccountDBContext accountDB = new AccountDBContext();
            accountDB.addNewAccount(fullname, username, hashedPassword, email, salt, phonenumber, role);
            response.sendRedirect("../amanagement"); 
    }

    @Override
    public String getServletInfo() {
        return "Servlet for adding new staff/admin accounts";
    }
}