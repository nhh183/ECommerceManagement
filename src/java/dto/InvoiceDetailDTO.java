package dto;

public class InvoiceDetailDTO {
    private int invoiceID;
    private int productID;
    private int quantity;
    private double price;

    public InvoiceDetailDTO() {}

    public InvoiceDetailDTO(int invoiceID, int productID, int quantity, double price) {
        this.invoiceID = invoiceID;
        this.productID = productID;
        this.quantity = quantity;
        this.price = price;
    }

    // Getters and Setters
    public int getInvoiceID() { return invoiceID; }
    public void setInvoiceID(int invoiceID) { this.invoiceID = invoiceID; }

    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
