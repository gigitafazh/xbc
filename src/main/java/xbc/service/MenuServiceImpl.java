package xbc.service;

import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xbc.dao.MenuDao;
import xbc.model.Menu;
import xbc.model.Office;

@Service
@Transactional
public class MenuServiceImpl implements MenuService {
	@Autowired
	private MenuDao menuDao;
	
	@Autowired
	private AuditLogService auditLogService;

	@Override
	public Menu findOne(Integer id) {
		return menuDao.findOne(id);
	}

	@Override
	public Collection<Menu> findAll() {
		return menuDao.findAll();
	}
	
	@Override
	public void save(Menu menu, Integer sessionId) {
		menu.setCreatedOn(new Date());
		menu.setCreatedBy(sessionId);
		menu.setDelete(false);
		menuDao.save(menu);
		
		auditLogService.logInsert(auditLogService.objectToJsonString(menu));
	}

	@Override
	public Menu update(Menu newMenu, Integer sessionId) {
		Menu menu = menuDao.findOne(newMenu.getId());
		
		String jsonBefore = auditLogService.objectToJsonString(menu);
		
		menu.setCode(newMenu.getCode());
		menu.setTitle(newMenu.getTitle());
		menu.setDescription(newMenu.getDescription());
		menu.setImageUrl(newMenu.getImageUrl());
		menu.setMenuOrder(newMenu.getMenuOrder());
		menu.setMenuParent(newMenu.getMenuParent());
		menu.setMenuUrl(newMenu.getMenuUrl());
		menu.setModifiedBy(sessionId);
		menu.setModifiedOn(new Date());
		
		String jsonAfter = auditLogService.objectToJsonString(menu);
		auditLogService.logUpdate(jsonBefore, jsonAfter);
		
		return menuDao.update(menu);
	}

	@Override
	public void delete(Menu menu) {
		menuDao.delete(menu);
	}

	@Override
	public void deleteById(String id) {
		menuDao.deleteById(id);
	}

	@Override
	public Collection<Menu> search(String title) {
		return menuDao.search(title);
	}

	@Override
	public Menu deleteDisabled(Integer id, Integer sessionId) {
		Menu menu = menuDao.findOne(id);
		menu.setDeletedBy(sessionId);
		menu.setDeletedOn(new Date());
		menu.setDelete(true);
		
		auditLogService.logDelete(auditLogService.objectToJsonString(menu));
		
		return menuDao.update(menu);
	}
}