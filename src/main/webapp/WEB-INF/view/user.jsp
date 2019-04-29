<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<meta charset="ISO-8859-1">
<title>User</title>

<head>
<script>
	var tbUser;
	var modeSubmit = 'insert';
	
	function getFormData($form) {
		var unindexed_array = $form.serializeArray();
		var indexed_array = {};
		$.map(unindexed_array, function(n, i) {
			indexed_array[n['name']] = n['value'];
		});
		return indexed_array;
	}

	// function untuk show data dropdown role
	function showRole() {
		$.ajax({
			type : 'get',
			url : 'role/',
			success : function(d) {
				var s = '<option>Choose Role</option>';

				$(d).each(function(index, element) {
					s += '<option value="' + element.id + '" data-nama="' + element.name + '">'
						+ element.name + '</option>';
				});
				$('#roleId').html(s);
				$('#roleId2').html(s);
				$('#roleId3').html(s);
			}
		});
	}

	// function untuk show data user
	function showData() {
		var search = $('#search').val();
		var url = '';
		if (search == '') {
			url = 'user/'
		} else {
			url = 'user/search/?find=' + search
		}
		$.ajax({
			type : 'get',
			url : url,
			data : {
				email : $('#search').val()
			},
			success : function(d) {
				tbUser.clear().draw();
				$(d).each(function(index, element) {
					tbUser.row.add([
						element.username,
						element.role.name,
						element.email,
						'<div class="dropdown"><button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">'
						+ '<i class="fa fa-bars"></i></button><ul class="dropdown-menu">'
						+ '<li><a href="javascript:void(0)" data-toggle="modal" data-target="#modal-edit" onclick="loadData('
						+ element.id
						+ ')">Edit</a></li>'
						+ '<li><a href="javascript:void(0)" data-toggle="modal" data-target="#modal-reset" onclick="loadData('
						+ element.id
						+ ')">Reset Password</a></li>'
						+ '<li><a href="javascript:void(0)" onclick="deleteDisabled('
						+ element.id
						+ ')">Delete</a></li>'
						+ '</ul></div>',
						element.id
					]).draw();
					
				});
			},
		});
	}

	// function untuk load edit data user
	function loadData(id) {
		reset();
		$.ajax({
			type : 'get',
			url : 'user/' + id,
			success : function(d) {
				$('input[name=id]').val(d.id);
				$('select[name=roleId]').val(d.roleId);
				$('input[name=roleId]').val(d.roleId);
				$('input[name=email]').val(d.email);
				$('input[name=username]').val(d.username);
				$('#form-edit input[name=password]').val(d.password);
				$('input[name=mobileFlag]').val([d.mobileFlag]);
				$('input[name=mobileToken]').val(d.mobileToken);
				modeSubmit ='update';
			},
			error : function(d) {
				console.log('Error!');
			}
		});
	}

	//function untuk check huruf
	function cekHuruf(a) {
		valid = /^[A-Za-z0-9]{8,}$/;
		return valid.test(a);
	}
	
	// function untuk save data user
	function saveData() {
		var data = getFormData($('#form-add'));
		
		if ($('#roleId').val() == 'Choose Role' || $('#email').val().trim().length == 0 || $('#username').val().trim().length == 0 || $('#password').val().trim().length == 0 || $('#retypePass').val().trim().length == 0) {
			if ($('#roleId').val() == 'Choose Role') {
				$('#roleId').notify("Pilih data!", "error", {position: "right"});
			}
			else if ($('#email').val().trim().length == 0) {
				$('#email').notify("Data tidak boleh kosong", "error", {position: "right"});
			}
			else if ($('#username').val().trim().length == 0) {
				$('#username').notify("Data tidak boleh kosong", "error", {position: "right"});
			}
			else if ($('#password').val().trim().length == 0) {
				$('#password').notify("Data tidak boleh kosong", "error", {position: "right"});
			}
			else if ($('#retypePass').val().trim().length == 0) {
				$('#retypePass').notify("Data tidak boleh kosong", "error", {position: "right"});
			}
		} else if(!cekHuruf($('#password').val())) {
			$("#password").notify("Minimal 8 karakter dengan kombinasi a-z atau A-Z atau 0-9", "info", {position:"right"})
		} else if(data.password != data.retypePass) {
			$('#retypePass').notify("Password tidak sama. Ketik ulang password Anda", "error", {position: "right"});
			$('#retypePass').trigger('reset');
			$('#input[name=retypePass]').trigger('reset');
		} else {
			$.ajax({
				type : 'post',
				url : 'user/',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success : function(d) {
					if (d == 1) {
						debugger;
						$('#email').notify("Email sudah terdaftar!", "error", {position: "right"});
					} else if (d == 2) {
						debugger;
						$('#username').notify("Username sudah terdaftar!", "error", {position: "right"});
					} else if (d == 3){
						debugger;
						$.notify("Data successfully saved!", "success");
						$('#modal-add').modal('hide');
					}
					showData();
					modeSubmit = 'insert';
				},
				error : function(d) {
					console.log('Error');
				}
			});
		}
	}

	// function untuk save edit data user
	function saveEdit() {
		var data = getFormData($('#form-edit'));
	
		if ($('#roleId2').val() == 'Choose Role' || $('#email2').val().trim().length == 0 || $('#username2').val().trim().length == 0) {
			if ($('#roleId2').val() == 'Choose Role') {
				$('#roleId2').notify("Pilih data!", "error", {position: "right"});
			}
			else if ($('#email2').val().trim().length == 0) {
				$('#email2').notify("Data tidak boleh kosong", "error", {position: "right"});
			}
			else if ($('#username2').val().trim().length == 0) {
				$('#username2').notify("Data tidak boleh kosong", "error", {position: "right"});
			}
		} else {
			$.ajax({
				type : 'put',
				url : 'user/',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success : function(d) {
					showData();
					$.notify("Data successfully saved!", "success");
					modeSubmit = 'update';
					$('#modal-edit').modal('hide');
				},
				error : function(d) {
					console.log('Error');
				}
			});
		}
	}

	// function untuk save reset data user
	function saveReset() {
		var data = getFormData($('#form-reset'));
	
		if ($('#password3').val().trim().length == 0) {
			$('#password3').notify("Data tidak boleh kosong", "error", {
				position : "right"
			});
		} else if ($('#retypePass3').val().trim().length == 0) {
			$('#retypePass3').notify("Data tidak boleh kosong", "error", {
				position : "right"
			});
		} else if (!cekHuruf($('#password3').val())) {
			$("#password3")
					.notify(
							"Minimal 8 karakter dengan kombinasi a-z atau A-Z atau 0-9",
							"info", {
								position : "right"
							})
		} else if (data.password != data.retypePass) {
			$('#retypePass3').notify(
					"Password tidak sama. Ketik ulang password Anda", "error",
					{
						position : "right"
					});
			$('#retypePass3').trigger('reset');
			$('#retypePass3').trigger('reset');
		} else {
			$.ajax({
				type : 'put',
				url : 'user/',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success : function(d) {
					showData();
					$.notify("Data successfully saved!", "success");
					modeSubmit = 'update';
					$('#modal-reset').modal('hide');
				},
				error : function(d) {
					console.log('Error');
				}
			});
		}
	}

	// function untuk delete data users
	function deleteDisabled(id) {
		if (confirm("Are you sure to delete this data?")) {
			$.ajax({
				type : 'DELETE',
				url : 'user/' + id,
				success : function(d) {
					showData();
					alert("Data successfully deleted!");
				},
				error : function(d) {
					console.log('Error');
				}
			});
		}
	}

	// function untuk reset
	function reset() {
		$('#form-add').trigger('reset');
		$('#form-edit').trigger('reset');
		$('#form-reset').trigger('reset');
		$('#form-add input[type=hidden]').val('');
		$('#form-edit input[type=hidden]').val('');
		$('#form-edit input[readOnly=readOnly]').val('');
		$('#form-reset input[type=hidden]').val('');
	}

	$(document).ready(function() {
		showRole();
		showData();
		tbUser = $('#tbUser').DataTable({
			'searching' : false,
			'lengthChange' : false,
			'lengthMenu' : [ 10 ]
		});
	});
</script>
</head>

<body>
	<!-- Search User -->
	<div class="row">
		<div class="col-xs-12">
			<div class="col-xs-5" style="margin-left: 20px">
				<div class="input-group input-group-sm">
					<input type="text" id="search" class="form-control pull-right"
						placeholder="Search by username/email">
					<div class="input-group-btn">
						<button type="button" class="btn btn-default" onclick="showData()">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="col-xs-5">
				<button type="button" class="btn btn-default pull-right hidden-xs"
					data-toggle="modal" data-target="#modal-add" onclick="reset()"
					style="width: 30px; height: 30px; padding: 0px 0px">
					<i class="fa fa-plus" style="font-size: 20px"></i>
				</button>
			</div>
		</div>
	</div>
	<br>
	<!-- End Search User -->

	<!-- Modal Add User -->
	<div class="row">
		<div class="col-xs-6">
			<!-- Modal -->
			<div class="modal fade" id="modal-add" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
							<h4 class="modal-title">Add User</h4>
						</div>
						<form id="form-add">
							<div class="modal-body">
								<div class="row">
									<div class="col-xs-12">
										<div class="form-group">
											<label>Role</label> <select
												class="custom-select d-block w-100 form-control" id="roleId"
												name="roleId">
											</select>
										</div>
										<div class="form-group">
											<label>Email</label> <input type="email" class="form-control"
												name="email" id="email">
										</div>
										<div class="form-group">
											<label>Username</label> <input type="text"
												class="form-control" name="username" id="username">
										</div>
										<div class="form-group">
											<label>Password</label> <input type="text"
												class="form-control" name="password" id="password">
										</div>
										<div class="form-group">
											<label>Re-type Password</label> <input type="text"
												class="form-control" name="retypePass" id="retypePass">
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Cancel</button>
								&nbsp;
								<button type="button" class="btn btn-primary"
									onclick="saveData()">Save</button>
							</div>
						</form>
					</div>
					<!-- End Modal content -->
				</div>
			</div>
		</div>
	</div>
	<!-- End Modal Add User -->

	<!-- Show Data User -->
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body">
					<table id="tbUser" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Username</th>
								<th>Role</th>
								<th>Email</th>
								<th>#</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- End Show Data User -->

	<!-- Modal Edit User -->
	<div class="row">
		<div class="col-xs-6">
			<!-- Modal -->
			<div class="modal fade" id="modal-edit" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Edit User</h4>
						</div>
						<form id="form-edit">
							<div class="modal-body">
								<div class="row">
									<div class="col-xs-12">
										<div class="form-group">
											<input type="hidden" class="form-control" name="id" id="id2">
										</div>
										<div class="form-group">
											<label>Role</label> <select
												class="custom-select d-block w-100 form-control"
												id="roleId2" name="roleId">
											</select>
										</div>
										<div class="form-group">
											<label>Email</label> <input type="email" class="form-control"
												name="email" id="email2" readOnly="readonly">
										</div>
										<div class="form-group">
											<label>Username</label> <input type="text"
												class="form-control" name="username" id="username2" readOnly="readOnly">
										</div>
										<div class="form-group">
											<input type="hidden"
												class="form-control" name="password" id="password2">
										</div>
										<div class="form-group">
											<label>Mobile Flag</label>
											<div class="input-group">
												<input type="radio" name="mobileFlag" id="mobileFlag2"
													value="true"> True &nbsp; <input type="radio"
													name="mobileFlag" id="mobileFlag" value="false">
												False
											</div>
										</div>
										<div class="form-group">
											<label>Mobile Token</label> <input type="text"
												class="form-control" name="mobileToken" id="mobileToken">
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Cancel</button>
								&nbsp;
								<button type="button" class="btn btn-primary"
									onclick="saveEdit()">Save</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Modal Edit User -->

	<!-- Modal Reset Password -->
	<div class="row">
		<div class="col-xs-6">
			<!-- Modal -->
			<div class="modal fade" id="modal-reset" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Reset Password</h4>
						</div>
						<form id="form-reset">
							<div class="modal-body">
								<div class="row">
									<div class="col-xs-12">
										<div class="form-group">
											<input type="text" class="form-control" name="id" id="id3">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control"
												id="roleId3" name="roleId">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control"
												name="email" id="email3">
										</div>
										<div class="form-group">
											<input type="hidden"
												class="form-control" name="username" id="username3">
										</div>
										<div class="form-group">
											<label>Password</label><input type="text"
												class="form-control" name="password" id="password3">
										</div>
										<div class="form-group">
											<label>Re-type Password</label> <input type="text"
												class="form-control" name="retypePass" id="retypePass3">
										</div>
										<div class="form-group">
											<div class="input-group">
												<input type="hidden" class="form-control" name="mobileFlag"
													id="mobileFlag3">
											</div>
										</div>
										<div class="form-group">
											<input type="hidden"
												class="form-control" name="mobileToken" id="mobileToken3">
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Cancel</button>
								&nbsp;
								<button type="button" class="btn btn-primary"
									onclick="saveReset()">Save</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Modal Reset Password -->

</body>
</html>