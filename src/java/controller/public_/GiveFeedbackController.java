/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.public_;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.FeedbackDBContext;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class GiveFeedbackController extends BaseRequiredAuthenticationController {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response,Account account)
    throws ServletException, IOException {
        response.sendRedirect("homepage");
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response,Account account)
    throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
  
        
       FeedbackDBContext fdb = new FeedbackDBContext();
        int pid = Integer.parseInt(request.getParameter("pid"));
        float rating = Float.parseFloat(request.getParameter("rating"));
        String feedback = request.getParameter("feedback");
        fdb.insert(currentUser.getAid(), pid, feedback, rating);

         response.sendRedirect("feedback?pid="+pid);
    }


}
