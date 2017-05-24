package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.data.FloorSubstageList;
import org.bluepigeon.admin.data.ProjectSubstageList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.FloorSubstage;
import org.bluepigeon.admin.model.ProjectSubstage;
import org.bluepigeon.admin.util.HibernateUtil;

public class FloorSubstagesDAO {
    /**
     * Save Floor Substages
     * 
     * @param Floor Substages
     * @return String
     */
    public ResponseMessage save(FloorSubstage floorSubstage){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (floorSubstage.getName() == null || floorSubstage.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter floor substage name");
        }
        if(floorSubstage.getFloorStage().getId().equals(null)  || (floorSubstage.getFloorStage().getId()==0)){
        	 response.setStatus(0);
             response.setMessage("Please select floor stage name");
        }
        else {
        	String hql = "from FloorSubstage where name = :name and floorStage.id = :stage_id";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", floorSubstage.getName());
			query.setParameter("stage_id", floorSubstage.getFloorStage().getId());
			List<ProjectSubstage> result = query.list();
			session.close();
			if (result.size() > 0) {
				if(result.get(0).getIsDeleted() ==1){
					byte isDeleted=0;
					floorSubstage.setId(result.get(0).getId());
					floorSubstage.setIsDeleted(isDeleted);
					Session newsession = hibernateUtil.openSession();
					newsession.beginTransaction();
					newsession.update(floorSubstage);
					newsession.getTransaction().commit();
					newsession.close();
					response.setStatus(1);
					response.setMessage("Floor Substage Added Successfully");
				}else{
					response.setStatus(0);
					response.setMessage("Floor Substage name already exists");
				}
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(floorSubstage);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Floor Substage Added Successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(FloorSubstage floorSubstage){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from FloorSubstage where name = :name and floorStage.id = :stage_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", floorSubstage.getName());
		query.setParameter("stage_id", floorSubstage.getFloorStage().getId());
		query.setParameter("id", floorSubstage.getId());
		List<ProjectSubstage> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Floor substage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(floorSubstage);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Floor Substage updated Successfully");
		}
        return response;
    }
    public ResponseMessage delete(FloorSubstage floorSubstage) {
		
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from FloorSubstage where id = :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", floorSubstage.getId());
		List<FloorSubstage> result = query.list();
		session.close();
		if (result.size() > 0) {
			floorSubstage.setName(result.get(0).getName());
			floorSubstage.setStatus(result.get(0).getStatus());
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(floorSubstage);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Floor Substage Deleted Successfully");
		} 
		else{
			response.setStatus(0);
			response.setMessage("Floor Substage Fail to Delete");
		}

		return response;
	}
    
    /**
     * Get All floor substages    
     * @return List<FloorSubstage>
     */
    public List<FloorSubstage> getFloorSubstageList()
    {
        String hql = "from FloorSubstage where isDeleted=0";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<FloorSubstage> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Floor Substages by stage id
     * @param int stageId
     * @return List<FloorSubstage>
     */
    public List<FloorSubstage> getFloorSubstageByStageId(int stageId)
    {
        String hql = "from FloorSubstage where floorStage.id = :stageId and isDeleted=0";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("stageId",stageId);
        List<FloorSubstage> result = query.list();
        List<FloorSubstage> floorSubstagesList = new ArrayList<FloorSubstage>();
        for(int i=0; i<result.size(); i++){
        	FloorSubstage floorSubstage = new FloorSubstage();
        	floorSubstage.setId(result.get(i).getId());
        	floorSubstage.setName(result.get(i).getName());
        	floorSubstage.setStatus(result.get(i).getStatus());
        	floorSubstagesList.add(floorSubstage);
        }
        session.close();
        return floorSubstagesList;
    }
    
    public List<FloorSubstage> getFloorSubstagesByStageId(int stageId)
    {
        String hql = "from FloorSubstage where floorStage.id = :stageId and isDeleted=0";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("stageId",stageId);
        List<FloorSubstage> result = query.list();
        session.close();
        return result;
    }
    
    public List<FloorSubstage> getFloorSubstageById(int id)
    {
        String hql = "from FloorSubstage where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<FloorSubstage> result = query.list();
        session.close();
        return result;
    }
    
    public List<FloorSubstageList> getFloorSubstageListById(int id) {
		String hql = "from FloorSubstage where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<FloorSubstage> result = query.list();
		List<FloorSubstageList> floorSubstageLists = new ArrayList<FloorSubstageList>();
		for(FloorSubstage floorSubstage : result){
			FloorSubstageList floorSubstageList = new FloorSubstageList();
			floorSubstageList.setId(floorSubstage.getId());
			floorSubstageList.setFloorStageName(floorSubstage.getFloorStage().getName());
			floorSubstageList.setFloorSubstageName(floorSubstage.getName());
			floorSubstageList.setStatus(floorSubstage.getStatus());
			floorSubstageLists.add(floorSubstageList);
		}
		session.close();
		return floorSubstageLists;
	}
}