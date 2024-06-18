package controller.staff;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import controller.authentication.BaseRequiredAuthenticationController;
import dal.ProductDBContext;
import entity.Account;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

@WebServlet(name = "ProductManagementController", urlPatterns = {"/ProductManagementController", "/getProducts"})
public class ProductManagementController extends BaseRequiredAuthenticationController {

    private ProductDBContext pdb = new ProductDBContext();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        ArrayList<Product> products = pdb.list();

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
        String jsonData = gson.toJson(products);

        request.setAttribute("jsonData", jsonData);
        request.getRequestDispatcher("staff/productmanagement.jsp").forward(request, response);
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
        if (action.equals("/getProducts")) {
            response.setContentType("application/json");
            ArrayList<Product> products = pdb.list();
            Gson gson = new Gson();
            String jsonData = gson.toJson(products);
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
        return "Short description";
    }
}
