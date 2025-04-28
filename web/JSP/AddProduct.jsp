<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Product</title>
    <link href="../CSS/AddProduct.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <!-- back button -->
    <a href="AdminPanel.jsp" class="back-button">
        <i class="fas fa-arrow-left"></i> Back
    </a>

    <div class="wrap">
        <h1>Add Product</h1>
        <p class="subtitle">Fill in the product details below</p>

        <form action="<%= request.getContextPath() %>/AddProduct" method="post">
            <!-- Row 1: Product Name & Category -->
            <div class="form-row">
                <div class="form-group">
                    <label for="productName">Product Name</label>
                    <input type="text" id="productName" name="productName" placeholder="Enter product name" required>
                </div>
                <div class="form-group">
                    <label for="category">Category</label>
                    <input type="text" id="category" name="category" placeholder="Enter category" required>
                </div>
            </div>

            <!-- Row 2: Price & Stock Quantity -->
            <div class="form-row">
                <div class="form-group">
                    <label for="price">Price (RM)</label>
                    <input type="number" step="0.01" id="price" name="price" placeholder="e.g. 39.99" required>
                </div>
                <div class="form-group">
                    <label for="stockQuantity">Stock Quantity</label>
                    <input type="number" id="stockQuantity" name="stockQuantity" placeholder="e.g. 50" required>
                </div>
            </div>

            <!-- Row 3: Image URL & Description -->
            <div class="form-row">
                <div class="form-group">
                    <label for="imageUrl">Image URL</label>
                    <!-- no validation here -->
                    <input type="text" id="imageUrl" name="imageUrl" placeholder="Paste image URL">
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" rows="3" placeholder="Enter description" required></textarea>
                </div>
            </div>

            <!-- Action buttons -->
            <div class="button-container">
                <button type="reset" class="reset-btn">Reset</button>
                <button type="submit" class="register-btn">Create Product</button>
            </div>
        </form>
    </div>
</body>
</html>