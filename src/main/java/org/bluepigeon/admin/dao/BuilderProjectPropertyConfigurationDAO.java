package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuilderProjectPropertyConfigurationDAO {
	public ResponseMessage save(BuilderProjectPropertyConfiguration buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (buildingAmeneties.getName() == null || buildingAmeneties.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter project property configuration");
		} else {
			String hql = "from BuilderProjectPropertyConfiguration where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", buildingAmeneties.getName());
			List<BuilderProjectPropertyConfiguration> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Prject property configuration already exists");
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

	public ResponseMessage update(BuilderProjectPropertyConfiguration buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderProjectPropertyConfiguration where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", buildingAmeneties.getName());
		query.setParameter("id", buildingAmeneties.getId());
		
		List<BuilderProjectPropertyConfiguration> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Project property configuration already exists");
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

	public ResponseMessage delete(BuilderProjectPropertyConfiguration buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "delete from BuilderProjectPropertyConfiguration where id = :id";
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

	public List<BuilderProjectPropertyConfiguration> getBuilderCompany() {
		String hql = "from BuilderProjectPropertyConfiguration";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderProjectPropertyConfiguration> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderProjectPropertyConfiguration> getBuilderProjectConfigurations() {
		String hql = "from BuilderProjectPropertyConfiguration";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderProjectPropertyConfiguration> result = query.list();
		session.close();
		return result;
	}

	public List<BuilderProjectPropertyConfiguration> getCountryById(int id) {
		String hql = "from BuilderProjectPropertyConfiguration where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderProjectPropertyConfiguration> result = query.list();
		session.close();
		return result;
	}

}
