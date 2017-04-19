package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.PossessionList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Possession;
import org.bluepigeon.admin.model.PossessionInfo;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class PossessionDAO {
	/**
	 * @author pankaj
	 * @param possession
	 * @return response
	 */
	public ResponseMessage savePossession(Possession possession){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(possession);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setId(possession.getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Possession Added Successfully.");
		return responseMessage;
	}
	/**
	 * @author pankaj
	 * @param possession
	 * @return response
	 */
	public ResponseMessage updatePossession(Possession possession){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(possession);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(possession.getId());
		response.setStatus(1);
		response.setMessage("Possession updated Successfully.");
		return response;
	}
	/**
	 * @author pankaj
	 * @param id
	 * @return possession's object
	 */
	public Possession getPossessionById(int id){
		String hql = "from Possession where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Possession> result = query.list();
		session.close();
		return result.get(0);
	}
	/**
	 * Get Possession info by Possession Id
	 * @author pankaj
	 * @param id
	 * @return list of possession info's object
	 */
	public List<PossessionInfo> getPossessionInfoByPossessionId(int id){
		String hql = "from PossessionInfo where possession.id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<PossessionInfo> result = query.list();
		return result;
	}
	/**
	 * @author pankaj
	 * @return list of possession
	 */
	public List<PossessionList> getAllAgreement(){
		String hql = "from Possession";
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
		List<Possession> result = query.list();
		List<PossessionList> possession_list = new ArrayList<PossessionList>();
		for(Possession possession : result){
			PossessionList possessionList = new PossessionList();
			possessionList.setBuyerName(possession.getName());
			possessionList.setId(possession.getId());
			if(possession.getBuilderProject() != null){
				Query projectQuery = projectSession.createQuery(project_hql);
				projectQuery.setParameter("id", possession.getBuilderProject().getId());
				BuilderProject project = (BuilderProject)projectQuery.list().get(0);
				possessionList.setProjectName(project.getName());
			}
			if(possession.getBuilderBuilding() != null){
				Query buildingQuery = buildingSession.createQuery(building_hql);
				buildingQuery.setParameter("id", possession.getBuilderBuilding().getId());
				BuilderBuilding builderBuilding = (BuilderBuilding)buildingQuery.list().get(0);
				possessionList.setBuildingName(builderBuilding.getName());
			}
//			if(agreement.getBuilderFloor() != null){
//				Query floorQuery = floorSession.createQuery(floor_hql);
//				floorQuery.setParameter("id", agreement.getBuilderFloor().getId());
//				BuilderFloor builderFloor = (BuilderFloor)floorQuery.list().get(0);
//				agreementList.setFloorNo(builderFloor.getName());
//			}
			if(possession.getBuilderFlat() != null){
				Query flatQuery = flatSession.createQuery(flat_hql);
				flatQuery.setParameter("id", possession.getBuilderFlat().getId());
				BuilderFlat builderFlat = (BuilderFlat)flatQuery.list().get(0);
				possessionList.setFlatNo(builderFlat.getFlatNo());
			}
			possession_list.add(possessionList);
		}
		session.close();
		projectSession.close();
		buildingSession.close();
		floorSession.close();
		flatSession.close();
		return possession_list;
	}
	/**
	 * Save possession document
	 * @author pankaj
	 * @param possessionInfo
	 * @return message
	 */
	public ResponseMessage savePossessionDocuments(List<PossessionInfo> possessionInfo){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(int i=0;i<possessionInfo.size();i++)
			newsession.save(possessionInfo.get(i));
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setId(possessionInfo.get(0).getPossession().getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Possession Added Successfully.");
		return responseMessage;
	}
	/**
	 * Update Possession documents
	 * @author pankaj
	 * @param possessionInfo
	 * @return message
	 */
	public ResponseMessage updateAgreementDocuments(List<PossessionInfo> possessionInfo){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		/******************** Delete old Possession documents *****************************************/
		String delete_buyer_documents = "DELETE from  PossessionInfo where possession.id = :possession_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_buyer_documents);
		smdelete.setParameter("possession_id", possessionInfo.get(0).getPossession().getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/************************ Save new Possession Documents ****************************************/
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(possessionInfo.size()>0){
			for(int i=0;i<possessionInfo.size();i++){
				newsession.save(possessionInfo.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Possession documents Updated Successfully");
		}
		return responseMessage;
	}
	/**
	 * Get Possession Info
	 * @author pankaj
	 * @return list
	 */
	public List<PossessionInfo> getAllPossessions(){
		String hql = "from Possession";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<PossessionInfo> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage deletePossessionDoc(int possession_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from PossessionInfo where possession.id = :possession_id";
		Query query = session.createQuery(hql);
		query.setInteger("possession_id", possession_id);
		query.executeUpdate();
		//query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Possession Doucment deleted successfully.");
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
	
}
