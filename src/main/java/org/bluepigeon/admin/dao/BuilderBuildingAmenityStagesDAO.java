package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.data.BuildingAmenityList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuildingAmenity;
import org.bluepigeon.admin.model.BuilderBuildingAmenityStages;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderBuildingAmenityStagesDAO {
    /**
     * Save Building Amenity Stages
     * 
     * @param Amenity Stages
     * @return String
     */
    public ResponseMessage save(BuilderBuildingAmenityStages builderBuildingAmenityStages){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (builderBuildingAmenityStages.getName() == null || builderBuildingAmenityStages.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter Building amenity stage name");
        }
        if(builderBuildingAmenityStages.getBuilderBuildingAmenity().getId().equals(null)  || builderBuildingAmenityStages.getBuilderBuildingAmenity().getId()==0){
        	 response.setStatus(0);
             response.setMessage("Please select Amenity name");
        }
        else {
        	String hql = "from BuilderBuildingAmenityStages where name = :name and builderBuildingAmenity.id = :amenity_id";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", builderBuildingAmenityStages.getName());
			query.setParameter("amenity_id", builderBuildingAmenityStages.getBuilderBuildingAmenity().getId());
			List<BuilderBuildingAmenityStages> result = query.list();
			session.close();
			if (result.size() > 0) {
				if(result.get(0).getIsDeleted() ==1){
					byte isDeleted=0;
					builderBuildingAmenityStages.setId(result.get(0).getId());
					builderBuildingAmenityStages.setIsDeleted(isDeleted);
					Session newsession = hibernateUtil.openSession();
					newsession.beginTransaction();
					newsession.update(builderBuildingAmenityStages);
					newsession.getTransaction().commit();
					newsession.close();
					response.setStatus(1);
					response.setMessage("Building Amenity Stage Added Successfully");
				}else{
					response.setStatus(0);
					response.setMessage("Building Amenity Stage name already exists");
				}
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(builderBuildingAmenityStages);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Building Amenity Stage Added Successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(BuilderBuildingAmenityStages builderBuildingAmenityStages){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderBuildingAmenityStages where name = :name and builderBuildingAmenity.id = :amenity_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderBuildingAmenityStages.getName());
		query.setParameter("amenity_id", builderBuildingAmenityStages.getBuilderBuildingAmenity().getId());
		query.setParameter("id", builderBuildingAmenityStages.getId());
		List<BuilderBuildingAmenityStages> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Amenity stage name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(builderBuildingAmenityStages);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Success");
		}
        return response;
    }
    public ResponseMessage delete(BuilderBuildingAmenityStages builderBuildingAmenityStages) {
		
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from BuilderBuildingAmenityStages where id = :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderBuildingAmenityStages.getId());
		List<BuilderBuildingAmenityStages> result = query.list();
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
			response.setMessage("Building Amenity satge Deleted Successfully");
		} 
		else{
			response.setStatus(0);
			response.setMessage("Building Amenity stage Fail to Delete");
		}

		return response;
	}
    
    /**
     * Get All Building amenity stages    
     * @return List<BuilderBuildingAmenityStages>
     */
    public List<BuilderBuildingAmenityStages> getBuilderBuildingAmenityStagesList()
    {
        String hql = "from BuilderBuildingAmenityStages where isDeleted=0";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<BuilderBuildingAmenityStages> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Building Amenity Stages by amenity id
     * @param int countryID
     * @return List<BuilderBuildingAmenityStages>
     */
    public List<BuilderBuildingAmenityStages> getStateByAmenityId(int amenityId)
    {
        System.out.println("country="+amenityId);
        String hql = "from BuilderBuildingAmenityStages where builderBuildingAmenity.id = :amenityId";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("amenityId", amenityId);
        List<BuilderBuildingAmenityStages> result = query.list();
        List<BuilderBuildingAmenityStages> builderBuildingAmenityStagesList = new ArrayList<BuilderBuildingAmenityStages>();
        for(int i=0; i<result.size(); i++){
        	BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();
        	builderBuildingAmenityStages.setId(result.get(i).getId());
        	builderBuildingAmenityStages.setName(result.get(i).getName());
        	builderBuildingAmenityStages.setStatus(result.get(i).getStatus());
        	builderBuildingAmenityStagesList.add(builderBuildingAmenityStages);
        }
        session.close();
        System.out.println("Size1="+result.size());
        return builderBuildingAmenityStagesList;
    }
    
    public List<BuilderBuildingAmenityStages> getBuilderBuildingAmenityStagesById(int id)
    {
        String hql = "from BuilderBuildingAmenityStages where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<BuilderBuildingAmenityStages> result = query.list();
        session.close();
        return result;
    }
    
    public List<BuildingAmenityList> getBuildingAmenityById(int id) {
		String hql = "from BuilderBuildingAmenityStages where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderBuildingAmenityStages> result = query.list();
		List<BuildingAmenityList> buildingAmenityLists = new ArrayList<BuildingAmenityList>();
		for(BuilderBuildingAmenityStages builderBuildingAmenity : result){
			BuildingAmenityList buildingAmenityList = new BuildingAmenityList();
			buildingAmenityList.setId(builderBuildingAmenity.getId());
			buildingAmenityList.setBuildingAmenityName(builderBuildingAmenity.getBuilderBuildingAmenity().getName());
			buildingAmenityList.setBuildingAmenityStageName(builderBuildingAmenity.getName());
			buildingAmenityList.setStatus(builderBuildingAmenity.getStatus());
			buildingAmenityLists.add(buildingAmenityList);
		}
		session.close();
		return buildingAmenityLists;
	}
}