<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Guest List</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .icon-btn{
            background:none;border:none;padding:3px;
            font-size:1.1rem;cursor:pointer;transition:.15s;
        }
        .icon-btn:disabled{color:#aaa;cursor:not-allowed}
        .icon-btn:hover{transform:scale(1.15);font-weight:bold}
        .icon-checkin{color:#198754}
        .icon-checkout{color:#dc3545}
        .icon-edit{color:#0d6efd}
        .icon-delete{color:#dc3545}

        td.actions-cell:hover{background:#f1f3f5}

        /* Modal spacing */
        .modal-body label{
            margin-top:8px;
            margin-bottom:4px;
            font-weight:500;
        }
        .modal-body .input-group{
            margin-bottom:10px;
        }
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
boolean deleted=false, updated=false;

if(request.getParameter("action")!=null){
    try{
        Class.forName("org.postgresql.Driver");
        Connection con=DriverManager.getConnection(
            "jdbc:postgresql://192.168.137.84:5432/winter_training",
            "soham","admin"
        );

        int gid=Integer.parseInt(request.getParameter("guest_id"));
        String action=request.getParameter("action");
        PreparedStatement ps=null;

        if("checkin".equals(action)){
            ps=con.prepareStatement(
                "UPDATE guests SET check_in_time=NOW() WHERE guest_id=?"
            );
            ps.setInt(1,gid);
        }
        else if("checkout".equals(action)){
            ps=con.prepareStatement(
                "UPDATE guests SET check_out_time=NOW() WHERE guest_id=?"
            );
            ps.setInt(1,gid);
        }
        else if("delete".equals(action)){
            ps=con.prepareStatement(
                "DELETE FROM guests WHERE guest_id=?"
            );
            ps.setInt(1,gid);
            deleted=true;
        }
        else if("update".equals(action)){
            ps=con.prepareStatement(
                "UPDATE guests SET full_name=?, mobile_number=?, organization=?, food_choice=? WHERE guest_id=?"
            );
            ps.setString(1,request.getParameter("full_name"));
            ps.setString(2,request.getParameter("mobile_number"));
            ps.setString(3,request.getParameter("organization"));
            ps.setString(4,request.getParameter("food_choice"));
            ps.setInt(5,gid);
            updated=true;
        }

        ps.executeUpdate();
        con.close();
    }catch(Exception e){
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
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection(
    "jdbc:postgresql://192.168.137.84:5432/winter_training",
    "soham","admin"
);

Statement st=con.createStatement();
ResultSet rs=st.executeQuery("SELECT * FROM guests ORDER BY guest_id");

int i=1;
while(rs.next()){
    Timestamp cin=rs.getTimestamp("check_in_time");
    Timestamp cout=rs.getTimestamp("check_out_time");
%>
<tr>
<td><%=i++%></td>
<td><%=rs.getString("full_name")%></td>
<td><%=rs.getString("email")%></td>
<td><%=rs.getString("mobile_number")%></td>
<td><%=rs.getString("organization")%></td>
<td><%=rs.getString("food_choice")%></td>
<td><%=cin!=null?sdf.format(cin):"-"%></td>
<td><%=cout!=null?sdf.format(cout):"-"%></td>

<td class="actions-cell">
<div class="d-flex align-items-center gap-1">

<form method="post" class="m-0">
<input type="hidden" name="guest_id" value="<%=rs.getInt("guest_id")%>">
<input type="hidden" name="action" value="checkin">
<button class="icon-btn icon-checkin" <%=cin!=null?"disabled":""%>>
<i class="bi bi-box-arrow-in-right"></i>
</button>
</form>

<form method="post" class="m-0">
<input type="hidden" name="guest_id" value="<%=rs.getInt("guest_id")%>">
<input type="hidden" name="action" value="checkout">
<button class="icon-btn icon-checkout" <%= (cin==null||cout!=null)?"disabled":""%>>
<i class="bi bi-box-arrow-right"></i>
</button>
</form>

<button class="icon-btn icon-edit"
data-bs-toggle="modal"
data-bs-target="#editModal"
onclick="setEdit(
'<%=rs.getInt("guest_id")%>',
'<%=rs.getString("full_name")%>',
'<%=rs.getString("email")%>',
'<%=rs.getString("mobile_number")%>',
'<%=rs.getString("organization")%>',
'<%=rs.getString("food_choice")%>'
)">
<i class="bi bi-pencil-square"></i>
</button>

<form method="post" class="m-0">
<input type="hidden" name="guest_id" value="<%=rs.getInt("guest_id")%>">
<input type="hidden" name="action" value="delete">
<button type="button" class="icon-btn icon-delete" onclick="confirmDelete(this)">
<i class="bi bi-trash"></i>
</button>
</form>

</div>
</td>
</tr>
<% } con.close(); %>
</tbody>
</table>

</div>
</div>
</div>

<!-- EDIT MODAL -->
<div class="modal fade" id="editModal">
<div class="modal-dialog modal-dialog-centered">
<form method="post" class="modal-content">

<div class="modal-header">
<h5><i class="bi bi-pencil-square"></i> Edit Guest</h5>
<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">

<input type="hidden" name="guest_id" id="eid">
<input type="hidden" name="action" value="update">

<label for="ename">Name</label>
<div class="input-group">
<span class="input-group-text"><i class="bi bi-person"></i></span>
<input class="form-control" id="ename" name="full_name" required>
</div>

<label for="eemail">Email (read only)</label>
<div class="input-group">
<span class="input-group-text"><i class="bi bi-envelope"></i></span>
<input class="form-control bg-light" id="eemail" disabled>
</div>

<label for="emobile">Mobile</label>
<div class="input-group">
<span class="input-group-text"><i class="bi bi-telephone"></i></span>
<input class="form-control" id="emobile" name="mobile_number"
maxlength="10"
oninput="this.value=this.value.replace(/[^0-9]/g,'')"
required>
</div>

<label for="eorg">Organization</label>
<div class="input-group">
<span class="input-group-text"><i class="bi bi-building"></i></span>
<input class="form-control" id="eorg" name="organization" required>
</div>

<label for="efood">Food</label>
<div class="input-group">
<span class="input-group-text"><i class="bi bi-cup-hot"></i></span>
<select class="form-select" id="efood" name="food_choice">
<option>Veg</option>
<option>Non-Veg</option>
</select>
</div>

</div>

<div class="modal-footer">
<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
<i class="bi bi-x-circle"></i> Close
</button>
<button class="btn btn-primary">
<i class="bi bi-save"></i> Update
</button>
</div>

</form>
</div>
</div>

<script>
function setEdit(id,n,e,m,o,f){
    eid.value=id;
    ename.value=n;
    eemail.value=e;
    emobile.value=m;
    eorg.value=o;
    efood.value=f;
}

function confirmDelete(btn){
    Swal.fire({
        title:'Are you sure?',
        text:'This guest will be permanently deleted!',
        icon:'warning',
        showCancelButton:true,
        confirmButtonColor:'#dc3545'
    }).then(r=>{
        if(r.isConfirmed) btn.closest('form').submit();
    });
}
</script>

<% if(updated){ %>
<script>Swal.fire('Updated','Guest updated successfully','success');</script>
<% } %>

<% if(deleted){ %>
<script>Swal.fire('Deleted','Guest removed','success');</script>
<% } %>

</body>
</html>
