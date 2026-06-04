package model;

public class MonthlyTransactionSummary {
    private int month;
    private double totalIncome;
    private double totalExpense;

    public MonthlyTransactionSummary() {
    }

    public MonthlyTransactionSummary(int month, double totalIncome, double totalExpense) {
        this.month = month;
        this.totalIncome = totalIncome;
        this.totalExpense = totalExpense;
    }

    public int getMonth() {
        return month;
    }

    public double getTotalIncome() {
        return totalIncome;
    }

    public double getTotalExpense() {
        return totalExpense;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public void setTotalIncome(double totalIncome) {
        this.totalIncome = totalIncome;
    }

    public void setTotalExpense(double totalExpense) {
        this.totalExpense = totalExpense;
    }
}
