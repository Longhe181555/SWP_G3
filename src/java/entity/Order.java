/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author duong
 */
public class Order {
    private int orid;
    private int aid;
    private Date date;
    private String description;
    private String status;
    private int pmid;

    public Order(int orid, int aid, Date date, String description, String status, int pmid) {
        this.orid = orid;
        this.aid = aid;
        this.date = date;
        this.description = description;
        this.status = status;
        this.pmid = pmid;
    }

    public Order() {
        
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
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

    public int getPmid() {
        return pmid;
    }

    public void setPmid(int pmid) {
        this.pmid = pmid;
    }

}
