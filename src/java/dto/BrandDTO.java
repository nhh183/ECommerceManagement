
package dto;

public class BrandDTO {
    private String brandID;
    private String brandName;
    private String description;
    private String status;

    public BrandDTO() {
    }

    public BrandDTO(String brandID, String brandName, String description, String status) {
        this.brandID = brandID;
        this.brandName = brandName;
        this.description = description;
        this.status = status;
    }

    public String getBrandID() {
        return brandID;
    }

    public void setBrandID(String brandID) {
        this.brandID = brandID;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
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

    
}
