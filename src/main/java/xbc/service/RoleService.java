package xbc.service;

import java.util.Collection;

import xbc.model.Role;

public interface RoleService {
	public Role findOne(Integer id);

	public Collection<Role> findAll();

	public void save(Role role, Integer sessionId);
	
	public Role update(Role role, Integer sessionId);

	public void delete(Role role);

	public void deleteById(Integer id);

	public Collection<Role> search(String name);
	
	public Role deleteDisabled(Integer id, Integer sessionId);
}