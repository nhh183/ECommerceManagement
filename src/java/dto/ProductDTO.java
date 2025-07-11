/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author User
 */
public class ProductDTO {
    private int productID;
    private String name;
    private int categoryID;
    private double price;
    private int quantity;
    private String sellerID;
    private String status;
    private String imgUrl;
    private String description;
    
    private PromotionDTO promotion;


    public ProductDTO() {
    }

    public ProductDTO(int productID, String name, int categoryID, double price, int quantity, String sellerID, String status, String imgUrl, String description) {
        this.productID = productID;
        this.name = name;
        this.categoryID = categoryID;
        this.price = price;
        this.quantity = quantity;
        this.sellerID = sellerID;
        this.status = status;
        this.imgUrl = imgUrl;
        this.description = description;
    }

    public ProductDTO(String name, int categoryID, double price, int quantity, String sellerID, String status, String imgUrl, String description) {
        this.name = name;
        this.categoryID = categoryID;
        this.price = price;
        this.quantity = quantity;
        this.sellerID = sellerID;
        this.status = status;
        this.imgUrl = imgUrl;
        this.description = description;
    }

    public ProductDTO(int productID, String name, double price, String imgUrl, PromotionDTO promotion) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.imgUrl = imgUrl;
        this.promotion = promotion;
    }
    
    

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getSellerID() {
        return sellerID;
    }

    public void setSellerID(String sellerID) {
        this.sellerID = sellerID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String desciption) {
        this.description = desciption;
    }

    public PromotionDTO getPromotion() {
        return promotion;
    }

    public void setPromotion(PromotionDTO promotion) {
        this.promotion = promotion;
    }

    
    
    
}
