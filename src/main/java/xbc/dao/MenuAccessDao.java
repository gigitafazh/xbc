package xbc.dao;

import java.util.Collection;

import xbc.model.MenuAccess;

public interface MenuAccessDao {
	public MenuAccess findOne(int id);

	public Collection<MenuAccess> findAll();

	public MenuAccess update(MenuAccess menuAccess);

	public void delete(MenuAccess menuAccess);

	public void deleteById(int id);

	public void save(MenuAccess menuAccess);
	
	public Collection<MenuAccess> search(int roleId);
}