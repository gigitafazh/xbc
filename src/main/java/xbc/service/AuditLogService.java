package xbc.service;

import java.util.Collection;

import xbc.model.AuditLog;

public interface AuditLogService {

	public Collection<AuditLog> findAll();

	public AuditLog findOne(Integer id);

	public void delete(AuditLog auditLog);

	public void deleteById(Integer id);

	public AuditLog update(AuditLog auditLog);

	public void save(AuditLog auditLog);

	public String objectToJsonString(Object object);

	public void logInsert(String jsonInsert, Integer sessionId);

	public void logUpdate(String jsonBefore, String jsonAfter, Integer sessionId);

	public void logDelete(String jsonDelete, Integer sessionId);
}