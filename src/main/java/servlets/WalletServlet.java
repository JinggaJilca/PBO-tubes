package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.WalletDAO;
import model.Wallet;

@WebServlet(name = "WalletServlet", urlPatterns = { "/wallet" })
public class WalletServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        model.User loggedInUser = (model.User) session.getAttribute("user");
        Integer userId = loggedInUser.getUserID();

        WalletDAO walletDAO = new WalletDAO();
        List<Wallet> wallets = walletDAO.getWalletsByUserId(userId);

        request.setAttribute("wallets", wallets);
        request.setAttribute("user", loggedInUser);
        request.setAttribute("username", loggedInUser.getUsername());

        request.getRequestDispatcher("/wallet.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        model.User loggedInUser = (model.User) session.getAttribute("user");
        Integer userId = loggedInUser.getUserID();

        WalletDAO walletDAO = new WalletDAO();
        List<Wallet> wallets = walletDAO.getWalletsByUserId(userId);

        request.setAttribute("wallets", wallets);
        request.setAttribute("user", loggedInUser);
        request.setAttribute("username", loggedInUser.getUsername());

        request.getRequestDispatcher("/wallet.jsp").forward(request, response);
    }


}
