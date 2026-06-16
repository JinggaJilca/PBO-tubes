package servlets;

import dao.ProfileDAO;
import model.Profile;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

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

        ProfileDAO profileDAO = new ProfileDAO();
        Profile profile = profileDAO.getProfileByUserId(userId);

        request.setAttribute("profile", profile);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
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

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        Profile profile = new Profile();

        profile.setUserId(userId);
        profile.setFullName(fullName);
        profile.setUsername(username);
        profile.setPhoneNumber(phoneNumber);
        profile.setEmail(email);
        profile.setAddress(address);

        ProfileDAO profileDAO = new ProfileDAO();
        boolean success = profileDAO.updateProfile(profile);

        if (success) {
            loggedInUser.setUsername(username);
            loggedInUser.setEmail(email);
            session.setAttribute("user", loggedInUser);

            response.sendRedirect(request.getContextPath() + "/profile?success=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=1");
        }
    }
}