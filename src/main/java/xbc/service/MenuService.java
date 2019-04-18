package xbc.service;

import java.util.Collection;

import xbc.model.Menu;
import xbc.model.Office;

public interface MenuService {
	public Menu findOne(int id);

	public Collection<Menu> findAll();
	
	public void save(Menu menu);

	public Menu update(Menu menu);

	public void delete(Menu menu);

	public void deleteById(String id);

	public Collection<Menu> search(String title);
	
	public Menu deleteDisabled(int id);
}