package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderProjectAmenity;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderProjectAmenityDAO {

	public ResponseMessage save(BuilderProjectAmenity builderProjectAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (builderProjectAmenity.getName() == null || builderProjectAmenity.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter project amenity name");
		} else {
			String hql = "from BuilderProjectAmenity where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", builderProjectAmenity.getName());
			List<BuilderProjectAmenity> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Project amenity name already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(builderProjectAmenity);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Project amenity added Successfully");
			}
		}
		return response;
	}

	public ResponseMessage update(BuilderProjectAmenity builderProjectAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderProjectAmenity where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderProjectAmenity.getName());
		query.setParameter("id", builderProjectAmenity.getId());
		List<BuilderProjectAmenity> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Project amenity name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(builderProjectAmenity);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Project amenity updated Successfully");
		}
		return response;
	}

	public ResponseMessage delete(BuilderProjectAmenity builderProjectAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderProjectAmenity where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderProjectAmenity.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Project amenity deleted successfuuly");

		return response;
	}

	public List<BuilderProjectAmenity> getBuilderProjectAmenityList() {
		String hql = "from BuilderProjectAmenity";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderProjectAmenity> result = query.list();
		
		session.close();
		return result;
	}
	
	public List<BuilderProjectAmenity> getBuilderActiveProjectAmenityList() {
		String hql = "from BuilderProjectAmenity where status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderProjectAmenity> result = query.list();
		
		session.close();
		return result;
	}

	public List<BuilderProjectAmenity> getBuilderProjectAmenityById(int id) {
		String hql = "from BuilderProjectAmenity where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderProjectAmenity> result = query.list();
		session.close();
		return result;
	}

}
