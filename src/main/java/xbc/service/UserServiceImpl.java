package xbc.service;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xbc.dao.UserDao;
import xbc.model.User;

@Service
@Transactional
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;

	@Override
	public User findOne(int id) {
		return userDao.findOne(id);
	}

	@Override
	public Collection<User> findAll() {
		return userDao.findAll();
	}
	
	@Override
	public void save(User user, int sessionId) {
		user.setCreatedBy(sessionId);
		userDao.save(user);
	}

	@Override
	public User update(User user, int sessionId) {
		user.setModifiedBy(sessionId);
		return userDao.update(user);
	}

	@Override
	public void delete(User user) {
		userDao.delete(user);
	}

	@Override
	public void deleteById(String id) {
		userDao.deleteById(id);
	}

	@Override
	public Collection<User> search(String find) {
		return userDao.search(find);
	}
	
	@Override
	public User deleteDisabled(User user) {
		return userDao.deleteDisabled(user);
	}

	@Override
	public User findByUsername(String username) {
		return userDao.findByUsername(username);
	}
}