package controller.staff;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.BrandDBContext;
import dal.CategoryDBContext;
import dal.ProductDBContext;
import entity.Account;
import entity.Brand;
import entity.Category;
import entity.Product;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.commons.io.FileUtils;

@MultipartConfig
@WebServlet("/UpdateProductController")
public class UpdateProductController extends BaseRequiredAuthenticationController {

    private ProductDBContext productDB = new ProductDBContext();
    private BrandDBContext brandDB = new BrandDBContext();
    private CategoryDBContext categoryDB = new CategoryDBContext();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String pid = request.getParameter("pid");

        Product product = productDB.getProductDetail(Integer.parseInt(pid));
        ArrayList<Brand> brands = brandDB.list();
        ArrayList<Category> categories = categoryDB.list();
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/staff/updateproduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        try {
            // Retrieve product details from the request
            int pid = Integer.parseInt(request.getParameter("pid"));
            String pname = request.getParameter("pname");
            int price = Integer.parseInt(request.getParameter("price"));
            String description = request.getParameter("description");
            int brandId = Integer.parseInt(request.getParameter("brand"));
            Boolean isListed = Boolean.valueOf(request.getParameter("isListed"));
            ArrayList<String> imgpath = new ArrayList<>();

            String removedImages = request.getParameter("removedImages");
            if (removedImages != null && !removedImages.isEmpty()) {
                String[] imagePaths = removedImages.split(",");
                ProductDBContext productDBContext = new ProductDBContext();
                for (String imagePath : imagePaths) {
                    // Remove image record from the database
                    productDBContext.removeImage(imagePath);
                }
            }

            String projectRoot = getServletContext().getRealPath("");
            String uploadPath = projectRoot.replace("\\build\\web", "") + "web" + File.separator + "img" + File.separator + "product_picture";
            Collection<Part> fileParts = request.getParts().stream()
                    .filter(part -> "images".equals(part.getName()) && part.getSize() > 0)
                    .collect(Collectors.toList());
            StringBuilder uploadedFiles = new StringBuilder();

            for (Part filePart : fileParts) {
                String fileName = extractFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    File file = new File(uploadPath + File.separator + fileName);
                    try (InputStream fileContent = filePart.getInputStream()) {
                        FileUtils.copyInputStreamToFile(fileContent, file);
                        imgpath.add("img/product_picture/" + fileName); // Add to imgpath
                        uploadedFiles.append(fileName).append(", ");
                    }
                }
            }

            productDB.update(pid, pname, price, description, brandId, isListed, imgpath);

            if (uploadedFiles.length() > 0) {
                uploadedFiles.setLength(uploadedFiles.length() - 2); // Remove trailing comma and space
            }

            response.sendRedirect("updateProduct?pid=" + pid);
        } catch (NumberFormatException e) {
            response.sendRedirect("pmanagement");
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1).replace("\"", "");
            }
        }
        return null;
    }
}
