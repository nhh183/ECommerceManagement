package dto;

import java.io.Serializable;
import java.sql.Date;

public class CouponDTO implements Serializable {
    private String code;
    private float discountPercent;
    private Date startDate;
    private Date endDate;
    private int quantity;
    private String status;

    public CouponDTO() {
    }

    public CouponDTO(String code, float discountPercent, Date startDate, Date endDate, int quantity) {
        this.code = code;
        this.discountPercent = discountPercent;
        this.startDate = startDate;
        this.endDate = endDate;
        this.quantity = quantity;
        
    }
    
    public CouponDTO(String code, float discountPercent, Date startDate, Date endDate, int quantity, String status) {
        this.code = code;
        this.discountPercent = discountPercent;
        this.startDate = startDate;
        this.endDate = endDate;
        this.quantity = quantity;
        this.status = status;
    }

    // Getters and setters
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public float getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(float discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
