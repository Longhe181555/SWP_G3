/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.staff;

import dal.*;
import entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import org.apache.commons.io.FileUtils;

@MultipartConfig
@WebServlet("/CreateProductController")
public class CreateProductController extends HttpServlet {

    private ProductDBContext productDB = new ProductDBContext();
    private BrandDBContext brandDB = new BrandDBContext();
    private CategoryDBContext catDB = new CategoryDBContext();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
        if (currentUser != null) {
            request.setAttribute("Account", currentUser);
        }

        ArrayList<Brand> brands = brandDB.list();
        ArrayList<Category> cats = catDB.list();
        request.setAttribute("brands", brands);
        request.setAttribute("cats", cats);
        request.getRequestDispatcher("/staff/createproduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("checkProductName".equals(action)) {
            checkProductName(request, response);
        } else {
            createProduct(request, response);
        }
    }

    private void createProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String pname = request.getParameter("pname");
            int price = Integer.parseInt(request.getParameter("price"));
            String description = request.getParameter("description");
            int brand = Integer.parseInt(request.getParameter("brand"));
            int category = Integer.parseInt(request.getParameter("category"));
            Boolean isListed = Boolean.valueOf(request.getParameter("isListed"));
            ArrayList<String> imgpath = new ArrayList<>();

            String projectRoot = getServletContext().getRealPath("");
            String uploadPath = projectRoot.replace("\\build\\web", "") + "web" + File.separator + "img" + File.separator + "product_picture";
            Collection<Part> fileParts = request.getParts().stream().filter(part -> "files".equals(part.getName())).collect(Collectors.toList());
            StringBuilder uploadedFiles = new StringBuilder();
            for (Part filePart : fileParts) {
                String fileName = extractFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    File file = new File(uploadPath + File.separator + fileName);
                    imgpath.add("img/product_picture/" + fileName);
                    try (InputStream fileContent = filePart.getInputStream()) {
                        FileUtils.copyInputStreamToFile(fileContent, file);
                        uploadedFiles.append(fileName).append(", ");
                    }
                }
            }
            productDB.insert(pname, price, description, category, brand, isListed, imgpath);
            if (uploadedFiles.length() > 0) {
                uploadedFiles.setLength(uploadedFiles.length() - 2); // Remove trailing comma and space
                response.sendRedirect("pmanagement");
            } else {
                response.getWriter().print("No files uploaded or empty file list");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("pmanagement");
        }
    }

    private void checkProductName(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productName = request.getParameter("pname");
        boolean exists = productDB.productNameExists(productName); // Implement this method in your DAO
        response.setContentType("application/json");
        response.getWriter().write("{\"exists\": " + exists + "}");
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
    }
}
    
    


