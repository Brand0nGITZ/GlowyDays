<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.User" %>
<jsp:useBean id="user" class="model.User" scope="session" />
<jsp:setProperty name="user" property="name" param="name" />
<jsp:setProperty name="user" property="username" param="username" />
<jsp:setProperty name="user" property="birth" param="birth" />
<jsp:setProperty name="user" property="email" param="email" />
<jsp:setProperty name="user" property="mobileNo" param="mobileNo" />
<jsp:setProperty name="user" property="password" param="password" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link href="../CSS/register.css?v=2" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <a href="AdminPanel.jsp" class="back-button">
        <i class="fas fa-arrow-left"></i> Back
    </a>
    
    <div class="wrap">
        <h1>Sign Up</h1>
        <p class="subtitle">Please fill in the fields below</p>
        
        <form action="<%= request.getContextPath() %>/StaffRegistration" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                    <div id="nameValidation" class="validation-message"></div>
                </div>
                
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Choose a username" required>
                    <div id="usernameValidation" class="validation-message"></div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                    <div id="emailValidation" class="validation-message"></div>
                </div>
                
                <div class="form-group">
                    <label for="mobileNo">Mobile Number</label>
                    <input type="tel" id="mobileNo" name="mobileNo" pattern="01[0-9]-[0-9]{7,10}" placeholder="Format: 01x-xxxxxxx" required>
                    <div id="phoneValidation" class="validation-message"></div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="birth">Birth Date</label>
                    <input type="date" id="birth" name="birth" class="custom-date" required>
                    <div id="birthValidation" class="validation-message"></div>
                </div>
                
                <div class="form-group">
                    <!-- Empty div to maintain layout -->
                </div>
            </div>
            
            <input type="hidden" id="passwordInput" name="password" value="Admin123">
            
            <div class="login-link">
                Already have an account? <a href="../JSP/Login.jsp">Login Now</a>
            </div>
            
            <div class="button-container">
                <button type="reset" class="reset-btn">Reset</button>
                <button type="submit" class="register-btn">Register</button>
            </div>
        </form>
    </div>
    
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
</body>
</html>