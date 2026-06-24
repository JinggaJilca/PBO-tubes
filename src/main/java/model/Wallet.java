package model;

public abstract class Wallet {
    private int accountId;
    private int userId;
    private String accountName;
    private double balance;

    public Wallet() {}

    public Wallet(int accountId, 
            int userId, 
            String accountName, 
            double balance) {
        this.accountId = accountId;
        this.userId = userId;
        this.accountName = accountName;
        this.balance = balance;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }
    

}
