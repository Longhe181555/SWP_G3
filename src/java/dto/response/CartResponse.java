/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto.response;


public class CartResponse {

    private int cartId;
    private int quantity;
    private double totalPrice;
    private int productId;
    private int sizeId;
    private String sizeName;
    private int colorId;
    private String colorName;
    private String imgPath;
    private String productName;
    private double price;
    private double value;
    private String discountType;
    private int stock;

    public CartResponse() {
    }

    public CartResponse(int cartId, int quantity, double totalPrice, int productId, int sizeId, String sizeName, int colorId, String colorName, String imgPath, String productName, double price, double value, String discountType, int stock) {
        this.cartId = cartId;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.productId = productId;
        this.sizeId = sizeId;
        this.sizeName = sizeName;
        this.colorId = colorId;
        this.colorName = colorName;
        this.imgPath = imgPath;
        this.productName = productName;
        this.price = price;
        this.value = value;
        this.discountType = discountType;
        this.stock = stock;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    
    

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
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

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }

    public int getColorId() {
        return colorId;
    }

    public void setColorId(int colorId) {
        this.colorId = colorId;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "CartResponse{" + "cartId=" + cartId + ", quantity=" + quantity + ", totalPrice=" + totalPrice + ", productId=" + productId + ", sizeId=" + sizeId + ", sizeName=" + sizeName + ", colorId=" + colorId + ", colorName=" + colorName + ", imgPath=" + imgPath + ", productName=" + productName + ", price=" + price + ", value=" + value + ", discountType=" + discountType + ", stock=" + stock + '}';
    }

    

    

}
