package model;

public class User {
    private int userID;
    private String username;
    private String email;
    private String password;
    private Profile profile;

    public User() {
    }

    public User(int userID, String username, String email, String password, Profile profile) {
        this.userID = userID;
        this.username = username;
        this.email = email;
        this.password = password;
        this.profile = profile;
    }

    public void editProfile(String newUsername, String newEmail) {
        this.username = newUsername;
        this.email = newEmail;
    }

    public int getUserID() {
        return userID;
    }

    public String getUsername() {
        return this.username;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public Profile getprofile() {
        return profile;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setprofile(Profile profile) {
        this.profile = profile;
    }
}