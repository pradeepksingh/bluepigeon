package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.ProjectStage;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class ProjectStageDAO {
	public ResponseMessage save(ProjectStage projectStage){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (projectStage.getName() == null || projectStage.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter country name");
		} else {
			String hql = "from ProjectStage where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", projectStage.getName());
			List<ProjectStage> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Project Stage already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(projectStage);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Project Stage Added Successfully");
			}
		}
		return response;
	}
	
	public ResponseMessage update(ProjectStage projectStage) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from ProjectStage where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", projectStage.getName());
		query.setParameter("id", projectStage.getId());
		// System.out.println("Country status ::"+country.getStatus());
		// query.setParameter("status", country.getStatus());
		List<ProjectStage> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Project Stage already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(projectStage);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Project Stage Updated Successfully");
		}
		return response;
	}
	
	public List<ProjectStage> getProjectStageList() {
		String hql = "from ProjectStage";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<ProjectStage> result = query.list();
		session.close();
		return result;
	}

	public ProjectStage getProjectStageById(int id) {
		String hql = "from ProjectStage where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<ProjectStage> result = query.list();
		session.close();
		return result.get(0);
	}
	
	public List<ProjectStage> getActiveProjectStages() {
		String hql = "from ProjectStage where status = 1 and is_deleted = 0 order by name ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<ProjectStage> result = query.list();
		session.close();
		return result;
	}
	
}
