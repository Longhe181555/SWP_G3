/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.staff;

import com.google.gson.JsonObject;
import controller.authentication.BaseRequiredAuthenticationController;
import dal.OrderDBContext;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class SetOrderStatusController extends BaseRequiredAuthenticationController {
   
  @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        response.setContentType("application/json");
        JsonObject jsonResponse = new JsonObject();

        try {
            
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int status = Integer.parseInt(request.getParameter("status"));
            OrderDBContext orderDB = new OrderDBContext();
            boolean result = orderDB.setOrderStatusByOrid(orderId, status, account.getAid());

            if (result) {
                jsonResponse.addProperty("success", true);
            } else {
                jsonResponse.addProperty("success", false);
            }
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", e.getMessage());
        }

        response.getWriter().write(jsonResponse.toString());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
       
    }
}
