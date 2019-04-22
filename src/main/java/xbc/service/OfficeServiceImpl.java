package xbc.service;

import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xbc.dao.OfficeDao;
import xbc.model.Office;

@Service
@Transactional
public class OfficeServiceImpl implements OfficeService {
	@Autowired
	private OfficeDao officeDao;

	@Override
	public Office findOne(int id) {
		return officeDao.findOne(id);
	}

	@Override
	public Collection<Office> findAll() {
		return officeDao.findAll();
	}

	@Override
	public void save(Office office, int sessionId) {
		office.setCreatedOn(new Date());
		office.setCreatedBy(sessionId);
		office.setDeleted(false);
		officeDao.save(office);
	}

	@Override
	public Office update(Office newOffice, int sessionId) {
		Office office = officeDao.findOne(newOffice.getId());
		office.setName(newOffice.getName());
		office.setPhone(newOffice.getPhone());
		office.setEmail(newOffice.getEmail());
		office.setAddress(newOffice.getAddress());
		office.setNotes(newOffice.getNotes());
		office.setModifiedBy(sessionId);
		office.setModifiedOn(new Date());
		return officeDao.update(office);
	}

	@Override
	public void delete(Office office) {
		officeDao.delete(office);
	}

	@Override
	public void deleteById(String id) {
		officeDao.deleteById(id);
	}
	
	@Override
	public Collection<Office> search(String name) {
		return officeDao.search(name);
	}

	@Override
	public Office deleteDisabled(int id, int sessionId) {
		Office office = officeDao.findOne(id);
		office.setDeletedBy(sessionId);
		office.setDeletedOn(new Date());
		office.setDeleted(true);
		return officeDao.update(office);
	}
}