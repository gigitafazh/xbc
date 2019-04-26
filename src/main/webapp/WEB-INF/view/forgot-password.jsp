<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Xsis Bootcamp Core</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">

<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/AdminLTE.min.css">
<!-- iCheck -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/blue.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

<!-- Google Font -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
	
<script>
	function getFormData($form) {
		var unindexed_array = $form.serializeArray();
		var indexed_array = {};
		$.map(unindexed_array, function(n, i) {
			indexed_array[n['name']] = n['value'];
		});
		return indexed_array;
	}

	//function untuk check huruf
	function cekHuruf(a) {
		valid = /^[A-Za-z0-9_.]{8,20}$/;
		return valid.test(a);
	}

	//
	function loadData() {
		var search = $('#email').val();
		
		$.ajax({
			type : 'get',
			url : 'forgot-password/search/?find=' + search,
			success : function(d) {
				saveData();
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk save data user
	function saveData() {
		var data = getFormData($('#form-edit'));

		if ($('#password').val().trim().length == 0 || $('#retypePass').val().trim().length == 0) {
			if ($('#password').val().trim().length == 0) {
				$('#password').notify("Data tidak boleh kosong", "error", {position: "right"});
			}
			if ($('#retypePass').val().trim().length == 0) {
				$('#retypePass').notify("Data tidak boleh kosong", "error", {position: "right"});
			}
		} else if(!cekHuruf($('#password').val())) {
			//$("#password").notify("Minimal 8 karakter dengan kombinasi a-z atau A-Z atau 0-9", "info", {position:"right"})
		} else if(data.password != data.retypePass) {
			$('#retypePass').notify("Password tidak sama. Ketik ulang password Anda", "error", {position: "right"});
			$('#retypePass').trigger('reset');
			$('#form-edit input[name=retypePass]').trigger('reset');
		} else {
			debugger;
			$.ajax({
				type : 'put',
				url : 'forgot-password/change/',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success : function(d) {
					debugger;
					location.reload();
					$.notify("Data successfully saved!", "success");
				},
				error : function(d) {
					debugger;
					console.log('Error');
				}
			});
		}
	}
</script>
</head>
<body class="hold-transition login-page">
	<div class="login-box">
		<div class="login-logo">
			<a href="/"><b>Forgot Password</b></a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<form id="form-edit">
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label>Email</label><input type="text" class="form-control"
								name="email" id="email">
						</div>
						<div class="form-group">
							<label>Password</label><input type="text" class="form-control"
								name="password" id="password">
						</div>
						<div class="form-group">
							<label>Re-type Password</label> <input type="text"
								class="form-control" name="retypePass" id="retypePass">
						</div>
						<div class="form-group pull-right">
				<button type="button" class="btn btn-default" onclick="window.location.href = '${pageContext.request.contextPath}/login';">Cancel</button>
				&nbsp;
				<button type="button" class="btn btn-primary" onclick="loadData()">Save</button>
			</div>
					</div>
				</div>
			</form>
			<!-- /.login-box-body -->
		</div>
	</div>
	<!-- /.login-box -->

	<!-- jQuery 3 -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<!-- iCheck -->
	<script
		src="${pageContext.request.contextPath}/assets/js/icheck.min.js"></script>
</body>

</html>