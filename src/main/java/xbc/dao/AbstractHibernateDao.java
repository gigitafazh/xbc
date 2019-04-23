package xbc.dao;

import java.io.Serializable;
import java.util.Collection;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

public abstract class AbstractHibernateDao<T extends Serializable> {

	private Class<T> clazz;

	@Autowired
	private SessionFactory sessionFactory;

	protected void setClazz(Class<T> clazz) {
		this.clazz = clazz;
	}

	protected final Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	public T findOne(final Integer id) {
		return (T) getCurrentSession().get(clazz, id);
	}

	public T findOne(final String id) {
		return (T) getCurrentSession().get(clazz, id);
	}

	public Collection<T> findAll() {
		return getCurrentSession().createQuery("FROM " + clazz.getName()).list();
	}

	public void deleteById(final Integer id) {
		final T entity = findOne(id);
		delete(entity);
	}

	public void deleteById(final String id) {
		final T entity = findOne(id);
		delete(entity);
	}

	public void save(final T entity) {
		getCurrentSession().persist(entity);
	}

	public T update(final T entity) {
		return (T) getCurrentSession().merge(entity);
	}

	public T deleteDisabled(final T entity) {
		return (T) getCurrentSession().merge(entity);
	}

	public void delete(final T entity) {
		getCurrentSession().delete(entity);
	}
}