<title>Office</title>

<head>
<script>
	var modeSubmit = 'insert';
	var tbOffice;
	var tbRoom;

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

	// function untuk load data office
	function showData(d) {
		tbOffice.clear().draw();
		$(d)
				.each(
						function(index, element) {
							if (element.deleted == false) {
								tbOffice.row
										.add(
												[
														element.name,
														element.contact,
														'<div class="dropdown"><button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">'
																+ '<i class="fa fa-bars"></i></button><ul class="dropdown-menu">'
																+ '<li><input class="btn btn-default" data-toggle="modal"'
																+ 'data-target="#modalEdit" value="Edit" onclick="loadEdit(\''
																+ element.id
																+ '\')"></li>'
																+ '<li><input class="btn btn-default" data-toggle="modal"'
																+ 'data-target="#modalDelete" value="Delete" onclick="loadDelete(\''
																+ element.id
																+ '\')"></li></ul></div>' ])
										.draw();
							}
						});
		$('#officeId').val('1');

	}

	function loadData() {
		var search = $('#search').val();
		var url = '';
		if (search == '') {
			url = 'office/'
		} else {
			url = 'office/search/?name=' + search
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

	// function untuk load data room
	function showDataRoom(d) {
		tbRoom.clear().draw();
		$(d)
				.each(
						function(index, element) {
							if (element.deleted == false) {
								tbRoom.row
										.add(
												[
														element.code,
														element.name,
														element.capacity,
														'<div class="dropdown"><button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">'
																+ '<i class="fa fa-bars"></i></button><ul class="dropdown-menu">'
																+ '<li><input class="btn btn-default" data-toggle="modal"'
																+ 'data-target="#editRoom" value="Edit" onclick="loadEditRoom(\''
																+ element.id
																+ '\')"></li>'
																+ '<li><input class="btn btn-default" data-toggle="modal"'
																+ 'data-target="#deleteRoom" value="Delete" onclick="loadDeleteRoom(\''
																+ element.id
																+ '\')"></li></ul></div>' ])
										.draw();
							}
						});
	}

	function loadDataRoom() {
		var search = $('#search').val();

		$.ajax({
			type : 'get',
			url : 'room/',
			success : function(d) {
				showDataRoom(d);
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk save data office
	function saveAdd() {
		var method;

		if (modeSubmit == 'insert') {
			method = 'post';
			$('#createdOn').val(datetime);
		} else {
			method = 'put';
		}
		var data = getFormData($('#form-add'));
		$.ajax({
			type : method,
			url : 'office/',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function(d) {
				loadData();
				modeSubmit = 'insert';
				$('#name, #contact').val('');
				//$('#createdBy').val(${sessionScope.id});
				location.reload();
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk save update data office
	function saveEdit() {
		var data = getFormData($('#form-edit'));
		$.ajax({
			type : 'put',
			url : 'office/',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function(d) {
				loadData();
				modeSubmit = 'update';
				location.reload();
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk data save room
	function saveAddRoom() {
		var method;

		if (modeSubmit == 'insert') {
			method = 'post';

			$('#createdOn').val(datetime);
		} else {
			method = 'put';
		}
		var data = getFormData($('#form-addRoom'));
		$.ajax({
			type : method,
			url : 'room/',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function(d) {
				loadData();
				loadDataRoom();
				modeSubmit = 'insert';
				$('#code, #name, #capacity, #anyProjector, #notes, #officeId')
						.val('');
				//$('#createdBy').val(${sessionScope.id});
				location.reload();
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk delete data office (is_delete == true)
	function deleteOffice() {
		var data = getFormData($('#form-delete'));
		$.ajax({
			type : 'put',
			url : 'office/',
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

	// function untuk delete data room (is_delete == true)
	function deleteRoom() {
		var data = getFormData($('#form-deleteRoom'));
		$.ajax({
			type : 'put',
			url : 'room/',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function(d) {
				loadDeleteRoom();
				modeSubmit = 'update';
				location.reload();
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk load pada saat edit office
	function loadEdit(id) {
		$.ajax({
			type : 'get',
			url : 'office/' + id,
			success : function(d) {
				loadData();
				$('.modal-body #id').val(d.id);
				$('.modal-body #name').val(d.name);
				$('.modal-body #phone').val(d.phone);
				$('.modal-body #email').val(d.email);
				$('.modal-body #address').val(d.address);
				$('.modal-body #notes').val(d.notes);
				$('.modal-body #modifiedOn').val(datetime);
				//$('.modal-body #modifiedBy').val(${sessionScope.id});
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk load pada saat edit room
	function loadEditRoom(id) {
		$.ajax({
			type : 'get',
			url : 'room/' + id,
			success : function(d) {
				loadDataRoom();
				$('.modal-body #id').val(d.id);
				$('.modal-body #code').val(d.code);
				$('.modal-body #name').val(d.name);
				$('.modal-body #capacity').val(d.capacity);
				$('.modal-body #anyProjector').val(d.anyProjector);
				$('.modal-body #notes').val(d.notes);
				$('.modal-body #officeId').val(d.officeId);
				$('.modal-body #modifiedOn').val(datetime);
				//$('.modal-body #modifiedBy').val(${sessionScope.id});
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk load pada saat delete office
	function loadDelete(id) {
		$.ajax({
			type : 'get',
			url : 'office/' + id,
			success : function(d) {
				loadData();
				$('.modal-body #id').val(d.id);
				$('.modal-body #name').val(d.name);
				$('.modal-body #phone').val(d.phone);
				$('.modal-body #email').val(d.email);
				$('.modal-body #address').val(d.address);
				$('.modal-body #notes').val(d.notes);
				$('.modal-body #deleted').val(true);
				$('.modal-body #deletedOn').val(datetime);
				//$('.modal-body #deletedBy').val(${sessionScope.id});
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk load pada saat delete room
	function loadDeleteRoom(id) {
		$.ajax({
			type : 'get',
			url : 'room/' + id,
			success : function(d) {
				loadDataRoom();
				$('.modal-body #id').val(d.id);
				$('.modal-body #code').val(d.code);
				$('.modal-body #name').val(d.name);
				$('.modal-body #capacity').val(d.capacity);
				$('.modal-body #anyProjector').val(d.anyProjector);
				$('.modal-body #notes').val(d.notes);
				$('.modal-body #officeId').val(d.officeId);
				$('.modal-body #deleted').val(true);
				$('.modal-body #deletedOn').val(datetime);
				//$('.modal-body #deletedBy').val(${sessionScope.id});
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk button cancel (reset data form)
	function reset() {
		location = 'office.html';
	}

	$(document).ready(function() {
		loadData();
		loadDataRoom();
		tbOffice = $('#tbOffice').DataTable({
			'searching' : false,
			'lengthChange' : false,
			'lengthMenu' : [ 10 ]
		});
		tbRoom = $('#tbRoom').DataTable();
	});
</script>
</head>

<body>
	<!-- Search Office -->
	<div class="row">
		<div class="col-xs-12">
			<div class="col-xs-5" style="margin-left: 20px">
				<div class="input-group input-group-sm">
					<input type="text" id="search" class="form-control pull-right"
						placeholder="Search by name">
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
	<!-- End Search office -->

	<!-- Modal Add Office -->
	<div class="row">
		<div class="col-xs-6">
			<!-- Modal -->
			<div class="modal fade" id="modalAdd" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
							<h4 class="modal-title">Add Office</h4>
						</div>
						<form id="form-add">
							<div class="modal-body">
								<div class="row">
									<div class="form-group">
										<!-- <input type="hidden" class="form-control" name="createdBy"
												id="createdBy"> -->
										<input type="hidden" class="form-control" name="createdOn"
											id="createdOn">
									</div>
								</div>
								<!-- Row 1 -->
								<div class="row">
									<div class="col-xs-4">
										<div class="form-group">
											<input type="text" class="form-control" name="name" id="name"
												placeholder="Name">
										</div>
									</div>
									<div class="col-xs-4">
										<div class="form-group">
											<input type="text" class="form-control" name="phone"
												id="phone" placeholder="Phone">
										</div>
									</div>
									<div class="col-xs-4">
										<div class="form-group">
											<input type="text" class="form-control" name="email"
												id="email" placeholder="Email">
										</div>
									</div>
								</div>
								<!-- End Row 1 -->
								<!-- Row 2 -->
								<div class="row">
									<div class="col-xs-6">
										<div class="form-group">
											<textarea class="form-control" name="address" id="address"
												placeholder="Address"></textarea>
										</div>
									</div>
									<div class="col-xs-6">
										<div class="form-group">
											<textarea class="form-control" name="notes" id="notes"
												placeholder="Description"></textarea>
										</div>
									</div>
								</div>
								<!-- End Row 2 -->
								<button type="button"
									class="btn btn-default pull-right hidden-xs"
									data-toggle="modal" data-target="#addRoom">
									<b>+</b> Room
								</button>
								<br> <br>
								<hr>
								<!-- Row table office -->
								<div class="row">
									<div class="col-xs-12">
										<table id="tbRoom" class="table table-bordered table-striped">
											<thead>
												<tr>
													<th>Code</th>
													<th>Name</th>
													<th>Capacity</th>
													<th>#</th>
												</tr>
											</thead>
											<tbody></tbody>
										</table>
									</div>
								</div>
								<!-- End row table office -->
							</div>
						</form>
						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal" onclick="reset()">Cancel</button>
							&nbsp;
							<button type="button" class="btn btn-primary" onclick="saveAdd()">Save</button>
						</div>
					</div>
					<!-- End Modal Content -->

				</div>
			</div>
		</div>
	</div>
	<!-- End Modal Add Office -->

	<!-- Show Data Office -->
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body">
					<table id="tbOffice" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Name</th>
								<th>Contact</th>
								<th>#</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- End Show Data Office -->

	<!-- Modal Edit Office -->
	<div class="row">
		<div class="col-xs-6">
			<!-- Modal -->
			<div class="modal fade" id="modalAdd" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">Edit Office</h4>
						</div>
						<form id="form-edit">
							<div class="modal-body">
								<div class="row">
									<div class="form-group">
										<input type="hidden" class="form-control" name="id" id="id">
										<input type="hidden" class="form-control" name="modifiedOn"
											id="modifiedOn">
										<!-- <input type="hidden" class="form-control" name="modifiedBy"
												id="modifiedBy"> -->
									</div>
								</div>
								<!-- Row 1 -->
								<div class="row">
									<div class="col-xs-4">
										<div class="form-group">
											<input type="text" class="form-control" name="name" id="name">
										</div>
									</div>
									<div class="col-xs-4">
										<div class="form-group">
											<input type="text" class="form-control" name="phone"
												id="phone" placeholder="Phone">
										</div>
									</div>
									<div class="col-xs-4">
										<div class="form-group">
											<input type="text" class="form-control" name="email"
												id="email" placeholder="Email">
										</div>
									</div>
								</div>
								<!-- End Row 1 -->
								<!-- Row 2 -->
								<div class="row">
									<div class="col-xs-6">
										<div class="form-group">
											<textarea class="form-control" name="address" id="address"
												placeholder="Address"></textarea>
										</div>
									</div>
									<div class="col-xs-6">
										<div class="form-group">
											<textarea class="form-control" name="description"
												id="description"></textarea>
										</div>
									</div>
								</div>
								<!-- End Row 2 -->
								<!-- End Row 2 -->
								<button type="button"
									class="btn btn-default pull-right hidden-xs"
									data-toggle="modal" data-target="#addRoom">
									<b>+</b> Room
								</button>
								<br> <br>
								<hr>
								<!-- Row table office -->
								<div class="row">
									<div class="col-xs-12">
										<table id="tbRoom" class="table table-bordered table-striped">
											<thead>
												<tr>
													<th>Code</th>
													<th>Name</th>
													<th>Capacity</th>
													<th>#</th>
												</tr>
											</thead>
											<tbody></tbody>
										</table>
									</div>
								</div>
								<!-- End row table office -->
							</div>
						</form>
					</div>
					<!-- End Modal Content -->
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							onclick="reset()">Cancel</button>
						&nbsp;
						<button type="button" class="btn btn-primary" onclick="saveEdit()">Save</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Modal Edit Office -->

	<!-- Modal Add Room -->
	<div class="row">
		<div class="col-xs-6">
			<!-- Modal -->
			<div class="modal fade" id="addRoom" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">Add Room</h4>
						</div>
						<form id="form-addRoom">
							<div class="modal-body">
								<div class="row">
									<div class="col-xs-12">
										<div class="form-group">
											<input type="hidden" class="form-control" name="createOn"
												id="createdOn">
										</div>
										<div class="form-group">
											<!-- <input type="hidden" class="form-control" name="createdBy"
												id="createdBy"> -->
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="id" id="id">
										</div>
										<div class="form-group">
											<input type="text" class="form-control" name="code" id="code"
												placeholder="Code">
										</div>
										<div class="form-group">
											<input type="text" class="form-control" name="name" id="name"
												placeholder="Name">
										</div>
										<div class="form-group">
											<input type="text" class="form-control" name="capacity"
												id="capacity" placeholder="Capacity">
										</div>
										<div class="form-group">
											<div class="input-group">
												<label>Any Projector?</label> &nbsp; <input type="radio"
													name="anyProjector" id="anyProjector" value=true>
												Yes &nbsp; <input type="radio" name="anyProjector"
													id="anyProjector" value=false> No
											</div>
										</div>
										<div class="form-group">
											<textarea class="form-control" name="notes" id="notes"
												placeholder="Description"></textarea>
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="officeId"
												id="officeId">
										</div>
									</div>
								</div>
							</div>
							<!-- End Modal content-->
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal" onclick="reset()">Cancel</button>
								&nbsp;
								<button type="button" class="btn btn-primary"
									onclick="saveAddRoom()">Save</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Modal Add Room -->

	<!-- Modal Edit Room -->
	<div class="row">
		<div class="col-xs-6">
			<!-- Modal -->
			<div class="modal fade" id="editRoom" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">Edit Room</h4>
						</div>
						<form id="form-editRoom">
							<div class="modal-body">
								<div class="row">
									<div class="col-xs-12">
										<div class="form-group">
											<input type="hidden" class="form-control" name="id" id="id">
										</div>
										<div class="form-group">
											<input type="text" class="form-control" name="code" id="code"
												placeholder="Code">
										</div>
										<div class="form-group">
											<input type="text" class="form-control" name="name" id="name"
												placeholder="Name">
										</div>
										<div class="form-group">
											<input type="text" class="form-control" name="capacity"
												id="capacity" placeholder="Capacity">
										</div>
										<div class="form-group">
											<input type="radio" class="form-control" name="anyProjector"
												id="anyProjector" value="yes"> &nbsp; <input
												type="radio" class="form-control" name="anyProjector"
												id="anyProjector" value="no">
										</div>
										<div class="form-group">
											<textarea class="form-control" name="notes" id="notes"
												placeholder="Description"></textarea>
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="officeId"
												id="officeId">
										</div>
										<div class="form-group">
											<!-- <input type="hidden" class="form-control" name="modifiedBy"
												id="modifiedBy"> -->
										</div>
										<div class="form-group">
											<input type="hidden" class="form-control" name="modifiedOn"
												id="modifiedOn">
										</div>
									</div>
								</div>
							</div>
							<!-- End Modal content-->
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal" onclick="reset()">Cancel</button>
								&nbsp;
								<button type="button" class="btn btn-primary"
									onclick="saveEditRoom()">Save</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Modal Edit Room -->

	<!-- Modal Delete Office -->
	<div class="row">
		<div class="col-xs-3">
			<!-- Modal -->
			<div class="modal fade" id="modalDelete" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">Delete Office</h4>
						</div>
						<div class="modal-body">
							<form id="form-delete">
								<div class="row">
									<div class="col-xs-6">
										<div class="form-group"></div>
										<input type="hidden" class="form-control" name="id" id="id">
										<input type="hidden" class="form-control" name="phone"
											id="phone"> <input type="hidden" class="form-control"
											name="email" id="email">
										<textarea class="form-control" name="address" id="address"
											hidden></textarea>
										<textarea class="form-control" name="notes" id="notes" hidden></textarea>
										<input type="hidden" class="form-control" name="deleted"
											id="deleted">
										<!-- <input type="hidden" class="form-control" name="deleteBy" id="deleteBy"> -->
										<input type="hidden" class="form-control" name="deleteOn"
											id="deleteOn">
									</div>
								</div>
							</form>
						</div>
						<p>Are you sure want to delete data?</p>
					</div>
					<!-- End Modal content -->
					<div class="modal-footer">
						<button type="button" class="btn btn-success" data-dismiss="modal"
							onclick="reset()">No</button>
						&nbsp;
						<button type="button" class="btn btn-danger"
							onclick="deleteOffice()">Yes</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Modal Delete Office -->

	<!-- Modal Delete Room -->
	<div class="row">
		<div class="col-xs-3">
			<!-- Modal -->
			<div class="modal fade" id="deleteRoom" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">Delete Office</h4>
						</div>
						<div class="modal-body">
							<form id="form-deleteRoom">
								<div class="row">
									<div class="col-xs-6">
										<div class="form-group">
											<input type="hidden" class="form-control" name="id" id="id">
											<input type="hidden" class="form-control" name="code"
												id="code"> <input type="hidden" class="form-control"
												name="name" id="name"> <input type="hidden"
												class="form-control" name="capacity" id="capacity">
											<input type="hidden" class="form-control" name="anyProjector"
												id="anyProjector">
											<textarea class="form-control" name="notes" id="notes" hidden></textarea>
											<input type="hidden" class="form-control" name="officeId"
												id="officeId"> <input type="hidden"
												class="form-control" name="deleted" id="deleted">
											<!-- <input type="hidden" class="form-control" name="deleteBy" id="deleteBy"> -->
											<input type="hidden" class="form-control" name="deleteOn"
												id="deleteOn">
										</div>
									</div>
								</div>
							</form>
						</div>
						<p>Are you sure want to delete data?</p>
					</div>
					<!-- End Modal content -->
					<div class="modal-footer">
						<button type="button" class="btn btn-success" data-dismiss="modal"
							onclick="reset()">No</button>
						&nbsp;
						<button type="button" class="btn btn-danger"
							onclick="deleteRoom()">Yes</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<!-- End Modal Delete Room -->
</body>