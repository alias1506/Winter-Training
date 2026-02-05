<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Guest List</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .icon-btn {
            background: none;
            border: none;
            padding: 4px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: transform 0.15s ease, color 0.15s ease;
        }
        .icon-btn:disabled {
            color: #aaa;
            cursor: not-allowed;
        }
        .icon-btn:not(:disabled):hover {
            transform: scale(1.15);
            font-weight: bold;
        }
        .icon-checkin { color: #198754; }
        .icon-checkout { color: #dc3545; }
        .icon-delete { color: #6c757d; }
        .icon-delete:hover { color: #dc3545; }
    </style>
</head>

<body class="bg-light">

<div class="container mt-5">
<div class="card shadow-sm">
<div class="card-body">

<!-- HEADER -->
<div class="d-flex justify-content-between align-items-center mb-3">
    <h4 class="mb-0">Guest List</h4>
    <div>
        <a href="guest_table.jsp" class="btn btn-outline-secondary me-2">
            <i class="bi bi-arrow-clockwise"></i> Refresh
        </a>
        <a href="index.jsp" class="btn btn-success">
            <i class="bi bi-person-plus"></i> Add Guest
        </a>
    </div>
</div>

<%
boolean deleted = false;

/* HANDLE ACTIONS */
if (request.getParameter("action") != null) {
    try {
        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:postgresql://192.168.137.84:5432/winter_training",
            "soham",
            "admin"
        );

        int gid = Integer.parseInt(request.getParameter("guest_id"));
        String action = request.getParameter("action");
        String sql = "";

        if ("checkin".equals(action)) {
            sql = "UPDATE guests SET check_in_time = NOW() WHERE guest_id = ?";
        } else if ("checkout".equals(action)) {
            sql = "UPDATE guests SET check_out_time = NOW() WHERE guest_id = ?";
        } else if ("delete".equals(action)) {
            sql = "DELETE FROM guests WHERE guest_id = ?";
            deleted = true;
        }

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, gid);
        ps.executeUpdate();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }
}
%>

<!-- TABLE -->
<table class="table table-bordered table-hover table-striped">
<thead class="table-dark">
<tr>
    <th>#</th>
    <th>Name</th>
    <th>Email</th>
    <th>Mobile</th>
    <th>Organization</th>
    <th>Food</th>
    <th>Check In</th>
    <th>Check Out</th>
    <th>Actions</th>
</tr>
</thead>

<tbody>
<%
boolean hasData = false;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

try {
    Class.forName("org.postgresql.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:postgresql://192.168.137.84:5432/winter_training",
        "soham",
        "admin"
    );

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM guests ORDER BY guest_id");

    int i = 1;
    while (rs.next()) {
        hasData = true;
        Timestamp cin = rs.getTimestamp("check_in_time");
        Timestamp cout = rs.getTimestamp("check_out_time");
%>
<tr>
    <td><%= i++ %></td>
    <td><%= rs.getString("full_name") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("mobile_number") %></td>
    <td><%= rs.getString("organization") %></td>
    <td><%= rs.getString("food_choice") %></td>
    <td><%= cin != null ? sdf.format(cin) : "-" %></td>
    <td><%= cout != null ? sdf.format(cout) : "-" %></td>

    <td>
        <div class="d-flex gap-2">

            <!-- CHECK-IN -->
            <form method="post" class="m-0">
                <input type="hidden" name="guest_id" value="<%= rs.getInt("guest_id") %>">
                <input type="hidden" name="action" value="checkin">
                <button class="icon-btn icon-checkin"
                        title="Check In"
                        <%= cin != null ? "disabled" : "" %>>
                    <i class="bi bi-box-arrow-in-right"></i>
                </button>
            </form>

            <!-- CHECK-OUT -->
            <form method="post" class="m-0">
                <input type="hidden" name="guest_id" value="<%= rs.getInt("guest_id") %>">
                <input type="hidden" name="action" value="checkout">
                <button class="icon-btn icon-checkout"
                        title="Check Out"
                        <%= (cin == null || cout != null) ? "disabled" : "" %>>
                    <i class="bi bi-box-arrow-right"></i>
                </button>
            </form>

            <!-- DELETE (SweetAlert) -->
            <form method="post" class="m-0 delete-form">
                <input type="hidden" name="guest_id" value="<%= rs.getInt("guest_id") %>">
                <input type="hidden" name="action" value="delete">
                <button type="button"
                        class="icon-btn icon-delete"
                        title="Delete"
                        onclick="confirmDelete(this)">
                    <i class="bi bi-trash"></i>
                </button>
            </form>

        </div>
    </td>
</tr>
<%
    }
    con.close();

} catch (Exception e) {
    // handled
}

if (!hasData) {
%>
<tr>
    <td colspan="9" class="text-center text-muted">
        No data found / Database not reachable
    </td>
</tr>
<%
}
%>
</tbody>
</table>

</div>
</div>
</div>

<!-- DELETE CONFIRM SCRIPT -->
<script>
function confirmDelete(btn) {
    Swal.fire({
        title: 'Are you sure?',
        text: 'This guest will be permanently deleted!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            btn.closest('form').submit();
        }
    });
}
</script>

<!-- DELETE SUCCESS -->
<% if (deleted) { %>
<script>
Swal.fire({
    icon: 'success',
    title: 'Deleted!',
    text: 'Guest removed successfully.',
    confirmButtonColor: '#198754'
});
</script>
<% } %>

</body>
</html>
