package xbc.service;

import java.util.Collection;

import xbc.model.Menu;
import xbc.model.Office;

public interface MenuService {
	public Menu findOne(Integer id);

	public Collection<Menu> findAll();
	
	public void save(Menu menu, Integer sessionId);

	public Menu update(Menu menu, Integer sessionId);

	public void delete(Menu menu);

	public void deleteById(String id);

	public Collection<Menu> search(String title);
	
	public Menu deleteDisabled(Integer id, Integer sessionId);
}