package controller.staff;

import com.google.gson.Gson;
import entity.*;
import dal.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "StockManagementController")
public class StockManagementController extends HttpServlet {

     @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        ProductItemDBContext pidb = new ProductItemDBContext();
        List<ProductItem> stockList = pidb.getStockList();
        req.setAttribute("stockList", gson.toJson(stockList));
        req.setAttribute("test", pidb.getStockList().get(0));
        req.getRequestDispatcher("staff/stockmanagement.jsp").forward(req, resp);
    }
}