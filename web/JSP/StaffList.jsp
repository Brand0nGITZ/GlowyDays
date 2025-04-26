<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Home</title>
    <link href="../CSS/List.css?v=2" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
    
        <%
            Long userID = (Long) session.getAttribute("userID");
            String username = (String) session.getAttribute("username");
        %>
        <%
            String driverName = "org.apache.derby.jdbc.ClientDriver";
            String connectionUrl = "jdbc:derby://localhost:1527/myderbyDB";
            String userId = "user";
            String password = "pass";

            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
                Class.forName(driverName);
                connection = DriverManager.getConnection(connectionUrl, userId, password);
                statement = connection.createStatement();
                String sql = "SELECT * FROM APP.\"USER\" WHERE \"role\" = 'staff'";
                resultSet = statement.executeQuery(sql);
        %>
        <h2 align="center"><strong>STAFF</strong></h2>
         <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Username</th>
                        <th>Birth Date</th>
                        <th>Email</th>
                        <th>Mobile No</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
            <%
                while (resultSet.next()) {
            %>
            
            <tbody>
                    <tr>
                        <td><%= resultSet.getString("user_id") %></td>
                        <td><%= resultSet.getString("name") %></td>
                        <td><%= resultSet.getString("username") %></td>
                        <td><%= resultSet.getString("birth") %></td>
                        <td><%= resultSet.getString("email") %></td>
                        <td><%= resultSet.getString("mobileNo") %></td>
                        <td><span class="role-badge"><%= resultSet.getString("role") %></span></td>
                        <td class="actions">
                            <a href="EditStaff.jsp?id=<%= resultSet.getString("user_id") %>" class="action-link edit"><i class="fas fa-pen"></i></a>
                            <a href="<%= request.getContextPath() %>/RemoveUserServlet?id=<%= resultSet.getString("user_id") %>" 
                            onclick="return confirm('Are you sure you want to delete this staff member?')" 
                            class="action-link delete">
                            <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
            <%
                }
            } catch (Exception e) {
                out.println("Database error: " + e.getMessage());
                e.printStackTrace();
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            %>
            </tbody>
            </table>
         </div>
    </body>
</html>