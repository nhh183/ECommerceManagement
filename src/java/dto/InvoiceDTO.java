package dto;

import java.util.Date;

public class InvoiceDTO {
    private int invoiceID;
    private String userID;
    private double totalAmount;
    private String status;
    private Date createdDate;

    public InvoiceDTO() {}

    public InvoiceDTO(int invoiceID, String userID, double totalAmount, String status, Date createdDate) {
        this.invoiceID = invoiceID;
        this.userID = userID;
        this.totalAmount = totalAmount;
        this.status = status;
        this.createdDate = createdDate;
    }

    // Getters and Setters
    public int getInvoiceID() { return invoiceID; }
    public void setInvoiceID(int invoiceID) { this.invoiceID = invoiceID; }

    public String getUserID() { return userID; }
    public void setUserID(String userID) { this.userID = userID; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
}
