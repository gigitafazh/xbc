package xbc.service;

import java.util.Collection;

import xbc.model.Office;

public interface OfficeService {
	public Office findOne(Integer id);

	public Collection<Office> findAll();

	public void save(Office office, Integer sessionId);
	
	public Office update(Office office, Integer sessionId);

	public void delete(Office office);

	public void deleteById(String id);

	public Collection<Office> search(String name);
	
	public Office deleteDisabled(Integer id, Integer sessionI);
}