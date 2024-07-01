/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import com.google.gson.Gson;
import controller.authentication.BaseRequiredAuthenticationController;
import dal.AccountDBContext;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.List;
import util.EncryptionHelper;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ViewListStaffAccount", urlPatterns = {"/admin-staff-account"})
public class ViewListStaffAccount extends BaseRequiredAuthenticationController {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        String username = req.getParameter("username");
        String fullname = req.getParameter("fullname");
        String phoneNumber = req.getParameter("phoneNumber");
        String address = req.getParameter("address");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        AccountDBContext db = new AccountDBContext();
        Account check = db.checkAccountExist(username);

        if (check != null) {
            String error = "Username is existed";
            resp.getWriter().print(error);
        } else {
            String salt = EncryptionHelper.generateSalt();
            String hashedPassword = "";
            try {
                hashedPassword = EncryptionHelper.hashPassword(password, salt);
            } catch (NoSuchAlgorithmException ex) {
            } catch (InvalidKeySpecException ex) {
            }
            Account newAccount = new Account();
            newAccount.setFullname(fullname);
            newAccount.setUsername(username);
            newAccount.setPassword(hashedPassword);
            newAccount.setEmail(email);
            newAccount.setPhonenumber(phoneNumber);
            int result = db.addNewStaff(newAccount);
            if(result != 0){
                resp.getWriter().print("Successfully");
            }else{
                resp.getWriter().print("Add fail");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        Gson gson = new Gson();
        AccountDBContext accountDBContext = new AccountDBContext();
        List<Account> staffs = accountDBContext.getAllAccountByRole("staff");
        req.setAttribute("staffs", gson.toJson(staffs));
        req.getRequestDispatcher("ViewAllStaffAccount.jsp").forward(req, resp);
    }

}
