package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.data.BuildingAmenityList;
import org.bluepigeon.admin.data.BuildingSubstageList;
import org.bluepigeon.admin.data.ProjectSubstageList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuildingAmenity;
import org.bluepigeon.admin.model.BuilderBuildingAmenityStages;
import org.bluepigeon.admin.model.BuildingSubstage;
import org.bluepigeon.admin.model.ProjectSubstage;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuildingSubstagesDAO {
    /**
     * Save Building Substages
     * 
     * @param Building Substages
     * @return String
     */
    public ResponseMessage save(BuildingSubstage buildingSubstage){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (buildingSubstage.getName() == null || buildingSubstage.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter building substage name");
        }
        if(buildingSubstage.getBuildingStage().getId().equals(null)  || (buildingSubstage.getBuildingStage().getId()==0)){
        	 response.setStatus(0);
             response.setMessage("Please select building stage name");
        }
        else {
        	String hql = "from BuildingSubstage where name = :name and buildingStage.id = :stage_id";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", buildingSubstage.getName());
			query.setParameter("stage_id", buildingSubstage.getBuildingStage().getId());
			List<BuildingSubstage> result = query.list();
			session.close();
			if (result.size() > 0) {
				if(result.get(0).getIsDeleted() ==1){
					byte isDeleted=0;
					buildingSubstage.setId(result.get(0).getId());
					buildingSubstage.setIsDeleted(isDeleted);
					Session newsession = hibernateUtil.openSession();
					newsession.beginTransaction();
					newsession.update(buildingSubstage);
					newsession.getTransaction().commit();
					newsession.close();
					response.setStatus(1);
					response.setMessage("Building Substage Added Successfully");
				}else{
					response.setStatus(0);
					response.setMessage("Building Substage name already exists");
				}
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(buildingSubstage);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Building Substage Added Successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(BuildingSubstage buildingSubstage){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuildingSubstage where name = :name and buildingStage.id = :stage_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", buildingSubstage.getName());
		query.setParameter("stage_id", buildingSubstage.getBuildingStage().getId());
		query.setParameter("id", buildingSubstage.getId());
		List<BuildingSubstage> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Building substage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(buildingSubstage);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Building Substage updated Successfully");
		}
        return response;
    }
    public ResponseMessage delete(BuildingSubstage buildingSubstage) {
		
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from BuildingSubstage where id = :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", buildingSubstage.getId());
		List<BuilderBuildingAmenityStages> result = query.list();
		session.close();
		if (result.size() > 0) {
			buildingSubstage.setName(result.get(0).getName());
			buildingSubstage.setStatus(result.get(0).getStatus());
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(buildingSubstage);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Building Substage Deleted Successfully");
		} 
		else{
			response.setStatus(0);
			response.setMessage("Building Substage Fail to Delete");
		}

		return response;
	}
    
    /**
     * Get All building substages    
     * @return List<BuildingSubstage>
     */
    public List<BuildingSubstage> getBuildingSubstageList()
    {
        String hql = "from BuildingSubstage where isDeleted=0";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<BuildingSubstage> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Building Substages by stage id
     * @param int stageId
     * @return List<BuildingSubstage>
     */
    public List<BuildingSubstage> getBuildingSubstageByStageId(int stageId)
    {
        String hql = "from BuildingSubstage where buildingStage.id = :stageId and isDeleted=0";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("stageId",stageId);
        List<BuildingSubstage> result = query.list();
        List<BuildingSubstage> buildingSubstagesList = new ArrayList<BuildingSubstage>();
        for(int i=0; i<result.size(); i++){
        	BuildingSubstage buildingSubstage = new BuildingSubstage();
        	buildingSubstage.setId(result.get(i).getId());
        	buildingSubstage.setName(result.get(i).getName());
        	buildingSubstage.setStatus(result.get(i).getStatus());
        	buildingSubstagesList.add(buildingSubstage);
        }
        session.close();
        return buildingSubstagesList;
    }
    
    public List<BuildingSubstage> getBuildingSubstagesByStageId(int stageId)
    {
        String hql = "from BuildingSubstage where buildingStage.id = :stageId and isDeleted=0";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("stageId",stageId);
        List<BuildingSubstage> result = query.list();
        session.close();
        return result;
    }
    
    public List<BuildingSubstage> getBuildingSubstageById(int id)
    {
        String hql = "from BuildingSubstage where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<BuildingSubstage> result = query.list();
        session.close();
        return result;
    }
    
    public List<BuildingSubstageList> getBuildingSubstageListById(int id) {
		String hql = "from BuildingSubstage where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuildingSubstage> result = query.list();
		List<BuildingSubstageList> buildingSubstageLists = new ArrayList<BuildingSubstageList>();
		for(BuildingSubstage projectSubstage : result){
			BuildingSubstageList buildingSubstageList = new BuildingSubstageList();
			buildingSubstageList.setId(projectSubstage.getId());
			buildingSubstageList.setBuildingStageName(projectSubstage.getBuildingStage().getName());
			buildingSubstageList.setBuildingSubstageName(projectSubstage.getName());
			buildingSubstageList.setStatus(projectSubstage.getStatus());
			buildingSubstageLists.add(buildingSubstageList);
		}
		session.close();
		return buildingSubstageLists;
	}
}