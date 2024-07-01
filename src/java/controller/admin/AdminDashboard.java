/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import com.google.gson.Gson;
import controller.authentication.BaseRequiredAuthenticationController;
import dal.OrderDBContext;
import entity.Account;
import entity.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import util.OrderStatus;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminDashboard", urlPatterns = {"/dashboard"})
public class AdminDashboard extends BaseRequiredAuthenticationController {
    
    int[] getStatistic(List<Order> orders){
        int[] result = new int[3];
        int totalAmmount = 0;
        int totalConfirmedStatusOrder = 0;
        int totalShippingStatusOrder = 0;
        for(int i = 0 ; i < orders.size() ; i++){
            Order order = orders.get(i);
            if(order.getStatus() == OrderStatus.CONFIRMED_STATUS){
                totalConfirmedStatusOrder++;
            }else if(order.getStatus() == OrderStatus.SHIPPING_STATUS){
                totalShippingStatusOrder++;
            }
            totalAmmount += orders.get(i).getTotalAmount();
        }
        result[0] = totalAmmount;
        result[1] = totalConfirmedStatusOrder;
        result[2] = totalShippingStatusOrder;
        return result;
    }

    

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        Gson gson = new Gson();
        String rawDate = req.getParameter("date");
        String pattern = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        Date date = new Date();
        // Get the current date
        LocalDate currentDate = LocalDate.now();
        // Extract the year
        int currentYear = currentDate.getYear();
        try{
            date = simpleDateFormat.parse(rawDate);
        }catch(Exception ex){
            
        }
        OrderDBContext orderDBContext = new OrderDBContext();
        List<Order> orders = orderDBContext.getOrdersByDate(date);
        HashMap<Integer , Integer> months = orderDBContext.getTotalAmountByYear(currentYear);
        addDefaultMonths(months);
        int[] statistic = getStatistic(orders);
        req.setAttribute("statistic", statistic);
        req.setAttribute("totalOrder", orders.size());
        req.setAttribute("date", simpleDateFormat.format(date));
        req.setAttribute("months", gson.toJson(months));
        req.getRequestDispatcher("AdminDashboard.jsp").forward(req, resp);
    }
    
    HashMap<Integer, Integer> addDefaultMonths(HashMap<Integer , Integer> months){
        for(int i = 1 ; i <= 12 ; i++){
            if(!months.containsKey(i)) months.put(i, 0);
        }
        return months;
    }

}
