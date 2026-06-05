/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.DashboardDAO;
import model.DashboardSummary;
import model.CategorySpendingSummary;
import model.MonthlyTransactionSummary;
import model.RecentActivity;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Julio
 */
@WebServlet("/dashboard")
// @WebServlet(name = "DashboardServlet", urlPatterns = {"/DashboardServlet"})
public class DashboardServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

                if (session == null || session.getAttribute("user") == null) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                    return;
                }

                model.User loggedInUser = (model.User) session.getAttribute("user");

                Integer userId = loggedInUser.getUserID();
        LocalDate now = LocalDate.now();
        int year = now.getYear();
        int month = now.getMonthValue();

        DashboardDAO dashboardDAO = new DashboardDAO();
        String username = dashboardDAO.getUsernameByUserId(userId);
        System.out.println("USERNAME USER ID 1 = " + username);

        DashboardSummary summary = dashboardDAO.getDashboardSummary(userId, year, month);

        List<RecentActivity> recentActivities = dashboardDAO.getRecentActivities(userId, 5);

        List<CategorySpendingSummary> spendingOverview = dashboardDAO.getSpendingOverviewByCategory(userId, year,
                month);

        List<MonthlyTransactionSummary> monthlySummary = dashboardDAO.getMonthlyTransactionSummary(userId, year);
        request.setAttribute("username", username);
        request.setAttribute("summary", summary);
        request.setAttribute("recentActivities", recentActivities);
        request.setAttribute("spendingOverview", spendingOverview);
        request.setAttribute("monthlySummary", monthlySummary);
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
