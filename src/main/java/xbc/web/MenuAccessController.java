package xbc.web;

import java.util.Collection;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import xbc.model.MenuAccess;
import xbc.service.MenuAccessService;

@RestController
@RequestMapping("secure/menu-access")
public class MenuAccessController {

	@Autowired
	private MenuAccessService menuAccessService;

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<MenuAccess> findOne(@PathVariable("id") Integer id) {
		MenuAccess menuAccess = menuAccessService.findOne(id);

		ResponseEntity<MenuAccess> result = new ResponseEntity<>(menuAccess, HttpStatus.OK);
		return result;
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ResponseEntity<Collection<MenuAccess>> findAll() {
		Collection<MenuAccess> list = menuAccessService.findAll();

		ResponseEntity<Collection<MenuAccess>> result = new ResponseEntity<>(list, HttpStatus.OK);
		return result;
	}
	
	@RequestMapping(value = "/search/", method = RequestMethod.GET)
	public ResponseEntity<Collection<MenuAccess>> search(@RequestParam(value = "roleId") Integer roleId) {
		Collection<MenuAccess> list = menuAccessService.search(roleId);

		ResponseEntity<Collection<MenuAccess>> result = new ResponseEntity<>(list, HttpStatus.OK);
		return result;
	}
	
	@RequestMapping(value = "/", method = RequestMethod.POST)
	public ResponseEntity<MenuAccess> save(@RequestBody MenuAccess menuAccess, HttpSession session) {
		menuAccessService.save(menuAccess, (Integer) session.getAttribute("sessionId"));

		ResponseEntity<MenuAccess> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.PUT)
	public ResponseEntity<MenuAccess> update(@RequestBody MenuAccess menuAccess, HttpSession session) {
		menuAccessService.update(menuAccess, (Integer) session.getAttribute("sessionId"));

		ResponseEntity<MenuAccess> result = new ResponseEntity<>(HttpStatus.OK);
		return result;

	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<MenuAccess> deleteById(@PathVariable("id") Integer id) {
		menuAccessService.deleteById(id);

		ResponseEntity<MenuAccess> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}
}