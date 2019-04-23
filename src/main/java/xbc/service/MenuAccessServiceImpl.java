package xbc.service;

import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xbc.dao.MenuAccessDao;
import xbc.model.MenuAccess;

@Service
@Transactional
public class MenuAccessServiceImpl implements MenuAccessService {
	@Autowired
	private MenuAccessDao menuAccessDao;
	
	@Autowired
	private AuditLogService auditLogService;

	@Override
	public MenuAccess findOne(Integer id) {
		return menuAccessDao.findOne(id);
	}
	
	@Override
	public Collection<MenuAccess> findAll() {
		return menuAccessDao.findAll();
	}

	@Override
	public void save(MenuAccess menuAccess, Integer sessionId) {
		menuAccess.setCreatedOn(new Date());
		menuAccess.setCreatedBy(sessionId);
		menuAccessDao.save(menuAccess);
		
		auditLogService.logInsert(auditLogService.objectToJsonString(menuAccess));
	}

	@Override
	public MenuAccess update(MenuAccess menuAccess, Integer sessionId) {
		String jsonBefore = auditLogService.objectToJsonString(menuAccess);
		
		String jsonAfter = auditLogService.objectToJsonString(menuAccess);
		auditLogService.logUpdate(jsonBefore, jsonAfter);
		
		return menuAccessDao.update(menuAccess);
	}

	@Override
	public void delete(MenuAccess menuAccess) {
		menuAccessDao.delete(menuAccess);
	}

	@Override
	public void deleteById(Integer id) {
		menuAccessDao.deleteById(id);
	}

	@Override
	public Collection<MenuAccess> search(Integer roleId) {
		return menuAccessDao.search(roleId);
	}
}