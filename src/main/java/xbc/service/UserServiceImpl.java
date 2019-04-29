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
	public Integer save(User user, Integer sessionId) {
		user.setCreatedOn(new Date());
		user.setCreatedBy(sessionId);
		user.setDelete(false);
		
		Integer countEmail = this.checkEmail(user.getEmail(), user.getId());
		Integer countUsername = this.checkUsername(user.getUsername(), user.getId());
		
		if (countEmail > 0) {
			user.setEmail(user.getEmail());
			return 1;
		} else {
			if (countUsername > 0) {
				user.setUsername(user.getUsername());
				return 2;
			} else {
				userDao.save(user);
				auditLogService.logInsert(auditLogService.objectToJsonString(user), sessionId);
				return 3;
			}
		}
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
		auditLogService.logUpdate(jsonBefore, jsonAfter, sessionId);
		
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
	public User email(String email) {
		return userDao.email(email);
	}

	@Override
	public User username(String username) {
		return userDao.username(username);
	}
	
	@Override
	public Collection<User> findByUsername(String username, Integer id) {
		return userDao.findByUsername(username,id);
	}
	
	@Override
	public Collection<User> findByEmail(String email, Integer id) {
		return userDao.findByEmail(email, id);
	}

	@Override
	public User deleteDisabled(Integer id, Integer sessionId) {
		User user = userDao.findOne(id);
		
		String jsonBefore = auditLogService.objectToJsonString(user);
		
		user.setDeletedBy(sessionId);
		user.setDeletedOn(new Date());
		user.setDelete(true);
		
		String jsonAfter = auditLogService.objectToJsonString(user);
		auditLogService.logUpdate(jsonBefore, jsonAfter, sessionId);
		
		return userDao.update(user);
	}
	
	public Integer checkEmail(String email, Integer id) {
		Collection<User> list = userDao.findByEmail(email, id);
		Integer countEmail = 0;
		if (list.isEmpty()) {
			countEmail = 0;
		} else {
			countEmail = 1;
		}
		return countEmail;
	}
	
	public Integer checkUsername(String username, Integer id) {
		Collection<User> list = userDao.findByUsername(username, id);
		Integer countUsername = 0;
		if (list.isEmpty()) {
			countUsername = 0;
		} else {
			countUsername = 1;
		}
		return countUsername;
	}
}