/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author User
 */
public class CategoryDTO {
    private int categoryID;
    private String categoryName;
    private String description;
    private String imgUrl;

    public CategoryDTO() {
    }

    public CategoryDTO(int categoryID, String categoryName, String description, String imgUrl) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.description = description;
        this.imgUrl = imgUrl;
    }

    public CategoryDTO(String categoryName, String description, String imgUrl) {
        this.categoryName = categoryName;
        this.description = description;
        this.imgUrl = imgUrl;
    }


    
    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }
    
    
}
