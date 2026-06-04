package model;

public class Profile {
    private int profileID;
   private int userID;
   private String fullName;
   private String phoneNumber;
   private String address;

   public Profile() {
   }

   public Profile(int var1, int var2, String var3, String var4, String var5) {
      this.profileID = var1;
      this.userID = var2;
      this.fullName = var3;
      this.phoneNumber = var4;
      this.address = var5;
   }

   public void updateProfile(String var1, String var2, String var3) {
      this.fullName = var1;
      this.phoneNumber = var2;
      this.address = var3;
   }

   public int getProfileID() {
      return this.profileID;
   }

   public void setProfileID(int var1) {
      this.profileID = var1;
   }

   public int getUserID() {
      return this.userID;
   }

   public void setUserID(int var1) {
      this.userID = var1;
   }

   public String getFullName() {
      return this.fullName;
   }

   public void setFullName(String var1) {
      this.fullName = var1;
   }

   public String getPhoneNumber() {
      return this.phoneNumber;
   }

   public void setPhoneNumber(String var1) {
      this.phoneNumber = var1;
   }

   public String getAddress() {
      return this.address;
   }

   public void setAddress(String var1) {
      this.address = var1;
   }

   public String toString() {
      return "Profile{profileID=" + this.profileID + ", userID=" + this.userID + ", fullName='" + this.fullName + "', phoneNumber='" + this.phoneNumber + "', address='" + this.address + "'}";
   }
}
