<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ReportGen"%>
<%@ page import="jakarta.servlet.*" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report Gen</title>
        <link rel="stylesheet" href="../CSS/ReportGenCSS.css?v=3"/>
        <link rel="stylesheet" href="CSS/ReportGenCSS.css?v=3"/>
    </head>
    <body>

        <form method="get" action="/GlowyDaysProjectNew/ReportGenServlet">
            <label for="filterType">Filter By:</label>
            <select name="filterType" id="filterType">
                <option value="all">All</option>
                <option value="daily">Daily</option>
                <option value="monthly">Monthly</option>
                <option value="yearly">Yearly</option>
            </select>

            <label for="filterDate">Date:</label>
            <input type="date" name="filterDate" id="filterDate">

            <button type="submit">Search</button>
        </form>
        <%
            List<ReportGen> reportList = (List<ReportGen>) request.getAttribute("reportList");
        %>
        <h1>Product Sales Report</h1>

        <% if (reportList != null && !reportList.isEmpty()) { %>
        <table>
            <tr>
                <th>No</th>
                <th>Photo</th>
                <th>Item Name</th>
                <th>Quantity Sold</th>
            </tr>
            <%
                int no = 1;
                for (ReportGen item : reportList) {
            %>
            <tr>
                <td><%= no++%></td>
                <td><img src="<%= item.getImageUrl()%>" alt="Product Image" style="max-width:60px;"></td>
                <td><%= item.getProductName()%></td>
                <td><%= item.getQuantitySold()%></td>
            </tr>
            <% } %>
        </table>
        <% } else { %>
        <p>No data available or failed to load the report.</p>
        <% }%>
    </body>
</html>