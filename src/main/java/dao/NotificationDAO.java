package dao;

import model.BudgetNotification;
import model.JDBC;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    public void checkBudgetAfterExpense(Connection conn, int userId, int categoryId) {
        String budgetSql = "SELECT b.budget_id, b.category_id, b.category_budget, b.threshold, " +
                "b.start_date, b.end_date, c.name AS category_name " +
                "FROM budgets b " +
                "LEFT JOIN categories c ON b.category_id = c.category_id " +
                "WHERE b.user_id = ? " +
                "AND b.category_budget IS NOT NULL " +
                "AND CURDATE() BETWEEN b.start_date AND b.end_date " +
                "AND b.category_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(budgetSql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, categoryId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int budgetId = rs.getInt("budget_id");
                    double categoryBudget = rs.getDouble("category_budget");
                    double threshold = rs.getDouble("threshold");
                    String startDate = rs.getString("start_date");
                    String endDate = rs.getString("end_date");
                    String categoryName = rs.getString("category_name");

                    double currentSpending = getCurrentSpending(conn, userId, categoryId, startDate, endDate);
                    double warningThreshold = categoryBudget * (threshold / 100.0);

                    if (currentSpending >= warningThreshold) {
                        if (!notificationAlreadyExists(conn, userId, budgetId)) {
                            String message = categoryName + " threshold reached";

                            insertNotification(conn, userId, budgetId, message);
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private double getCurrentSpending(Connection conn, int userId, int categoryId,
            String startDate, String endDate) {
        String sql = "SELECT COALESCE(SUM(amount), 0) AS total_spending " +
                "FROM transactions " +
                "WHERE user_id = ? " +
                "AND category_id = ? " +
                "AND transaction_type = 'expense' " +
                "AND DATE(transaction_date) BETWEEN ? AND ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, categoryId);
            stmt.setString(3, startDate);
            stmt.setString(4, endDate);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total_spending");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    private boolean notificationAlreadyExists(Connection conn, int userId, int budgetId) {
        String sql = "SELECT notification_id " +
                "FROM notifications " +
                "WHERE user_id = ? " +
                "AND budget_id = ? " +
                "AND DATE(notification_date) = CURDATE() " +
                "LIMIT 1";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, budgetId);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private void insertNotification(Connection conn, int userId, int budgetId, String message) {
        String sql = "INSERT INTO notifications (user_id, budget_id, message) " +
                "VALUES (?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, budgetId);
            stmt.setString(3, message);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<BudgetNotification> getNotificationsByUserId(int userId) {
        List<BudgetNotification> notifications = new ArrayList<>();

        String sql = "SELECT " +
                "n.notification_id, " +
                "n.budget_id, " +
                "n.message, " +
                "n.notification_date, " +
                "n.is_read, " +
                "b.category_id, " +
                "b.category_budget, " +
                "b.threshold, " +
                "b.start_date, " +
                "b.end_date, " +
                "c.name AS category_name, " +
                "COALESCE(SUM(t.amount), 0) AS current_spending " +
                "FROM notifications n " +
                "JOIN budgets b ON n.budget_id = b.budget_id " +
                "LEFT JOIN categories c ON b.category_id = c.category_id " +
                "LEFT JOIN transactions t ON t.user_id = n.user_id " +
                "AND t.category_id = b.category_id " +
                "AND t.transaction_type = 'expense' " +
                "AND DATE(t.transaction_date) BETWEEN b.start_date AND b.end_date " +
                "WHERE n.user_id = ? " +
                "GROUP BY n.notification_id, n.budget_id, n.message, n.notification_date, " +
                "b.category_id, b.category_budget, b.threshold, b.start_date, b.end_date, c.name " +
                "ORDER BY n.notification_date DESC";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    double categoryBudget = rs.getDouble("category_budget");
                    double threshold = rs.getDouble("threshold");
                    double currentSpending = rs.getDouble("current_spending");
                    double warningThreshold = categoryBudget * (threshold / 100.0);
                    double difference = currentSpending - warningThreshold;

                    BudgetNotification notification = new BudgetNotification();

                    notification.setNotificationId(rs.getInt("notification_id"));
                    notification.setBudgetId(rs.getInt("budget_id"));
                    notification.setMessage(rs.getString("message"));
                    notification.setNotificationDate(rs.getTimestamp("notification_date"));
                    notification.setCategoryName(rs.getString("category_name"));
                    notification.setCurrentSpending(currentSpending);
                    notification.setWarningThreshold(warningThreshold);
                    notification.setDifference(difference);
                    notification.setRead(rs.getBoolean("is_read"));

                    notifications.add(notification);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return notifications;
    }

    public boolean deleteNotification(int notificationId, int userId) {
        String sql = "DELETE FROM notifications " +
                "WHERE notification_id = ? AND user_id = ?";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, notificationId);
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public int getNotificationCountByUserId(int userId) {
        String sql = "SELECT COUNT(*) AS total_notification " +
                "FROM notifications " +
                "WHERE user_id = ? AND is_read = FALSE";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total_notification");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public boolean markNotificationAsRead(int notificationId, int userId) {
        String sql = "UPDATE notifications " +
                "SET is_read = TRUE " +
                "WHERE notification_id = ? AND user_id = ?";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, notificationId);
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean markAllAsReadByUserId(int userId) {
        String sql = "UPDATE notifications " +
                "SET is_read = TRUE " +
                "WHERE user_id = ? AND is_read = FALSE";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}