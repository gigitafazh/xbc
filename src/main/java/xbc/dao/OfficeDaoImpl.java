package xbc.dao;

import java.util.Collection;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import xbc.dao.AbstractHibernateDao;
import xbc.dao.OfficeDao;
import xbc.model.Office;

@Repository
public class OfficeDaoImpl extends AbstractHibernateDao<Office> implements OfficeDao {
	public OfficeDaoImpl() {
		setClazz(Office.class);
	}
	
	public Collection<Office> search(final String name) {
		String hql = "FROM Office O WHERE LOWER(O.name) LIKE LOWER(:name)"
				+ "AND O.deleted = 'false'";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("name", "%" + name + "%");
		
		Collection<Office> result = q.list();
		return result;
	}
}