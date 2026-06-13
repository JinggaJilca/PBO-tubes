package model;

public class Wallet {
    private int accountId;
    private int userId;
    private String accountName;
    private double balance;

    private String walletType;      // physical atau ewallet
    private String providerName;    // GoPay, OVO, Dana, dll
    private String accountNumber;   // nomor ewallet

    public Wallet() {
    }

    public Wallet(int accountId, int userId, String accountName, double balance,
                  String walletType, String providerName, String accountNumber) {
        this.accountId = accountId;
        this.userId = userId;
        this.accountName = accountName;
        this.balance = balance;
        this.walletType = walletType;
        this.providerName = providerName;
        this.accountNumber = accountNumber;
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

    public String getWalletType() {
        return walletType;
    }

    public void setWalletType(String walletType) {
        this.walletType = walletType;
    }

    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }
}
