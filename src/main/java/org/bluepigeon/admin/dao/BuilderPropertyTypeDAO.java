package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderPropertyType;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuilderPropertyTypeDAO {
	public ResponseMessage save(BuilderPropertyType buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (buildingAmeneties.getName() == null || buildingAmeneties.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter property type");
		} else {
			String hql = "from BuilderPropertyType where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", buildingAmeneties.getName());
			List<BuilderPropertyType> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Property type already exists");
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

	public ResponseMessage update(BuilderPropertyType buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderPropertyType where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", buildingAmeneties.getName());
		query.setParameter("id", buildingAmeneties.getId());

		List<BuilderPropertyType> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Property type already exists");
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

	public ResponseMessage delete(BuilderPropertyType buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "delete from BuilderPropertyType where id = :id";
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

	public List<BuilderPropertyType> getBuilderCompany() {
		String hql = "from BuilderPropertyType";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderPropertyType> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderPropertyType> getBuilderPropertyTypes() {
		String hql = "from BuilderPropertyType";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderPropertyType> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderPropertyType> getBuilderActivePropertyTypes() {
		String hql = "from BuilderPropertyType where status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderPropertyType> result = query.list();
		session.close();
		return result;
	}

	public List<BuilderPropertyType> getCountryById(int id) {
		String hql = "from BuilderPropertyType where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderPropertyType> result = query.list();
		session.close();
		return result;
	}

}
