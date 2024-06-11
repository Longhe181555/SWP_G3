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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import util.ProductSortHelper;

public class ProductListController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            ProductDBContext pdb = new ProductDBContext();
            CategoryDBContext catdb = new CategoryDBContext();
            BrandDBContext bdb = new BrandDBContext();
            ArrayList<Category> cats = catdb.list();
            ArrayList<Brand> brands = bdb.list();

            ArrayList<Product> products = new ArrayList<>();

            String search = request.getParameter("search");
            String category = request.getParameter("category");
            String brand = request.getParameter("brand");
            int minPrice = 0;
            int maxPrice = 0;
            float rating = 0;

            String minPriceParam = request.getParameter("minPrice");
            String maxPriceParam = request.getParameter("maxPrice");
            String ratingParam = request.getParameter("rating");
            String discount = request.getParameter("discount");
            if (minPriceParam != null && !minPriceParam.isEmpty()) {
                minPrice = Integer.parseInt(minPriceParam);
            }
            if (maxPriceParam != null && !maxPriceParam.isEmpty()) {
                maxPrice = Integer.parseInt(maxPriceParam);
            }

            // Call the method to filter products based on parameters
            products = pdb.listFilter(search, category, brand, minPrice, maxPrice);

            if (discount != null && !discount.isEmpty()) {
                products = ProductSortHelper.haveDiscount(products);
            }
            if (ratingParam != null && !ratingParam.isEmpty()) {
                rating = Float.parseFloat(ratingParam);
                products = ProductSortHelper.filterByRating(products, rating);
            }

            String order = request.getParameter("order");
            if (order != null) {
                switch (order) {
                    case "priceAsc":
                        products = ProductSortHelper.sortByPriceAscending(products);
                        break;
                    case "priceDesc":
                        products = ProductSortHelper.sortByPriceDescending(products);
                        break;
                    case "dateAsc":
                        products = ProductSortHelper.sortByDateAscending(products);
                        break;
                    case "dateDesc":
                        products = ProductSortHelper.sortByDateDescending(products);
                        break;
                    case "ratingAsc":
                        products = ProductSortHelper.sortByRatingAscending(products);
                        break;
                    case "ratingDesc":
                        products = ProductSortHelper.sortByRatingDescending(products);
                        break;
                }
            }

            request.setAttribute("cats", cats);
            request.setAttribute("brands", brands);
            request.setAttribute("products", products);
            request.getRequestDispatcher("/public/productlist.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
        if (currentUser != null) {
            request.setAttribute("Account", currentUser);
        }
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
