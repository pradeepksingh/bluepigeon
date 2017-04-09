package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderFlatAmenityStages;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderFlatAmenityStagesDAO {
    /**
     * Save Flat Amenity Stages
     * 
     * @param Amenity Stages
     * @return String
     */
    public ResponseMessage save(BuilderFlatAmenityStages builderFlatAmenityStages){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (builderFlatAmenityStages.getName() == null || builderFlatAmenityStages.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter Flat amenity stage name");
        }
        if(builderFlatAmenityStages.getBuilderFlatAmenity().getId().equals(null)  || builderFlatAmenityStages.getBuilderFlatAmenity().getId()==0){
        	 response.setStatus(0);
             response.setMessage("Please select Amenity name");
        }
        else {
            String hql = "from BuilderFlatAmenityStages where name = :name and builderFlatAmenity.id = :amenity_id";
            Session session = hibernateUtil.openSession();
            Query query = session.createQuery(hql);
            query.setParameter("name", builderFlatAmenityStages.getName());
            query.setParameter("amenity_id", builderFlatAmenityStages.getBuilderFlatAmenity().getId());
            List<BuilderFlatAmenityStages> result = query.list();
            session.close();
            if (result.size() > 0) {
                response.setStatus(0);
                response.setMessage("Flat Amenity Stage name already exists");
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(builderFlatAmenityStages);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Flat Amenity Stage added successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(BuilderFlatAmenityStages builderFlatAmenityStages){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderFlatAmenityStages where name = :name and builderFlatAmenity.id = :amenity_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderFlatAmenityStages.getName());
		query.setParameter("amenity_id", builderFlatAmenityStages.getBuilderFlatAmenity().getId());
		query.setParameter("id", builderFlatAmenityStages.getId());
		List<BuilderFlatAmenityStages> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Flat amenity stage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(builderFlatAmenityStages);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Flat amenity stage updated successfully");
		}
        return response;
    }
    public ResponseMessage delete(BuilderFlatAmenityStages builderFlatAmenityStages) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderFlatAmenityStages where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderFlatAmenityStages.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Flat amenity stage deleted successfuly");

		return response;
	}
    
    /**
     * Get All Flat amenity stages    
     * @return List<BuilderFlatAmenityStages>
     */
    public List<BuilderFlatAmenityStages> getBuilderFlatAmenityStagesList()
    {
        String hql = "from BuilderFlatAmenityStages";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<BuilderFlatAmenityStages> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Flat Amenity Stages by amenity id
     * @param int countryID
     * @return List<BuilderFlatAmenityStages>
     */
    public List<BuilderFlatAmenityStages> getStateByAmenityId(int amenityId)
    {
        
        String hql = "from BuilderFlatAmenityStages where builderFlatAmenity.id = :amenityId";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("amenityId", amenityId);
        List<BuilderFlatAmenityStages> result = query.list();
        List<BuilderFlatAmenityStages> builderFlatAmenityStagesList = new ArrayList<BuilderFlatAmenityStages>();
        for(int i=0; i<result.size(); i++){
        	BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
        	builderFlatAmenityStages.setId(result.get(i).getId());
        	builderFlatAmenityStages.setName(result.get(i).getName());
        	builderFlatAmenityStages.setStatus(result.get(i).getStatus());
        	builderFlatAmenityStagesList.add(builderFlatAmenityStages);
        }
        session.close();
        return builderFlatAmenityStagesList;
    }
    
    public List<BuilderFlatAmenityStages> getBuilderFlatAmenityStagesById(int id)
    {
        String hql = "from BuilderFlatAmenityStages where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<BuilderFlatAmenityStages> result = query.list();
        session.close();
        return result;
    }
}