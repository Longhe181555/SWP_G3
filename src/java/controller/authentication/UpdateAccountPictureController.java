package controller.authentication;

import dal.AccountDBContext;
import entity.Account;
import org.apache.commons.io.FileUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig
@WebServlet("/UpdateAccountPictureController")
public class UpdateAccountPictureController extends HttpServlet {

    private AccountDBContext accountDB = new AccountDBContext();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String projectRoot = getServletContext().getRealPath("");
        String uploadPath = projectRoot.replace("\\build\\web", "") + "web" + File.separator + "img" + File.separator + "profile_picture";
        Part filePart = request.getPart("file");

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            if (fileName != null && !fileName.isEmpty()) {
                File file = new File(uploadPath + File.separator + fileName);
                String picturePath = "img/profile_picture/" + fileName;
                try (InputStream fileContent = filePart.getInputStream()) {
                    FileUtils.copyInputStreamToFile(fileContent, file);
                }
                accountDB.updateProfilePicture(currentUser.getAid(), picturePath);
                currentUser.setImg(picturePath);
                session.setAttribute("account", currentUser);
                try {
                    Thread.sleep(5000);
                } catch (InterruptedException ex) {
                    Logger.getLogger(UpdateAccountPictureController.class.getName()).log(Level.SEVERE, null, ex);
                }
                response.sendRedirect("ad"); 
            } else {
                response.getWriter().print("Invalid file name");
            }
        } else {
            response.getWriter().print("No file uploaded");
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
