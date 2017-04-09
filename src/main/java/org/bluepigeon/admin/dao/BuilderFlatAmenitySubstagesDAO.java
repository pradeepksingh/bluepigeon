package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderFlatAmenitySubstages;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderFlatAmenitySubstagesDAO {
    /**
     * Save Flat Amenity Substages
     * 
     * @param Amenity Substages
     * @return String
     */
    public ResponseMessage save(BuilderFlatAmenitySubstages builderFlatAmenitySubstages){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (builderFlatAmenitySubstages.getName() == null || builderFlatAmenitySubstages.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter Flat amenity substage name");
        }
        if(builderFlatAmenitySubstages.getBuilderFlatAmenityStages().getId().equals(null)  || builderFlatAmenitySubstages.getBuilderFlatAmenityStages().getId()==0){
        	 response.setStatus(0);
             response.setMessage("Please select Amenity stage name");
        }
        else {
            String hql = "from BuilderFlatAmenitySubstages where name = :name and builderFlatAmenityStages.id = :stage_id";
            Session session = hibernateUtil.openSession();
            Query query = session.createQuery(hql);
            query.setParameter("name", builderFlatAmenitySubstages.getName());
            query.setParameter("stage_id", builderFlatAmenitySubstages.getBuilderFlatAmenityStages().getId());
            List<BuilderFlatAmenitySubstages> result = query.list();
            session.close();
            if (result.size() > 0) {
                response.setStatus(0);
                response.setMessage("Flat Amenity Substage name already exists");
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(builderFlatAmenitySubstages);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Flat Amenity Substage added Successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(BuilderFlatAmenitySubstages builderFlatAmenityStages){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderFlatAmenitySubstages where name = :name and builderFlatAmenityStages.id = :stage_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderFlatAmenityStages.getName());
		query.setParameter("stage_id", builderFlatAmenityStages.getBuilderFlatAmenityStages().getId());
		query.setParameter("id", builderFlatAmenityStages.getId());
		List<BuilderFlatAmenitySubstages> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Flat amenity substage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(builderFlatAmenityStages);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Flat Amenity Substage Updated Successfully");
		}
        return response;
    }
    public ResponseMessage delete(BuilderFlatAmenitySubstages builderFlatAmenityStages) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderFlatAmenitySubstages where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderFlatAmenityStages.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Flat Amenity Substage Deleted Successfully");

		return response;
	}
    
    /**
     * Get All Flat amenity stages    
     * @return List<BuilderFlatAmenitySubstages>
     */
    public List<BuilderFlatAmenitySubstages> getBuilderFlatAmenitySubstagesList()
    {
        String hql = "from BuilderFlatAmenitySubstages";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<BuilderFlatAmenitySubstages> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Flat Amenity Substages by stage id
     * @param int stageID
     * @return List<BuilderFlatAmenitySubstages>
     */
    public List<BuilderFlatAmenitySubstages> getBuilderFlatAmenitySubstagesByStageId(int stageId)
    {
        String hql = "from BuilderFlatAmenitySubstages where builderFlatAmenityStages.id = :stageId";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("stageId", stageId);
        List<BuilderFlatAmenitySubstages> result = query.list();
//        List<BuilderFlatAmenitySubstages> builderFlatAmenityStagesList = new ArrayList<BuilderFlatAmenitySubstages>();
//        for(int i=0; i<result.size(); i++){
//        	BuilderFlatAmenitySubstages builderFlatAmenityStages = new BuilderFlatAmenitySubstages();
//        	builderFlatAmenityStages.setId(result.get(i).getId());
//        	builderFlatAmenityStages.setName(result.get(i).getName());
//        	builderFlatAmenityStages.setStatus(result.get(i).getStatus());
//        	builderFlatAmenityStagesList.add(builderFlatAmenityStages);
//        }
        session.close();
     
        return result;
    }
    
    public List<BuilderFlatAmenitySubstages> getBuilderFlatAmenityStagesById(int id)
    {
        String hql = "from BuilderFlatAmenitySubstages where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<BuilderFlatAmenitySubstages> result = query.list();
        session.close();
        return result;
    }
}