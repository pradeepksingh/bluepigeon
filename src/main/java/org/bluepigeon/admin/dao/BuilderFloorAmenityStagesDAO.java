package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderFloorAmenityStages;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderFloorAmenityStagesDAO {
    /**
     * Save Floor Amenity Stages
     * 
     * @param Amenity Stages
     * @return String
     */
    public ResponseMessage save(BuilderFloorAmenityStages builderFloorAmenityStages){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (builderFloorAmenityStages.getName() == null || builderFloorAmenityStages.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter Floor amenity stage name");
        }
        if(builderFloorAmenityStages.getBuilderFloorAmenity().getId().equals(null)  || builderFloorAmenityStages.getBuilderFloorAmenity().getId()==0){
        	 response.setStatus(0);
             response.setMessage("Please select Amenity name");
        }
        else {
            String hql = "from BuilderFloorAmenityStages where name = :name and builderFloorAmenity.id = :amenity_id";
            Session session = hibernateUtil.openSession();
            Query query = session.createQuery(hql);
            query.setParameter("name", builderFloorAmenityStages.getName());
            query.setParameter("amenity_id", builderFloorAmenityStages.getBuilderFloorAmenity().getId());
            List<BuilderFloorAmenityStages> result = query.list();
            session.close();
            if (result.size() > 0) {
                response.setStatus(0);
                response.setMessage("Floor Amenity Stage name already exists");
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(builderFloorAmenityStages);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Floor Amenity Stage added successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(BuilderFloorAmenityStages builderFloorAmenityStages){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderFloorAmenityStages where name = :name and builderFloorAmenity.id = :amenity_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderFloorAmenityStages.getName());
		query.setParameter("amenity_id", builderFloorAmenityStages.getBuilderFloorAmenity().getId());
		query.setParameter("id", builderFloorAmenityStages.getId());
		List<BuilderFloorAmenityStages> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Floor amenity stage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(builderFloorAmenityStages);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Floor amenity stage updated successfully");
		}
        return response;
    }
    public ResponseMessage delete(BuilderFloorAmenityStages builderFloorAmenityStages) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderFloorAmenityStages where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderFloorAmenityStages.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Floor amenity stage deleted successfuly");

		return response;
	}
    
    /**
     * Get All Floor amenity stages    
     * @return List<BuilderFloorAmenityStages>
     */
    public List<BuilderFloorAmenityStages> getBuilderFloorAmenityStagesList()
    {
        String hql = "from BuilderFloorAmenityStages";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<BuilderFloorAmenityStages> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Floor Amenity Stages by amenity id
     * @param int countryID
     * @return List<BuilderFloorAmenityStages>
     */
    public List<BuilderFloorAmenityStages> getStateByAmenityId(int amenityId)
    {
        
        String hql = "from BuilderFloorAmenityStages where builderFloorAmenity.id = :amenityId";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("amenityId", amenityId);
        List<BuilderFloorAmenityStages> result = query.list();
        List<BuilderFloorAmenityStages> builderFloorAmenityStagesList = new ArrayList<BuilderFloorAmenityStages>();
        for(int i=0; i<result.size(); i++){
        	BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
        	builderFloorAmenityStages.setId(result.get(i).getId());
        	builderFloorAmenityStages.setName(result.get(i).getName());
        	builderFloorAmenityStages.setStatus(result.get(i).getStatus());
        	builderFloorAmenityStagesList.add(builderFloorAmenityStages);
        }
        session.close();
        return builderFloorAmenityStagesList;
    }
    
    public List<BuilderFloorAmenityStages> getBuilderFloorAmenityStagesById(int id)
    {
        String hql = "from BuilderFloorAmenityStages where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<BuilderFloorAmenityStages> result = query.list();
        session.close();
        return result;
    }
}