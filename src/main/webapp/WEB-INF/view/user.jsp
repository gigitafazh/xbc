<title>User</title>

<head>
<script>
	var modeSubmit = 'insert';
	var tbUser;

	var currentdate = new Date();
	var datetime = currentdate.getFullYear() + "-"
			+ (currentdate.getMonth() + 1) + "-" + currentdate.getDate() + " "
			+ currentdate.getHours() + ":" + currentdate.getMinutes() + ":"
			+ currentdate.getSeconds();
	//document.write(datetime);

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
		$('#roleId2').html(s);
		$('#roleId3').html(s);
		$('#roleId4').html(s);
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

	// function untuk load data user
	function showData(d) {
		tbUser.clear().draw();
		$(d)
				.each(
						function(index, element) {
							if (element.deleted == false) {
								tbUser.row
										.add(
												[
														element.username,
														element.role.name,
														element.email,
														'<div class="dropdown"><button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">'
																+ '<i class="fa fa-bars"></i></button><ul class="dropdown-menu">'
																+ '<li><input class="btn btn-default" data-toggle="modal"'
																+ 'data-target="#modalEdit" value="Edit" onclick="loadEdit(\''
																+ element.id
																+ '\')"></li>'
																+ '<li><input class="btn btn-default" data-toggle="modal"'
																+ 'data-target="#modalReset" value="Reset" onclick="loadReset(\''
																+ element.id
																+ '\')"></li>'
																+ '<li><input class="btn btn-default" data-toggle="modal"'
																+ 'data-target="#modalDelete" value="Delete" onclick="loadDelete(\''
																+ element.id
																+ '\')"></li></ul></div>' ])
										.draw();
							}
						})

	}

	function loadData() {
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
			success : function(d) {
				showData(d);
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk save data user
	function saveAdd() {
		var method;
		var data = getFormData($('#form-add'));

		if (modeSubmit == 'insert') {
			method = 'post';
		} else {
			method = 'put';
		}
		$.ajax({
			type : method,
			url : 'user/',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function(d) {
				loadData();
				modeSubmit = 'insert';
				$('#roleId, #email, #username, #password').val('');
				location.reload();
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk save update data user
	function saveEdit() {
		var data = getFormData($('#form-edit'));
		$.ajax({
			type : 'put',
			url : 'user/',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function(d) {
				loadData();
				modeSubmit = 'update';
				console.log(d);
				location.reload();
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk save reset password user
	function saveReset() {
		var data = getFormData($('#form-resetPass'));
		$.ajax({
			type : 'put',
			url : 'user/',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function(d) {
				if (d.retypePass == d.password) {
					loadData();
					modeSubmit = 'update';
					location.reload();
				} else {
					alert("Password tidak sama!\nKetik ulang password anda");
				}
				//$('#modifiedBy').val(${sessionScope.id});
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk delete data user (is_delete == true)
	function deleteDisabled() {
		var data = getFormData($('#form-delete'));
		$.ajax({
			type : 'put',
			url : 'user/',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function(d) {
				loadDelete();
				modeSubmit = 'update';
				location.reload();
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk load pada saat edit
	function loadEdit(id) {
		$.ajax({
			type : 'get',
			url : 'user/' + id,
			success : function(d) {
				loadDataRole();
				$('.modal-body #id').val(d.id);
				$('.modal-body #roleId2').val(d.roleId);
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

	// function untuk load pada saat reset
	function loadReset(id) {
		$.ajax({
			type : 'get',
			url : 'user/' + id,
			success : function(d) {
				loadDataRole();
				$('.modal-body #id').val(d.id);
				$('.modal-body #roleId3').val(d.roleId);
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

	// function untuk load pada saat delete
	function loadDelete(id) {
		$.ajax({
			type : 'get',
			url : 'user/' + id,
			success : function(d) {
				loadDataRole();
				$('.modal-body #id').val(d.id);
				$('.modal-body #roleId4').val(d.roleId);
				$('.modal-body #password').val(d.password);
				$('.modal-body #email').val(d.email);
				$('.modal-body #username').val(d.username);
				$('.modal-body #mobileFlag').val(d.mobileFlag);
				$('.modal-body #mobileToken').val(d.mobileToken);
				$('.modal-body #deletedOn').val(datetime);
				$('.modal-body #deleted').val(true);
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk button cancel (reset data form)
	function reset() {
		location = 'user.html';
	}

	$(document).ready(function() {
		loadData();
		loadDataRole();
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
						<button type="button" class="btn btn-default" onclick="loadData()">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="col-xs-5">
				<button type="button" class="btn btn-default pull-right hidden-xs"
					data-toggle="modal" data-target="#modalAdd"
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
			<div class="modal fade" id="modalAdd" role="dialog">
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
											<label>Email</label> <input type="text" class="form-control"
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
									data-dismiss="modal" onclick="reset()">Cancel</button>
								&nbsp;
								<button type="button" class="btn btn-primary"
									onclick="saveAdd()">Save</button>
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
			<div class="modal fade" id="modalEdit" role="dialog">
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
											<input type="hidden" class="form-control" name="id" id="id">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="password"
												id="password">
										</div>
										<div class="form-group">
											<label>Role</label> <select
												class="custom-select d-block w-100 form-control"
												id="roleId2" name="roleId">
											</select>
										</div>
										<div class="form-group">
											<label>Email</label> <input type="text" class="form-control"
												name="email" id="email">
										</div>
										<div class="form-group">
											<label>Username</label> <input type="text"
												class="form-control" name="username" id="username">
										</div>
										<div class="form-group">
											<label>Mobile Flag</label>
											<div class="input-group">
												<input type="radio" name="mobileFlag" id="mobileFlag"
													value=true> True &nbsp; <input type="radio"
													name="mobileFlag" id="mobileFlag" value=false>
												False
											</div>
										</div>
										<div class="form-group">
											<label>Mobile Token</label> <input type="text"
												class="form-control" name="mobileToken" id="mobileToken">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="modifiedOn"
												id="modifiedOn">
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal" onclick="reset()">Cancel</button>
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
			<div class="modal fade" id="modalReset" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Reset Password</h4>
						</div>
						<form id="form-resetPass">
							<div class="modal-body">
								<div class="row">
									<div class="col-xs-12">
										<div class="form-group">
											<input type="hidden" class="form-control" name="id" id="id">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="roleId"
												id="roleId3">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="email"
												id="email">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="username"
												id="username">
										</div>

										<div class="form-group">
											<label>Password</label> <input type="text"
												class="form-control" name="password" id="password">
										</div>
										<div class="form-group">
											<label>Re-type Password</label> <input type="text"
												class="form-control" name="retypePass" id="retypePass">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="modifiedOn"
												id="modifiedOn">
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal" onclick="reset()">Cancel</button>
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

	<!-- Modal Delete User -->
	<div class="row">
		<div class="col-xs-3">
			<!-- Modal -->
			<div class="modal fade" id="modalDelete" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Delete User</h4>
						</div>

						<div class="modal-body">
							<form id="form-delete">
								<div class="row">
									<div class="col-xs-12">
										<div class="form-group">
											<input type="hidden" class="form-control" name="id" id="id">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="roleId"
												id="roleId4">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="email"
												id="email">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="username"
												id="username">
										</div>

										<div class="form-group">
											<input type="hidden" class="form-control" name="password"
												id="password">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="deleted"
												id="deleted">
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="deletedOn"
												id="deletedOn">
										</div>
									</div>
								</div>
							</form>
							<p>Are you sure want to delete data?</p>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal" onclick="reset()">Cancel</button>
							&nbsp;
							<button type="button" class="btn btn-primary"
								onclick="deleteDisabled()">Yes</button>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Modal Delete User -->
</body>