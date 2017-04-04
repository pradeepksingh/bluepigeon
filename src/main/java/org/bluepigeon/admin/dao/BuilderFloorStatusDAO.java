package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderFloorStatus;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuilderFloorStatusDAO {
	public ResponseMessage save(BuilderFloorStatus builderFloorStatus) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (builderFloorStatus.getName() == null || builderFloorStatus.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter floor status");
		} else {
			String hql = "from BuilderFloorStatus where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", builderFloorStatus.getName());
			List<BuilderFloorStatus> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Floor status already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(builderFloorStatus);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Success");
			}
		}
		return response;
	}

	public ResponseMessage update(BuilderFloorStatus builderFloorStatus) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderFloorStatus where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderFloorStatus.getName());
		query.setParameter("id", builderFloorStatus.getId());
		
		List<BuilderFloorStatus> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Floor status already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(builderFloorStatus);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Success");
		}
		return response;
	}

	public ResponseMessage delete(BuilderFloorStatus builderFloorStatus) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "delete from BuilderFloorStatus where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderFloorStatus.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Success");

		return response;
	}

	public List<BuilderFloorStatus> getFloorStatus() {
		String hql = "from BuilderFloorStatus";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFloorStatus> result = query.list();
		session.close();
		return result;
	}

	public List<BuilderFloorStatus> getFloorStatusById(int id) {
		String hql = "from BuilderFloorStatus where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderFloorStatus> result = query.list();
		session.close();
		return result;
	}
}
