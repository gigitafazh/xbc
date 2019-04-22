package xbc.service;

import java.util.Collection;
import java.util.Date;

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
		user.setCreatedOn(new Date());
		user.setCreatedBy(sessionId);
		user.setDeleted(false);
		userDao.save(user);
	}

	@Override
	public User update(User newUser, int sessionId) {
		User user = userDao.findOne(newUser.getId());
		user.setUsername(newUser.getUsername());
		user.setEmail(newUser.getEmail());
		user.setRole(newUser.getRole());
		user.setPassword(newUser.getPassword());
		user.setMobileFlag(newUser.isMobileFlag());
		user.setMobileToken(newUser.getMobileToken());
		user.setModifiedOn(new Date());
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
	public User findByUsername(String username) {
		return userDao.findByUsername(username);
	}

	@Override
	public User deleteDisabled(int id, int sessionId) {
		User user = userDao.findOne(id);
		user.setDeletedBy(sessionId);
		user.setDeletedOn(new Date());
		user.setDeleted(true);
		return userDao.update(user);
	}
}