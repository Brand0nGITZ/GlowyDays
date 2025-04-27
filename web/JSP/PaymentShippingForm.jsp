
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Payment Shipping Form</title>
    <link href="../CSS/payment.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    
    <p>User ID: <%= session.getAttribute("user_id")%></p>
    <div class="container">
        <form action="/GlowyDaysProjectNew/PaymentShippingServlet" method="post">
            <div class="row">
                <div class="column">
                    <h3 class="title">Shipping Address</h3>
                    <div class="input-box">
                        <label>Full Name</label>
                        <input type="text" name="shippingName" id="shippingName" placeholder="Enter full name" required>
                        <div id="shipNameValidation"></div>
                    </div>
                    <div class="input-box">
                        <label>Email</label>
                        <input type="email" name="shippingEmail" id="shippingEmail" placeholder="Enter email" required>
                        <div id="shipEmailValidation"></div>
                    </div>
                    <div class="input-box">
                        <label>Mobile Number</label>
                        <input type="tel" name="shippingMobile" id="shippingMobile" pattern="01[0-9]-[0-9]{7,10}" placeholder="Enter mobile number (01X-XXXXXXX)" required>
                        <div id="shipMobileValidation"></div>
                    </div>
                    <div class="input-box">
                        <label>Address</label>
                        <input type="text" name="shippingAddress" id="shippingAddress" placeholder="Enter address" required>
                        <div id="shipAddressValidation"></div>
                    </div>
                    <div class="input-box">
                        <label>City</label>
                        <input type="text" name="shippingCity" id="shippingCity" placeholder="Enter city" required>
                        <div id="shipCityValidation"></div>
                    </div>

                    <div class="flex">
                        <div class="input-box">
                            <label>State</label>
                            <select name="shippingState" id="shippingState" required>
                                <option value="">Choose state</option>
                                <option value="Johor">Johor</option>
                                <option value="Kedah">Kedah</option>
                                <option value="Kelantan">Kelantan</option>
                                <option value="KualaLumpur">Kuala Lumpur</option>
                                <option value="Labuan">Labuan</option>
                                <option value="Melaka">Melaka</option>
                                <option value="NegeriSembilan">Negeri Sembilan</option>
                                <option value="Pahang">Pahang</option>
                                <option value="Penang">Penang</option>
                                <option value="Perak">Perak</option>
                                <option value="Perlis">Perlis</option>
                                <option value="Putrajaya">Putrajaya</option>
                                <option value="Sabah">Sabah</option>
                                <option value="Sarawak">Sarawak</option>
                                <option value="Selangor">Selangor</option>
                                <option value="Terengganu">Terengganu</option>
                            </select>
                            <div id="shipStateValidation"></div>
                        </div>
                        <div class="input-box">
                            <label>Postcode</label>
                            <input type="number" name="shippingPostcode" id="shippingPostcode" maxlength="5" placeholder="Enter postcode" required> 
                            <div id="shipPostcodeValidation"></div>
                        </div>
                    </div>
                </div>

                <div class="column">
                    <h3 class="title">Payment</h3>
                    <div class="input-box">
                        <label>Payment Method</label>
                        <input type="hidden" name="payment_method" id="payment_method">
                        <div id="paymtMethodValidation"></div>
                        <div class="icon-container">
                            <button type="button" id="cashIcon" class="cashIcon" data-method="cash"><img src="../ICON/cash.svg"></button>
                            <button type="button" id="tngIcon" class="tngIcon" data-method="tng"><img src="../ICON/tng.svg"></button>
                            <button type="button" id="visaIcon" class="visaIcon" data-method="visa"><img src="../ICON/visa.svg"></button>
                            <button type="button" id="mcIcon" class="mcIcon" data-method="master"><img src="../ICON/mastercard.svg"></button>
                        </div>
                    </div>
                    
                    <div class="input-box">
                        <label>Name On Card</label>
                        <input type="text" name="cardOwner" id="cardOwner" placeholder="Enter card owner" disabled>
                        <div id="cardOwnerValidation"></div>
                    </div>
                    <div class="input-box">
                        <label>Credit Card Number</label>
                        <input type="text" name="cardNumber" id="cardNumber" maxlength="16" pattern="\d{15,16}" placeholder="Enter card number" disabled>
                        <div id="cardNumValidation"></div>
                    </div>
                    <div class="input-box">
                        <label>Exp Month</label>
                        <input type="number" name="expMonth" id="expMonth" maxlength="2" min="1" max="12" placeholder="Enter expiry month (MM)" disabled>
                        <div id="expMonthValidation"></div>
                    </div>

                    <div class="input-box">
                        <label>Exp Year </label>
                        <input type="number" name="expYear" id="expYear" maxlength="4" min="2025" max="2100" placeholder="Enter exp year (YYYY)" disabled>
                        <div id="expYearValidation"></div>
                    </div>
                    <div class="input-box">
                        <label>CVV</label>
                        <input type="number" name="cvv" id="cvv" maxlength="3" placeholder="Enter CVV with 3 digits" disabled> 
                        <div id="cvvValidation"></div>
                    </div>
                </div>
            </div>            
            <button type="submit" class="submitBtn">Pay Now</button>
        </form>
    </div>
    
    <!-- VALIDATE SHIPPING DETAIL -->
    <!-- Replace the problematic shipping validation section with this fixed code -->
    <script>
        $(document).ready(function() {
            // -------------------------------
            //    SHIPPING NAME VALIDATION
            // -------------------------------
            $('#shippingName').on('keyup', function() {
                var name = $(this).val().trim(); // Trim whitespace
                var nameRegex = /^[A-Za-z\s/]+$/; // Only letters, spaces, and '/'

                // Only check if there's input      
                if (name.length > 0) { 
                    if (!nameRegex.test(name)) {
                        $('#shipNameValidation').html('<span style="color:red; font-size:13px;">Invalid characters detected! Only alphabets, spaces, and "/" are allowed.</span>');
                        $('.submitBtn[type="submit"]').prop('disabled', true);
                    } else {
                        $.ajax({
                            type: 'POST',
                            url: '/GlowyDaysProjectNew/ValidateShippingServlet', // Calls servlet
                            data: { shippingName: name }, // Match parameter name with servlet
                            success: function (response) {
                                if (response.trim() === "Valid Name") {
                                    $('#shipNameValidation').html('<span style="color:green; font-size:13px;">Valid Name!</span>');
                                    $('.submitBtn[type="submit"]').prop('disabled', false);
                                } else {
                                    $('#shipNameValidation').html('<span style="color:red; font-size:13px;">Invalid Name.</span>');
                                    $('.submitBtn[type="submit"]').prop('disabled', true);
                                }
                            },
                            error: function () {
                                $('#shipNameValidation').html('<span style="color:red;">Error validating name.</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        });
                    }
                } else {
                    $('#shipNameValidation').html(''); // Clear validation message
                    $('.submitBtn[type="submit"]').prop('disabled', true); // Ensure form is disabled
                }
            });

            // -------------------------------
            //    SHIPPING EMAIL VALIDATION
            // -------------------------------
            $('#shippingEmail').on('keyup', function() {
                var email = $(this).val().trim(); 
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; 

                // Only check if there's input      
                if (email.length > 0) { 
                    if (!emailRegex.test(email)) {
                        $('#shipEmailValidation').html('<span style="color:red; font-size:13px;">Invalid email format! Please enter a valid email address.</span>');
                        $('.submitBtn[type="submit"]').prop('disabled', true);
                    } else {
                        $.ajax({
                            type: 'POST',
                            url: '/GlowyDaysProjectNew/ValidateShippingServlet', 
                            data: { shippingEmail: email },
                            success: function (response) {
                                if (response.trim() === "Valid Email") {
                                    $('#shipEmailValidation').html('<span style="color:green; font-size:13px;">Valid email!</span>');
                                    $('.submitBtn[type="submit"]').prop('disabled', false);
                                } else {
                                    $('#shipEmailValidation').html('<span style="color:red; font-size:13px;">Invalid email.</span>');
                                    $('.submitBtn[type="submit"]').prop('disabled', true);
                                }
                            },
                            error: function () {
                                $('#shipEmailValidation').html('<span style="color:red;">Error validating email.</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        });
                    }
                } else {
                    $('#shipEmailValidation').html('');
                    $('.submitBtn[type="submit"]').prop('disabled', true)
                }
            });

            // -------------------------------
            //   SHIPPING MOBILE VALIDATION
            // -------------------------------
            $('#shippingMobile').on('keyup', function() {
                var mobile = $(this).val().trim(); 
                var mobileRegex = /^01[0-9]-[0-9]{7,8}$/; 

                // Only check if there's input      
                if (mobile.length > 0) { 
                    if (!mobileRegex.test(mobile)) {
                        $('#shipMobileValidation').html('<span style="color:red; font-size:13px;">Invalid mobile format! Please enter a valid mobile number.</span>');
                        $('.submitBtn[type="submit"]').prop('disabled', true);
                    } else {
                        $.ajax({
                            type: 'POST',
                            url: '/GlowyDaysProjectNew/ValidateShippingServlet', 
                            data: { shippingMobile: mobile },
                            success: function (response) {
                                if (response.trim() === "Valid Mobile") {
                                    $('#shipMobileValidation').html('<span style="color:green; font-size:13px;">Valid mobile!</span>');
                                    $('.submitBtn[type="submit"]').prop('disabled', false);
                                } else {
                                    $('#shipMobileValidation').html('<span style="color:red; font-size:13px;">Invalid mobile.</span>');
                                    $('.submitBtn[type="submit"]').prop('disabled', true);
                                }
                            },
                            error: function () {
                                $('#shipMobileValidation').html('<span style="color:red;">Error validating mobile.</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        });
                    }
                } else {
                    $('#shipMobileValidation').html('');
                    $('.submitBtn[type="submit"]').prop('disabled', true); 
                }
            });

            // -------------------------------
            //   SHIPPING ADDRESS VALIDATION
            // -------------------------------
            $('#shippingAddress').on('keyup', function() {
                var address = $(this).val().trim();

                // Only check if there's input 
                if (address.length > 0) {
                    $.ajax({
                        type: 'POST',
                        url: '/GlowyDaysProjectNew/ValidateShippingServlet', 
                        data: { shippingAddress: address }, 
                        success: function(response) {
                            if (response.trim() === "Valid Address") {
                                $('#shipAddressValidation').html('<span style="color:green; font-size:13px;">Valid Address!</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', false);
                            } else {
                                $('#shipAddressValidation').html('<span style="color:red; font-size:13px;">Please enter your address.</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        },
                        error: function() {
                            $('#shipAddressValidation').html('<span style="color:red;">Error validating address.</span>');
                            $('.submitBtn[type="submit"]').prop('disabled', true);
                        }
                    });
                } else {
                    $('#shipAddressValidation').html(''); // Clear validation message
                    $('.submitBtn[type="submit"]').prop('disabled', true); // Disable submit button if input is empty
                }
            });

            // -------------------------------
            //     SHIPPING CITY VALIDATION
            // -------------------------------
            $('#shippingCity').on('keyup', function() {
                var city = $(this).val().trim();
                if (city.length > 0) {
                    $.ajax({
                        type: 'POST',
                        url: '/GlowyDaysProjectNew/ValidateShippingServlet',
                        data: { shippingCity: city }, // Match parameter name with servlet
                        success: function(response) {
                            if (response.trim() === "Valid City") {
                                $('#shipCityValidation').html('<span style="color:green; font-size:13px;">Valid City!</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', false);
                            } else {
                                $('#shipCityValidation').html('<span style="color:red; font-size:13px;">Please enter your city.</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        },
                        error: function() {
                            $('#shipCityValidation').html('<span style="color:red;">Error validating city.</span>');
                            $('.submitBtn[type="submit"]').prop('disabled', true);
                        }
                    });
                } else {
                    $('#shipCityValidation').html('');
                    $('.submitBtn[type="submit"]').prop('disabled', true);
                }
            });

            // -------------------------------
            //    SHIPPING STATE VALIDATION
            // -------------------------------
            $('#shippingState').on('change', function() {
                var state = $(this).val();

                if (state.length > 0) {
                    $.ajax({
                        type: 'POST',
                        url: '/GlowyDaysProjectNew/ValidateShippingServlet',
                        data: { shippingState: state },
                        success: function(response) {
                            if (response.trim() === "Valid State") {
                                $('#shipStateValidation').html('<span style="color:green; font-size:13px;">Valid State!</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', false);
                            } else {
                                $('#shipStateValidation').html('<span style="color:red; font-size:13px;">Please select a state.</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        },
                        error: function() {
                            $('#shipStateValidation').html('<span style="color:red;">Error validating state.</span>');
                            $('.submitBtn[type="submit"]').prop('disabled', true);
                        }
                    });
                } else {
                    $('#shipStateValidation').html('<span style="color:red; font-size:13px;">Please select your state.</span>');
                    $('.submitBtn[type="submit"]').prop('disabled', true);
                }
            });

            // -------------------------------
            //  SHIPPING POSTCODE VALIDATION
            // -------------------------------
            $('#shippingPostcode').on('keyup', function() {
                var postcode = $(this).val().trim();
                var postcodeRegex = /^\d{5}$/;

                if (postcode.length > 0) {
                    if (postcodeRegex.test(postcode)) {  
                        $.ajax({
                            type: 'POST',
                            url: '/GlowyDaysProjectNew/ValidateShippingServlet',
                            data: { shippingPostcode: postcode },
                            success: function(response) {
                                if (response.trim() === "Valid Postcode") {
                                    $('#shipPostcodeValidation').html('<span style="color:green; font-size:13px;">Valid Postcode!</span>');
                                    $('.submitBtn[type="submit"]').prop('disabled', false);
                                } else {
                                    $('#shipPostcodeValidation').html('<span style="color:red; font-size:13px;">Postcode not recognized.</span>');
                                    $('.submitBtn[type="submit"]').prop('disabled', true);
                                }
                            },
                            error: function() {
                                $('#shipPostcodeValidation').html('<span style="color:red;">Server error. Try again.</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        });
                    } else {
                        $('#shipPostcodeValidation').html('<span style="color:red; font-size:13px;">Postcode must be 5 digits (e.g., 12345).</span>');
                        $('.submitBtn[type="submit"]').prop('disabled', true);
                    }
                } else {
                    $('#shipPostcodeValidation').html('');
                    $('.submitBtn[type="submit"]').prop('disabled', true);
                }
            });
        });
    </script>

    <!-- Payment Validation -->
    <script>
        $(document).ready(function() {
            // Initialize submit button as disabled
            $('.submitBtn').prop('disabled', true);

            // -------------------------------
            //    PAYMENT METHOD VALIDATION
            // -------------------------------
            $('.icon-container button').on('click', function() {
                var method = $(this).data('method');
                $('#payment_method').val(method);

                // Reset all icons
                $('.icon-container button').removeClass('active');
                $(this).addClass('active');

                // Show selection message 
                $('#paymtMethodValidation').html('<span style="color:green; font-size:13px;">Selected: ' + method.toUpperCase() + '</span>');

                // Toggle card fields
                if (method === 'visa' || method === 'master') {
                    $('#cardOwner, #cardNumber, #expMonth, #expYear, #cvv').prop('disabled', false).prop('required', true);
                } else {
                    $('#cardOwner, #cardNumber, #expMonth, #expYear, #cvv').prop('disabled', true).val('').prop('required', false);
                    $('#cardOwnerValidation, #cardNumValidation, #expMonthValidation, #expYearValidation, #cvvValidation').html('');
                }

                // Call servlet to validate payment method
                validatePaymentMethod(method);
            });

            function validatePaymentMethod(method) {
                if (!method) {
                    $('#paymtMethodValidation').html('<span style="color:red; font-size:13px;">Please select payment method</span>');
                    $('.submitBtn[type="submit"]').prop('disabled', true);
                    return;
                }

                $.ajax({
                    type: 'POST',
                    url: '/GlowyDaysProjectNew/ValidatePaymentServlet',
                    data: { payment_method: method },
                    success: function(response) {
                        if (response.trim() === "Valid Payment Method") {
                            $('#paymtMethodValidation').html('<span style="color:green; font-size:13px;">Valid payment method selected</span>');
                            validateAllFields();
                        } else {
                            $('#paymtMethodValidation').html('<span style="color:red; font-size:13px;">' + response + '</span>');
                            $('.submitBtn[type="submit"]').prop('disabled', true);
                        }
                    },
                    error: function() {
                        $('#paymtMethodValidation').html('<span style="color:red;">Please select your payment method.</span>');
                        $('.submitBtn[type="submit"]').prop('disabled', true);
                    }
                });
            }

            // -------------------------------
            //    CARD OWNER VALIDATION
            // -------------------------------
            $('#cardOwner').on('keyup', function() {
                var owner = $(this).val().trim();
                var ownerRegex = /^[A-Za-z\s/]+$/; 

                if (owner.length > 0) {
                    if (!ownerRegex.test(owner)) {
                        $('#cardOwnerValidation').html('<span style="color:red; font-size:13px;">Invalid characters! Only letters and spaces allowed.</span>');
                        $('.submitBtn[type="submit"]').prop('disabled', true);
                    } else {
                        $.ajax({
                            type: 'POST',
                            url: '/GlowyDaysProjectNew/ValidatePaymentServlet',
                            data: { cardOwner: owner },
                            success: function(response) {
                                if (response.trim() === "Valid Card Owner") {
                                    $('#cardOwnerValidation').html('<span style="color:green; font-size:13px;">Valid name</span>');
                                    validateAllFields();
                                } else {
                                    $('#cardOwnerValidation').html('<span style="color:red; font-size:13px;">' + response + '</span>');
                                    $('.submitBtn[type="submit"]').prop('disabled', true);
                                }
                            },
                            error: function() {
                                $('#cardOwnerValidation').html('<span style="color:red;">Error validating name</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        });
                    }
                } else {
                    $('#cardOwnerValidation').html('');
                    $('.submitBtn[type="submit"]').prop('disabled', true);
                }
            });

            // -------------------------------
            //    CARD NUMBER VALIDATION
            // -------------------------------
            $('#cardNumber').on('keyup', function() {
                var cardNumber = $(this).val().trim();

                if (cardNumber.length > 0) {
                    $.ajax({
                        type: 'POST',
                        url: '/GlowyDaysProjectNew/ValidatePaymentServlet',
                        data: { cardNumber: cardNumber },
                        success: function(response) {
                            if (response.trim() === "Valid Card Number") {
                                $('#cardNumValidation').html('<span style="color:green; font-size:13px;">Valid card number</span>');
                                validateAllFields();
                            } else {
                                $('#cardNumValidation').html('<span style="color:red; font-size:13px;">' + response + '</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        },
                        error: function() {
                            $('#cardNumValidation').html('<span style="color:red;">Error validating card</span>');
                            $('.submitBtn[type="submit"]').prop('disabled', true);
                        }
                    });
                } else {
                    $('#cardNumValidation').html('');
                    $('.submitBtn[type="submit"]').prop('disabled', true);
                }
            });

            // -------------------------------
            //    EXPIRY MONTH VALIDATION
            // -------------------------------
            $('#expMonth').on('keyup', function() {
                var month = $(this).val();

                if (month.length > 0) {
                    $.ajax({
                        type: 'POST',
                        url: '/GlowyDaysProjectNew/ValidatePaymentServlet',
                        data: { expMonth: month },
                        success: function(response) {
                            if (response.trim() === "Valid Expiry Month") {
                                $('#expMonthValidation').html('<span style="color:green; font-size:13px;">Valid month</span>');
                                validateAllFields();
                            } else {
                                $('#expMonthValidation').html('<span style="color:red; font-size:13px;">' + response + '</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        },
                        error: function() {
                            $('#expMonthValidation').html('<span style="color:red;">Error validating month</span>');
                            $('.submitBtn[type="submit"]').prop('disabled', true);
                        }
                    });
                } else {
                    $('#expMonthValidation').html('');
                    $('.submitBtn[type="submit"]').prop('disabled', true);
                }
            });

            // -------------------------------
            //      EXPIRY YEAR VALIDATION
            // -------------------------------
            $('#expYear').on('keyup', function() {
                var year = $(this).val();

                if (year.length > 0) {
                    $.ajax({
                        type: 'POST',
                        url: '/GlowyDaysProjectNew/ValidatePaymentServlet',
                        data: { expYear: year },
                        success: function(response) {
                            if (response.trim() === "Valid Expiry Year") {
                                $('#expYearValidation').html('<span style="color:green; font-size:13px;">Valid year</span>');
                                validateAllFields();
                            } else {
                                $('#expYearValidation').html('<span style="color:red; font-size:13px;">' + response + '</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        },
                        error: function() {
                            $('#expYearValidation').html('<span style="color:red;">Error validating year</span>');
                            $('.submitBtn[type="submit"]').prop('disabled', true);
                        }
                    });
                } else {
                    $('#expYearValidation').html('');
                    $('.submitBtn[type="submit"]').prop('disabled', true);
                }
            });

            // -------------------------------
            //         CVV VALIDATION
            // -------------------------------
            $('#cvv').on('keyup', function() {
                var cvv = $(this).val();

                if (cvv.length > 0) {
                    $.ajax({
                        type: 'POST',
                        url: '/GlowyDaysProjectNew/ValidatePaymentServlet',
                        data: { cvv: cvv },
                        success: function(response) {
                            if (response.trim() === "Valid CVV") {
                                $('#cvvValidation').html('<span style="color:green; font-size:13px;">Valid CVV</span>');
                                validateAllFields();
                            } else {
                                $('#cvvValidation').html('<span style="color:red; font-size:13px;">' + response + '</span>');
                                $('.submitBtn[type="submit"]').prop('disabled', true);
                            }
                        },
                        error: function() {
                            $('#cvvValidation').html('<span style="color:red;">Error validating CVV</span>');
                            $('.submitBtn[type="submit"]').prop('disabled', true);
                        }
                    });
                } else {
                    $('#cvvValidation').html('');
                    $('.submitBtn[type="submit"]').prop('disabled', true);
                }
            });

            // Validate all fields before enabling submit
            function validateAllFields() {
                var method = $('#payment_method').val();

                // Payment method must be selected
                if (!method) {
                    $('.submitBtn[type="submit"]').prop('disabled', true);
                    return;
                }

                // For cash/tng, check shipping fields validation 
                if (method === 'cash' || method === 'tng') {
                    var shippingValid = 
                        isFieldValid('shipNameValidation') &&
                        isFieldValid('shipEmailValidation') &&
                        isFieldValid('shipMobileValidation') &&
                        isFieldValid('shipAddressValidation') &&
                        isFieldValid('shipCityValidation') &&
                        isFieldValid('shipStateValidation') &&
                        isFieldValid('shipPostcodeValidation');

                    $('.submitBtn[type="submit"]').prop('disabled', !shippingValid);
                    return;
                }

                // For visa/master, check all fields
                var allValid = 
                    isFieldValid('shipNameValidation') &&
                    isFieldValid('shipEmailValidation') &&
                    isFieldValid('shipMobileValidation') &&
                    isFieldValid('shipAddressValidation') &&
                    isFieldValid('shipCityValidation') &&
                    isFieldValid('shipStateValidation') &&
                    isFieldValid('shipPostcodeValidation') &&
                    isFieldValid('cardOwnerValidation') &&
                    isFieldValid('cardNumValidation') &&
                    isFieldValid('expMonthValidation') &&
                    isFieldValid('expYearValidation') &&
                    isFieldValid('cvvValidation');

                $('.submitBtn[type="submit"]').prop('disabled', !allValid);
            }

            // Helper function to check if a validation field is valid
            function isFieldValid(fieldId) {
                var field = $('#' + fieldId + ' span');
                if (field.length === 0) return false;
                return field.css('color') === 'rgb(0, 128, 0)'; // Check if the span is green
            }
        });
    </script>
    
    <!-- Payment Method Selection & Card Input -->
    <script>
        document.addEventListener('DOMContentLoaded', function(){
            const paymentMethodInput = document.getElementById("payment_method");
            const cardInputs = [
                document.getElementById("cardOwner"),
                document.getElementById("cardNumber"),
                document.getElementById("expYear"),
                document.getElementById("cvv"),
                document.getElementById("expMonth")
            ];
            
            const paymentButtons = {
                cash: document.getElementById("cashIcon"),
                tng: document.getElementById("tngIcon"),
                visa: document.getElementById("visaIcon"),
                master: document.getElementById("mcIcon")
            };

            // Highlight selected button and remove highlight from others
            function highlightSelected(selectedBtn) {
                Object.values(paymentButtons).forEach(btn => btn.classList.remove("selected"));
                selectedBtn.classList.add("selected");
            }
            
            // Enable/disable card inputs & manage required attribute
            function setPaymentMethod(method) {
                paymentMethodInput.value = method;
                const enable = method === "visa" || method === "master";
                
                // Loop 
                cardInputs.forEach(input => {
                    input.disabled = !enable; // Enable/disable the field
                    input.style.backgroundColor = enable ? "white" : "#f0f0f0"; // Set background color
                    if (!enable) input.value = ""; // Clear if disable
                    input.required = enable; // Toggle required attribute
                });
            }

            // Add click event to each payment method button
            Object.entries(paymentButtons).forEach(([method, btn]) => {
                btn.addEventListener("click", () => {
                    setPaymentMethod(method);      // Enable/disable fields based on method
                    highlightSelected(btn);        // Visually indicate selected meth
                });
            });
        });
    </script>
</body>
</html>
