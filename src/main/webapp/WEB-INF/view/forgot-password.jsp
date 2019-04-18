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
	var modeSubmit = 'insert';
	var tbUser;

	var currentdate = new Date();
	var datetime = currentdate.getFullYear() + "-"
			+ (currentdate.getMonth() + 1) + "-" + currentdate.getDate() + " "
			+ currentdate.getHours() + ":" + currentdate.getMinutes() + ":"
			+ currentdate.getSeconds();

	function getFormData($form) {
		var unindexed_array = $form.serializeArray();
		var indexed_array = {};
		$.map(unindexed_array, function(n, i) {
			indexed_array[n['name']] = n['value'];
		});
		return indexed_array;
	}

	// function untuk load data dropdown role
	function showDataRole(d) {
		var s = '<option>Silahkan Pilih</option>';
		$(d)
				.each(
						function(index, element) {
							s += '<option value="' + element.id + '" data-nama="' + element.name + '">'
									+ element.name + '</option>';
						});
		$('#roleId').html(s);
	}

	function loadDataRole() {
		$.ajax({
			type : 'get',
			url : 'role/',
			success : function(d) {
				showDataRole(d);
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk load pada saat forgot password
	function loadForgotPass(id) {
		$.ajax({
			type : 'get',
			url : 'user/' + id,
			success : function(d) {
				loadDataRole();
				$('.modal-body #id').val(d.id);
				$('.modal-body #roleId').val(d.roleId);
				$('.modal-body #password').val(d.password);
				$('.modal-body #email').val(d.email);
				$('.modal-body #username').val(d.username);
				$('.modal-body #mobileFlag').val(d.mobileFlag);
				$('.modal-body #mobileToken').val(d.mobileToken);
				$('.modal-body #modifiedOn').val(datetime);
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk save reset password user
	function saveForgotPass() {
		var data = getFormData($('#form-forgotPass'));
		$.ajax({
			type : 'put',
			url : 'user/',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function(d) {
				if (d.retypePass == d.password) {
					modeSubmit = 'update';
					location.reload();
				} else {
					alert("Password tidak sama!\nKetik ulang password anda");
				}
			},
			error : function(d) {
				console.log('Error');
			}
		});
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
			<form id="form-forgotPass">
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<input type="hidden" class="form-control" name="id" id="id">
						</div>
						<div class="form-group">
							<input type="hidden" class="form-control" name="roleId"
								id="roleId">
						</div>
						<div class="form-group">
							<input type="hidden" class="form-control" name="username"
								id="username">
						</div>
						<div class="form-group">
							<label>Email</label><input type="text" class="form-control"
								name="email" id="email">
						</div>
						<div class="form-group">
							<label>Password</label> <input type="text" class="form-control"
								name="password" id="password">
						</div>
						<div class="form-group">
							<label>Re-type Password</label> <input type="text"
								class="form-control" name="retypePass" id="retypePass">
						</div>
						<div class="form-group">
							<input type="hidden" class="form-control" name="modifiedOn"
								id="modifiedOn">
						</div>
						<div class="form-group pull-right">
							<button type="button" class="btn btn-default" onclick="reset()">Cancel</button>
							&nbsp;
							<button type="button" class="btn btn-primary"
								onclick="saveForgotPass()">Save</button>
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