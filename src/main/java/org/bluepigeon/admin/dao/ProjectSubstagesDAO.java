package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.data.ProjectSubstageList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.ProjectSubstage;
import org.bluepigeon.admin.util.HibernateUtil;

public class ProjectSubstagesDAO {
    /**
     * Save Project Substages
     * 
     * @param Project Substages
     * @return String
     */
    public ResponseMessage save(ProjectSubstage projectSubstage){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (projectSubstage.getName() == null || projectSubstage.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter project substage name");
        }
        if(projectSubstage.getProjectStage().getId().equals(null)  || (projectSubstage.getProjectStage().getId()==0)){
        	 response.setStatus(0);
             response.setMessage("Please select project stage name");
        }
        else {
        	String hql = "from ProjectSubstage where name = :name and projectStage.id = :stage_id";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", projectSubstage.getName());
			query.setParameter("stage_id", projectSubstage.getProjectStage().getId());
			List<ProjectSubstage> result = query.list();
			session.close();
			if (result.size() > 0) {
				if(result.get(0).getIsDeleted() ==1){
					byte isDeleted=0;
					projectSubstage.setId(result.get(0).getId());
					projectSubstage.setIsDeleted(isDeleted);
					Session newsession = hibernateUtil.openSession();
					newsession.beginTransaction();
					newsession.update(projectSubstage);
					newsession.getTransaction().commit();
					newsession.close();
					response.setStatus(1);
					response.setMessage("Project Substage Added Successfully");
				}else{
					response.setStatus(0);
					response.setMessage("Project Substage name already exists");
				}
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(projectSubstage);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Project Substage Added Successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(ProjectSubstage projectSubstage){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from ProjectSubstage where name = :name and projectStage.id = :stage_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", projectSubstage.getName());
		query.setParameter("stage_id", projectSubstage.getProjectStage().getId());
		query.setParameter("id", projectSubstage.getId());
		List<ProjectSubstage> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Project substage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(projectSubstage);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Project Substage updated Successfully");
		}
        return response;
    }
    public ResponseMessage delete(ProjectSubstage projectSubstage) {
		
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from ProjectSubstage where id = :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", projectSubstage.getId());
		List<ProjectSubstage> result = query.list();
		session.close();
		if (result.size() > 0) {
			projectSubstage.setName(result.get(0).getName());
			projectSubstage.setStatus(result.get(0).getStatus());
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(projectSubstage);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Project Substage Deleted Successfully");
		} 
		else{
			response.setStatus(0);
			response.setMessage("Project Substage Fail to Delete");
		}

		return response;
	}
    
    /**
     * Get All project substages    
     * @return List<BuilderBuildingAmenityStages>
     */
    public List<ProjectSubstage> getprojectSubstageList()
    {
        String hql = "from ProjectSubstage where isDeleted=0";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<ProjectSubstage> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Project Substages by stage id
     * @param int stageId
     * @return List<ProjectSubstage>
     */
    public List<ProjectSubstage> getProjectSubstageByStageId(int stageId)
    {
        String hql = "from ProjectSubstage where projectStage.id = :stageId";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("stageId",stageId);
        List<ProjectSubstage> result = query.list();
        List<ProjectSubstage> projectSubstageList = new ArrayList<ProjectSubstage>();
        for(int i=0; i<result.size(); i++){
        	ProjectSubstage projectSubstage = new ProjectSubstage();
        	projectSubstage.setId(result.get(i).getId());
        	projectSubstage.setName(result.get(i).getName());
        	projectSubstage.setStatus(result.get(i).getStatus());
        	projectSubstageList.add(projectSubstage);
        }
        session.close();
        return projectSubstageList;
    }
    
    public List<ProjectSubstage> getProjectSubstageById(int id)
    {
        String hql = "from ProjectSubstage where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<ProjectSubstage> result = query.list();
        session.close();
        return result;
    }
    
    public List<ProjectSubstageList> getBuildingAmenityById(int id) {
		String hql = "from ProjectSubstage where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<ProjectSubstage> result = query.list();
		List<ProjectSubstageList> buildingAmenityLists = new ArrayList<ProjectSubstageList>();
		for(ProjectSubstage projectSubstage : result){
			ProjectSubstageList buildingAmenityList = new ProjectSubstageList();
			buildingAmenityList.setId(projectSubstage.getId());
			buildingAmenityList.setProjectStageName(projectSubstage.getProjectStage().getName());
			buildingAmenityList.setProjectSubstageName(projectSubstage.getName());
			buildingAmenityList.setStatus(projectSubstage.getStatus());
			buildingAmenityLists.add(buildingAmenityList);
		}
		session.close();
		return buildingAmenityLists;
	}
}