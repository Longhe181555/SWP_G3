/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package entity;

import java.sql.Date;
import java.util.ArrayList;


public class Product implements IEntity {
  private int pid;
  private String pname;
  private int price;
  private ArrayList<ProductImg> productimgs;
  private Boolean isListed;
  private Brand brand;
  private Category category;
  private String description;
  private java.sql.Date Date;
  private int discountedPrice;
  private String discountDescription;
  private float avarageRating;

    public float getAvarageRating() {
        return avarageRating;
    }

    public void setAvarageRating(float avarageRating) {
        this.avarageRating = avarageRating;
    }

    public String getDiscountDescription() {
        return discountDescription;
    }

    public void setDiscountDescription(String discountDescription) {
        this.discountDescription = discountDescription;
    }

    public int getDiscountedPrice() {
        return discountedPrice;
    }

    public void setDiscountedPrice(int discountedPrice) {
        this.discountedPrice = discountedPrice;
    }

    public Date getDate() {
        return Date;
    }

    public void setDate(java.sql.Date Date) {
        this.Date = Date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public Boolean getIsListed() {
        return isListed;
    }

    public void setIsListed(Boolean isListed) {
        this.isListed = isListed;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
    
     public ArrayList<ProductImg> getProductimgs() {
        return productimgs;
    }

    public void setProductimgs(ArrayList<ProductImg> productimgs) {
        this.productimgs = productimgs;
    }
}
