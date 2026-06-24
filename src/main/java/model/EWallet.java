package model;

public class EWallet extends Wallet {
    private String providerName;
    private String accountNumber;

    public EWallet() {}

    public EWallet(int accountId, 
            int userId, 
            String accountName, 
            double balance, 
            String providerName, 
            String accountNumber) {
        
        super(accountId, userId, accountName, balance);
        
        this.providerName = providerName;
        this.accountNumber = accountNumber;
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