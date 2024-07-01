package controller.staff;

import dal.ProductItemDBContext;
import entity.Color;
import entity.Size;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name="AddNewStockController", urlPatterns={"/AddNewStockController"})
public class AddNewStockController extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        int pid = Integer.parseInt(request.getParameter("pid"));
        String stockcountStr = request.getParameter("stockcount");
        
        int stockcount = 0;
        if (stockcountStr != null && !stockcountStr.isEmpty()) {
            stockcount = Integer.parseInt(stockcountStr);
        }
        
        ProductItemDBContext pidb = new ProductItemDBContext();
        
        
         if (!"all".equalsIgnoreCase(size) && !"all".equalsIgnoreCase(color)) {
             int cid = Integer.parseInt(color);
             int sid = Integer.parseInt(size);
        boolean itemExists = pidb.checkProductItemExists(sid, cid, pid);
        if (itemExists) {
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.write("exists");
            out.flush();
            return;
        }
         }
        if ("all".equalsIgnoreCase(size) && "all".equalsIgnoreCase(color)) {
            List<Size> sizes = pidb.sizeList();
            List<Color> colors = pidb.colorList();
            
            for (Size s : sizes) {
                for (Color c : colors) {
                    pidb.addProductItem(s.getSid(), c.getCid(), stockcount,pid);
                }
            }
        } else if ("all".equalsIgnoreCase(size)) {
            List<Size> sizes = pidb.sizeList();
            int cid = Integer.parseInt(color);
            for(Size s : sizes) {
                 pidb.addProductItem(s.getSid(), cid, stockcount,pid);
            }
           
        } else if ("all".equalsIgnoreCase(color)) {
            List<Color> colors = pidb.colorList();
            int sid = Integer.parseInt(size);
            for(Color c : colors) {
                 pidb.addProductItem(sid, c.getCid(), stockcount,pid);
            }
            
        } else {
            int sid = Integer.parseInt(size);
            int cid = Integer.parseInt(color);
            pidb.addProductItem(sid, cid, stockcount,pid);
        }
        
        response.sendRedirect(request.getContextPath() + "/staff/productstock.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
