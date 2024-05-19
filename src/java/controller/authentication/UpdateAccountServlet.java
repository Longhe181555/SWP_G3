
package controller.authentication;


import dal.AccountDBContext;
import entity.Account;


import dal.AccountDBContext;
import entity.Account;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/updateAccount")
public class UpdateAccountServlet extends HttpServlet {
    private AccountDBContext accountDBContext;

    @Override
    public void init() throws ServletException {
        accountDBContext = new AccountDBContext();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");

        boolean genderBoolean = gender.equals("male");
        Date birthdate = Date.valueOf(dob);

        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");

        currentUser.setUsername(fullName);
        currentUser.setEmail(email);
        currentUser.setPhonenumber(phone);
        currentUser.setGender(genderBoolean);
        currentUser.setBirthdate(birthdate);
        currentUser.setAddress(address);

        accountDBContext.update(currentUser);
        session.setAttribute("message", "Saved!");
        session.setAttribute("account", currentUser);

        response.sendRedirect("profile");
    }
}
