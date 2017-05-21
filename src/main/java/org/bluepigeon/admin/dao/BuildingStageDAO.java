package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuildingStage;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuildingStageDAO {
	/**
	 * @author pankaj
	 * Save building stage
	 * @param buildingStage
	 * @return message
	 */
	public ResponseMessage save(BuildingStage buildingStage){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (buildingStage.getName() == null || buildingStage.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter building stage name");
		} else {
			String hql = "from BuildingStage where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", buildingStage.getName());
			List<BuildingStage> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Building Stage already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(buildingStage);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Building Stage Successfully added");
			}
		}
		return response;
	}
	/**
	 * @author pankaj
	 * Update building stage
	 * @param buildingStage
	 * @return message
	 */
	public ResponseMessage update(BuildingStage buildingStage) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from BuildingStage where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", buildingStage.getName());
		query.setParameter("id", buildingStage.getId());
		
		List<BuildingStage> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Building Stage already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(buildingStage);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Building Stage Updated Successfully");
		}
		return response;
	}
	/**
	 * @author pankaj
	 * Get all building stage
	 * @return list of building stage
	 */
	public List<BuildingStage> getBuildingStageList() {
		String hql = "from BuildingStage";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuildingStage> result = query.list();
		session.close();
		return result;
	}
	/**
	 * @author pankaj
	 * Get building stage by id
	 * @param id
	 * @return building stage object
	 */
	public BuildingStage getBuildingStageById(int id) {
		String hql = "from BuildingStage where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuildingStage> result = query.list();
		session.close();
		return result.get(0);
	}
}
