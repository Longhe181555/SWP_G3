/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author duong
 */
public class OrderDetail {
    private int orid;
    private int aid;
    private String date;
    private String description;
    private String status;
    private double totalAmount;
    private String items;
    private String approvalStatus;

    public OrderDetail() {
    }

    public OrderDetail(int orid, int aid, String date, String description, String status, double totalAmount, String items, String approvalStatus) {
        this.orid = orid;
        this.aid = aid;
        this.date = date;
        this.description = description;
        this.status = status;
        this.totalAmount = totalAmount;
        this.items = items;
        this.approvalStatus = approvalStatus;
    }

 

    public int getOrid() {
        return orid;
    }

    public void setOrid(int orid) {
        this.orid = orid;
    }

    public int getAid() {
        return aid;
    }

    public void setAid(int aid) {
        this.aid = aid;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getItems() {
        return items;
    }

    public void setItems(String items) {
        this.items = items;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

}
