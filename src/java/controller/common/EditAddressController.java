package controller.common;

import dal.AccountDBContext;
import entity.Account;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "EditAddressController", urlPatterns = {"/EditAddressController"})
public class EditAddressController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String oldAddress = request.getParameter("oldAddress");
        String newAddress = request.getParameter("newAddress");

        if (account != null && oldAddress != null && newAddress != null && 
            !oldAddress.trim().isEmpty() && !newAddress.trim().isEmpty()) {
            AccountDBContext dbContext = new AccountDBContext();
            dbContext.editAddress(account.getAid(), oldAddress, newAddress);
            account.setAddresses(dbContext.getAddressByAid(account.getAid()));
            session.setAttribute("account", account);
        }

        response.sendRedirect("ad");
    }
}
