<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="model.User" %>
<%@page import="dao.UserDAO" %>
<%@page import="java.time.LocalDate" %>
<%@page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit User</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="../CSS/Edit.css?v=2" rel="stylesheet" type="text/css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
<body>
<%
    String driverName = "org.apache.derby.jdbc.ClientDriver";
    String connectionUrl = "jdbc:derby://localhost:1527/myderbyDB";
    String dbUser = "user";
    String dbPassword = "pass";
    
    Connection connection = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    
    String message = "";
    
    // If form submitted (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String birth = request.getParameter("birth");
            String email = request.getParameter("email");
            String mobileNo = request.getParameter("mobileNo");
            String password = request.getParameter("password");

            Class.forName(driverName);
            connection = DriverManager.getConnection(connectionUrl, dbUser, dbPassword);
            
            String sql = "UPDATE APP.\"USER\" SET \"name\"=?, \"username\"=?, \"birth\"=?, \"email\"=?, \"mobileNo\"=?, \"password\"=? WHERE \"user_id\"=?";
            pst = connection.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, username);
            pst.setDate(3, java.sql.Date.valueOf(birth));
            pst.setString(4, email);
            pst.setString(5, mobileNo);
            pst.setString(6, password);
            pst.setLong(7, id);

            int updated = pst.executeUpdate();
            if (updated > 0) {
                message = "✅ Staff updated successfully!";
            } else {
                message = "⚠️ Failed to update staff!";
            }

        } catch (Exception e) {
            message = "❌ Error: " + e.getMessage();
            e.printStackTrace();
        } finally {
            if (pst != null) pst.close();
            if (connection != null) connection.close();
        }
    }

    // Retrieve staff to edit (GET)
    Long userId = null;
    User user = null;

    try {
        if (request.getParameter("id") != null) {
            userId = Long.parseLong(request.getParameter("id"));
            
            Class.forName(driverName);
            connection = DriverManager.getConnection(connectionUrl, dbUser, dbPassword);
            String sql = "SELECT * FROM APP.\"USER\" WHERE \"user_id\"=?";
            pst = connection.prepareStatement(sql);
            pst.setLong(1, userId);
            rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getLong("user_id"));
                user.setName(rs.getString("name"));
                user.setUsername(rs.getString("username"));
                user.setBirth(rs.getDate("birth").toLocalDate());
                user.setEmail(rs.getString("email"));
                user.setMobileNo(rs.getString("mobileNo"));
                user.setPassword(rs.getString("password"));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (connection != null) connection.close();
    }
%>
                    
        <div id="details">
            <br />
            <div class="wrap">
                
            <a href="AdminPanel.jsp" class="back-button">
                <i class="fas fa-arrow-left"></i> Back
            </a>
                
            <h1>Edit Staff</h1>
                <% if (!message.isEmpty()) { %>
                    <p style="color: green;"><%= message %></p>
                <% } %>

                <% if (user != null) { %>   
                <div>
                    
                <form action="<%= request.getContextPath() %>/UpdateStaffServlet" method="post">
                    <input type="hidden" name="id" value="<%= user.getId() %>" />

                    <div class="form-row">
                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" id="name" name="name" value="<%= user.getName() %>" required>
                            <div id="nameValidation" style="margin-top: 7px;"></div>
                        </div>

                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" value="<%= user.getUsername() %>" required>
                            <span class="red-text accent-4" id="usernameValidation" style="margin-top: 7px;"></span>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
                            <div id="emailValidation" style="margin-top: 7px;"></div>
                        </div>

                        <div class="form-group">
                            <label for="mobileNo">Phone Number</label>
                            <input type="tel" id="mobileNo" name="mobileNo" value="<%= user.getMobileNo() %>" required>
                            <span class="red-text accent-4" id="phoneValidation" style="margin-top: 7px;"></span>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="passwordInput">Password (Leave blank to keep current)</label>
                            <input 
                                type="password" 
                                id="passwordInput" 
                                name="password" 
                                value="" 
                                placeholder="Enter new password only if you want to change"
                                pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" 
                                onkeyup="checkPasswordInput()"
                            />

                            <div id="passwordMessage" style="display: none;">
                                <h3 style="font-size: 15px;">Password must contain the following:</h3>
                                <p id="letter" class="invalid" style="font-size: 13px;">&#10006; A <b>lowercase</b> letter</p>
                                <p id="capital" class="invalid" style="font-size: 13px;">&#10006; A <b>capital (uppercase)</b> letter</p>
                                <p id="number" class="invalid" style="font-size: 13px;">&#10006; A <b>number</b></p>
                                <p id="length" class="invalid" style="font-size: 13px;">&#10006; Minimum <b>8 characters</b></p>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="birth">Birth Date</label>
                            <input type="date" id="birth" name="birth" class="custom-date" value="<%= user.getBirth() %>" required>
                            <span id="birthValidation" style="margin-top: 7px;"></span>
                        </div>
                    </div>               

                    <button type="submit" class="register-btn" style="border-radius:10px;">Update Staff</button>
                </form>
        </div>
                </div>
        </div>
    <% } else { %>
        <p style="color: red;">⚠️ Staff not found.</p>
    <% } %>
    
    <script>
    $(document).ready(function () {
        // 标记是否需要回填原始密码
        var isPasswordEmpty = false;

        // 监听输入框的变化，检查是否为空
        $('#passwordInput').on('input', function() {
            // 只在输入框为空时设置标志
            if ($(this).val() === "") {
                isPasswordEmpty = true;
            } else {
                isPasswordEmpty = false;
            }
        });

        // 在提交表单时检查密码是否为空
        $('form').on('submit', function(e) {
            var password = $('#passwordInput').val(); // 获取当前密码输入框的值

            // 只有当密码为空并且输入框已经清空时，才回填原始密码
            if (isPasswordEmpty) {
                e.preventDefault(); // 阻止表单立即提交
                $('#passwordInput').val($('#originalPassword').val()); // 设置密码框的值为原始密码
                this.submit(); // 现在手动提交表单
            }
        });
    });
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

    <!-- Password validation (Meet with requirement)-->
    <script>
        function checkPasswordInput() {
            var passwordInput = document.getElementById("passwordInput");
            var originalPassword = document.getElementById("originalPassword").value;

            // If the password input is empty, keep the original password in the hidden input
            if (passwordInput.value.trim() === "") {
                passwordInput.value = originalPassword; // Ensure the hidden field value remains the original password
            }
        }
        
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
</body>
</html>