package controller.staff;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.ProductDBContext;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="changeListedController", urlPatterns={"/changeListedController"})
public class ChangeListedController extends BaseRequiredAuthenticationController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        ProductDBContext pdb = new ProductDBContext();
        int pid = Integer.parseInt(request.getParameter("pid"));
        Boolean value = Boolean.valueOf(request.getParameter("value"));
        pdb.updateIsListed(pid, value);
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response,Account account)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response,Account account)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
