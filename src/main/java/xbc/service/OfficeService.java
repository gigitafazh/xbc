package xbc.service;

import java.util.Collection;

import xbc.model.Office;

public interface OfficeService {
	public Office findOne(int id);

	public Collection<Office> findAll();

	public void save(Office office);
	
	public Office update(Office office);

	public void delete(Office office);

	public void deleteById(String id);

	public Collection<Office> search(String name);
	
	public Office deleteDisabled(int id);
}