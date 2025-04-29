package model;

public class DashboardStats {
    private int totalOrders;
    private int totalCustomers;
    private int totalItemsSold;

    public DashboardStats(int totalOrders, int totalCustomers, int totalItemsSold) {
        this.totalOrders = totalOrders;
        this.totalCustomers = totalCustomers;
        this.totalItemsSold = totalItemsSold;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public int getTotalCustomers() {
        return totalCustomers;
    }

    public int getTotalItemsSold() {
        return totalItemsSold;
    }
}