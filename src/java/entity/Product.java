/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package entity;

import java.util.ArrayList;


public class Product implements IEntity {
  private int pid;
  private String pname;
  private float price;
  private ArrayList<ProductImg> productimgs;
  private Boolean isListed;
  private Brand brand;
  private Category category;

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

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
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
