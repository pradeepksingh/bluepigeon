package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderFlatStatus;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuilderFlatStatusDAO {
	public ResponseMessage save(BuilderFlatStatus buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (buildingAmeneties.getName() == null || buildingAmeneties.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter flat status");
		} else {
			String hql = "from BuilderFlatStatus where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", buildingAmeneties.getName());
			List<BuilderFlatStatus> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Flat status already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(buildingAmeneties);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Success");
			}
		}
		return response;
	}

	public ResponseMessage update(BuilderFlatStatus buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderFlatStatus where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", buildingAmeneties.getName());
		query.setParameter("id", buildingAmeneties.getId());
		
		List<BuilderFlatStatus> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Flat status already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(buildingAmeneties);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Success");
		}
		return response;
	}

	public ResponseMessage delete(BuilderFlatStatus buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "delete from BuilderFlatStatus where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", buildingAmeneties.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Success");

		return response;
	}

	public List<BuilderFlatStatus> getBuilderCompany() {
		String hql = "from BuilderFlatStatus";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFlatStatus> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderFlatStatus> getBuilderFlatStatus() {
		String hql = "from BuilderFlatStatus";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFlatStatus> result = query.list();
		session.close();
		return result;
	}

	public List<BuilderFlatStatus> getCountryById(int id) {
		String hql = "from BuilderFlatStatus where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderFlatStatus> result = query.list();
		session.close();
		return result;
	}

}
