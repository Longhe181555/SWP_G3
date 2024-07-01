package controller.staff;

import dal.*;
import entity.*;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ProductStockController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            ProductDBContext pdb = new ProductDBContext();
            ProductItemDBContext pidb = new ProductItemDBContext();
            if (request.getServletPath().equals("/updateStock")) {
                int piid = Integer.parseInt(request.getParameter("piid"));
                int stockcount = Integer.parseInt(request.getParameter("stockcount"));
                pidb.updateStock(piid, stockcount);
                return; 
            }
            int pid = Integer.parseInt(request.getParameter("pid"));
            Product p = pdb.get(pid);
            request.setAttribute("product", p);
            ArrayList<ProductItem> productItems = pidb.getByPid(pid);
            ArrayList<Color> colors = pidb.colorList();
            ArrayList<Size> sizes = pidb.sizeList();
            
            request.setAttribute("sizes", sizes);
            request.setAttribute("colors", colors);
            request.setAttribute("productItems", productItems);
            request.getRequestDispatcher("/staff/productstock.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error processing request: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request.");
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
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Product Stock Controller";
    }
}
