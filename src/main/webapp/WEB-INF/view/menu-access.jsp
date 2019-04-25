<title>Menu Access</title>

<head>
<script>
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
				var s = '<option value="defRole">Choose Role</option>';

				$(d).each(function(index, element) {
					s += '<option value="' + element.id + '" data-nama="' + element.name + '">'
						+ element.name + '</option>';
				});
				$('#roleId').html(s);
				$('#search').html(s);
			}
		});
	}


	// function untuk show data dropdown menu
	function showMenu() {
		$.ajax({
			type : 'get',
			url : 'menu/',
			success : function(d) {
				var s = '<option value="defMenu">Choose Menu</option>';

				$(d).each(function(index, element) {
					s += '<option value="' + element.id + '" data-nama="' + element.title + '">'
						+ element.title + '</option>';
				});
				$('#menuId').html(s);
			}
		});
	}

	// function untuk show data menu access
	function showMenuAccess() {
		$("#menuId option[value='defMenu']").prop('selected', true);
		$("#roleId option[value='defRole']").prop('selected', true);
		$.ajax({
			type : 'get',
			url : 'menu-access/',
			
			success : function(d) {
				tbMenuAccess.clear().draw();
				$(d).each(function(index, element) {
					tbMenuAccess.row.add([
						element.role.name,
						element.menu.title,
						'<div class="dropdown"><button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">'
						+ '<i class="fa fa-bars"></i></button><ul class="dropdown-menu">'
						+ '<li><a href="javascript:void(0)" onclick="deleteMenuAccess('
						+ element.id
						+ ')">Delete</a></li>'
						+ '</ul></div>',
						element.id ])
					.draw();
				});
			},
		});
	}

	// function untuk search data menu access
	function searchMenuAccess() {
		$("#menuId option[value='defMenu']").prop('selected', true);
		$("#roleId option[value='defRole']").prop('selected', true);
		$.ajax({
			type : 'get',
			url : 'menu-access/search/',
			data : {
				roleId : parseInt($('#search').val())
			},
			success : function(d) {
				tbMenuAccess.clear().draw();
				$(d).each(function(index, element) {
					tbMenuAccess.row.add([
						element.role.name,
						element.menu.title,
						'<div class="dropdown"><button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">'
						+ '<i class="fa fa-bars"></i></button><ul class="dropdown-menu">'
						+ '<li><a href="javascript:void(0)" onclick="deleteMenuAccess('
						+ element.id
						+ ')">Delete</a></li>'
						+ '</ul></div>',
						element.id ])
					.draw();
				});
			},
		});
	}

	// function untuk load data menu access
	function loadMenuAccess(id) {
		$.ajax({
			type : 'get',
			url : 'menu-access/' + id,
			success : function(d) {
				$('#form-room input[name=id]').val(d.id);
				$('select[name=roleId]').val(d.roleId);
				$('select[name=menuId]').val(d.menuId);
				$('#form-access-menu').trigger('reset');
			},
			error : function(d) {
				console.log('Error!');
			}
		});
	}

	// function untuk save data menu access
	function saveMenuAccess() {
		$("#menuId option[value='defMenu']").prop('selected', true);
		$("#roleId option[value='defRole']").prop('selected', true);
		var unindexed_data = $('#form-menu-access').serializeArray();
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

		$.ajax({
			type : method,
			url : 'menu-access/',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function(d) {
				showMenuAccess();
			},
			error : function(d) {
				console.log('Error');
			}
		});
	}

	// function untuk delete data menu access
	function deleteMenuAccess(id) {
		if (confirm("Are you sure to delete this data?")) {
			$.ajax({
				type : 'DELETE',
				url : 'menu-access/' + id,
				success : function(d) {
					showMenuAccess();
				},
				error : function(d) {
					console.log('Error');
				}
			});
		}
	}

	// function reset
	function reset() {
		location = "menu-access.html";
	}
	
	$(document).ready(function() {
		showRole();
		showMenu();
		showMenuAccess();
		searchMenuAccess();
		tbMenuAccess = $('#tbMenuAccess').DataTable({
			'searching' : false,
			'lengthChange' : false,
			'lengthMenu' : [ 10 ]
		});
	});
</script>
</head>

<body>
	<div class="box">
		<div class="box-body">
			<!-- Form Add Menu Access -->
			<form id="form-menu-access">
				<div class="row">
					<div class="col-xs-12">
						<div class="col-xs-6">
							<div class="form-group">
								<input type="hidden" class="form-control" name="id" id="id">
								<select class="custom-select d-block w-100 form-control" id="roleId"
									name="roleId"></select>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="form-group">
								<select class="custom-select d-block w-100 form-control" id="menuId"
									name="menuId"></select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">	
					<div class="col-xs-12">
						<div class="form-group pull-right" style="margin-right:20px">	
							<button type="button" class="btn btn-default" onclick="reset()">Cancel</button>
							&nbsp;
							<button type="button" class="btn btn-primary" onclick="saveMenuAccess()">Save</button>	
						</div>
					</div>
				</div>
			</form>
			<!-- End Form Add Menu Access -->
			<hr>
			<br>
			
			<!-- Show Data Menu Access -->
			<div class="row">
				<div class="col-xs-6">
					<div class="input-group input-group-md">
						<select class="custom-select d-block w-100 form-control" id="search"
							name="roleId"></select>
						<div class="input-group-btn">
							<button type="button" class="btn btn-default" onclick="searchMenuAccess()">
								<i class="fa fa-search"></i>
							</button>
						</div>
					</div>
				</div>
			</div>
			<br>
			
			<div class="row">
				<div class="col-xs-12">
					<table id="tbMenuAccess" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Role</th>
								<th>Menu</th>
								<th>#</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
			</div>
			<!-- End Show Data Menu Access -->
		</div>
	</div>
</body>