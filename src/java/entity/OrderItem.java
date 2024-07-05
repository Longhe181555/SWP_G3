/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package entity;


public class OrderItem {
  private int orderId;
  private int piid;
  private ProductItem productItem;
  private int amount;
  private int soldPrice;
  private int oiid;
  private Discount discount;
  private String product_status; 
  
    public int getPiid() {
        return piid;
    }

    public void setPiid(int piid) {
        this.piid = piid;
    }

    public ProductItem getProductItem() {
        return productItem;
    }

    public void setProductItem(ProductItem productItem) {
        this.productItem = productItem;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public int getSoldPrice() {
        return soldPrice;
    }

    public void setSoldPrice(int soldPrice) {
        this.soldPrice = soldPrice;
    }

    public int getOiid() {
        return oiid;
    }

    public void setOiid(int oiid) {
        this.oiid = oiid;
    }

    public Discount getDiscount() {
        return discount;
    }

    public void setDiscount(Discount discount) {
        this.discount = discount;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getProduct_status() {
        return product_status;
    }

    public void setProduct_status(String product_status) {
        this.product_status = product_status;
    }

    
}
