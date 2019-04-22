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

import xbc.model.Office;
import xbc.service.OfficeService;

@RestController
@RequestMapping("secure/office")
public class OfficeController {

	@Autowired
	private OfficeService officeService;

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Office> findOne(@PathVariable("id") int id) {
		Office office = officeService.findOne(id);

		ResponseEntity<Office> result = new ResponseEntity<>(office, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ResponseEntity<Collection<Office>> findAll() {
		Collection<Office> list = officeService.findAll();

		ResponseEntity<Collection<Office>> result = new ResponseEntity<>(list, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/search/", method = RequestMethod.GET)
	public ResponseEntity<Collection<Office>> search(@RequestParam(value = "name") String name) {
		Collection<Office> list = officeService.search(name);

		ResponseEntity<Collection<Office>> result = new ResponseEntity<>(list, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.POST)
	public ResponseEntity<Office> save(@RequestBody Office office, HttpSession session) {
		officeService.save(office, (int) session.getAttribute("sessionId"));

		ResponseEntity<Office> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.PUT)
	public ResponseEntity<Office> update(@RequestBody Office office, HttpSession session) {
		officeService.update(office, (int) session.getAttribute("sessionId"));

		ResponseEntity<Office> result = new ResponseEntity<>(HttpStatus.OK);
		return result;

	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<Office> deleteDisabled(@PathVariable("id") int id, HttpSession session) {
		officeService.deleteDisabled(id, (int) session.getAttribute("sessionId"));

		ResponseEntity<Office> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}

}