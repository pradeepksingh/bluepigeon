package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.data.BuildingAmenityList;
import org.bluepigeon.admin.data.FlatSubstageList;
import org.bluepigeon.admin.data.ProjectSubstageList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuildingAmenity;
import org.bluepigeon.admin.model.BuilderBuildingAmenityStages;
import org.bluepigeon.admin.model.FlatSubstage;
import org.bluepigeon.admin.util.HibernateUtil;

public class FlatSubstagesDAO {
    /**
     * Save Flat Substages
     * 
     * @param Flat Substages
     * @return String
     */
    public ResponseMessage save(FlatSubstage flatSubstage){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (flatSubstage.getName() == null || flatSubstage.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter flat substage name");
        }
        if(flatSubstage.getFlatStage().getId().equals(null)  || (flatSubstage.getFlatStage().getId()==0)){
        	 response.setStatus(0);
             response.setMessage("Please select flat stage name");
        }
        else {
        	String hql = "from FlatSubstage where name = :name and flatStage.id = :stage_id";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", flatSubstage.getName());
			query.setParameter("stage_id", flatSubstage.getFlatStage().getId());
			List<FlatSubstage> result = query.list();
			session.close();
			if (result.size() > 0) {
				if(result.get(0).getIsDeleted() ==1){
					byte isDeleted=0;
					flatSubstage.setId(result.get(0).getId());
					flatSubstage.setIsDeleted(isDeleted);
					Session newsession = hibernateUtil.openSession();
					newsession.beginTransaction();
					newsession.update(flatSubstage);
					newsession.getTransaction().commit();
					newsession.close();
					response.setStatus(1);
					response.setMessage("Flat Substage Added Successfully");
				}else{
					response.setStatus(0);
					response.setMessage("Flat Substage name already exists");
				}
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(flatSubstage);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Flat Substage Added Successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(FlatSubstage flatSubstage){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from FlatSubstage where name = :name and flatStage.id = :stage_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", flatSubstage.getName());
		query.setParameter("stage_id", flatSubstage.getFlatStage().getId());
		query.setParameter("id", flatSubstage.getId());
		List<FlatSubstage> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Flat substage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(flatSubstage);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Flat Substage updated Successfully");
		}
        return response;
    }
    public ResponseMessage delete(FlatSubstage flatSubstage) {
		
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from FlatSubstage where id = :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", flatSubstage.getId());
		List<BuilderBuildingAmenityStages> result = query.list();
		session.close();
		if (result.size() > 0) {
			flatSubstage.setName(result.get(0).getName());
			flatSubstage.setStatus(result.get(0).getStatus());
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(flatSubstage);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Flat Substage Deleted Successfully");
		} 
		else{
			response.setStatus(0);
			response.setMessage("Flat Substage Fail to Delete");
		}

		return response;
	}
    
    /**
     * Get All flat substages    
     * @return List<BuilderBuildingAmenityStages>
     */
    public List<FlatSubstage> getprojectSubstageList()
    {
        String hql = "from FlatSubstage where isDeleted=0";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<FlatSubstage> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get flat Substages by stage id
     * @param int stageId
     * @return List<FlatSubstage>
     */
    public List<FlatSubstage> getFlatSubstageByStageId(int stageId)
    {
        String hql = "from FlatSubstage where flatStage.id = :stageId";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("stageId",stageId);
        List<FlatSubstage> result = query.list();
        List<FlatSubstage> flatSubstageList = new ArrayList<FlatSubstage>();
        for(int i=0; i<result.size(); i++){
        	FlatSubstage flatSubstage = new FlatSubstage();
        	flatSubstage.setId(result.get(i).getId());
        	flatSubstage.setName(result.get(i).getName());
        	flatSubstage.setStatus(result.get(i).getStatus());
        	flatSubstageList.add(flatSubstage);
        }
        session.close();
        return flatSubstageList;
    }
    
    public List<FlatSubstage> getFlatSubstagesByStageId(int stageId)
    {
        String hql = "from FlatSubstage where flatStage.id = :stageId and isDeleted=0";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("stageId",stageId);
        List<FlatSubstage> result = query.list();
        session.close();
        return result;
    }
    
    public List<FlatSubstage> getFlatSubstageById(int id)
    {
        String hql = "from FlatSubstage where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<FlatSubstage> result = query.list();
        session.close();
        return result;
    }
    
    public List<FlatSubstageList> getFlatSubstageListById(int id) {
		String hql = "from FlatSubstage where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<FlatSubstage> result = query.list();
		List<FlatSubstageList> flatSubstageLists = new ArrayList<FlatSubstageList>();
		for(FlatSubstage flatSubstage : result){
			FlatSubstageList flatSubstageList = new FlatSubstageList();
			flatSubstageList.setId(flatSubstage.getId());
			flatSubstageList.setFlatStageName(flatSubstage.getFlatStage().getName());
			flatSubstageList.setFlatSubstageName(flatSubstage.getName());
			flatSubstageList.setStatus(flatSubstage.getStatus());
			flatSubstageLists.add(flatSubstageList);
		}
		session.close();
		return flatSubstageLists;
	}
}