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
	
	public Collection<User> search(final String find) {
		String hql = "FROM User U" + " WHERE U.username = :find "
				+ "OR U.email = :find";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("find", find);
		
		Collection<User> result = q.list();
		return result;
	}

	@Override
	public User findByUsername(String username) {
		String hql = "FROM User U" + " WHERE U.username = :username";
		Query q = getCurrentSession().createQuery(hql);
		q.setParameter("username", username);
		
		User result = (User) q.uniqueResult();
		return result;
	}
}