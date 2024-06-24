/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto.response;


public class ProductPriceResponse{
        private int productId;
        private double price;
        private int value;
        private String type;
        private int stock;

        public ProductPriceResponse() {
        }

        public ProductPriceResponse(int productId, double price, int value, String type, int stock) {
            this.productId = productId;
            this.price = price;
            this.value = value;
            this.type = type;
            this.stock = stock;
        }

        public int getProductId() {
            return productId;
        }

        public void setProductId(int productId) {
            this.productId = productId;
        }

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }

        public int getValue() {
            return value;
        }

        public void setValue(int value) {
            this.value = value;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public int getStock() {
            return stock;
        }

        public void setStock(int stock) {
            this.stock = stock;
        }
        
    }
