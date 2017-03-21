package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderFloorAmenity;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderFloorAmenityDAO {

	public ResponseMessage save(BuilderFloorAmenity builderFloorAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (builderFloorAmenity.getName() == null || builderFloorAmenity.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter Floor amenity name");
		} else {
			String hql = "from BuilderFloorAmenity where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", builderFloorAmenity.getName());
			List<BuilderFloorAmenity> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Floor amenity name already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(builderFloorAmenity);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Floor amenity added Successfully");
			}
		}
		return response;
	}

	public ResponseMessage update(BuilderFloorAmenity builderFloorAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderFloorAmenity where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderFloorAmenity.getName());
		query.setParameter("id", builderFloorAmenity.getId());
		List<BuilderFloorAmenity> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Floor amenity name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(builderFloorAmenity);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Floor amenity updated Successfully");
		}
		return response;
	}

	public ResponseMessage delete(BuilderFloorAmenity builderFloorAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderFloorAmenity where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderFloorAmenity.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Floor amenity deleted successfuuly");

		return response;
	}

	public List<BuilderFloorAmenity> getBuilderFloorAmenityList() {
		String hql = "from BuilderFloorAmenity";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFloorAmenity> result = query.list();
		
		session.close();
		return result;
	}

	public List<BuilderFloorAmenity> getBuilderFloorAmenityById(int id) {
		String hql = "from BuilderFloorAmenity where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderFloorAmenity> result = query.list();
		session.close();
		return result;
	}

}
