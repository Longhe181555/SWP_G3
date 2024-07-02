/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package entity;


public class ProductItem implements IEntity {
  private int piid;
  private int stockcount;
  private Product product;
  private String size;
  private String color;
  private Discount discount;
    public int getPiid() {
        return piid;
    }

    public void setPiid(int piid) {
        this.piid = piid;
    }

    public int getStockcount() {
        return stockcount;
    }

    public void setStockcount(int stockcount) {
        this.stockcount = stockcount;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Discount getDiscount() {
        return discount;
    }

    public void setDiscount(Discount discount) {
        this.discount = discount;
    }
    public int getDiscountedPrice() {
    if (discount != null && "percentage".equalsIgnoreCase(discount.getDtype())) {
        double discountValue = discount.getValue() / 100.0;
        return (int) (product.getPrice() * (1 - discountValue));
    } else {
        return product.getPrice(); 
    }
}
    
}
