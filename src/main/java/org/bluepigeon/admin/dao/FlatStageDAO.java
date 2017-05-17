package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.FlatStage;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class FlatStageDAO {
	/**
	 * @author pankaj
	 * Save flat stage
	 * @param flatStage
	 * @return message
	 */
	public ResponseMessage save(FlatStage flatStage){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (flatStage.getName() == null || flatStage.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter flat stage name");
		} else {
			String hql = "from FlatStage where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", flatStage.getName());
			List<FlatStage> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Flat Stage already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(flatStage);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Flat Stage Successfully added");
			}
		}
		return response;
	}
	/**
	 * @author pankaj
	 * Update flat stage
	 * @param flatStage
	 * @return message
	 */
	public ResponseMessage update(FlatStage flatStage) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from FlatStage where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", flatStage.getName());
		query.setParameter("id", flatStage.getId());
		
		List<FlatStage> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Flat Stage already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(flatStage);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Flat Stage Updated Successfully");
		}
		return response;
	}
	/**
	 * @author pankaj
	 * Get all Flat stage
	 * @return list of flat stage
	 */
	public List<FlatStage> getFlatStageList() {
		String hql = "from FlatStage";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<FlatStage> result = query.list();
		session.close();
		return result;
	}
	/**
	 * @author pankaj
	 * Get flat stage by id
	 * @param id
	 * @return flat stage object
	 */
	public FlatStage getFlatStageById(int id) {
		String hql = "from FlatStage where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<FlatStage> result = query.list();
		session.close();
		return result.get(0);
	}
}
