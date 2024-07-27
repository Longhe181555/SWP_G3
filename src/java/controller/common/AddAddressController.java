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

@WebServlet(name = "AddAddressController", urlPatterns = {"/AddAddressController"})
public class AddAddressController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String address = request.getParameter("address");

        if (account != null && address != null && !address.trim().isEmpty()) {
            AccountDBContext dbContext = new AccountDBContext();
            dbContext.addAddress(account.getAid(), address);
            account.setAddresses(dbContext.getAddressByAid(account.getAid()));
            session.setAttribute("account", account);
        }

        response.sendRedirect("ad");
    }
}
