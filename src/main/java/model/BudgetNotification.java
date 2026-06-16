package model;

import java.sql.Timestamp;

public class BudgetNotification {

    private int notificationId;
    private int budgetId;
    private String categoryName;
    private String message;
    private Timestamp notificationDate;

    private double currentSpending;
    private double warningThreshold;
    private double difference;
    private boolean read;

    public BudgetNotification() {
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public int getBudgetId() {
        return budgetId;
    }

    public void setBudgetId(int budgetId) {
        this.budgetId = budgetId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getNotificationDate() {
        return notificationDate;
    }

    public void setNotificationDate(Timestamp notificationDate) {
        this.notificationDate = notificationDate;
    }

    public double getCurrentSpending() {
        return currentSpending;
    }

    public void setCurrentSpending(double currentSpending) {
        this.currentSpending = currentSpending;
    }

    public double getWarningThreshold() {
        return warningThreshold;
    }

    public void setWarningThreshold(double warningThreshold) {
        this.warningThreshold = warningThreshold;
    }

    public double getDifference() {
        return difference;
    }

    public void setDifference(double difference) {
        this.difference = difference;
    }

    public boolean isRead() {
        return read;
    }

    public void setRead(boolean read) {
        this.read = read;
    }
}