package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.AgreementList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Agreement;
import org.bluepigeon.admin.model.AgreementBuyer;
import org.bluepigeon.admin.model.AgreementInfo;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Campaign;
import org.bluepigeon.admin.model.CampaignBuyer;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class AgreementDAO {
	/**
	 * @author pankaj
	 * @param agreement
	 * @return response
	 */
	public ResponseMessage saveAgreement(Agreement agreement){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(agreement);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setId(agreement.getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Agreement Added Successfully.");
		return responseMessage;
	}
	
	public ResponseMessage saveAgreementBuyer(List<AgreementBuyer> agreementBuyerList){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(AgreementBuyer agreementBuyer: agreementBuyerList)
			newsession.save(agreementBuyer);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Agreement Added Successfully.");
		return responseMessage;
	}
	/**
	 * @author pankaj
	 * @param agreement
	 * @return response
	 */
	public ResponseMessage updateAgreement(Agreement agreement){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(agreement);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(agreement.getId());
		response.setStatus(1);
		response.setMessage("Agreement updated Successfully.");
		return response;
	}
	/**
	 * @author pankaj
	 * @param id
	 * @return agreement's object
	 */
	public Agreement getAgreementById(int id){
		String hql = "from Agreement where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Agreement> result = query.list();
		session.close();
		return result.get(0);
	}
	
	public List<AgreementInfo> getAgreementInfoByAgreementId(int id){
		String hql = "from AgreementInfo where agreement.id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<AgreementInfo> result = query.list();
		return result;
	}
	/**
	 * @author pankaj
	 * @return list of agreement
	 */
	public List<AgreementList> getAllAgreement(){
		String hql = "from Agreement";
		String project_hql= "from BuilderProject where id = :id";
		String building_hql = "from BuilderBuilding where id = :id";
		String floor_hql = "from BuilderFloor where id = :id";
		String flat_hql = "from BuilderFlat where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Session projectSession = hibernateUtil.openSession();
		Session buildingSession = hibernateUtil.openSession();
		Session floorSession = hibernateUtil.openSession();
		Session flatSession = hibernateUtil.openSession();
		
		Query query = session.createQuery(hql);
		List<Agreement> result = query.list();
		List<AgreementList> agreement_list = new ArrayList<AgreementList>();
		for(Agreement agreement : result){
			AgreementList agreementList = new AgreementList();
			agreementList.setBuyerName(agreement.getName());
			agreementList.setId(agreement.getId());
			if(agreement.getBuilderProject() != null){
				Query projectQuery = projectSession.createQuery(project_hql);
				projectQuery.setParameter("id", agreement.getBuilderProject().getId());
				BuilderProject project = (BuilderProject)projectQuery.list().get(0);
				agreementList.setProjectName(project.getName());
			}
			if(agreement.getBuilderBuilding() != null){
				Query buildingQuery = buildingSession.createQuery(building_hql);
				buildingQuery.setParameter("id", agreement.getBuilderBuilding().getId());
				BuilderBuilding builderBuilding = (BuilderBuilding)buildingQuery.list().get(0);
				agreementList.setBuildingName(builderBuilding.getName());
			}
//			if(agreement.getBuilderFloor() != null){
//				Query floorQuery = floorSession.createQuery(floor_hql);
//				floorQuery.setParameter("id", agreement.getBuilderFloor().getId());
//				BuilderFloor builderFloor = (BuilderFloor)floorQuery.list().get(0);
//				agreementList.setFloorNo(builderFloor.getName());
//			}
			if(agreement.getBuilderFlat() != null){
				Query flatQuery = flatSession.createQuery(flat_hql);
				flatQuery.setParameter("id", agreement.getBuilderFlat().getId());
				BuilderFlat builderFlat = (BuilderFlat)flatQuery.list().get(0);
				agreementList.setFlatNo(builderFlat.getFlatNo());
			}
			agreement_list.add(agreementList);
		}
		session.close();
		projectSession.close();
		buildingSession.close();
		floorSession.close();
		flatSession.close();
		return agreement_list;
	}
	
	/**
	 * Get all active agreement list
	 * @author pankaj
	 * @return List<AgreementList>
	 */
	public List<AgreementList> getAgreementsByBuilderId(int builderId){
		String hql = "from Agreement";
		String project_hql= "from BuilderProject where builder.id = :id and status=1";
		String building_hql = "from BuilderBuilding where id = :id and status=1";
		String floor_hql = "from BuilderFloor where id = :id and status=1";
		String flat_hql = "from BuilderFlat where id = :id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Session projectSession = hibernateUtil.openSession();
		Session buildingSession = hibernateUtil.openSession();
		Session floorSession = hibernateUtil.openSession();
		Session flatSession = hibernateUtil.openSession();
		
		Query query = session.createQuery(hql);
		List<Agreement> result = query.list();
		List<AgreementList> agreement_list = new ArrayList<AgreementList>();
		for(Agreement agreement : result){
			AgreementList agreementList = new AgreementList();
			agreementList.setBuyerName(agreement.getName());
			agreementList.setId(agreement.getId());
			if(agreement.getBuilderProject() != null){
				Query projectQuery = projectSession.createQuery(project_hql);
				projectQuery.setParameter("id", builderId);
				BuilderProject project = (BuilderProject)projectQuery.list().get(0);
				agreementList.setProjectName(project.getName());
			}
			if(agreement.getBuilderBuilding() != null){
				Query buildingQuery = buildingSession.createQuery(building_hql);
				buildingQuery.setParameter("id", agreement.getBuilderBuilding().getId());
				BuilderBuilding builderBuilding = (BuilderBuilding)buildingQuery.list().get(0);
				agreementList.setBuildingName(builderBuilding.getName());
			}
//			if(agreement.getBuilderFloor() != null){
//				Query floorQuery = floorSession.createQuery(floor_hql);
//				floorQuery.setParameter("id", agreement.getBuilderFloor().getId());
//				BuilderFloor builderFloor = (BuilderFloor)floorQuery.list().get(0);
//				agreementList.setFloorNo(builderFloor.getName());
//			}
			if(agreement.getBuilderFlat() != null){
				Query flatQuery = flatSession.createQuery(flat_hql);
				flatQuery.setParameter("id", agreement.getBuilderFlat().getId());
				BuilderFlat builderFlat = (BuilderFlat)flatQuery.list().get(0);
				agreementList.setFlatNo(builderFlat.getFlatNo());
			}
			agreement_list.add(agreementList);
		}
		session.close();
		projectSession.close();
		buildingSession.close();
		floorSession.close();
		flatSession.close();
		return agreement_list;
	}
	/**
	 * Save agreement document
	 * @author pankaj
	 * @param agreementInfo
	 * @return
	 */
	public ResponseMessage saveAgreementDocuments(List<AgreementInfo> agreementInfo){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(int i=0;i<agreementInfo.size();i++)
			newsession.save(agreementInfo.get(i));
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setId(agreementInfo.get(0).getAgreement().getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Agreement Added Successfully.");
		return responseMessage;
	}
	/**
	 * Update Agreement documents
	 * @author pankaj
	 * @param agreementInfo
	 * @return message
	 */
	public ResponseMessage updateAgreementDocuments(List<AgreementInfo> agreementInfo){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		/******************** Delete old Agreement documents *****************************************/
		String delete_buyer_documents = "DELETE from  AgreementInfo where agreement.id = :agreement_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_buyer_documents);
		smdelete.setParameter("agreement_id", agreementInfo.get(0).getAgreement().getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/************************ Save new Agreement Documents ****************************************/
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(agreementInfo.size()>0){
			for(int i=0;i<agreementInfo.size();i++){
				newsession.save(agreementInfo.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Agreement documents Updated Successfully");
		}
		return responseMessage;
	}
	/**
	 * Get Agreement Info
	 * @author pankaj
	 * @return list
	 */
	public List<AgreementInfo> getAllAgreements(){
		String hql = "from AgreementInfo";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<AgreementInfo> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage deleteAgreementDoc(int agreement_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from AgreementInfo where agreement.id = :agreement_id";
		Query query = session.createQuery(hql);
		query.setInteger("agreement_id", agreement_id);
		query.executeUpdate();
		//query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Agreement Doucment deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public List<BuilderFlat> getBuilderProjectBuildingFlats(int building_id) {
		String hql = "from BuilderFlat where builderFloor.builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderFlat> result = query.list();
		List<BuilderFlat> builderFlats = new ArrayList<>();
		for(BuilderFlat builderFlat : result){
			BuilderFlat builderFlat1 = new BuilderFlat();
			builderFlat1.setId(builderFlat.getId());
			builderFlat1.setFlatNo(builderFlat.getFlatNo());
			builderFlats.add(builderFlat1);
		}
		session.close();
		return builderFlats;
	}
	
	public ResponseMessage saveCampaign(Agreement campaign){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(campaign);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(campaign.getId());
		response.setStatus(1);
		//response.setMessage("Campaign Added Successfully");
		return response;
	}
	public ResponseMessage saveBuyerAgreement(List<AgreementBuyer> campaignBuyers){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(campaignBuyers.size()>0){
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			for(int i=0;i<campaignBuyers.size();i++){
				newsession.save(campaignBuyers.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Agreement Added Successfully");
		}
		return response;
	}
	
}
