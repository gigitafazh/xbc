package xbc.dao;

import java.util.Collection;

import xbc.model.Menu;

public interface MenuDao {
	public Menu findOne(int id);

	public Collection<Menu> findAll();
	
	public void save(Menu menu);

	public Menu update(Menu menu);

	public void delete(Menu menu);

	public void deleteById(String id);
	
	public Collection<Menu> search(String title);
}