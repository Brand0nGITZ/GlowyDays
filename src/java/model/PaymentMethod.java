package model;

public class PaymentMethod {

    private String methodId;
    private String methodName;
    private String cardOwner;
    private String cardNumber;
    private String expMonth;
    private String expYear;
    private String cvv;
    private int userId; // Added user_id for association with user

    // Constructors
    public PaymentMethod() {}

    public PaymentMethod(String methodId, String methodName, String cardOwner, String cardNumber,
                         String expMonth, String expYear, String cvv, int userId) {
        this.methodId = methodId;
        this.methodName = methodName;
        this.cardOwner = cardOwner;
        this.cardNumber = cardNumber;
        this.expMonth = expMonth;
        this.expYear = expYear;
        this.cvv = cvv;
        this.userId = userId;
    }

    // Getters and Setters
   public String getMethodId() {
        return methodId;
    }

    public void setMethodId(String methodId) {
        this.methodId = methodId;
    }
    
   
    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    public String getCardOwner() {
        return cardOwner;
    }

    public void setCardOwner(String cardOwner) {
        this.cardOwner = cardOwner;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getExpMonth() {
        return expMonth;
    }

    public void setExpMonth(String expMonth) {
        this.expMonth = expMonth;
    }

    public String getExpYear() {
        return expYear;
    }

    public void setExpYear(String expYear) {
        this.expYear = expYear;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}