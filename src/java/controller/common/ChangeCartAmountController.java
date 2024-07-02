import dal.CartDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/ChangeCartAmountController")
public class ChangeCartAmountController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int cartId = Integer.parseInt(request.getParameter("cartId"));
        int amount = Integer.parseInt(request.getParameter("amount"));
        CartDBContext cdb = new CartDBContext();
        boolean updateSuccess = cdb.updateCartAmount(cartId, amount); 
        

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{ \"success\": " + updateSuccess + " }");
        out.flush();
    }

}
