package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.BuildingPaymentList;
import org.bluepigeon.admin.data.BuyerPaymentList;
import org.bluepigeon.admin.data.DemandLetterList;
import org.bluepigeon.admin.data.FlatPaymentList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuilderProjectPaymentInfo;
import org.bluepigeon.admin.model.BuildingPaymentInfo;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.BuyerPayment;
import org.bluepigeon.admin.model.DemandLetters;
import org.bluepigeon.admin.model.DemandLettersInfo;
import org.bluepigeon.admin.model.FlatPaymentSchedule;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class DemandLettersDAO {
	/**
	 * Save/ add demaind Letters
	 * @author pankaj
	 * @param demandLetter
	 * @return response
	 */
	public ResponseMessage saveDemaindLetter(DemandLetters demandLetters){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(demandLetters);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setId(demandLetters.getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Demand Letter Added Successfully.");
		return responseMessage;
	}
	/**
	 * Update demand Letter
	 * @author pankaj
	 * @param Demand Letters
	 * @return response
	 */
	public ResponseMessage updateDemandLetters(DemandLetters demandLetters){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(demandLetters);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(demandLetters.getId());
		response.setStatus(1);
		response.setMessage("demand Letter updated Successfully.");
		return response;
	}
	/**
	 * Get Demand Letters by id
	 * @author pankaj
	 * @param id
	 * @return demand letter's object
	 */
	public DemandLetters getDemandLettersById(int id){
		String hql = "from DemandLetters where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<DemandLetters> result = query.list();
		session.close();
		return result.get(0);
	}
	/**
	 * Get Demand Letters document by demand letter id
	 * @author pankaj
	 * @param id
	 * @return
	 */
	public List<DemandLettersInfo> getDemandLettersInfoByDemandLetterId(int id){
		String hql = "from DemandLettersInfo where demandLetters.id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<DemandLettersInfo> result = query.list();
		return result;
	}
	/**
	 * @author pankaj
	 * @return list of demand letters
	 */
	public List<DemandLetterList> getAllDemandLetters(){
		String hql = "from DemandLetters";
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
		List<DemandLetters> result = query.list();
		List<DemandLetterList> demandletter_list = new ArrayList<DemandLetterList>();
		for(DemandLetters demandLetters : result){
			DemandLetterList demandLetteList = new DemandLetterList();
			demandLetteList.setBuyerName(demandLetters.getName());
			demandLetteList.setId(demandLetters.getId());
			if(demandLetters.getBuilderProject() != null){
				Query projectQuery = projectSession.createQuery(project_hql);
				projectQuery.setParameter("id", demandLetters.getBuilderProject().getId());
				BuilderProject project = (BuilderProject)projectQuery.list().get(0);
				demandLetteList.setProjectName(project.getName());
			}
			if(demandLetters.getBuilderBuilding() != null){
				Query buildingQuery = buildingSession.createQuery(building_hql);
				buildingQuery.setParameter("id", demandLetters.getBuilderBuilding().getId());
				BuilderBuilding builderBuilding = (BuilderBuilding)buildingQuery.list().get(0);
				demandLetteList.setBuildingName(builderBuilding.getName());
			}
//			if(agreement.getBuilderFloor() != null){
//				Query floorQuery = floorSession.createQuery(floor_hql);
//				floorQuery.setParameter("id", agreement.getBuilderFloor().getId());
//				BuilderFloor builderFloor = (BuilderFloor)floorQuery.list().get(0);
//				agreementList.setFloorNo(builderFloor.getName());
//			}
			if(demandLetters.getBuilderFlat() != null){
				Query flatQuery = flatSession.createQuery(flat_hql);
				flatQuery.setParameter("id", demandLetters.getBuilderFlat().getId());
				BuilderFlat builderFlat = (BuilderFlat)flatQuery.list().get(0);
				demandLetteList.setFlatname(builderFlat.getFlatNo());
			}
			demandletter_list.add(demandLetteList);
		}
		session.close();
		projectSession.close();
		buildingSession.close();
		floorSession.close();
		flatSession.close();
		return demandletter_list;
	}
	
	/**
	 * @author pankaj
	 * @return list of demand letters
	 */
	public List<DemandLetterList> getAllDemandLettersByBuilderId(int builderId){
		String hql = "from DemandLetters";
		String project_hql= "from BuilderProject where builder.id = :id";
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
		List<DemandLetters> result = query.list();
		List<DemandLetterList> demandletter_list = new ArrayList<DemandLetterList>();
		for(DemandLetters demandLetters : result){
			DemandLetterList demandLetteList = new DemandLetterList();
			demandLetteList.setBuyerName(demandLetters.getName());
			demandLetteList.setId(demandLetters.getId());
			if(demandLetters.getBuilderProject() != null){
				Query projectQuery = projectSession.createQuery(project_hql);
				projectQuery.setParameter("id", builderId);
				BuilderProject project = (BuilderProject)projectQuery.list().get(0);
				demandLetteList.setProjectName(project.getName());
			}
			if(demandLetters.getBuilderBuilding() != null){
				Query buildingQuery = buildingSession.createQuery(building_hql);
				buildingQuery.setParameter("id", demandLetters.getBuilderBuilding().getId());
				BuilderBuilding builderBuilding = (BuilderBuilding)buildingQuery.list().get(0);
				demandLetteList.setBuildingName(builderBuilding.getName());
			}
//			if(agreement.getBuilderFloor() != null){
//				Query floorQuery = floorSession.createQuery(floor_hql);
//				floorQuery.setParameter("id", agreement.getBuilderFloor().getId());
//				BuilderFloor builderFloor = (BuilderFloor)floorQuery.list().get(0);
//				agreementList.setFloorNo(builderFloor.getName());
//			}
			if(demandLetters.getBuilderFlat() != null){
				Query flatQuery = flatSession.createQuery(flat_hql);
				flatQuery.setParameter("id", demandLetters.getBuilderFlat().getId());
				BuilderFlat builderFlat = (BuilderFlat)flatQuery.list().get(0);
				demandLetteList.setFlatname(builderFlat.getFlatNo());
			}
			demandletter_list.add(demandLetteList);
		}
		session.close();
		projectSession.close();
		buildingSession.close();
		floorSession.close();
		flatSession.close();
		return demandletter_list;
	}
	
	public List<DemandLetters> getDemandLetters(){
		String hql = "from DemandLetters";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<DemandLetters> result = query.list();
		session.close();
		return result;
	}
	
	/**
	 * Save demand letter document
	 * @author pankaj
	 * @param demandLetterInfo
	 * @return
	 */
	public ResponseMessage saveDemandLtterDocuments(List<DemandLettersInfo> demandLettersInfo){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(int i=0;i<demandLettersInfo.size();i++)
			newsession.save(demandLettersInfo.get(i));
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setId(demandLettersInfo.get(0).getDemandLetters().getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Demand Letter Added Successfully.");
		return responseMessage;
	}
	/**
	 * Update Demand Letters documents
	 * @author pankaj
	 * @param demandLettersInfo
	 * @return message
	 */
	public ResponseMessage updateDemandLetterDocuments(List<DemandLettersInfo> demandLettersInfo){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		/******************** Delete old Demand Letter documents *****************************************/
		String delete_buyer_documents = "DELETE from  DemandLettersInfo where demandLetters.id = :demandletter_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_buyer_documents);
		smdelete.setParameter("demandLetter_id", demandLettersInfo.get(0).getDemandLetters().getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/************************ Save new Agreement Documents ****************************************/
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(demandLettersInfo.size()>0){
			for(int i=0;i<demandLettersInfo.size();i++){
				newsession.save(demandLettersInfo.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Demand Letter documents Updated Successfully");
		}
		return responseMessage;
	}
	/**
	 * Get Demand Letter Info
	 * @author pankaj
	 * @return demand letter documents as list
	 */
	public List<DemandLettersInfo> getAllAgreements(){
		String hql = "from DemandLettersInfo";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<DemandLettersInfo> result = query.list();
		session.close();
		return result;
	}
	
	/**
	 * Get Demand Letter Info
	 * @author pankaj
	 * @return demand letter documents as list
	 */
	public List<BuilderProjectPaymentInfo> getAllBuilderProjectPaymentInfo(){
		String hql = "from BuilderProjectPaymentInfo";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderProjectPaymentInfo> result = query.list();
		session.close();
		return result;
	}
	
	/**
	 * Get Demand Letter Info
	 * @author pankaj
	 * @return demand letter documents as list
	 */
	public List<BuildingPaymentInfo> getAllBuildingPaymentInfo(){
		String hql = "from BuildingPaymentInfo";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuildingPaymentInfo> result = query.list();
		session.close();
		return result;
	}
	
	/**
	 * Get Demand Letter Info
	 * @author pankaj
	 * @return demand letter documents as list
	 */
	public List<FlatPaymentSchedule> getAllFlatPaymentSchedule(){
		String hql = "from FlatPaymentSchedule";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<FlatPaymentSchedule> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get Demand Letter Info by project Id
	 * @author pankaj
	 * @return demand letter documents as list
	 */
	public List<BuilderProjectPaymentInfo> getAllBuilderProjectPaymentInfo(int projectId){
		String hql = "from BuilderProjectPaymentInfo where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderProjectPaymentInfo> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get Demand Letter Info by building Id
	 * @author pankaj
	 * @return demand letter documents as list
	 */
	public List<BuildingPaymentInfo> getBuildingPaymentInfo(int buildingId){
		String hql = "from BuildingPaymentInfo where builderBuilding.id = :buildingId";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buildingId", buildingId);
		List<BuildingPaymentInfo> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get Demand Letter Info by flat id
	 * @author pankaj
	 * @return demand letter documents as list
	 */
	public List<FlatPaymentSchedule> getFlatPaymentSchedule(int flatId){
		String hql = "from FlatPaymentSchedule where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		List<FlatPaymentSchedule> result = query.list();
		session.close();
		return result;
	}
	public ResponseMessage deleteDemandLettersDoc(int demandLetters_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from DemandLettersInfo where demandLetters.id = :demandLetters_id";
		Query query = session.createQuery(hql);
		query.setInteger("demandLetters_id", demandLetters_id);
		query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Demand Letter Doucment deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public List<BuildingPaymentList> getPaymentByProejctId(int projectId){
		List<BuildingPaymentList> buildingPaymentLists = new ArrayList<BuildingPaymentList>();
		List<BuildingPaymentList> buildingPaymentLists1 = new ArrayList<BuildingPaymentList>();
		String buildingHql = "from BuilderBuilding where builderProject.id = :project_id";
		String paymentHql = "from BuilderProjectPaymentInfo where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		BuildingPaymentList buildingPaymentList = null;
		Session buildingSession = hibernateUtil.openSession();
		Query buildingQuery = buildingSession.createQuery(buildingHql);
		buildingQuery.setParameter("project_id", projectId);
		List<BuilderBuilding> buildingList = buildingQuery.list();
		for(BuilderBuilding builderBuilding : buildingList){
			buildingPaymentList = new BuildingPaymentList();
			buildingPaymentList.setBuildingId(builderBuilding.getId());
			buildingPaymentList.setBuildingName(builderBuilding.getName());
			buildingPaymentLists.add(buildingPaymentList);
		}
		Session paymentSession = hibernateUtil.openSession();
		Query paymentQuery = paymentSession.createQuery(paymentHql);
		paymentQuery.setParameter("project_id", projectId);
		List<BuilderProjectPaymentInfo> projectPaymentList = paymentQuery.list();
		for(BuilderProjectPaymentInfo builderProjectPaymentInfo : projectPaymentList){
			buildingPaymentList = new BuildingPaymentList();
			buildingPaymentList.setPaymentId(builderProjectPaymentInfo.getId());
			buildingPaymentList.setPaymentMilestone(builderProjectPaymentInfo.getSchedule());
			buildingPaymentLists.add(buildingPaymentList);
		}
		for(int i=0;i<buildingPaymentLists.size();i++){
			buildingPaymentList = new BuildingPaymentList();
			if(buildingPaymentLists.get(i).getBuildingId() != 0){
				buildingPaymentList.setBuildingId(buildingPaymentLists.get(i).getBuildingId());
			}
			if(buildingPaymentLists.get(i).getBuildingName() != null){
				buildingPaymentList.setBuildingName(buildingPaymentLists.get(i).getBuildingName());
			}
			if(buildingPaymentLists.get(i).getPaymentId() != 0){
				buildingPaymentList.setPaymentId(buildingPaymentLists.get(i).getPaymentId());
			}
			if(buildingPaymentLists.get(i).getPaymentMilestone() != null){
				buildingPaymentList.setPaymentMilestone(buildingPaymentLists.get(i).getPaymentMilestone());
			}
			buildingPaymentLists1.add(buildingPaymentList);	
		}
		buildingSession.close();
		paymentSession.close();
		return buildingPaymentLists1;
	}
	
	public List<BuyerPaymentList> getBuyerPaymentByFlatId(int flatId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		List<BuyerPaymentList> buyerPaymentLists = new ArrayList<BuyerPaymentList>();
		List<BuyerPaymentList> buyerPaymentLists2 = new ArrayList<BuyerPaymentList>();
		BuyerPaymentList buyerPaymentList = null;
		String buyerHql = "from Buyer where builderFlat.id = :flat_id";
		Session buyerSession = hibernateUtil.openSession();
		Query buyerQuery = buyerSession.createQuery(buyerHql);
		buyerQuery.setParameter("flat_id", flatId);
		List<Buyer> buyerList = buyerQuery.list();
		for(Buyer buyer : buyerList){
			buyerPaymentList = new BuyerPaymentList();
			buyerPaymentList.setName(buyer.getName());
			buyerPaymentList.setEmail(buyer.getEmail());
			buyerPaymentList.setContact(buyer.getMobile());
			buyerPaymentLists.add(buyerPaymentList);
		}
		String PaymentHql = "from FlatPaymentSchedule where builderFlat.id = :flat_id and builderFlat.builderFlatStatus.name='booked'";
		Session paymentSession = hibernateUtil.openSession();
		Query paymentQuery = paymentSession.createQuery(PaymentHql);
		paymentQuery.setParameter("flat_id", flatId);
		List<FlatPaymentSchedule> flatPaymentList = paymentQuery.list();
		for(FlatPaymentSchedule flatPaymentSchedule : flatPaymentList){
			buyerPaymentList = new BuyerPaymentList();
			buyerPaymentList.setPaymentId(flatPaymentSchedule.getId());
			buyerPaymentList.setPaymentMilestone(flatPaymentSchedule.getMilestone());
			buyerPaymentLists.add(buyerPaymentList);
		}
		for(int i=0;i<buyerPaymentLists.size();i++){
			buyerPaymentList  = new BuyerPaymentList();
			if(buyerPaymentLists.get(i).getName() != null){
				buyerPaymentList.setName(buyerPaymentLists.get(i).getName());
			}
			if(buyerPaymentLists.get(i).getContact() != null){
				buyerPaymentList.setContact(buyerPaymentLists.get(i).getContact());
			}
			if(buyerPaymentLists.get(i).getEmail() != null){
				buyerPaymentList.setEmail(buyerPaymentLists.get(i).getEmail());
			}
			if(buyerPaymentLists.get(i).getPaymentId() != 0){
				buyerPaymentList.setPaymentId(buyerPaymentLists.get(i).getPaymentId());
			}
			if(buyerPaymentLists.get(i).getPaymentMilestone() != null){
				buyerPaymentList.setPaymentMilestone(buyerPaymentLists.get(i).getPaymentMilestone());
			}
			buyerPaymentLists2.add(buyerPaymentList);
		}
		buyerSession.close();
		paymentSession.close();
		return buyerPaymentLists2;
		
	}
	
	public List<FlatPaymentList> getPaymentByBuildingId(int buildingId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		List<FlatPaymentList> flatPaymentLists = new ArrayList<FlatPaymentList>();
		List<FlatPaymentList> flatPaymentLists2 = new ArrayList<FlatPaymentList>();
		FlatPaymentList flatPaymentList = null;
		String flatHql = "from BuilderFlat where builderFloor.builderBuilding.id = :building_id ";
		Session flatSession = hibernateUtil.openSession();
		Query flatQuery = flatSession.createQuery(flatHql);
		flatQuery.setParameter("building_id", buildingId);
		List<BuilderFlat> flatList = flatQuery.list();
		for(BuilderFlat builderFlat: flatList){
			flatPaymentList = new FlatPaymentList();
			flatPaymentList.setFlatId(builderFlat.getId());
			flatPaymentList.setFlatName(builderFlat.getFlatNo());
			flatPaymentLists.add(flatPaymentList);
		}
		String paymentHql = "from BuildingPaymentInfo where builderBuilding.id = :building_id";
		Session paymentSession = hibernateUtil.openSession();
		Query paymentQuery = paymentSession.createQuery(paymentHql);
		paymentQuery.setParameter("building_id", buildingId);
		List<BuildingPaymentInfo> buildingpaymentList = paymentQuery.list();
		for(BuildingPaymentInfo buildingPaymentInfo : buildingpaymentList) {
			flatPaymentList = new FlatPaymentList();
			flatPaymentList.setPaymentId(buildingPaymentInfo.getId());
			flatPaymentList.setPaymentMilestone(buildingPaymentInfo.getMilestone());
			flatPaymentLists.add(flatPaymentList);
		}
		for(int i=0;i<flatPaymentLists.size();i++){
			flatPaymentList = new FlatPaymentList();
			if(flatPaymentLists.get(i).getFlatId() != 0){
				flatPaymentList.setFlatId(flatPaymentLists.get(i).getFlatId());
			}
			if(flatPaymentLists.get(i).getFlatName() != null){
				flatPaymentList.setFlatName(flatPaymentLists.get(i).getFlatName());
			}
			if(flatPaymentLists.get(i).getPaymentId() != 0){
				flatPaymentList.setPaymentId(flatPaymentLists.get(i).getPaymentId());
			}
			if(flatPaymentLists.get(i).getPaymentMilestone() != null){
				flatPaymentList.setPaymentMilestone(flatPaymentLists.get(i).getPaymentMilestone());
			}
			flatPaymentLists2.add(flatPaymentList);
		}
		flatSession.close();
		paymentSession.close();
		return flatPaymentLists2;
	}
	
	public List<FlatPaymentSchedule> getPaymentByFlatId(int flatId){
		String hql = "from FlatPaymentSchedule where BuilderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		List<FlatPaymentSchedule> result = query.list();
		session.close();
		return result;
	}
	public List<BuyerPayment> getBuyerPaymentByDemandId(int demandLetter_id){
		List<BuyerPayment> buyerPayments = new ArrayList<BuyerPayment>();
		String hql ="from DemandLetters where id=:id";
		String buyerProjectHql = "from Buyer where builderProject.id = :project_id";
		String buyerBuildingHql = "from Buyer where builderBuilding.id = :building_id";
		String buyerflatHql = "from Buyer where builderFlat.id = :flat_id";
		String paymentHql = "from BuyerPayment where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Session buyerSession = hibernateUtil.openSession();
		Session paymentSession = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", demandLetter_id);
		DemandLetters demandLetters = (DemandLetters)query.list().get(0);
		if(demandLetters != null){
//			if(demandLetters.getBuilderProject() != null){
//				Query buyerQuery = buyerSession.createQuery(buyerProjectHql);
//				buyerQuery.setParameter("project_id", demandLetters.getBuilderProject().getId());
//				Buyer buyers = (Buyer)buyerQuery.list().get(0);
//				if(buyers != null){
//					Query paymentQuery = paymentSession.createQuery(paymentHql);
//					paymentQuery.setParameter("buyer_id", buyers.getId());
//					buyerPayments = paymentQuery.list();
//				}
//			}
//			if(demandLetters.getBuilderBuilding() != null){
//				Query buyerQuery = buyerSession.createQuery(buyerBuildingHql);
//				buyerQuery.setParameter("building_id", demandLetters.getBuilderBuilding().getId());
//				Buyer buyers = (Buyer)buyerQuery.list().get(0);
//				if(buyers != null){
//					Query paymentQuery = paymentSession.createQuery(paymentHql);
//					paymentQuery.setParameter("buyer_id", buyers.getId());
//					buyerPayments = paymentQuery.list();
//				}
//			}
//			if(demandLetters.getBuilderFlat() != null){
				Query buyerQuery = buyerSession.createQuery(buyerflatHql);
				buyerQuery.setParameter("flat_id", demandLetters.getBuilderFlat().getId());
				Buyer buyers = (Buyer)buyerQuery.list().get(0);
				if(buyers != null){
					Query paymentQuery = paymentSession.createQuery(paymentHql);
					paymentQuery.setParameter("buyer_id", buyers.getId());
					buyerPayments = paymentQuery.list();
			//	}
			}
		}
		session.close();
		buyerSession.close();
		paymentSession.close();
		return buyerPayments;
	}
}