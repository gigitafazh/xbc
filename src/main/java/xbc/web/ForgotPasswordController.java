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
//@PreAuthorize("hasAnyAuthority('user', 'admin')")
@RequestMapping("forgot-password")
public class ForgotPasswordController {

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<User> findOne(@PathVariable("id") Integer id) {
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
	public Integer save(@RequestBody User user, HttpSession session) {
		Integer result =  userService.save(user, (Integer) session.getAttribute("sessionId"));

		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.PUT)
	public ResponseEntity<User> update(@RequestBody User user, HttpSession session) {
		userService.update(user, (Integer) session.getAttribute("sessionId"));

		ResponseEntity<User> result = new ResponseEntity<>(HttpStatus.OK);
		return result;

	}
	
	@RequestMapping(value = "/change/", method = RequestMethod.PUT)
	public ResponseEntity<User> forgotPassword(@RequestBody User user) {
		User usr = userService.email(user.getEmail());
		
		usr.setPassword(user.getPassword());
		userService.update(usr, usr.getId());
		
		ResponseEntity<User> result = new ResponseEntity<>(HttpStatus.OK);
		return result;

	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<User> deleteDisabled(@PathVariable("id") Integer id, HttpSession session) {
		userService.deleteDisabled(id, (Integer) session.getAttribute("sessionId"));

		ResponseEntity<User> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}
}