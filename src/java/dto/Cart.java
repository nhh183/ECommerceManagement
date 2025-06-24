/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.Date;
import java.time.LocalDate;


/**
 *
 * @author NHH
 */
public class Cart {
    private int cartID;
    private String userID;
    private Date createdDate;

    public Cart(String userID) {
        this.userID = userID;
        this.createdDate = Date.valueOf(LocalDate.now());
    }

    public Cart(int cartID, String userID, Date createdDate) {
        this.cartID = cartID;
        this.userID = userID;
        this.createdDate = createdDate;
    }
    
    
    
    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    
    
}
