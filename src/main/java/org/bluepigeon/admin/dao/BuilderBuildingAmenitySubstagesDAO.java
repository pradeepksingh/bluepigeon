package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuildingAmenityStages;
import org.bluepigeon.admin.model.BuilderBuildingAmenitySubstages;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderBuildingAmenitySubstagesDAO {
    /**
     * Save Building Amenity Substages
     * 
     * @param Amenity Substages
     * @return String
     */
    public ResponseMessage save(BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (builderBuildingAmenitySubstages.getName() == null || builderBuildingAmenitySubstages.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter Building amenity substage name");
        }
        if(builderBuildingAmenitySubstages.getBuilderBuildingAmenityStages().getId().equals(null)  || builderBuildingAmenitySubstages.getBuilderBuildingAmenityStages().getId()==0){
        	 response.setStatus(0);
             response.setMessage("Please select Amenity stage name");
        }
        else {
            String hql = "from BuilderBuildingAmenitySubstages where name = :name";
            Session session = hibernateUtil.openSession();
            Query query = session.createQuery(hql);
            query.setParameter("name", builderBuildingAmenitySubstages.getName());
            List<BuilderBuildingAmenitySubstages> result = query.list();
            session.close();
            if (result.size() > 0) {
            	if(result.get(0).getIsDeleted() ==1){
					byte isDeleted=0;
					builderBuildingAmenitySubstages.setId(result.get(0).getId());
					builderBuildingAmenitySubstages.setIsDeleted(isDeleted);
					Session newsession = hibernateUtil.openSession();
					newsession.beginTransaction();
					newsession.update(builderBuildingAmenitySubstages);
					newsession.getTransaction().commit();
					newsession.close();
					response.setStatus(1);
					response.setMessage("Building Amenity Ssubstage Added Successfully");
				}else{
				response.setStatus(0);
				response.setMessage("Building Amenity Substage name already exists");
				}
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(builderBuildingAmenitySubstages);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Building Amenity Substage added Successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(BuilderBuildingAmenitySubstages builderBuildingAmenityStages){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderBuildingAmenitySubstages where name = :name and builderBuildingAmenityStages.id = :stage_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderBuildingAmenityStages.getName());
		query.setParameter("stage_id", builderBuildingAmenityStages.getBuilderBuildingAmenityStages().getId());
		query.setParameter("id", builderBuildingAmenityStages.getId());
		List<BuilderBuildingAmenitySubstages> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Building amenity substage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(builderBuildingAmenityStages);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Building Amenity Substage Updated Successfully");
		}
        return response;
    }
    public ResponseMessage delete(BuilderBuildingAmenitySubstages builderBuildingAmenityStages) {
		/*ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderBuildingAmenitySubstages where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderBuildingAmenityStages.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Building Amenity Substage Deleted Successfully");

		return response;*/
		
		
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from BuilderBuildingAmenitySubstages where id = :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderBuildingAmenityStages.getId());
		List<BuilderBuildingAmenitySubstages> result = query.list();
		session.close();
		if (result.size() > 0) {
			builderBuildingAmenityStages.setName(result.get(0).getName());
			builderBuildingAmenityStages.setStatus(result.get(0).getStatus());
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(builderBuildingAmenityStages);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Building Amenity subsatge Deleted Successfully");
		} 
		else{
			response.setStatus(0);
			response.setMessage("Building Amenity substage Fail to Delete");
		}

		return response;
	}
    
    /**
     * Get All Building amenity stages    
     * @return List<BuilderBuildingAmenitySubstages>
     */
    public List<BuilderBuildingAmenitySubstages> getBuilderBuildingAmenitySubstagesList()
    {
        String hql = "from BuilderBuildingAmenitySubstages";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<BuilderBuildingAmenitySubstages> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Building Amenity Substages by stage id
     * @param int stageID
     * @return List<BuilderBuildingAmenitySubstages>
     */
    public List<BuilderBuildingAmenitySubstages> getBuilderBuildingAmenitySubstagesByStageId(int stageId)
    {
        String hql = "from BuilderBuildingAmenitySubstages where builderBuildingAmenityStages.id = :stageId";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("stageId", stageId);
        List<BuilderBuildingAmenitySubstages> result = query.list();
//        List<BuilderBuildingAmenitySubstages> builderBuildingAmenityStagesList = new ArrayList<BuilderBuildingAmenitySubstages>();
//        for(int i=0; i<result.size(); i++){
//        	BuilderBuildingAmenitySubstages builderBuildingAmenityStages = new BuilderBuildingAmenitySubstages();
//        	builderBuildingAmenityStages.setId(result.get(i).getId());
//        	builderBuildingAmenityStages.setName(result.get(i).getName());
//        	builderBuildingAmenityStages.setStatus(result.get(i).getStatus());
//        	builderBuildingAmenityStagesList.add(builderBuildingAmenityStages);
//        }
        session.close();
     
        return result;
    }
    
    public List<BuilderBuildingAmenitySubstages> getBuilderBuildingAmenityStagesById(int id)
    {
        String hql = "from BuilderBuildingAmenitySubstages where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<BuilderBuildingAmenitySubstages> result = query.list();
        session.close();
        return result;
    }
}