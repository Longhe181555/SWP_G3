/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.staff;

import dal.BrandDBContext;
import dal.ProductDBContext;
import entity.Brand;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author duong
 */
public class UpdateProductController extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
         
        }
    }

    
    private ProductDBContext productDB = new ProductDBContext();
    private BrandDBContext brandDB = new BrandDBContext();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pid = request.getParameter("pid");
        Product product = productDB.getProductDetail(Integer.parseInt(pid));
        ArrayList<Brand> brands = brandDB.list();
        request.setAttribute("brands", brands);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/staff/updateproduct.jsp").forward(request, response);
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pid = request.getParameter("pid");
        String pname = request.getParameter("pname");
        String price = request.getParameter("price");
        String description = request.getParameter("description");
        String bid = request.getParameter("brand");
        System.out.println(pid + pname + price + description+ bid);
        Brand brand = (Brand) brandDB.get(Integer.parseInt(bid));
        List<Part> imageParts = request.getParts().stream()
                .filter(part -> "images".equals(part.getName()) && part.getSize() > 0)
                .collect(Collectors.toList());

        ProductDBContext pdb = new ProductDBContext();
        Product product = new Product();
        product.setPid(Integer.parseInt(pid));
        product.setPname(pname);
        product.setPrice(Integer.parseInt(price));
        product.setDescription(description);
        product.setBrand(brand);

        pdb.updateProduct(product, imageParts);


        response.sendRedirect("productdetail?pid=" + pid);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
