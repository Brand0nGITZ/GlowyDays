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
    <title>Register</title>
    <link href="../CSS/register.css?v=2" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* Inline styles to ensure spacing works */
        .container {
            width: 100%;
            max-width: 1000px;
            margin: 2rem auto;
            background-color: white;
            border-radius: 1rem;
            box-shadow: 0 1rem 3rem rgba(0, 0, 0, 0.1);
            padding: 4rem;
        }
        
        .form-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 3.5rem;
        }
        
        .form-group {
            width: 45%; /* This creates space between the fields */
        }
        
        .form-group label {
            display: block;
            font-size: 1.6rem;
            color: #333;
            font-weight: 600;
            margin-bottom: 1.2rem;
        }
        
        .form-group input {
            width: 100%;
            padding: 1.2rem 1.5rem;
            border: 1px solid #ddd;
            border-radius: 0.5rem;
            font-size: 1.6rem;
        }
        
        .footer {
            margin-top: auto;
            width: 100%;
            clear: both;
        }
        
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
    </style>
</head>
<body>
    <section id="header" class="header">   
             <a href="GuestHome.jsp"><h2 style="font-weight: bolder; font-size: 3rem; color: black;">GLOWY DAYS</h2></a>
               <div class="navbar">
                    <a href="">Home</a>
                    <a href="#">Product</a> 
                    <a href="">About Us</a>               
                    <a href="">Contact Us</a>                             
               </div>
               <div class="icons">
                    <div class="search-wrapper">
                        <i class="fa-solid fa-magnifying-glass" id="search-icon"></i>
                        <input type="text" id="search-box" placeholder="Search..." />
                    </div>
                    <a href="" class="fa-solid fa-cart-shopping"></a>    
                    <a href="UserRegister.jsp" class="fa-regular fa-user"></a>
               </div>
        </section>
    
    <div class="wrap">
        <h1>Sign Up</h1>
        <p class="subtitle">Please fill in the fields below</p>
        
        <form action="<%= request.getContextPath() %>/UserRegistrationAdmin" method="post" class="registration-form">
 
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Full Name:</label>
                        <input type="text" id="name" name="name" placeholder="Full Name" required>
                        <div id="nameValidation" class="validation-message"></div>
                    </div>
                
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" id="username" name="username" placeholder="Username" required>
                        <span class="red-text accent-4 validation-message" id="usernameValidation"></span>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="birth">Birth date:</label>
                        <input type="date" id="birth" name="birth" class="custom-date" required>
                        <span id="birthValidation" class="validation-message"></span>
                    </div>
  
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" placeholder="Email" required>
                        <div id="emailValidation" class="validation-message"></div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="mobileNo">Mobile Number:</label>
                        <input type="tel" id="mobileNo" name="mobileNo" pattern="01[0-9]-[0-9]{7,10}" placeholder="Mobile Number (01x-xxxxxxx)" required>
                        <span class="red-text accent-4 validation-message" id="phoneValidation"></span>
                    </div>
                
                    <div class="form-group">
                        <label for="passwordInput">Password:</label>
                        <input type="password" id="passwordInput" name="password" placeholder="Password" 
                                pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                        <div id="passwordMessage" style="display: none;" class="password-requirements">
                            <h3>Password must contain the following:</h3>
                            <p id="letter" class="invalid">&#10006; A <b>lowercase</b> letter</p>
                            <p id="capital" class="invalid">&#10006; A <b>capital (uppercase)</b> letter</p>
                            <p id="number" class="invalid">&#10006; A <b>number</b></p>
                            <p id="length" class="invalid">&#10006; Minimum <b>8 characters</b></p>
                        </div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="CpasswordInput">Confirm Password:</label>
                        <input type="password" id="CpasswordInput" name="Cpassword" placeholder="Confirm Password" 
                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                        <div id="CpasswordMessage" style="display: none;" class="validation-message">
                            <span class="CpasswordMessage"></span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <!-- Empty div to maintain layout -->
                    </div>
                </div>
                
                <div class="login-link">
                    <p>Already have an account? <a href="../JSP/Login.jsp">Login Now</a></p>
                </div>
                
                <div class="button-container">
                    <button type="reset" class="reset-btn">Reset</button>
                    <button type="submit" class="register-btn">Register</button>
                </div>
        </form>
    </div>
    
    
    
    <script src="../JavaScript/main.js"></script>
    
    <!-- Double Confirm-->
    <script>
        $(document).ready(function(){
            // Attach a click event to the Register button
            $('button[type="submit"]').on('click', function(event){
                // Prevent the form from submitting immediately
                event.preventDefault();

                // Check if all fields are valid before proceeding
                var isValid = true;
                // Check the validation status of each field
                if ($('#nameValidation span').css('color') === 'rgb(255, 0, 0)' || 
                    $('#usernameValidation span').css('color') === 'rgb(255, 0, 0)' ||
                    $('#birthValidation span').css('color') === 'rgb(255, 0, 0)' ||
                    $('#emailValidation span').css('color') === 'rgb(255, 0, 0)' ||
                    $('#phoneValidation span').css('color') === 'rgb(255, 0, 0)' ||
                    $('#passwordMessage span').css('color') === 'rgb(255, 0, 0)' ||
                    $('#CpasswordMessage span').css('color') === 'rgb(255, 0, 0)') {
                    isValid = false; // If any field has a red error message, set isValid to false
                }

                if (isValid) {
                    // Show confirmation popup if all fields are valid
                    var isConfirmed = confirm("Are you sure all the details are correct?");

                    // If the user confirms, submit the form
                    if (isConfirmed) {
                        $('form').submit();
                    }
                } else {
                    // If any field is invalid, prevent form submission
                    alert("Please fix the errors before submitting.");
                }
            });
        });
    </script>
    <!-- End of Double Confirm-->

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
    
    <!-- Password validation (Meet with requirement)-->
    <script>
        $(document).ready(function(){
            $('#passwordInput').on('keyup', function(){
                var password = $(this).val();

                var hasLowerCase = /[a-z]/.test(password);
                var hasUpperCase = /[A-Z]/.test(password);
                var hasNumber = /[0-9]/.test(password);
                var hasMinLength = password.length >= 8;

                function updateValidation(element, isValid) {
                    if (isValid) {
                        $(element).removeClass("invalid").addClass("valid").text("\u2714 " + $(element).text().substring(2));
                    } else {
                        $(element).removeClass("valid").addClass("invalid").text("\u2716 " + $(element).text().substring(2));
                    }
                }

                updateValidation('#letter', hasLowerCase);
                updateValidation('#capital', hasUpperCase);
                updateValidation('#number', hasNumber);
                updateValidation('#length', hasMinLength);

                // Check server-side validation only if all conditions pass
                if (hasLowerCase && hasUpperCase && hasNumber && hasMinLength) {
                    $.ajax({
                        type: 'POST',
                        url: '/GlowyDaysProjectNew/CheckPassword',
                        data: { password: password },
                        success: function(response){
                            $('#passwordMessage span').remove(); // Remove previous messages
                            if (response.trim() !== "Valid") {
                                $('#passwordMessage').append('<span style="color:red;">✖ ' + response + '</span>');
                            }
                        },
                        error: function(){
                            $('#passwordMessage span').remove();
                            $('#passwordMessage').append('<span style="color:red;">Error validating password.</span>');
                        }
                    });
                }
            });

            // Show message box when focused
            $('#passwordInput').focus(function() {
                $('#passwordMessage').show();
            });

            // Hide message box when input is empty
            $('#passwordInput').blur(function() {
                if ($('#passwordInput').val() === '') {
                    $('#passwordMessage').hide();
                }
            });
        });
    </script>
    <!-- End of Password validation (Meet with requirement)-->

    <!-- Confirm Password validation (Must same with Password text field)-->
    <script>
        $(document).ready(function(){
            function validatePassword() {
                var password = $('#passwordInput').val();
                var confirmPassword = $('#CpasswordInput').val();

                // Password requirements check
                var hasLowerCase = /[a-z]/.test(password);
                var hasUpperCase = /[A-Z]/.test(password);
                var hasNumber = /[0-9]/.test(password);
                var hasMinLength = password.length >= 8;

                var isPasswordValid = hasLowerCase && hasUpperCase && hasNumber && hasMinLength;

                if (confirmPassword.length > 0) { 
                    $('#CpasswordMessage').show();

                    if (!isPasswordValid) {
                        $('#CpasswordMessage').html('<span style="color:red; font-size:13px;">Please enter a valid password that meets all requirements first!</span>');
                        $('button[type="submit"]').prop('disabled', true);
                    } else if (confirmPassword !== password) {
                        $('#CpasswordMessage').html('<span style="color:red; font-size:13px;">Please reenter the same password to confirm!</span>');
                        $('button[type="submit"]').prop('disabled', true);
                    } else {
                        $('#CpasswordMessage').html('<span style="color:green; font-size:13px;">Passwords match.</span>');
                        $('button[type="submit"]').prop('disabled', false);
                    }
                } else {
                    $('#CpasswordMessage').hide();
                }
            }

            $('#passwordInput, #CpasswordInput').on('keyup', validatePassword);
        });
    </script>
    <!-- End of Confirm Password validation (Must same with Password text field)-->
    
</body>
</html>