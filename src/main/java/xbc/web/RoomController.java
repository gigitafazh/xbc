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

import xbc.model.Room;
import xbc.service.RoomService;

@RestController
@RequestMapping("secure/room")
public class RoomController {

	@Autowired
	private RoomService roomService;

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Room> findOne(@PathVariable("id") Integer id) {
		Room room = roomService.findOne(id);

		ResponseEntity<Room> result = new ResponseEntity<>(room, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/office-id/{id}", method = RequestMethod.GET)
	public ResponseEntity<Collection<Room>> findAll(@PathVariable("id") Integer id) {
		Collection<Room> list = roomService.findAll(id);

		ResponseEntity<Collection<Room>> result = new ResponseEntity<>(list, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.POST)
	public ResponseEntity<Room> save(@RequestBody Room room, HttpSession session) {
		roomService.save(room, (Integer) session.getAttribute("sessionId"));

		ResponseEntity<Room> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.PUT)
	public ResponseEntity<Room> update(@RequestBody Room room, HttpSession session) {
		roomService.update(room, (Integer) session.getAttribute("sessionId"));

		ResponseEntity<Room> result = new ResponseEntity<>(HttpStatus.OK);
		return result;

	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<Room> deleteDisabled(@PathVariable("id") Integer id, HttpSession session) {
		roomService.deleteDisabled(id, (Integer) session.getAttribute("sessionId"));

		ResponseEntity<Room> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}
}