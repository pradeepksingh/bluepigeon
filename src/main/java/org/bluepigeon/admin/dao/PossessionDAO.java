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

public class PossessionDAO {
	/**
	 * @author pankaj
	 * @param possession
	 * @return response
	 */
	public ResponseMessage saveAgreement(Possession possession){
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
	public ResponseMessage updateAgreement(Possession possession){
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
	public Possession getAgreementById(int id){
		String hql = "from Possession where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Possession> result = query.list();
		session.close();
		return result.get(0);
	}
	
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
	 * @return list of agreement
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
		List<PossessionList> agreement_list = new ArrayList<PossessionList>();
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
			agreement_list.add(possessionList);
		}
		session.close();
		projectSession.close();
		buildingSession.close();
		floorSession.close();
		flatSession.close();
		return agreement_list;
	}
	/**
	 * Save possession document
	 * @author pankaj
	 * @param possessionInfo
	 * @return
	 */
	public ResponseMessage saveAgreementDocuments(List<PossessionInfo> posseionInfo){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(int i=0;i<posseionInfo.size();i++)
			newsession.save(posseionInfo.get(i));
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setId(posseionInfo.get(0).getPossession().getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Posseion Added Successfully.");
		return responseMessage;
	}
	/**
	 * Update Possession documents
	 * @author pankaj
	 * @param posseionInfo
	 * @return
	 */
	public ResponseMessage updateAgreementDocuments(PossessionInfo possessionInfo){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(possessionInfo);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(possessionInfo.getId());
		response.setStatus(1);
		response.setMessage("Posseion updated Successfully.");
		return response;
	}
	/**
	 * Get Possession Info
	 * @author pankaj
	 * @return list
	 */
	public List<PossessionInfo> getAllAgreements(){
		String hql = "from PossessionInfo";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<PossessionInfo> result = query.list();
		session.close();
		return result;
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
