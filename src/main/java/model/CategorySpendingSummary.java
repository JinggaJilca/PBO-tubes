package model;

public class CategorySpendingSummary {
    private String categoryName;
    private double totalAmount;
    private double percentage;

    public CategorySpendingSummary() {
    }

    public CategorySpendingSummary(String categoryName, double totalAmount, double percentage) {
        this.categoryName = categoryName;
        this.totalAmount = totalAmount;
        this.percentage = percentage;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public double getPercentage() {
        return percentage;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public void setPercentage(double percentage) {
        this.percentage = percentage;
    }
}
