package xbc.dao;

import java.util.Collection;

import xbc.model.Role;

public interface RoleDao {
	public Role findOne(int id);

	public Collection<Role> findAll();

	public void save(Role role);
	
	public Role update(Role role);

	public void delete(Role role);

	public void deleteById(int id);
	
	public Collection<Role> search(String name);
}