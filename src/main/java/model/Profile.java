package model;

public class Profile {
    private int userId;
    private String username;
    private String email;
    private String password;
    private String fullName;
    private String phoneNumber;
    private String address;

    public Profile() {
    }

    public Profile(int userId, String username, String email, String password,
                   String fullName, String phoneNumber, String address) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.address = address;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    // Untuk tampilan profile, password jangan ditampilkan asli
    public String getMaskedPassword() {
        return "***";
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public String getDisplayName() {
        if (fullName != null && !fullName.trim().isEmpty()) {
            return fullName;
        }
        return username;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getDisplayPhoneNumber() {
        if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
            return phoneNumber;
        }
        return "None";
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public String getDisplayAddress() {
        if (address != null && !address.trim().isEmpty()) {
            return address;
        }
        return "None";
    }

    public void setAddress(String address) {
        this.address = address;
    }
}