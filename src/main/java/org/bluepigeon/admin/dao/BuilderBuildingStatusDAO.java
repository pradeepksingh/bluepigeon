package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuildingStatus;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuilderBuildingStatusDAO {
	public ResponseMessage save(BuilderBuildingStatus buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (buildingAmeneties.getName() == null || buildingAmeneties.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter Building status");
		} else {
			String hql = "from BuilderBuildingStatus where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", buildingAmeneties.getName());
			List<BuilderBuildingStatus> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Building status name already exists");
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

	public ResponseMessage update(BuilderBuildingStatus buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderBuildingStatus where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", buildingAmeneties.getName());
		query.setParameter("id", buildingAmeneties.getId());
		// System.out.println("Country status ::"+country.getStatus());
		// query.setParameter("status", country.getStatus());
		List<BuilderBuildingStatus> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Building status name already exists");
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

	public ResponseMessage delete(BuilderBuildingStatus buildingAmeneties) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "delete from BuilderBuildingStatus where id = :id";
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
	
	public List<BuilderBuildingStatus> getBuilderBuildingStatus() {
		String hql = "from BuilderBuildingStatus";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderBuildingStatus> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all active building status
	 * @author pankaj
	 * @return List<BuilderBuildingStatus>
	 */
	public List<BuilderBuildingStatus> getActiveBuilderBuildingStatus() {
		String hql = "from BuilderBuildingStatus where status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderBuildingStatus> result = query.list();
		session.close();
		return result;
	}


	public List<BuilderBuildingStatus> getCountryById(int id) {
		String hql = "from BuilderBuildingStatus where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderBuildingStatus> result = query.list();
		session.close();
		return result;
	}

}
