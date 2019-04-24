package xbc.service;

import java.util.Collection;

import xbc.model.User;

public interface UserService {
	public User findOne(Integer id);

	public Collection<User> findAll();
	
	public Integer save(User user, Integer sessionId);

	public User update(User user, Integer sessionId);

	public void delete(User user);

	public void deleteById(String id);

	public Collection<User> search(String find);
	
	public User findByUsername(String username);
	
	public Collection<User> findByEmail(String email);
	
	public User deleteDisabled(Integer id, Integer sessionId);
}