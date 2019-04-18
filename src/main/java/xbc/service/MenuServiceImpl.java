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

	@Override
	public Menu findOne(int id) {
		return menuDao.findOne(id);
	}

	@Override
	public Collection<Menu> findAll() {
		return menuDao.findAll();
	}
	
	@Override
	public void save(Menu menu) {
		menu.setCreatedOn(new Date());
		menu.setCreatedBy(0);
		menu.setDeleted(false);
		menuDao.save(menu);
	}

	@Override
	public Menu update(Menu newMenu) {
		Menu menu = menuDao.findOne(newMenu.getId());
		menu.setCode(newMenu.getCode());
		menu.setTitle(newMenu.getTitle());
		menu.setDescription(newMenu.getDescription());
		menu.setImageUrl(newMenu.getImageUrl());
		menu.setMenuOrder(newMenu.getMenuOrder());
		menu.setMenuParent(newMenu.getMenuParent());
		menu.setMenuUrl(newMenu.getMenuUrl());
		menu.setModifiedBy(0);
		menu.setModifiedOn(new Date());
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
	public Menu deleteDisabled(int id) {
		Menu menu = menuDao.findOne(id);
		menu.setDeletedBy(0);
		menu.setDeletedOn(new Date());
		menu.setDeleted(true);
		return menuDao.update(menu);
	}
}