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
	
	@Autowired
	private AuditLogService auditLogService;

	@Override
	public Role findOne(Integer id) {
		return roleDao.findOne(id);
	}

	@Override
	public Collection<Role> findAll() {
		return roleDao.findAll();
	}
	
	@Override
	public void save(Role role, Integer sessionId) {
		role.setCreatedOn(new Date());
		role.setCreatedBy(sessionId);
		role.setDelete(false);
		roleDao.save(role);
		
		auditLogService.logInsert(auditLogService.objectToJsonString(role));
	}

	@Override
	public Role update(Role newRole, Integer sessionId) {
		Role role = roleDao.findOne(newRole.getId());
		
		String jsonBefore = auditLogService.objectToJsonString(role);
		
		role.setCode(newRole.getCode());
		role.setName(newRole.getName());
		role.setDescription(newRole.getDescription());
		role.setModifiedBy(sessionId);
		role.setModifiedOn(new Date());
		
		String jsonAfter = auditLogService.objectToJsonString(role);
		auditLogService.logUpdate(jsonBefore, jsonAfter);
		
		return roleDao.update(role);
	}

	@Override
	public void delete(Role role) {
		roleDao.delete(role);
	}

	@Override
	public void deleteById(Integer id) {
		roleDao.deleteById(id);
	}

	@Override
	public Collection<Role> search(String name) {
		return roleDao.search(name);
	}

	@Override
	public Role deleteDisabled(Integer id, Integer sessionId) {
		Role role = roleDao.findOne(id);
		role.setDeletedBy(sessionId);
		role.setDeletedOn(new Date());
		role.setDelete(true);
		
		auditLogService.logDelete(auditLogService.objectToJsonString(role));
		
		return roleDao.update(role);
	}
}