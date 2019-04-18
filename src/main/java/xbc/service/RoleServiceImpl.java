package xbc.service;

import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xbc.dao.RoleDao;
import xbc.model.Role;
import xbc.model.Role;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {
	@Autowired
	private RoleDao roleDao;

	@Override
	public Role findOne(int id) {
		return roleDao.findOne(id);
	}

	@Override
	public Collection<Role> findAll() {
		return roleDao.findAll();
	}
	
	@Override
	public void save(Role role) {
		role.setCreatedOn(new Date());
		role.setCreatedBy(0);
		role.setDeleted(false);
		roleDao.save(role);
	}

	@Override
	public Role update(Role newRole) {
		Role role = roleDao.findOne(newRole.getId());
		role.setCode(newRole.getCode());
		role.setName(newRole.getName());
		role.setDescription(newRole.getDescription());
		role.setModifiedBy(0);
		role.setModifiedOn(new Date());
		return roleDao.update(role);
	}

	@Override
	public void delete(Role role) {
		roleDao.delete(role);
	}

	@Override
	public void deleteById(int id) {
		roleDao.deleteById(id);
	}

	@Override
	public Collection<Role> search(String name) {
		return roleDao.search(name);
	}

	@Override
	public Role deleteDisabled(int id) {
		Role role = roleDao.findOne(id);
		role.setDeletedBy(0);
		role.setDeletedOn(new Date());
		role.setDeleted(true);
		return roleDao.update(role);
	}
}