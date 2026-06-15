package model;

import java.sql.Date;

public class Budget {
    private int budgetId;
    private int userId;
    private int categoryId;
    private double totalBudget;     
    private double categoryBudget;
    private double threshold;
    private Date startDate;         
    private Date endDate; 

    public int getBudgetId() {
        return budgetId;
    }

    public void setBudgetId(int budgetId) {
        this.budgetId = budgetId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public double getTotalBudget() {
        return totalBudget;
    }

    public void setTotalBudget(double totalBudget) {
        this.totalBudget = totalBudget;
    }

    public double getCategoryBudget() {
        return categoryBudget;
    }

    public void setCategoryBudget(double categoryBudget) {
        this.categoryBudget = categoryBudget;
    }

    public double getThreshold() {
        return threshold;
    }

    public void setThreshold(double threshold) {
        this.threshold = threshold;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    
    // Logika Threshold
    public boolean checkThreshold(double currentSpending) {
        if (this.categoryBudget <= 0) return false; // Hindari pembagian dengan nol
        
        double currentPercentage = (currentSpending / this.categoryBudget) * 100;
        return currentPercentage >= this.threshold;
    }
}