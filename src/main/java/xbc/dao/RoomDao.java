package xbc.dao;

import java.util.Collection;

import xbc.model.Room;

public interface RoomDao {
	public Room findOne(int id);

	public Collection<Room> findAll();
	
	public void save(Room room);

	public Room update(Room room);

	public void delete(Room room);

	public void deleteById(String id);
}