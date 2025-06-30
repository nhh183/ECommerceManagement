/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.Date;
/**
 *
 * @author loan1
 */

public class ReturnDTO {
    private int returnID;
    private int invoiceID;
    private String reason;
    private String status;
    private Date returnDate;

    public ReturnDTO() {
    }

    public ReturnDTO(int returnID, int invoiceID, String reason, String status, Date returnDate) {
        this.returnID = returnID;
        this.invoiceID = invoiceID;
        this.reason = reason;
        this.status = status;
        this.returnDate = returnDate;
    }

    public int getReturnID() {
        return returnID;
    }

    public void setReturnID(int returnID) {
        this.returnID = returnID;
    }

    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }
}
