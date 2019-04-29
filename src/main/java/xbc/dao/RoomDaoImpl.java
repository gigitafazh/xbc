package xbc.dao;

import java.util.Collection;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import xbc.dao.AbstractHibernateDao;
import xbc.dao.RoomDao;
import xbc.model.Room;
import xbc.model.User;

@Repository
public class RoomDaoImpl extends AbstractHibernateDao<Room> implements RoomDao {
	public RoomDaoImpl() {
		setClazz(Room.class);
	}
	
	@Override
	public Collection<Room> findAll(Integer id) {
		String hql = "FROM Room R "
				   + "WHERE isDelete = 'false' AND R.officeId = :id";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("id", id);
		
		Collection<Room> result = q.list();
		return result;
	}
	
	public Collection<Room> searchByName(final String name) {
		String hql = "FROM Room R WHERE LOWER(R.name) LIKE LOWER(:name) AND R.deleted = 'false'";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("name", "%" + name + "%");

		Collection<Room> result = q.list();
		return result;
	}
}