<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Home</title>
        <link rel="stylesheet" href="../CSS/home.css?v=6">
        <link rel="stylesheet" href="../CSS/updateUser.css?v=3">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        
        <style>
            .avatar-container {
                position: relative;
                display: inline-block;
            }

            .dropdown-menu {
                display: none;
                position: absolute;
                top: 45px;
                left: -10px;
                z-index: 1000;
            }

            .avatar-container .dropdown-menu a {
                /* 这样写就只影响avatar那边的下拉menu */
                display: block;
                text-decoration: none;
                color: black;
                background-color: white;
                width: 180px;
                border: 1px solid #ccc;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .avatar-container .dropdown-menu a:hover {
                background-color: #F9E075;
                color: black;
}

            .avatar-container:hover .dropdown-menu {
                display: block;
            }
            
            .logo img {
            width: 90px; /* Adjust the width according to your design */
            height: 60px; /* Keep aspect ratio */
            display: block;
        }
        </style>
        
    </head>
    <body>
        <%
            String name = (String) session.getAttribute("name");
            String username = (String) session.getAttribute("username");
            String birth = (String) session.getAttribute("birth");
            String email = (String) session.getAttribute("email");
            String mobileNo = (String) session.getAttribute("mobileNo");
        %>

          <section id="header" class="header">
    <a href="UserHome.jsp" class="logo">
        <img src="../ICON/logo2.png" alt="Glowy Days Logo">
    </a>
    <div class="navbar">
        <a href="UserHome.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/ProductServlet">Product</a>
        <a href="<%= request.getContextPath() %>/PromotionProductsServlet">Promotion</a>              
        <a href="AboutUs.jsp">About Us</a>                           
    </div>
    <div class="icons">
        <div class="search-wrapper">
            <i class="fa-solid fa-magnifying-glass" id="search-icon"></i>
            <input type="text" id="search-box" placeholder="Search..." />
        </div>
        <a href="<%= request.getContextPath() %>/LoadCartServlet" class="fa-solid fa-cart-shopping"></a>    
        <div class="avatar-container">
            <i class="fa-regular fa-user" style="font-size:18px; cursor:pointer;"></i> 
            <div class="dropdown-menu">
              
             
                <a class="dropdown-item" href="UserProfile.jsp">User Profile</a>
                <a class="dropdown-item" href="<%= request.getContextPath() %>/LogoutServlet">Log Out</a>
            </div>
        </div>
    </div>
</section>
                    
        <div id="details">
            <br />
            <h1>User Details</h1>
                <hr>
                
                <form id="userForm" action="<%= request.getContextPath() %>/UpdateUserDetails" method="post" onsubmit="prepareForm()">
                    <fieldset>
                        
                        <!-- Name Field -->
                        <fieldset>
                            <div class="label">
                                <label for="name">Full Name:</label>
                            </div>
                            <div class="input">
                                <input type="text" id="name" name="name" value="<%= name %>" readonly>
                                <span class="edit-icon" onclick="makeEditable('name')" style="cursor: pointer;">
                                    <img src="../ICON/edit.svg" alt="Edit" width="20" height="20">
                                </span>
                                <div id="nameValidation" style="margin-top: 7px;"></div>
                                <button type="submit" name="field" value="name" id="saveName" style="display:none; margin-top: 10px; margin-bottom: -15px;">Save</button>
                            </div>
                        </fieldset>
                                    
                        <!-- Username Field -->
                        <fieldset>
                            <div class="label">
                                <label for="username">Username:</label>
                            </div>
                            <div class="input">
                                <input type="text" id="username" name="username" value="<%= username %>" readonly>
                                <span class="edit-icon" style="visibility: hidden;">
                                    <img src="../ICON/edit.svg" alt="Edit" width="20" height="20">
                                </span> <!-- Hidden for Username -->
                            </div>
                        </fieldset>

                        <!-- Birth -->
                        <fieldset>
                            <div class="label">
                                <label for="birthday">Birth date:</label>
                            </div>
                            <div class="input">
                                <input type="date" id="birth" name="birth" value="<%= birth %>" readonly>
                                <span class="edit-icon" onclick="makeEditable('birth')" style="cursor: pointer;">
                                    <img src="../ICON/edit.svg" alt="Edit" width="20" height="20">
                                </span>
                                <span id="birthValidation" style="margin-top: 7px;"></span>
                                <button type="submit" name="field" value="birth" id="saveBirth" style="display:none; margin-top: 10px; margin-bottom: -15px;">Save</button>
                            </div>
                        </fieldset>

                        <!-- Email -->
                        <fieldset>
                            <div class="label">
                                <label for="emailInput">Email:</label>
                            </div>
                            <div class="input">
                                <input type="email" id="email" name="email" value="<%= email %>" readonly>
                                <span class="edit-icon" onclick="makeEditable('email')" style="cursor: pointer;">
                                    <img src="../ICON/edit.svg" alt="Edit" width="20" height="20">
                                </span>
                                <div id="emailValidation" style="margin-top: 7px;"></div>
                                <button type="submit" name="field" value="email" id="saveEmail" style="display:none; margin-top: 10px; margin-bottom: -15px;">Save</button>
                            </div>
                        </fieldset>

                        <!-- Mobile No -->
                        <fieldset>
                            <div class="label">
                                <label for="phoneInput">Mobile Number:</label>
                            </div>
                            <div class="input">
                                <input type="tel" id="mobileNo" name="mobileNo" value="<%= mobileNo %>" readonly>
                                <span class="edit-icon" onclick="makeEditable('mobileNo')" style="cursor: pointer;">
                                    <img src="../ICON/edit.svg" alt="Edit" width="20" height="20">
                                </span>
                                <span class="red-text accent-4" id="phoneValidation" style="margin-top: 7px;"></span>
                                <button type="submit" name="field" value="mobileNo" id="saveMobileNo" style="display:none; margin-top: 10px; margin-bottom: -15px;">Save</button>
                            </div>
                        </fieldset>

                        <p id="message" style="color: gray; font-size: 14px; text-align: center;">This page is for display purposes only. Click the edit icon to modify individual fields.</p>
                    </fieldset>
                </form>
        </div>
    
        <script>
        function makeEditable(id) {
            const input = document.getElementById(id);
            const saveButton = document.getElementById('save' + capitalizeFirstLetter(id));
            const editIcon = input.parentElement.querySelector(".edit-icon");
            const message = document.getElementById('message');

            // Enable the input
            input.removeAttribute('readonly');
            input.style.border = '1px solid #ccc';
            input.focus();

            // Show save button
            if (saveButton) saveButton.style.display = 'block';

            // Hide the edit icon
            if (editIcon) editIcon.style.visibility = 'hidden';

            // Hide the instruction message
            if (message) message.style.display = 'none';
        }

        function capitalizeFirstLetter(string) {
            return string.charAt(0).toUpperCase() + string.slice(1);
        }

        function prepareForm() {
            const form = document.getElementById("userForm");
            const inputs = form.querySelectorAll("input");

            inputs.forEach(input => {
                if (input.hasAttribute("readonly")) {
                    input.disabled = true;
                }
            });
        }
        </script>
        
    
    <!-- Full name validation (No special character)-->
    <script>
        $(document).ready(function () {
            $('#name').on('keyup', function () {
                var fullName = $(this).val();
                var regex = /^[A-Za-z\s/]+$/; // Only letters, spaces, and '/'

                if (fullName.length > 0) { // Only check if there's input
                    if (!regex.test(fullName)) {
                        $('#nameValidation').html('<span style="color:red; font-size:13px;">Invalid characters detected! Only alphabets, spaces, and "/" are allowed.</span>');
                        $('button[type="submit"]').prop('disabled', true);
                    } else {
                        $.ajax({
                            type: 'POST',
                            url: '/GlowyDaysProjectNew/ValidateName', // Calls the servlet
                            data: { name: fullName },
                            success: function (response) { // Renamed for clarity
                                if (response.trim() === "Valid Name") {
                                    $('#nameValidation').html('<span style="color:green; font-size:13px;">Valid Name!</span>');
                                    $('button[type="submit"]').prop('disabled', false);
                                } else {
                                    $('#nameValidation').html('<span style="color:red; font-size:13px;">Invalid Name.</span>');
                                    $('button[type="submit"]').prop('disabled', true);
                                }
                            },
                            error: function () {
                                $('#nameValidation').html('<span style="color:red;">Error validating name.</span>');
                                $('button[type="submit"]').prop('disabled', true);
                            }
                        });
                    }
                } else {
                    $('#nameValidation').html(''); // Clear validation message
                    $('button[type="submit"]').prop('disabled', true); // Ensure form is disabled
                }
            });
        });
    </script>
    <!-- End of Full name validation (No special character)-->
    
    <!-- Username validation (No duplicate username)-->
    <script>
        $(document).ready(function(){
            $('#username').on('keyup', function(){
                var username = $(this).val().trim(); // Trim whitespace
                if (username.length > 0) { // Only check if there's input
                    $.ajax({
                        type: 'POST',
                        url: '/GlowyDaysProjectNew/CheckName',
                        data: { username: username },
                        success: function(response){ // Renamed for clarity
                            if (response.trim() === "Already Exists") {
                                $('#usernameValidation').html('<span style="color:red; font-size:13px;">Username is already taken. Please choose another.</span>');
                                $('button[type="submit"]').prop('disabled', true); // Disable the register button
                            } else {
                                $('#usernameValidation').html('<span style="color:green; font-size:13px;">Username is available!</span>');
                                $('button[type="submit"]').prop('disabled', false); // Enable the register button
                            }
                        },
                        error: function(){
                            $('#usernameValidation').html('<span style="color:red;">Error checking username.</span>');
                            $('button[type="submit"]').prop('disabled', true);
                        }
                    });
                } else {
                    $('#usernameValidation').html(''); // Clear validation message
                    $('button[type="submit"]').prop('disabled', true); // Disable submit button if input is empty
                }
            });
        });
    </script>
    <!-- End of Username validation (No duplicate username)-->
    
    <!-- Birth date validation (X smaller than 1990 && Larger than today's date)-->
    <script>
        $(document).ready(function () {
            $('#birth').on('input', function () {
                var birthDate = $(this).val(); // Get input value
                if (!birthDate) {
                    $('#birthValidation').html(''); // Clear error if empty
                    return;
                }

                var inputDate = new Date(birthDate);
                var minDate = new Date("1990-01-01");
                var maxDate = new Date();
                maxDate.setHours(0, 0, 0, 0); // Remove time part

                // Validate only when full date is entered
                if (birthDate.length === 10) {
                    if (inputDate < minDate) {
                        $('#birthValidation').html('<span style="color:red; font-size:13px;">Invalid birth date. Must be after 01-01-1990!</span>');
                        $(this).val(""); // Clear invalid input
                    } else if (inputDate > maxDate) {
                        $('#birthValidation').html('<span style="color:red; font-size:13px;">Invalid birth date. Cannot be in the future!</span>');
                        $(this).val(""); // Clear invalid input
                    } else {
                        $('#birthValidation').html(''); // Clear error if valid
                    }
                }
            });
        });
    </script>
    <!-- End of Birth date validation (X smaller than 1990 && Larger than today's date)-->

    <!-- Email validation (No duplicate email)-->
    <script>
        $(document).ready(function(){
            $('#email').on('keyup', function(){
                var email = $(this).val().trim(); // Trim whitespace
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Regular expression for valid email format

                if (email.length > 0) { 
                    if (!emailRegex.test(email)) { // Invalid email format
                        $('#emailValidation').html('<span style="color:red; font-size:13px;">Invalid email format! Please enter a valid email address.</span>');
                        $('button[type="submit"]').prop('disabled', true);
                    } else { // Valid email format, check if it already exists
                        $.ajax({
                            type: 'POST',
                            url: '/GlowyDaysProjectNew/CheckEmail',
                            data: { email: email },
                            success: function(response){
                                if (response.trim() === "Already Exists") {
                                    $('#emailValidation').html('<span style="color:red; font-size:13px;">This email address has already been registered. Please use another email.</span>');
                                    $('button[type="submit"]').prop('disabled', true);
                                } else {
                                    $('#emailValidation').html('<span style="color:green; font-size:13px;">Email is available!</span>');
                                    $('button[type="submit"]').prop('disabled', false);
                                }
                            },
                            error: function(){
                                $('#emailValidation').html('<span style="color:red;">Error checking email.</span>');
                                $('button[type="submit"]').prop('disabled', true);
                            }
                        });
                    }
                } else {
                    $('#emailValidation').html(''); // Clear validation message
                    $('button[type="submit"]').prop('disabled', true); // Disable submit button if input is empty
                }
            });
        });
    </script>
    <!-- End of email validation (No duplicate email)-->
    
    <!-- Mobile No validation (No duplicate mobile no)-->
    <script>
        $(document).ready(function(){
            $('#mobileNo').on('keyup', function(){
                var mobileNo = $(this).val().trim(); // Trim whitespace

                // Mobile number pattern (Malaysian format: 01x-xxxxxxx)
                var mobilePattern = /^01[0-9]-[0-9]{7,10}$/;

                if (mobileNo.length > 0) { 
                    if (!mobilePattern.test(mobileNo)) {
                        $('#phoneValidation').html('<span style="color:red; font-size:13px;">Invalid mobile number format. Use 01x-xxxxxxx.</span>');
                        $('button[type="submit"]').prop('disabled', true);
                        return;
                    }

                    // Perform AJAX request
                    $.ajax({
                        type: 'POST',
                        url: '/GlowyDaysProjectNew/CheckMobile',
                        data: { mobileNo: mobileNo },
                        success: function(response){
                            if (response.trim() === "Already Exists") {
                                $('#phoneValidation').html('<span style="color:red; font-size:13px;">Mobile Number is already taken. Please choose another.</span>');
                                $('button[type="submit"]').prop('disabled', true);
                            } else {
                                $('#phoneValidation').html('<span style="color:green; font-size:13px;">Mobile Number is available!</span>');
                                $('button[type="submit"]').prop('disabled', false);
                            }
                        },
                        error: function(){
                            $('#phoneValidation').html('<span style="color:red;">Error checking mobile number.</span>');
                            $('button[type="submit"]').prop('disabled', true);
                        }
                    });
                } else {
                    $('#phoneValidation').html(''); // Clear validation message
                    $('button[type="submit"]').prop('disabled', true);
                }
            });
        });
    </script>
    <!-- End of Mobile No validation (No duplicate mobile no)-->
    </body>
</html>
