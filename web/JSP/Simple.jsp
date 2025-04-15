<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Simple JSP Example</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
                line-height: 1.6;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                color: #333;
            }
            .info-box {
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 5px;
                margin-top: 20px;
            }
            .note {
                font-style: italic;
                color: #777;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Simple JSP Page</h1>
            
            <div class="info-box">
                <h2>Data from Servlet</h2>
                <p><strong>Message:</strong> <%= request.getAttribute("message") %></p>
                <p><strong>Current Time:</strong> <%= request.getAttribute("currentTime") %></p>
            </div>
            
            <div class="note">
                <p>Note: This JSP is receiving data from the SimpleServlet. 
                   If you're seeing this page directly without any data displayed, make sure 
                   you're accessing it through the servlet at: 
                   <a href="${pageContext.request.contextPath}/SimpleServlet">/SimpleServlet</a>
                </p>
            </div>
        </div>
    </body>
</html>