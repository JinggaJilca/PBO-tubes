/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class Category {

    private int categoryID;
    private String name;
    private String type;
    // Constructor Kosong (Wajib ada agar tidak error saat bikin objek kosong)
    public Category() {
    }

    // Constructor dengan 3 Parameter (Ini yang dicari oleh CategoryDAO)
    public Category(int categoryID, String name, String type) {
        this.categoryID = categoryID;
        this.name = name;
        this.type = type;
    }
    public String getCategoryInfo() {
        return "Category [ID=" + categoryID + ", Name=" + name + ", Type=" + type + "]";
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
