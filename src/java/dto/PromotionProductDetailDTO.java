/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author User
 */
public class PromotionProductDetailDTO {
    private int promoID;
    private String promoName;
    private int productID;
    private String productName;

    public PromotionProductDetailDTO() {
    }

    public PromotionProductDetailDTO(int promoID, String promoName, int productID, String productName) {
        this.promoID = promoID;
        this.promoName = promoName;
        this.productID = productID;
        this.productName = productName;
    }

    public int getPromoID() {
        return promoID;
    }

    public void setPromoID(int promoID) {
        this.promoID = promoID;
    }

    public String getPromoName() {
        return promoName;
    }

    public void setPromoName(String promoName) {
        this.promoName = promoName;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    
}
