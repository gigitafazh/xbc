package xbc.dao;

import java.util.Collection;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import xbc.dao.AbstractHibernateDao;
import xbc.dao.MenuAccessDao;
import xbc.model.MenuAccess;
import xbc.model.Office;

@Repository
public class MenuAccessDaoImpl extends AbstractHibernateDao<MenuAccess> implements MenuAccessDao {
	public MenuAccessDaoImpl() {
		setClazz(MenuAccess.class);
	}

	@Override
	public Collection<MenuAccess> search(final int roleId) {
		String hql = "FROM MenuAccess M WHERE M.roleId = :roleId";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("roleId", roleId);
		
		Collection<MenuAccess> result = q.list();
		return result;
	}
}