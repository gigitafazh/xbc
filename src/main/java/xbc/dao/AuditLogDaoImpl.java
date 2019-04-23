package xbc.dao;

import java.util.Collection;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import xbc.model.AuditLog;

@Repository
public class AuditLogDaoImpl extends AbstractHibernateDao<AuditLog> implements AuditLogDao {

	public AuditLogDaoImpl() {
		setClazz(AuditLog.class);
	}
}