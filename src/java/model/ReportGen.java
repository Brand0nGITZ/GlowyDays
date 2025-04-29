
package model;


public class ReportGen {
    private String productName;
    private int quantitySold;
    private String imageUrl;

    public ReportGen(String productName, int quantitySold, String imageUrl) {
        this.productName = productName;
        this.quantitySold = quantitySold;
        this.imageUrl = imageUrl;
    }

    public String getProductName() {
        return productName;
    }

    public int getQuantitySold() {
        return quantitySold;
    }

    public String getImageUrl() {
        return imageUrl;
    }
}





