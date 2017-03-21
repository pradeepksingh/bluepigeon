package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderProjectAmenityStages;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderProjectAmenityStagesDAO {
    /**
     * Save Project Amenity Stages
     * 
     * @param Amenity Stages
     * @return String
     */
    public ResponseMessage save(BuilderProjectAmenityStages builderProjectAmenityStages){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (builderProjectAmenityStages.getName() == null || builderProjectAmenityStages.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter Project amenity stage name");
        }
        if(builderProjectAmenityStages.getBuilderProjectAmenity().getId().equals(null)  || builderProjectAmenityStages.getBuilderProjectAmenity().getId()==0){
        	 response.setStatus(0);
             response.setMessage("Please select Amenity name");
        }
        else {
            String hql = "from BuilderProjectAmenityStages where name = :name";
            Session session = hibernateUtil.openSession();
            Query query = session.createQuery(hql);
            query.setParameter("name", builderProjectAmenityStages.getName());
            List<BuilderProjectAmenityStages> result = query.list();
            session.close();
            if (result.size() > 0) {
                response.setStatus(0);
                response.setMessage("Project Amenity Stage name already exists");
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(builderProjectAmenityStages);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Project Amenity Stage added successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(BuilderProjectAmenityStages builderProjectAmenityStages){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderProjectAmenityStages where name = :name and builderProjectAmenity.id = :amenity_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderProjectAmenityStages.getName());
		query.setParameter("amenity_id", builderProjectAmenityStages.getBuilderProjectAmenity().getId());
		query.setParameter("id", builderProjectAmenityStages.getId());
		List<BuilderProjectAmenityStages> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Project amenity stage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(builderProjectAmenityStages);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Project amenity stage updated successfully");
		}
        return response;
    }
    public ResponseMessage delete(BuilderProjectAmenityStages builderProjectAmenityStages) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderProjectAmenityStages where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderProjectAmenityStages.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Project amenity stage deleted successfuly");

		return response;
	}
    
    /**
     * Get All Project amenity stages    
     * @return List<BuilderProjectAmenityStages>
     */
    public List<BuilderProjectAmenityStages> getBuilderProjectAmenityStagesList()
    {
        String hql = "from BuilderProjectAmenityStages";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<BuilderProjectAmenityStages> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Project Amenity Stages by amenity id
     * @param int countryID
     * @return List<BuilderProjectAmenityStages>
     */
    public List<BuilderProjectAmenityStages> getStateByAmenityId(int amenityId)
    {
        
        String hql = "from BuilderProjectAmenityStages where builderProjectAmenity.id = :amenityId";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("amenityId", amenityId);
        List<BuilderProjectAmenityStages> result = query.list();
        List<BuilderProjectAmenityStages> builderProjectAmenityStagesList = new ArrayList<BuilderProjectAmenityStages>();
        for(int i=0; i<result.size(); i++){
        	BuilderProjectAmenityStages builderProjectAmenityStages = new BuilderProjectAmenityStages();
        	builderProjectAmenityStages.setId(result.get(i).getId());
        	builderProjectAmenityStages.setName(result.get(i).getName());
        	builderProjectAmenityStages.setStatus(result.get(i).getStatus());
        	builderProjectAmenityStagesList.add(builderProjectAmenityStages);
        }
        session.close();
        return builderProjectAmenityStagesList;
    }
    
    public List<BuilderProjectAmenityStages> getBuilderProjectAmenityStagesById(int id)
    {
        String hql = "from BuilderProjectAmenityStages where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<BuilderProjectAmenityStages> result = query.list();
        session.close();
        return result;
    }
}