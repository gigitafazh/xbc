package xbc.service;

import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import xbc.dao.AuditLogDao;
import xbc.model.AuditLog;

@Service
@Transactional
public class AuditLogServiceImpl implements AuditLogService {

	@Autowired
	private AuditLogDao auditLogDao;

	@Override
	public AuditLog findOne(Integer id) {
		return auditLogDao.findOne(id);
	}

	@Override
	public Collection<AuditLog> findAll() {
		return auditLogDao.findAll();
	}

	@Override
	public AuditLog update(AuditLog auditLog) {
		return auditLogDao.update(auditLog);
	}

	@Override
	public void delete(AuditLog auditLog) {
		auditLogDao.delete(auditLog);
	}

	@Override
	public void deleteById(Integer id) {
		auditLogDao.deleteById(id);
	}

	@Override
	public void save(AuditLog auditLog) {
		auditLogDao.save(auditLog);
	}

	// ------------- tambahan

	@Override
	public String objectToJsonString(Object object) {
		String jsonString = null;
		try {
			jsonString = new ObjectMapper().writeValueAsString(object);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return jsonString;

	}

	@Override
	public void logInsert(String jsonInsert) {
		AuditLog auditLog = new AuditLog();
		auditLog.setJsonInsert(jsonInsert);
		auditLog.setType("INSERT");
		auditLog.setCreatedBy(555);
		auditLog.setCreatedOn(new Date());
		auditLogDao.save(auditLog);
	}

	@Override
	public void logUpdate(String jsonBefore, String jsonAfter) {
		AuditLog auditLog = new AuditLog();
		auditLog.setJsonBefore(jsonBefore);
		auditLog.setJsonAfter(jsonAfter);
		auditLog.setType("MODIFY");
		auditLog.setCreatedBy(555);
		auditLog.setCreatedOn(new Date());
		auditLogDao.save(auditLog);
	}

	@Override
	public void logDelete(String jsonDelete) {
		AuditLog auditLog = new AuditLog();
		auditLog.setJsonDelete(jsonDelete);
		auditLog.setType("DELETE");
		auditLog.setCreatedBy(555);
		auditLog.setCreatedOn(new Date());
		auditLogDao.save(auditLog);
	}
}