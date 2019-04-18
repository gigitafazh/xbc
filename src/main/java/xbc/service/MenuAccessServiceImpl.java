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

	@Override
	public MenuAccess findOne(int id) {
		return menuAccessDao.findOne(id);
	}
	
	@Override
	public Collection<MenuAccess> findAll() {
		return menuAccessDao.findAll();
	}

	@Override
	public void save(MenuAccess menuAccess) {
		menuAccess.setCreatedOn(new Date());
		menuAccess.setCreatedBy(0);
		menuAccessDao.save(menuAccess);
	}

	@Override
	public MenuAccess update(MenuAccess menuAccess) {
		return menuAccessDao.update(menuAccess);
	}

	@Override
	public void delete(MenuAccess menuAccess) {
		menuAccessDao.delete(menuAccess);
	}

	@Override
	public void deleteById(int id) {
		menuAccessDao.deleteById(id);
	}

	@Override
	public Collection<MenuAccess> search(int roleId) {
		return menuAccessDao.search(roleId);
	}
}