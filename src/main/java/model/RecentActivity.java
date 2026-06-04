package model;

public class RecentActivity {
     private int transactionID;
    private String categoryName;
    private String transactionName;
    private double amount;
    private String transactionType;
    private String date;
    private String time;
    private String note;

    public RecentActivity() {
    }

    public RecentActivity(int transactionID, String categoryName, String transactionName,
                          double amount, String transactionType, String date, String time, String note) {
        this.transactionID = transactionID;
        this.categoryName = categoryName;
        this.transactionName = transactionName;
        this.amount = amount;
        this.transactionType = transactionType;
        this.date = date;
        this.time = time;
        this.note = note;
    }

    public int getTransactionID() {
        return transactionID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public String getTransactionName() {
        return transactionName;
    }

    public double getAmount() {
        return amount;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public String getDate() {
        return date;
    }

    public String getTime() {
        return time;
    }

    public String getNote() {
        return note;
    }
}
