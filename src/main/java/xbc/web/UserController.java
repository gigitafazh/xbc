package xbc.web;

import java.util.Collection;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import xbc.model.User;
import xbc.service.UserService;

@RestController
@RequestMapping("secure/user")
public class UserController {

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<User> findOne(@PathVariable("id") int id) {
		User user = userService.findOne(id);

		ResponseEntity<User> result = new ResponseEntity<>(user, HttpStatus.OK);
		return result;
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ResponseEntity<Collection<User>> findAll() {
		Collection<User> list = userService.findAll();

		ResponseEntity<Collection<User>> result = new ResponseEntity<>(list, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/search/", method = RequestMethod.GET)
	public ResponseEntity<Collection<User>> search(@RequestParam(value = "find") String find) {
		Collection<User> list = userService.search(find);

		ResponseEntity<Collection<User>> result = new ResponseEntity<>(list, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.POST)
	public ResponseEntity<User> save(@RequestBody User user, HttpSession session) {
		userService.save(user, (int) session.getAttribute("sessionId"));

		ResponseEntity<User> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.PUT)
	public ResponseEntity<User> update(@RequestBody User user, HttpSession session) {
		userService.update(user, (int) session.getAttribute("sessionId"));

		ResponseEntity<User> result = new ResponseEntity<>(HttpStatus.OK);
		return result;

	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<User> deleteDisabled(@PathVariable("id") int id, HttpSession session) {
		userService.deleteDisabled(id, (int) session.getAttribute("sessionId"));

		ResponseEntity<User> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}
}