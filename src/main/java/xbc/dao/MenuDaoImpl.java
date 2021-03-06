package xbc.dao;

import java.util.Collection;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import xbc.dao.AbstractHibernateDao;
import xbc.dao.MenuDao;
import xbc.model.Menu;

@Repository
public class MenuDaoImpl extends AbstractHibernateDao<Menu> implements MenuDao {
	public MenuDaoImpl() {
		setClazz(Menu.class);
	}
	
	public Collection<Menu> search(final String title) {
		String hql = "FROM Menu M WHERE LOWER(M.title) LIKE LOWER(:title)";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("title", "%" + title + "%");
		
		Collection<Menu> result = q.list();
		return result;
	}

	@Override
	public Collection<Menu> findAllByRole(Integer sessionRoleId) {
		String hql = "select m.id, m.code, m.title, m.description, m.imageUrl,"
				+ "m.menuOrder, m.menuParent, m.menuUrl, m.isDelete "
				+ "from MenuAccess a, Menu m, Role r "
				+ "where a.menuId = m.id and a.roleId = r.id and r.id=:sessionRoleId";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("sessionRoleId", sessionRoleId);
		
		Collection<Menu> result = q.list();
		return result;
	}
}