package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DashboardDAO;
import model.RecentActivity;
import model.User;

/**
 *
 * @author Julio
 */
@WebServlet(urlPatterns = { "/DashboardExportServlet" })
public class DashboardExportServlet extends HttpServlet {

    private String escapeCsv(String value) {
        if (value == null) {
            return "";
        }

        String escaped = value.replace("\"", "\"\"");

        if (escaped.contains(",") || escaped.contains("\"") || escaped.contains("\n")) {
            return "\"" + escaped + "\"";
        }

        return escaped;
    }

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

        LocalDate now = LocalDate.now();
        int year = now.getYear();
        int month = now.getMonthValue();

        DashboardDAO dashboardDAO = new DashboardDAO();
        List<RecentActivity> transactions = dashboardDAO.getExportTransactions(userId, year, month);

        String fileName = "fintrack-transactions-" + year + "-" + month + ".csv";

        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        try (PrintWriter writer = response.getWriter()) {
            // BOM agar CSV aman dibuka di Excel
            writer.write('\uFEFF');

            writer.println("Tanggal,Waktu,Kategori,Nama Transaksi,Tipe,Nominal,Catatan");

            for (RecentActivity activity : transactions) {
                writer.println(
                        escapeCsv(activity.getDate()) + "," +
                                escapeCsv(activity.getTime()) + "," +
                                escapeCsv(activity.getCategoryName()) + "," +
                                escapeCsv(activity.getTransactionName()) + "," +
                                escapeCsv(activity.getTransactionType()) + "," +
                                activity.getAmount() + "," +
                                escapeCsv(activity.getNote()));
            }
        }
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

        LocalDate now = LocalDate.now();
        int year = now.getYear();
        int month = now.getMonthValue();

        DashboardDAO dashboardDAO = new DashboardDAO();
        List<RecentActivity> transactions = dashboardDAO.getExportTransactions(userId, year, month);

        String fileName = "fintrack-transactions-" + year + "-" + month + ".csv";

        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        try (PrintWriter writer = response.getWriter()) {
            // BOM agar CSV aman dibuka di Excel
            writer.write('\uFEFF');

            writer.println("Tanggal,Waktu,Kategori,Nama Transaksi,Tipe,Nominal,Catatan");

            for (RecentActivity activity : transactions) {
                writer.println(
                        escapeCsv(activity.getDate()) + "," +
                                escapeCsv(activity.getTime()) + "," +
                                escapeCsv(activity.getCategoryName()) + "," +
                                escapeCsv(activity.getTransactionName()) + "," +
                                escapeCsv(activity.getTransactionType()) + "," +
                                activity.getAmount() + "," +
                                escapeCsv(activity.getNote()));
            }
        }
    }



}
