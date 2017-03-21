package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderFlatAmenity;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderFlatAmenityDAO {

	public ResponseMessage save(BuilderFlatAmenity builderFlatAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (builderFlatAmenity.getName() == null || builderFlatAmenity.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter flat amenity name");
		} else {
			String hql = "from BuilderFlatAmenity where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", builderFlatAmenity.getName());
			List<BuilderFlatAmenity> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Flat amenity name already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(builderFlatAmenity);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Flat amenity added Successfully");
			}
		}
		return response;
	}

	public ResponseMessage update(BuilderFlatAmenity builderFlatAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderFlatAmenity where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderFlatAmenity.getName());
		query.setParameter("id", builderFlatAmenity.getId());
		List<BuilderFlatAmenity> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Flat amenity name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(builderFlatAmenity);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Flat amenity updated Successfully");
		}
		return response;
	}

	public ResponseMessage delete(BuilderFlatAmenity builderFlatAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderFlatAmenity where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderFlatAmenity.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Flat amenity deleted successfuuly");

		return response;
	}

	public List<BuilderFlatAmenity> getBuilderFlatAmenityList() {
		String hql = "from BuilderFlatAmenity";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFlatAmenity> result = query.list();
		
		session.close();
		return result;
	}

	public List<BuilderFlatAmenity> getBuilderFlatAmenityById(int id) {
		String hql = "from BuilderFlatAmenity where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderFlatAmenity> result = query.list();
		session.close();
		return result;
	}

}
