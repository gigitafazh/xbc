package xbc.service;

import java.util.Collection;

import xbc.model.User;

public interface UserService {
	public User findOne(int id);

	public Collection<User> findAll();
	
	public void save(User user, int id);

	public User update(User user, int id);

	public void delete(User user);

	public void deleteById(String id);

	public Collection<User> search(String find);
	
	public User deleteDisabled(User user);

	public User findByUsername(String name);
}