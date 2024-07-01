/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.staff;

import dal.ProductItemDBContext;
import entity.Color;
import entity.Size;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="AddStockCountMultiController", urlPatterns={"/AddStockCountMultiController"})
public class AddStockCountMultiController extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        int pid = Integer.parseInt(request.getParameter("pid"));
        int stockAdjustment = Integer.parseInt(request.getParameter("stockAdjustment"));
        String adjustmentType = request.getParameter("adjustmentType");
        boolean isAllSizes = Boolean.parseBoolean(request.getParameter("isAllSizes"));
        boolean isAllColors = Boolean.parseBoolean(request.getParameter("isAllColors"));
        
        ProductItemDBContext pidb = new ProductItemDBContext();
        
        try {
            if (isAllSizes && isAllColors) {
                // Update stock count for all sizes and colors
                List<Size> sizes = pidb.sizeList();
                List<Color> colors = pidb.colorList();
                
                for (Size s : sizes) {
                    for (Color c : colors) {
                        updateStock(pidb, s.getSid(), c.getCid(), pid, stockAdjustment, adjustmentType);
                    }
                }
            } else if (isAllSizes) {
                // Update stock count for all sizes with specific color
                int cid = Integer.parseInt(color);
                List<Size> sizes = pidb.sizeList();
                
                for (Size s : sizes) {
                    updateStock(pidb, s.getSid(), cid, pid, stockAdjustment, adjustmentType);
                }
            } else if (isAllColors) {
              
                int sid = Integer.parseInt(size);
                List<Color> colors = pidb.colorList();
                for (Color c : colors) {
                    updateStock(pidb, sid, c.getCid(), pid, stockAdjustment, adjustmentType);
                }
            } else {
                int sid = Integer.parseInt(size);
                int cid = Integer.parseInt(color);
                updateStock(pidb, sid, cid, pid, stockAdjustment, adjustmentType);
            }
            
        } catch (Exception e) {
            
        }
    }
    
   private void updateStock(ProductItemDBContext pidb, int sid, int cid, int pid, int stockAdjustment, String adjustmentType) {
    int currentStock = pidb.getCurrentStock(sid, cid, pid);
    
    if (adjustmentType.equals("increase")) {
        int newStock = currentStock + stockAdjustment;
        pidb.updateStock(sid, cid, pid, newStock);
    } else if (adjustmentType.equals("decrease")) {
        int newStock = Math.max(currentStock - stockAdjustment, 0);
        pidb.updateStock(sid, cid, pid, newStock);
    }
    System.out.println("Stock updated successfully.");
}
}

