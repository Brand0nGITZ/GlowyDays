<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="../CSS/NewPassword.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
    <div class="back-button">
        <a href="Login.jsp"><i class="fas fa-arrow-left"></i> Back</a>
    </div>

    <div class="password-container">
        <div class="password-card">
            <h1 class="password-title">Reset Password</h1>
            <div class="underline"></div>
            
            <p class="password-subtitle">Please fill in the fields below</p>
            
            <form action="<%= request.getContextPath() %>/NewPassword" method="post" class="password-form">
                <div class="form-row">
                    <div class="form-group">
                        <label for="passwordInput">Password:</label>
                        <input type="password" id="passwordInput" name="password" placeholder="Enter new password" 
                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                        <div id="passwordMessage" style="display: none;" class="password-requirements">
                            <h3>Password must contain the following:</h3>
                            <p id="letter" class="invalid">&#10006; A <b>lowercase</b> letter</p>
                            <p id="capital" class="invalid">&#10006; A <b>capital (uppercase)</b> letter</p>
                            <p id="number" class="invalid">&#10006; A <b>number</b></p>
                            <p id="length" class="invalid">&#10006; Minimum <b>8 characters</b></p>
                        </div>
                    </div>
                
                    <div class="form-group">
                        <label for="CpasswordInput">Confirm Password:</label>
                        <input type="password" id="CpasswordInput" name="Cpassword" placeholder="Confirm new password" 
                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                        <div id="CpasswordMessage" style="display: none;" class="validation-message">
                            <span class="CpasswordMessage"></span>
                        </div>
                    </div>
                </div>
                
                <button type="submit" class="submit-btn">Update Password</button>
            </form>
        </div>
    </div>
    
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