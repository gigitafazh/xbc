package xbc.dao;

import java.util.Collection;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import xbc.dao.AbstractHibernateDao;
import xbc.dao.RoleDao;
import xbc.model.Role;

@Repository
public class RoleDaoImpl extends AbstractHibernateDao<Role> implements RoleDao {
	public RoleDaoImpl() {
		setClazz(Role.class);
	}
	
	public Collection<Role> search(final String name) {
		String hql = "FROM Role R WHERE LOWER(R.name) LIKE LOWER(:name)";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("name", "%" + name + "%");
		
		Collection<Role> result = q.list();
		return result;
	}
}