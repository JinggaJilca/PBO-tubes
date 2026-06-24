package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.NotificationDAO;
import model.User;

@WebServlet(name = "DeleteNotificationServlet", urlPatterns = { "/notification/delete" })
public class DeleteNotificationServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");
        int userId = loggedInUser.getUserID();

        int notificationId = 0;

        try {
            notificationId = Integer.parseInt(request.getParameter("notificationId"));
        } catch (Exception e) {
            notificationId = 0;
        }

        NotificationDAO notificationDAO = new NotificationDAO();

        if (notificationId != 0) {
            notificationDAO.deleteNotification(notificationId, userId);
        }

        response.sendRedirect(request.getContextPath() + "/notification");
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
        return "Short description";
    }

}
