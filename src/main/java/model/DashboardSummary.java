package model;

public class DashboardSummary {
    private double totalBalance;
    private double totalEarnings;
    private double totalSpending;
    private double lastMonthEarnings;
    private double lastMonthSpending;
    private double lastMonthBalance;

    public DashboardSummary() {
    }

    public DashboardSummary(double totalBalance, double totalEarnings, double totalSpending,
            double lastMonthEarnings, double lastMonthSpending, double lastMonthBalance) {
        this.totalBalance = totalBalance;
        this.totalEarnings = totalEarnings;
        this.totalSpending = totalSpending;
        this.lastMonthEarnings = lastMonthEarnings;
        this.lastMonthSpending = lastMonthSpending;
        this.lastMonthBalance = lastMonthBalance;
    }

    public double getTotalBalance() {
        return totalBalance;
    }

    public void setTotalBalance(double totalBalance) {
        this.totalBalance = totalBalance;
    }

    public double getTotalEarnings() {
        return totalEarnings;
    }

    public void setTotalEarnings(double totalEarnings) {
        this.totalEarnings = totalEarnings;
    }

    public double getTotalSpending() {
        return totalSpending;
    }

    public void setTotalSpending(double totalSpending) {
        this.totalSpending = totalSpending;
    }

    public double getLastMonthEarnings() {
        return lastMonthEarnings;
    }

    public void setLastMonthEarnings(double lastMonthEarnings) {
        this.lastMonthEarnings = lastMonthEarnings;
    }

    public double getLastMonthSpending() {
        return lastMonthSpending;
    }

    public void setLastMonthSpending(double lastMonthSpending) {
        this.lastMonthSpending = lastMonthSpending;
    }

    public double getLastMonthBalance() {
        return lastMonthBalance;
    }

    public void setLastMonthBalance(double lastMonthBalance) {
        this.lastMonthBalance = lastMonthBalance;
    }
}