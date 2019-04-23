package xbc.service;

import java.util.Collection;

import xbc.model.MenuAccess;

public interface MenuAccessService {
	public MenuAccess findOne(Integer id);

	public Collection<MenuAccess> findAll();
	
	public void save(MenuAccess menuAccess, Integer sessionId);

	public MenuAccess update(MenuAccess menuAccess, Integer sessionId);

	public void delete(MenuAccess menuAccess);

	public void deleteById(Integer id);

	public Collection<MenuAccess> search(Integer roleId);
}