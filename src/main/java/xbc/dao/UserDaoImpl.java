package xbc.dao;

import java.util.Collection;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import xbc.dao.AbstractHibernateDao;
import xbc.dao.UserDao;
import xbc.model.User;

@Repository
public class UserDaoImpl extends AbstractHibernateDao<User> implements UserDao {
	public UserDaoImpl() {
		setClazz(User.class);
	}
	
	public Collection<User> findAll() {
		String hql = "FROM User U "
				   + "WHERE U.isDelete = 'false'";
		Query q = getCurrentSession().createQuery(hql);
		Collection<User> result = q.list();
		return result;
	}
	
	public Collection<User> search(final String find) {
		String hql = "FROM User U" + " WHERE U.username = :find OR U.email = :find"
				+ " AND U.isDelete ='false'";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("find", find);
		
		Collection<User> result = q.list();
		return result;
	}
	
	public User email(String email) {
		String hql = "FROM User U" + " WHERE U.email = :email"
				+ " AND U.isDelete ='false'";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("email", email);
		
		User result = (User) q.uniqueResult();
		return result;
	}

	@Override
	public User username(String username) {
		String hql = "FROM User U" + " WHERE U.username = :username"
				+ " AND U.isDelete ='false'";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("username", username);
		
		User result = (User) q.uniqueResult();
		return result;
	}
	
	public Collection<User> findByEmail(String email, Integer id) {
		String hql = "FROM User U" + " WHERE U.email = :email"
				+ " AND U.isDelete ='false' AND U.id <> :id";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("email", email);
		if (id == null) {
			id = 0;
		}
		q.setParameter("id", id);
		
		Collection<User> result = q.list();
		return result;
	}
	
	public Collection<User> findByUsername(String username, Integer id) {
		String hql = "FROM User U" + " WHERE U.username = :username"
				+ " AND U.isDelete ='false' AND U.id <> :id";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("username", username);
		if (id == null) {
			id = 0;
		}
		q.setParameter("id", id);
		
		Collection<User> result = q.list();
		return result;
	}
}