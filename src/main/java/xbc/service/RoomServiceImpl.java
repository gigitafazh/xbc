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
	
	@Autowired
	private AuditLogService auditLogService;

	@Override
	public Room findOne(Integer id) {
		return roomDao.findOne(id);
	}

	@Override
	public Collection<Room> findAll() {
		return roomDao.findAll();
	}
	
	@Override
	public void save(Room room, Integer sessionId) {
		room.setCreatedBy(sessionId);
		room.setCreatedOn(new Date());
		room.setDelete(false);
		room.setOfficeId(room.getOfficeId());
		roomDao.save(room);
		
		auditLogService.logInsert(auditLogService.objectToJsonString(room), sessionId);
	}

	@Override
	public Room update(Room newRoom, Integer sessionId) {
		Room room = roomDao.findOne(newRoom.getId());
		
		String jsonBefore = auditLogService.objectToJsonString(room);
		
		room.setCode(newRoom.getCode());
		room.setName(newRoom.getName());
		room.setCapacity(newRoom.getCapacity());
		room.setAnyProjector(newRoom.isAnyProjector());
		room.setNotes(newRoom.getNotes());
		room.setModifiedBy(sessionId);
		room.setModifiedOn(new Date());
		room.setOfficeId(newRoom.getOfficeId());
		
		String jsonAfter = auditLogService.objectToJsonString(room);
		auditLogService.logUpdate(jsonBefore, jsonAfter, sessionId);
		
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
	public Room deleteDisabled(Integer id, Integer sessionId) {
		Room room = roomDao.findOne(id);
		room.setDeletedBy(sessionId);
		room.setDeletedOn(new Date());
		room.setDelete(true);
		
		auditLogService.logDelete(auditLogService.objectToJsonString(room), sessionId);
		
		return roomDao.update(room);
	}
}