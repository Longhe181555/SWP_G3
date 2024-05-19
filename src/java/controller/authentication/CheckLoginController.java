/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.authentication;

import entity.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class CheckLoginController extends BaseRequiredAuthenticationController {
   
  

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response,Account Account)
    throws ServletException, IOException {
        System.out.println(Account.getUsername() + "   " + Account.getPassword());
        response.sendRedirect("./login");
    } 

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response,Account Account)
    throws ServletException, IOException {
        response.sendRedirect("./login");
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
