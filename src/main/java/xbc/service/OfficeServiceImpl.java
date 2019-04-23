package xbc.service;

import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xbc.dao.OfficeDao;
import xbc.model.Office;

@Service
@Transactional
public class OfficeServiceImpl implements OfficeService {
	@Autowired
	private OfficeDao officeDao;
	
	@Autowired
	private AuditLogService auditLogService;

	@Override
	public Office findOne(Integer id) {
		return officeDao.findOne(id);
	}

	@Override
	public Collection<Office> findAll() {
		return officeDao.findAll();
	}

	@Override
	public void save(Office office, Integer sessionId) {
		office.setCreatedOn(new Date());
		office.setCreatedBy(sessionId);
		office.setDelete(false);
		officeDao.save(office);
		
		auditLogService.logInsert(auditLogService.objectToJsonString(office));
	}

	@Override
	public Office update(Office newOffice, Integer sessionId) {
		Office office = officeDao.findOne(newOffice.getId());
		
		String jsonBefore = auditLogService.objectToJsonString(office);
		
		office.setName(newOffice.getName());
		office.setPhone(newOffice.getPhone());
		office.setEmail(newOffice.getEmail());
		office.setAddress(newOffice.getAddress());
		office.setNotes(newOffice.getNotes());
		office.setModifiedBy(sessionId);
		office.setModifiedOn(new Date());
		
		String jsonAfter = auditLogService.objectToJsonString(office);
		auditLogService.logUpdate(jsonBefore, jsonAfter);
		
		return officeDao.update(office);
	}

	@Override
	public void delete(Office office) {
		officeDao.delete(office);
	}

	@Override
	public void deleteById(String id) {
		officeDao.deleteById(id);
	}
	
	@Override
	public Collection<Office> search(String name) {
		return officeDao.search(name);
	}

	@Override
	public Office deleteDisabled(Integer id, Integer sessionId) {
		Office office = officeDao.findOne(id);
		office.setDeletedBy(sessionId);
		office.setDeletedOn(new Date());
		office.setDelete(true);
		
		auditLogService.logDelete(auditLogService.objectToJsonString(office));
		
		return officeDao.update(office);
	}
}