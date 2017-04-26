package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.BuyerProjectList;
import org.bluepigeon.admin.data.ProjectUpdateList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuyerProjectUpdate;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuyerProjectUpdateDAO {
	public ResponseMessage save(BuyerProjectUpdate buyerProjectUpdate){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(buyerProjectUpdate);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(buyerProjectUpdate.getId());
		response.setStatus(1);
		response.setMessage("Project Update Added Successfully");
		return response;
	}
	
	public List<ProjectUpdateList> getAllProjectUpdate(){
		List<ProjectUpdateList> project_update_list = new ArrayList<ProjectUpdateList>();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql ="from BuyerProjectUpdate";
		String projectHql = "from BuilderProject where id = :id";
		Session session = hibernateUtil.openSession();
		Session projectSession = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuyerProjectUpdate> result = query.list();
		for(BuyerProjectUpdate buyerProjectUpdate : result){
			ProjectUpdateList projectUpdateList = new ProjectUpdateList();
			projectUpdateList.setId(buyerProjectUpdate.getId());
			//projectUpdateList.setTitle(buyerProjectUpdate.getTitle());
			Query projectQuery = projectSession.createQuery(projectHql);
			projectQuery.setParameter("id",buyerProjectUpdate.getBuilderProject().getId());
			BuilderProject builderProject = (BuilderProject)projectQuery.list().get(0);
			projectUpdateList.setProjectName(builderProject.getName());
			if(buyerProjectUpdate.getStatusId() == 0)
				projectUpdateList.setStatus("Pending");
			if(buyerProjectUpdate.getStatusId() == 1)
				projectUpdateList.setStatus("Scheduled");
			if(buyerProjectUpdate.getStatusId() == 2)
				projectUpdateList.setStatus("Published");
			project_update_list.add(projectUpdateList);
		}
		return project_update_list;
	}
}
