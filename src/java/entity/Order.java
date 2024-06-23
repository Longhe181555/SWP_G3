/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;


public class Order implements IEntity{
    private int orderId;
    private int accountId;
    private String date;
    private String description;
    private double total;

    public Order() {
    }

    public Order(int orderId, int accountId, String date, String description, double total) {
        this.orderId = orderId;
        this.accountId = accountId;
        this.date = date;
        this.description = description;
        this.total = total;
    }

    public Order(int accountId, double total) {
        this.accountId = accountId;
        this.total = total;
    }
    
    

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
    
    
}
