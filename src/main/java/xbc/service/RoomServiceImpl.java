package xbc.service;

import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xbc.dao.RoomDao;
import xbc.model.Room;

@Service
@Transactional
public class RoomServiceImpl implements RoomService {
	@Autowired
	private RoomDao roomDao;

	@Override
	public Room findOne(int id) {
		return roomDao.findOne(id);
	}

	@Override
	public Collection<Room> findAll() {
		return roomDao.findAll();
	}
	
	@Override
	public void save(Room room) {
		room.setCreatedBy(0);
		room.setCreatedOn(new Date());
		room.setDeleted(false);
		room.setOfficeId(room.getOfficeId());
		roomDao.save(room);
	}

	@Override
	public Room update(Room newRoom) {
		Room room = roomDao.findOne(newRoom.getId());
		room.setCode(newRoom.getCode());
		room.setName(newRoom.getName());
		room.setCapacity(newRoom.getCapacity());
		room.setAnyProjector(newRoom.isAnyProjector());
		room.setNotes(newRoom.getNotes());
		room.setModifiedBy(0);
		room.setModifiedOn(new Date());
		room.setOfficeId(newRoom.getOfficeId());
		return roomDao.update(room);
	}

	@Override
	public void delete(Room room) {
		roomDao.delete(room);
	}

	@Override
	public void deleteById(String id) {
		roomDao.deleteById(id);
	}

	@Override
	public Room deleteDisabled(int id) {
		Room room = roomDao.findOne(id);
		room.setDeletedBy(0);
		room.setDeletedOn(new Date());
		room.setDeleted(true);
		return roomDao.update(room);
	}
}