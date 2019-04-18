package xbc.service;

import java.util.Collection;

import xbc.model.MenuAccess;

public interface MenuAccessService {
	public MenuAccess findOne(int id);

	public Collection<MenuAccess> findAll();
	
	public void save(MenuAccess menuAccess);

	public MenuAccess update(MenuAccess menuAccess);

	public void delete(MenuAccess menuAccess);

	public void deleteById(int id);

	public Collection<MenuAccess> search(int roleId);
}