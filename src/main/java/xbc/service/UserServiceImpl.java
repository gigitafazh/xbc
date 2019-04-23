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
	
	@Autowired
	private AuditLogService auditLogService;

	@Override
	public User findOne(Integer id) {
		return userDao.findOne(id);
	}

	@Override
	public Collection<User> findAll() {
		return userDao.findAll();
	}
	
	@Override
	public void save(User user, Integer sessionId) {
		user.setCreatedOn(new Date());
		user.setCreatedBy(sessionId);
		user.setDelete(false);
		userDao.save(user);
		
		auditLogService.logInsert(auditLogService.objectToJsonString(user));
	}

	@Override
	public User update(User newUser, Integer sessionId) {
		User user = userDao.findOne(newUser.getId());
		
		String jsonBefore = auditLogService.objectToJsonString(user);
		
		user.setUsername(newUser.getUsername());
		user.setEmail(newUser.getEmail());
		user.setRole(newUser.getRole());
		user.setPassword(newUser.getPassword());
		user.setMobileFlag(newUser.isMobileFlag());
		user.setMobileToken(newUser.getMobileToken());
		user.setModifiedOn(new Date());
		user.setModifiedBy(sessionId);
		
		String jsonAfter = auditLogService.objectToJsonString(user);
		auditLogService.logUpdate(jsonBefore, jsonAfter);
		
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
	public User deleteDisabled(Integer id, Integer sessionId) {
		User user = userDao.findOne(id);
		user.setDeletedBy(sessionId);
		user.setDeletedOn(new Date());
		user.setDelete(true);
		
		auditLogService.logDelete(auditLogService.objectToJsonString(user));
		
		return userDao.update(user);
	}
}