package controller.staff;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import controller.authentication.BaseRequiredAuthenticationController;
import dal.ProductItemDBContext;
import entity.Account;
import entity.ProductItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

public class StockManagementController extends BaseRequiredAuthenticationController {

    private ProductItemDBContext pidbc = new ProductItemDBContext();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        List<ProductItem> productItems = pidbc.getStockList();

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
        
        for(ProductItem  p : productItems) {
            System.out.println(p.getProduct().getIsListed());
        }
        
        String jsonData = gson.toJson(productItems);

        request.setAttribute("jsonData", jsonData);
        request.getRequestDispatcher("staff/stockmanagement.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
        if (currentUser != null) {
            request.setAttribute("Account", currentUser);
        }

        String action = request.getServletPath();
        if (action.equals("/getStockItems")) {
            response.setContentType("application/json");
            List<ProductItem> productItems = pidbc.getStockList();
            Gson gson = new Gson();
            String jsonData = gson.toJson(productItems);
            PrintWriter out = response.getWriter();
            out.print(jsonData);
            out.flush();
        } else {
            processRequest(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Stock Management Controller";
    }
}
