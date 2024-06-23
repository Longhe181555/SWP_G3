/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;


public class Cart implements IEntity{

    private int cartId;
    private int amount;
    private double totalPrice;
    private int accountId;
    private int colorId;
    private int productId;
    private int sizeId;

    public Cart() {
    }

    public Cart(int cartId, int amount, double totalPrice, int accountId, int colorId, int productId, int sizeId) {
        this.cartId = cartId;
        this.amount = amount;
        this.totalPrice = totalPrice;
        this.accountId = accountId;
        this.colorId = colorId;
        this.productId = productId;
        this.sizeId = sizeId;
    }

    public Cart(int amount, double totalPrice, int accountId, int colorId, int productId, int sizeId) {
        this.amount = amount;
        this.totalPrice = totalPrice;
        this.accountId = accountId;
        this.colorId = colorId;
        this.productId = productId;
        this.sizeId = sizeId;
    }
    
    

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getColorId() {
        return colorId;
    }

    public void setColorId(int colorId) {
        this.colorId = colorId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
    }

    @Override
    public String toString() {
        return "Cart{" + "cartId=" + cartId + ", amount=" + amount + ", totalPrice=" + totalPrice + ", accountId=" + accountId + ", colorId=" + colorId + ", productId=" + productId + ", sizeId=" + sizeId + '}';
    }

    
}

