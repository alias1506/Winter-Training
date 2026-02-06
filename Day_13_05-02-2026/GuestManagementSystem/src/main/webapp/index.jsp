<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Guest</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-body">
            <h4 class="mb-4">Add Guest</h4>

            <form method="post">

                <!-- Full Name -->
                <div class="mb-3">
                    <label for="full_name" class="form-label">Full Name</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-person"></i>
                        </span>
                        <input
                            type="text"
                            id="full_name"
                            name="full_name"
                            class="form-control"
                            required
                        >
                    </div>
                </div>

                <!-- Email -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-envelope"></i>
                        </span>
                        <input
                            type="email"
                            id="email"
                            name="email"
                            class="form-control"
                        >
                    </div>
                </div>

                <!-- Mobile Number -->
                <div class="mb-3">
                    <label for="mobile_number" class="form-label">Mobile Number</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-telephone"></i>
                        </span>
                        <input
                            type="text"
                            id="mobile_number"
                            name="mobile_number"
                            class="form-control"
                            maxlength="10"
                            pattern="[0-9]{10}"
                            title="Enter 10 digit mobile number"
                            oninput="this.value=this.value.replace(/[^0-9]/g,'')"
                            required
                        >
                    </div>
                </div>

                <!-- Organization -->
                <div class="mb-3">
                    <label for="organization" class="form-label">Organization</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-building"></i>
                        </span>
                        <input
                            type="text"
                            id="organization"
                            name="organization"
                            class="form-control"
                            required
                        >
                    </div>
                </div>

                <!-- Food Choice -->
                <div class="mb-3">
                    <label class="form-label d-block">Food Choice</label>

                    <div class="form-check">
                        <input
                            class="form-check-input"
                            type="radio"
                            id="food_veg"
                            name="food_choice"
                            value="Veg"
                            required
                        >
                        <label class="form-check-label" for="food_veg">
                            Veg
                        </label>
                    </div>

                    <div class="form-check">
                        <input
                            class="form-check-input"
                            type="radio"
                            id="food_nonveg"
                            name="food_choice"
                            value="Non-Veg"
                        >
                        <label class="form-check-label" for="food_nonveg">
                            Non-Veg
                        </label>
                    </div>
                </div>

                <!-- Buttons -->
                <button type="submit" name="add" class="btn btn-primary">
                    <i class="bi bi-check-circle"></i> Add Guest
                </button>

                <a href="guest_table.jsp" class="btn btn-outline-secondary ms-2">
                    <i class="bi bi-table"></i> View Guests
                </a>

            </form>

            <%-- BACKEND LOGIC --%>
            <%
                boolean success = false;
                boolean error = false;

                if (request.getParameter("add") != null) {
                    try {
                        Class.forName("org.postgresql.Driver");
                        Connection con = DriverManager.getConnection(
                            "jdbc:postgresql://192.168.137.84:5432/winter_training",
                            "soham",
                            "admin"
                        );

                        PreparedStatement ps = con.prepareStatement(
                            "INSERT INTO guests (full_name,email,mobile_number,organization,food_choice) VALUES (?,?,?,?,?)"
                        );

                        ps.setString(1, request.getParameter("full_name"));
                        ps.setString(2, request.getParameter("email"));
                        ps.setString(3, request.getParameter("mobile_number"));
                        ps.setString(4, request.getParameter("organization"));
                        ps.setString(5, request.getParameter("food_choice"));

                        ps.executeUpdate();
                        con.close();
                        success = true;

                    } catch (Exception e) {
                        error = true;
                        e.printStackTrace();
                    }
                }
            %>

        </div>
    </div>
</div>

<!-- SweetAlert -->
<% if (success) { %>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Guest Added!',
        text: 'Guest details saved successfully',
        confirmButtonColor: '#3085d6'
    });
</script>
<% } %>

<% if (error) { %>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Oops!',
        text: 'Something went wrong. Guest not added.',
        confirmButtonColor: '#d33'
    });
</script>
<% } %>

</body>
</html>
