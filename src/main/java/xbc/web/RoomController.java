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

import xbc.model.Room;
import xbc.service.RoomService;

@RestController
@RequestMapping("/room")
public class RoomController {

	@Autowired
	private RoomService roomService;

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Room> findOne(@PathVariable("id") int id) {
		Room room = roomService.findOne(id);

		ResponseEntity<Room> result = new ResponseEntity<>(room, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ResponseEntity<Collection<Room>> findAll() {
		Collection<Room> list = roomService.findAll();

		ResponseEntity<Collection<Room>> result = new ResponseEntity<>(list, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.POST)
	public ResponseEntity<Room> save(@RequestBody Room room) {
		roomService.save(room);

		ResponseEntity<Room> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}

	@RequestMapping(value = "/", method = RequestMethod.PUT)
	public ResponseEntity<Room> update(@RequestBody Room room) {
		roomService.update(room);

		ResponseEntity<Room> result = new ResponseEntity<>(HttpStatus.OK);
		return result;

	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<Room> deleteDisabled(@PathVariable("id") int id) {
		roomService.deleteDisabled(id);

		ResponseEntity<Room> result = new ResponseEntity<>(HttpStatus.OK);
		return result;
	}
}