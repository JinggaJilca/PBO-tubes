package model;

public class PhysicalWallet extends Wallet{
    private String accountNumber;
    
    public PhysicalWallet(){}
    
    public PhysicalWallet(
            int accountId, 
            int userId, 
            String accountName, 
            double balance, 
            String accountNumber) {
        
        super(accountId, userId, accountName, balance);
        this.accountNumber = accountNumber;
    }
    public String getAccountNumber() { 
        return accountNumber; 
    }
    public void setAccountNumber(String accountNumber) { 
        this.accountNumber = accountNumber; 
    }
}
