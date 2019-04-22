package xbc.web;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import xbc.model.Office;
import xbc.model.Role;
import xbc.service.RoleService;

@RestController
@RequestMapping("secure/role")
public class RoleController {

	@Autowired
	private RoleService roleService;

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Role> findOne(@PathVariable("id") int id) {
		Role role = roleService.findOne(id);

		ResponseEntity<Role> result = new ResponseEntity<>(role, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ResponseEntity<Collection<Role>> findAll() {
		Collection<Role> list = roleService.findAll();

		ResponseEntity<Collection<Role>> result = new ResponseEntity<>(list, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/search/", method = RequestMethod.GET)
	public ResponseEntity<Collection<Role>> search(@RequestParam(value = "rolename") String name) {
		Collection<Role> list = roleService.search(name);

		ResponseEntity<Collection<Role>> result = new ResponseEntity<>(list, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.POST)
	public ResponseEntity<Role> save(@RequestBody Role role) {
		roleService.save(role);

		ResponseEntity<Role> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.PUT)
	public ResponseEntity<Role> update(@RequestBody Role role) {
		roleService.update(role);

		ResponseEntity<Role> result = new ResponseEntity<>(HttpStatus.OK);
		return result;

	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<Role> deleteDisabled(@PathVariable("id") int id) {
		roleService.deleteDisabled(id);

		ResponseEntity<Role> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}
}