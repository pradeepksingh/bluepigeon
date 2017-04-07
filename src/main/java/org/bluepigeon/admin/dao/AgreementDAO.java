package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.AgreementList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Agreement;
import org.bluepigeon.admin.model.AgreementInfo;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

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
			if(agreement.getBuilderFloor() != null){
				Query floorQuery = floorSession.createQuery(floor_hql);
				floorQuery.setParameter("id", agreement.getBuilderFloor().getId());
				BuilderFloor builderFloor = (BuilderFloor)floorQuery.list().get(0);
				agreementList.setFloorNo(builderFloor.getName());
			}
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
	public ResponseMessage saveAgreementDocuments(AgreementInfo agreementInfo){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(agreementInfo);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setId(agreementInfo.getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Agreement Added Successfully.");
		return responseMessage;
	}
	/**
	 * Update Agreement documents
	 * @author pankaj
	 * @param agreementInfo
	 * @return
	 */
	public ResponseMessage updateAgreementDocuments(AgreementInfo agreementInfo){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(agreementInfo);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(agreementInfo.getId());
		response.setStatus(1);
		response.setMessage("Agreement updated Successfully.");
		return response;
	}
}
