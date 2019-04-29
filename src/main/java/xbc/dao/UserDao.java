package xbc.dao;

import java.util.Collection;

import xbc.model.User;

public interface UserDao {
	public User findOne(Integer id);

	public Collection<User> findAll();

	public void save(User user);
	
	public User update(User user);

	public void delete(User user);

	public void deleteById(String id);
	
	public Collection<User> search(String find);
	
	public User email(String email);
	
	public User username(String username);
	
	public Collection<User> findByEmail(String email, Integer id);
	
	public Collection<User> findByUsername(String username, Integer id);
}