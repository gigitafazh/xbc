<title>Office</title>

<head>
<script>
	var tbOffice;
	var tbRoom;

	function getFormData($form) {
		var unindexed_array = $form.serializeArray();
		var indexed_array = {};
		$.map(unindexed_array, function(n, i) {
			indexed_array[n['name']] = n['value'];
		});
		return indexed_array;
	}

	// function untuk show data office
	function showOffice() {
		$.ajax({
			type : 'get',
			url : 'office/',
			success : function(d) {
				tbOffice.clear().draw();
				$(d).each(function(index, element) {
					tbOffice.row.add([
						element.name,
						element.phone,
						'<div class="dropdown"><button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">'
						+ '<i class="fa fa-bars"></i></button><ul class="dropdown-menu">'
						+ '<li><a href="javascript:void(0)" onclick="loadOffice('
						+ element.id
						+ ')">Edit</a></li>'
						+ '<li><a href="javascript:void(0)" onclick="deleteOffice('
						+ element.id
						+ ')">Delete</a></li>'
						+ '</ul></div>',
						element.email,
						element.address,
						element.notes,
						element.id 
					]).draw();
					$('#officeId').val(element.id);
				});
			}
		});
	}

	// function untuk search data office
	function searchOffice() {
		$.ajax({
			type : 'get',
			url : 'office/search/',
			data : {
				name : $('#search').val()
			},
			success : function(d) {
				tbOffice.clear().draw();
				$(d).each(function(index, element) {
					tbOffice.row.add([
						element.name,
						element.phone,
						'<div class="dropdown"><button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">'
						+ '<i class="fa fa-bars"></i></button><ul class="dropdown-menu">'
						+ '<li><a href="javascript:void(0)" onclick="loadOffice('
						+ element.id
						+ ')">Edit</a></li>'
						+ '<li><a href="javascript:void(0)" onclick="deleteOffice('
						+ element.id
						+ ')">Delete</a></li>'
						+ '</ul></div>',
						element.email,
						element.address,
						element.notes,
						element.id 
					]).draw();
				});
				$('#officeId').val(element.id);
			}
		});
	}

	// function untuk load data office
	function loadOffice(id) {
		if (id == null) {
			$('#form-office').trigger('reset');
		} else {
			$.ajax({
				type : 'get',
				url : 'office/' + id,
				success : function(d) {
					$('#form-office input[name=id]').val(d.id);
					$('input[name=name]').val(d.name);
					$('input[name=phone]').val(d.phone);
					$('input[name=email]').val(d.email);
					$('textarea[name=address]').val(d.address);
					$('textarea[name=notes]').val(d.notes);
				},
				error : function(d) {
					console.log('Error!');
				}
			});
		}
		$('#modal-office').modal('show');
	}

	// function untuk show data room
	function showRoom() {
		$.ajax({
			type : 'get',
			url : 'room/',
			success : function(d) {
				tbRoom.clear().draw();
				$(d).each(function(index, element) {
					tbRoom.row.add([
						element.code,
						element.name,
						element.capacity,
						'<div class="dropdown"><button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">'
						+ '<i class="fa fa-bars"></i></button><ul class="dropdown-menu">'
						+ '<li><a href="javascript:void(0)" onclick="loadRoom('
						+ element.id
						+ ')">Edit</a></li>'
						+ '<li><a href="javascript:void(0)" onclick="deleteRoom('
						+ element.id
						+ ')">Delete</a></li>'
						+ '</ul></div>',
						element.anyProjector,
						element.notes,
						element.officeId,
						element.id
					]).draw();
				});
			}
		});
	}

	// function untuk load data room
	function loadRoom(id) {
		if (id == null) {
			$('#form-room').trigger('reset');
		} else {
			$.ajax({
				type : 'get',
				url : 'room/' + id,
				success : function(d) {
					$('#form-room input[name=id]').val(d.id);
					$('input[name=code]').val(d.code);
					$('input[name=capacity]').val(d.capacity);
					$('input[name=anyProjector]').val(d.anyProjector);
					$('textarea[name=notes]').val(d.notes);
					$('input[name=officeId]').val(d.officeId);
				},
				error : function(d) {
					console.log('Error!');
				}
			});
		}
		$('#modal-room').modal('show');
	}

	// function untuk save data office
	function saveOffice() {
		var unindexed_data = $('#form-office').serializeArray();
		var data = {};
		$.map(unindexed_data, function(n, i) {
			data[n['name']] = n['value'];
		});

		var method;
		if (data.id == '') {
			method = 'POST';
		} else {
			method = 'PUT';
		}

		if ($('#name').val().trim().length == 0 || $('#phone').val().trim().length == 0 || $('#email').val().trim().length == 0 || $('#address').val().trim().length == 0 || $('#notes').val().trim().length == 0) {
			if ($('#name').val().trim().length == 0) {
				$('#name').notify("Data tidak boleh kosong!", "error", {position: "right"});
			}
			if ($('#phone').val().trim().length == 0) {
				$('#phone').notify("Data tidak boleh kosong!", "error", {position: "right"});
			}
			if ($('#email').val().trim().length == 0) {
				$('#email').notify("Data tidak boleh kosong!", "error", {position: "right"});
			}
			if ($('#address').val().trim().length == 0) {
				$('#address').notify("Data tidak boleh kosong!", "error", {position: "right"});
			}
			if ($('#notes').val().trim().length == 0) {
				$('#notes').notify("Data tidak boleh kosong!", "error", {position: "right"});
			}
		} else {
			$.ajax({
				type : method,
				url : 'office/',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success : function(d) {
					showOffice();
					$('#modal-office').modal('hide');
				},
				error : function(d) {
					console.log('Error');
				}
			});
		}
	}

	// function untuk save data room
	function saveRoom() {
		var unindexed_data = $('#form-room').serializeArray();
		var data = {};
		$.map(unindexed_data, function(n, i) {
			data[n['name']] = n['value'];
		});

		var method;
		if (data.id == '') {
			method = 'POST';
		} else {
			method = 'PUT';
		}

		if ($('#code').val().trim().length == 0 || $('#name').val().trim().length == 0 || $('#capacity').val().trim().length == 0 || $('#anyProjector').val().trim().length == 0 || $('#notes').val().trim().length == 0) {
			if ($('#code').val().trim().length == 0) {
				$('#code').notify("Data tidak boleh kosong!", "error", {position: "right"});
			}
			if ($('#name').val().trim().length == 0) {
				$('#name').notify("Data tidak boleh kosong!", "error", {position: "right"});
			}
			if ($('#capacity').val().trim().length == 0) {
				$('#capacity').notify("Data tidak boleh kosong!", "error", {position: "right"});
			}
			if ($('#anyProjector').val().trim().length == 0) {
				$('#anyProjector').notify("Data tidak boleh kosong!", "error", {position: "right"});
			}
			if ($('#notes').val().trim().length == 0) {
				$('#notes').notify("Data tidak boleh kosong!", "error", {position: "right"});
			}
		} else {
			$.ajax({
				type : method,
				url : 'room/',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success : function(d) {
					showRoom();
					$('#modal-room').modal('hide');
				},
				error : function(d) {
					console.log('Error');
				}
			});
		}
	}

	// function untuk delete data office
	function deleteOffice(id) {
		if (confirm("Are you sure to delete this data?")) {
			$.ajax({
				type : 'DELETE',
				url : 'office/' + id,
				success : function(d) {
					showOffice();
				},
				error : function(d) {
					console.log('Error');
				}
			});
		}
	}

	// function untuk delete data room
	function deleteRoom(id) {
		if (confirm("Are you sure to delete this data?")) {
			$.ajax({
				type : 'DELETE',
				url : 'room/' + id,
				success : function(d) {
					showRoom();
				},
				error : function(d) {
					console.log('Error');
				}
			});
		}
	}

	$(document).ready(function() {
		showOffice();
		showRoom();
		tbOffice = $('#tbOffice').DataTable({
			'searching' : false,
			'lengthChange' : false,
			'lengthMenu' : [ 10 ]
		});
		tbRoom = $('#tbRoom').DataTable({
			'searching' : false,
			'lengthChange' : false,
			'lengthMenu' : [ 10 ]
		});
	});
</script>
</head>

<body>
	<!-- Search Office -->
	<div class="row">
		<div class="col-xs-12">
			<div class="col-xs-5" style="margin-left: 20px">
				<div class="input-group input-group-sm">
					<input type="text" name="name" id="search" class="form-control pull-right"
						placeholder="Search by name">
					<div class="input-group-btn">
						<button type="button" class="btn btn-default"
							onclick="searchOffice()">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="col-xs-5">
				<button type="button" class="btn btn-default pull-right hidden-xs"
					data-toggle="modal" onclick="loadOffice()"
					style="width: 30px; height: 30px; padding: 0px 0px">
					<i class="fa fa-plus" style="font-size: 20px"></i>
				</button>
			</div>
		</div>
	</div>
	<br>
	<!-- End Search office -->

	<!-- Modal Form Office -->
	<div class="row">
		<div class="col-xs-6">
			<!-- Modal -->
			<div class="modal fade" id="modal-office" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
							<h4 class="modal-title">Office</h4>
						</div>
						<form id="form-office">
							<div class="modal-body">
								<!-- Row 1 -->
								<div class="row">
									<div class="col-xs-4">
										<div class="form-group">
											<input type="text" class="form-control" name="name" id="name"
												placeholder="Name"> <input type="hidden"
												class="form-control" name="id" id="id">
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
									data-toggle="modal" onclick="loadRoom()">
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
								data-dismiss="modal">Cancel</button>
							&nbsp;
							<button type="button" class="btn btn-primary"
								onclick="saveOffice()">Save</button>
						</div>
					</div>
					<!-- End Modal Content -->

				</div>
			</div>
		</div>
	</div>
	<!-- End Modal Form Office -->

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

	<!-- Modal Form Room -->
	<div class="row">
		<div class="col-xs-6">
			<!-- Modal -->
			<div class="modal fade" id="modal-room" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">Room</h4>
						</div>
						<form id="form-room">
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
									data-dismiss="modal">Cancel</button>
								&nbsp;
								<button type="button" class="btn btn-primary"
									onclick="saveRoom()">Save</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Modal Form Room -->

</body>