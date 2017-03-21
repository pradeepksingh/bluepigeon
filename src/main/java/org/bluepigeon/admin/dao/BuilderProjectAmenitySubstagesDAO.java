package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderProjectAmenitySubstages;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderProjectAmenitySubstagesDAO {
    /**
     * Save Project Amenity Substages
     * 
     * @param Amenity Substages
     * @return String
     */
    public ResponseMessage save(BuilderProjectAmenitySubstages builderProjectAmenitySubstages){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (builderProjectAmenitySubstages.getName() == null || builderProjectAmenitySubstages.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter Project amenity substage name");
        }
        if(builderProjectAmenitySubstages.getBuilderProjectAmenityStages().getId().equals(null)  || builderProjectAmenitySubstages.getBuilderProjectAmenityStages().getId()==0){
        	 response.setStatus(0);
             response.setMessage("Please select Amenity stage name");
        }
        else {
            String hql = "from BuilderProjectAmenitySubstages where name = :name";
            Session session = hibernateUtil.openSession();
            Query query = session.createQuery(hql);
            query.setParameter("name", builderProjectAmenitySubstages.getName());
            List<BuilderProjectAmenitySubstages> result = query.list();
            session.close();
            if (result.size() > 0) {
                response.setStatus(0);
                response.setMessage("Project Amenity Substage name already exists");
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(builderProjectAmenitySubstages);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Project Amenity Substage added Successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(BuilderProjectAmenitySubstages builderProjectAmenityStages){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderProjectAmenitySubstages where name = :name and builderProjectAmenityStages.id = :stage_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderProjectAmenityStages.getName());
		query.setParameter("stage_id", builderProjectAmenityStages.getBuilderProjectAmenityStages().getId());
		query.setParameter("id", builderProjectAmenityStages.getId());
		List<BuilderProjectAmenitySubstages> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Project amenity substage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(builderProjectAmenityStages);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Project Amenity Substage Updated Successfully");
		}
        return response;
    }
    public ResponseMessage delete(BuilderProjectAmenitySubstages builderProjectAmenityStages) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderProjectAmenitySubstages where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderProjectAmenityStages.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Project Amenity Substage Deleted Successfully");

		return response;
	}
    
    /**
     * Get All Project amenity stages    
     * @return List<BuilderProjectAmenitySubstages>
     */
    public List<BuilderProjectAmenitySubstages> getBuilderProjectAmenitySubstagesList()
    {
        String hql = "from BuilderProjectAmenitySubstages";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<BuilderProjectAmenitySubstages> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Project Amenity Substages by stage id
     * @param int stageID
     * @return List<BuilderProjectAmenitySubstages>
     */
    public List<BuilderProjectAmenitySubstages> getBuilderProjectAmenitySubstagesByStageId(int stageId)
    {
        String hql = "from BuilderProjectAmenitySubstages where builderProjectAmenityStages.id = :stageId";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("stageId", stageId);
        List<BuilderProjectAmenitySubstages> result = query.list();
//        List<BuilderProjectAmenitySubstages> builderProjectAmenityStagesList = new ArrayList<BuilderProjectAmenitySubstages>();
//        for(int i=0; i<result.size(); i++){
//        	BuilderProjectAmenitySubstages builderProjectAmenityStages = new BuilderProjectAmenitySubstages();
//        	builderProjectAmenityStages.setId(result.get(i).getId());
//        	builderProjectAmenityStages.setName(result.get(i).getName());
//        	builderProjectAmenityStages.setStatus(result.get(i).getStatus());
//        	builderProjectAmenityStagesList.add(builderProjectAmenityStages);
//        }
        session.close();
     
        return result;
    }
    
    public List<BuilderProjectAmenitySubstages> getBuilderProjectAmenityStagesById(int id)
    {
        String hql = "from BuilderProjectAmenitySubstages where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<BuilderProjectAmenitySubstages> result = query.list();
        session.close();
        return result;
    }
}