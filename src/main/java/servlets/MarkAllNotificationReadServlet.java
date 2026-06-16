package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.NotificationDAO;
import model.User;

@WebServlet(name = "MarkAllNotificationReadServlet", urlPatterns = { "/notification/read-all" })
public class MarkAllNotificationReadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");
        int userId = loggedInUser.getUserID();

        NotificationDAO notificationDAO = new NotificationDAO();
        notificationDAO.markAllAsReadByUserId(userId);

        response.sendRedirect(request.getContextPath() + "/notification");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");
        int userId = loggedInUser.getUserID();

        NotificationDAO notificationDAO = new NotificationDAO();
        notificationDAO.markAllAsReadByUserId(userId);

        response.sendRedirect(request.getContextPath() + "/notification");
    }

}
