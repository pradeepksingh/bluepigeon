package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderPaymentSubstages;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderPaymentSubstagesDAO {
    /**
     * Save Floor Amenity Stages
     * 
     * @param Amenity Stages
     * @return String
     */
    public ResponseMessage save(BuilderPaymentSubstages builderPaymentSubstages){
        ResponseMessage response = new ResponseMessage();
        HibernateUtil hibernateUtil = new HibernateUtil();
        if (builderPaymentSubstages.getName() == null || builderPaymentSubstages.getName().trim().length() == 0) {
            response.setStatus(0);
            response.setMessage("Please enter builder payment substage name");
        }
        if(builderPaymentSubstages.getBuilderPaymentStages().getId().equals(null)  || builderPaymentSubstages.getBuilderPaymentStages().getId()==0){
        	 response.setStatus(0);
             response.setMessage("Please select Payment Stage name");
        }
        else {
            String hql = "from BuilderPaymentSubstages where name = :name and builderPaymentStages.id = :stage_id";
            Session session = hibernateUtil.openSession();
            Query query = session.createQuery(hql);
            query.setParameter("name", builderPaymentSubstages.getName());
            query.setParameter("stage_id", builderPaymentSubstages.getBuilderPaymentStages().getId());
            List<BuilderPaymentSubstages> result = query.list();
            session.close();
            if (result.size() > 0) {
                response.setStatus(0);
                response.setMessage("Payment Substage name already exists");
            } else {
                Session newsession = hibernateUtil.openSession();
                newsession.beginTransaction();
                newsession.save(builderPaymentSubstages);
                newsession.getTransaction().commit();
                newsession.close();
                response.setStatus(1);
                response.setMessage("Payment Substages added successfully");
            }
        }
        return response;
    }
    
    public ResponseMessage update(BuilderPaymentSubstages builderPaymentSubstages){
    	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderPaymentSubstages where name = :name and builderPaymentStages.id = :payment_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderPaymentSubstages.getName());
		query.setParameter("payment_id", builderPaymentSubstages.getBuilderPaymentStages().getId());
		query.setParameter("id", builderPaymentSubstages.getId());
		List<BuilderPaymentSubstages> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Paymeny Substages name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(builderPaymentSubstages);
	        System.out.println("Builder Payment Stage id :: "+builderPaymentSubstages.getBuilderPaymentStages().getId());
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("Paymeny Substages updated successfully");
		}
        return response;
    }
    public ResponseMessage delete(BuilderPaymentSubstages builderPaymentSubstages) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderPaymentSubstages where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderPaymentSubstages.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Payment substage deleted successfuly");

		return response;
	}
    
    /**
     * Get All Floor amenity stages    
     * @return List<BuilderPaymentSubstages>
     */
    public List<BuilderPaymentSubstages> getBuilderPaymentSubstagesList()
    {
        String hql = "from BuilderPaymentSubstages";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        List<BuilderPaymentSubstages> result = query.list();
        session.close();
        return result;
    }
    
    /**
     * Get Floor Amenity Stages by amenity id
     * @param int countryID
     * @return List<BuilderFloorAmenityStages>
     */
    public List<BuilderPaymentSubstages> getBuilderPaymentSubstagesByPaymentId(int paymentId)
    {
        
        String hql = "from BuilderPaymentSubstages where builderPaymentStages.id = :paymentId";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("paymentId", paymentId);
        List<BuilderPaymentSubstages> result = query.list();
       /* List<BuilderPaymentSubstages> builderFloorAmenityStagesList = new ArrayList<BuilderPaymentSubstages>();
        for(int i=0; i<result.size(); i++){
        	BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
        	builderFloorAmenityStages.setId(result.get(i).getId());
        	builderFloorAmenityStages.setName(result.get(i).getName());
        	builderFloorAmenityStages.setStatus(result.get(i).getStatus());
        	builderFloorAmenityStagesList.add(builderFloorAmenityStages);
        }*/
        session.close();
        return result;
    }
    
    public List<BuilderPaymentSubstages> getBuilderPaymentSubstagesById(int id)
    {
        String hql = "from BuilderPaymentSubstages where id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<BuilderPaymentSubstages> result = query.list();
        session.close();
        return result;
    }
}