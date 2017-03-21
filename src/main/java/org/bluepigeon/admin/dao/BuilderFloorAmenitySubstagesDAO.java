package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderFloorAmenitySubstages;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderFloorAmenitySubstagesDAO {
    /**
     * Save Floor Amenity Substages
     * 
     * @param Amenity Substages
     * @return String
     */
    public ResponseMessage save(BuilderFloorAmenitySubstages builderFloorAmenitySubstages){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (builderFloorAmenitySubstages.getName() == null || builderFloorAmenitySubstages.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter Floor amenity substage name");
        }
        if(builderFloorAmenitySubstages.getBuilderFloorAmenityStages().getId().equals(null)  || builderFloorAmenitySubstages.getBuilderFloorAmenityStages().getId()==0){
        	 response.setStatus(0);
             response.setMessage("Please select Amenity stage name");
        }
        else {
            String hql = "from BuilderFloorAmenitySubstages where name = :name";
            Session session = hibernateUtil.openSession();
            Query query = session.createQuery(hql);
            query.setParameter("name", builderFloorAmenitySubstages.getName());
            List<BuilderFloorAmenitySubstages> result = query.list();
            session.close();
            if (result.size() > 0) {
                response.setStatus(0);
                response.setMessage("Floor Amenity Substage name already exists");
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(builderFloorAmenitySubstages);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Floor Amenity Substage added Successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(BuilderFloorAmenitySubstages builderFloorAmenityStages){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderFloorAmenitySubstages where name = :name and builderFloorAmenityStages.id = :stage_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderFloorAmenityStages.getName());
		query.setParameter("stage_id", builderFloorAmenityStages.getBuilderFloorAmenityStages().getId());
		query.setParameter("id", builderFloorAmenityStages.getId());
		List<BuilderFloorAmenitySubstages> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Floor amenity substage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(builderFloorAmenityStages);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Floor Amenity Substage Updated Successfully");
		}
        return response;
    }
    public ResponseMessage delete(BuilderFloorAmenitySubstages builderFloorAmenityStages) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderFloorAmenitySubstages where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderFloorAmenityStages.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Floor Amenity Substage Deleted Successfully");

		return response;
	}
    
    /**
     * Get All Floor amenity stages    
     * @return List<BuilderFloorAmenitySubstages>
     */
    public List<BuilderFloorAmenitySubstages> getBuilderFloorAmenitySubstagesList()
    {
        String hql = "from BuilderFloorAmenitySubstages";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<BuilderFloorAmenitySubstages> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Floor Amenity Substages by stage id
     * @param int stageID
     * @return List<BuilderFloorAmenitySubstages>
     */
    public List<BuilderFloorAmenitySubstages> getBuilderFloorAmenitySubstagesByStageId(int stageId)
    {
        String hql = "from BuilderFloorAmenitySubstages where builderFloorAmenityStages.id = :stageId";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("stageId", stageId);
        List<BuilderFloorAmenitySubstages> result = query.list();
//        List<BuilderFloorAmenitySubstages> builderFloorAmenityStagesList = new ArrayList<BuilderFloorAmenitySubstages>();
//        for(int i=0; i<result.size(); i++){
//        	BuilderFloorAmenitySubstages builderFloorAmenityStages = new BuilderFloorAmenitySubstages();
//        	builderFloorAmenityStages.setId(result.get(i).getId());
//        	builderFloorAmenityStages.setName(result.get(i).getName());
//        	builderFloorAmenityStages.setStatus(result.get(i).getStatus());
//        	builderFloorAmenityStagesList.add(builderFloorAmenityStages);
//        }
        session.close();
     
        return result;
    }
    
    public List<BuilderFloorAmenitySubstages> getBuilderFloorAmenityStagesById(int id)
    {
        String hql = "from BuilderFloorAmenitySubstages where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<BuilderFloorAmenitySubstages> result = query.list();
        session.close();
        return result;
    }
}