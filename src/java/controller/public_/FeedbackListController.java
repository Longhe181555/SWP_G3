/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.public_;

import dal.*;
import entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import util.ProductSortHelper;

/**
 *
 * @author ADMIN
 */
public class FeedbackListController extends HttpServlet {

    private ProductDBContext productDB = new ProductDBContext();
    private FeedbackDBContext feedbackDB = new FeedbackDBContext();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            String pidRaw = request.getParameter("pid");
            if (pidRaw != null) {
                ProductSortHelper ph = new ProductSortHelper();
                int pid = Integer.parseInt(pidRaw);
                Product product = productDB.get(pid);
                request.setAttribute("product", product);
                ArrayList<Feedback> fs = feedbackDB.getByPid(pid);
                request.setAttribute("fs", fs);
                request.getRequestDispatcher("public/productfeedbacks.jsp").forward(request, response);
            }

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FeedbackDBContext fdb = new FeedbackDBContext();

        int aid = Integer.parseInt(request.getParameter("aid"));
        int pid = Integer.parseInt(request.getParameter("pid"));
        float rating = Float.parseFloat(request.getParameter("rating"));
        String feedback = request.getParameter("feedback");
        fdb.insert(aid, pid, feedback, rating);

        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
