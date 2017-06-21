package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuildingStage;
import org.bluepigeon.admin.model.FloorStage;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class FloorStageDAO {
	/**
	 * @author pankaj
	 * Save floor stage
	 * @param floorStage
	 * @return message
	 */
	public ResponseMessage save(FloorStage floorStage){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (floorStage.getName() == null || floorStage.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter floor stage name");
		} else {
			String hql = "from FloorStage where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", floorStage.getName());
			List<BuildingStage> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Floor Stage already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(floorStage);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Floor Stage Successfully added");
			}
		}
		return response;
	}
	/**
	 * @author pankaj
	 * Update floor stage
	 * @param floorStage
	 * @return message
	 */
	public ResponseMessage update(FloorStage floorStage) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from FloorStage where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", floorStage.getName());
		query.setParameter("id", floorStage.getId());
		
		List<BuildingStage> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Floor Stage already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(floorStage);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Floor Stage Update Successfully");
		}
		return response;
	}
	/**
	 * @author pankaj
	 * Get all floor stage
	 * @return list of floor stage
	 */
	public List<FloorStage> getFloorStageList() {
		String hql = "from FloorStage";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<FloorStage> result = query.list();
		session.close();
		return result;
	}
	/**
	 * @author pankaj
	 * Get floor stage by id
	 * @param id
	 * @return floor stage object
	 */
	public FloorStage getFloorStageById(int id) {
		String hql = "from FloorStage where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<FloorStage> result = query.list();
		session.close();
		return result.get(0);
	}
	
	public List<FloorStage> getActiveFloorStages() {
		String hql = "from FloorStage where status = 1 and is_deleted = 0 order by name ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<FloorStage> result = query.list();
		session.close();
		return result;
	}
}
