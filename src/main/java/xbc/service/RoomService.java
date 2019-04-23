package xbc.service;

import java.util.Collection;

import xbc.model.Room;

public interface RoomService {
	public Room findOne(Integer id);

	public Collection<Room> findAll();
	
	public void save(Room room, Integer sessionId);

	public Room update(Room room, Integer sessionId);

	public void delete(Room room);

	public void deleteById(String id);
	
	public Room deleteDisabled(Integer id, Integer sessionId);
}