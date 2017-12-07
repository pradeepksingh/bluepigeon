package org.bluepigeon.admin.dao;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.data.BuildingData;
import org.bluepigeon.admin.data.BuyerData;
import org.bluepigeon.admin.data.BuyerDocList;
import org.bluepigeon.admin.data.BuyerList;
import org.bluepigeon.admin.data.FlatData;
import org.bluepigeon.admin.data.FloorData;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.data.Projects;
import org.bluepigeon.admin.exception.EmailValidator;
import org.bluepigeon.admin.exception.NameValidator;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderBuildingStatus;
import org.bluepigeon.admin.model.BuilderBuyer;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFlatStatus;
import org.bluepigeon.admin.model.BuilderFlatType;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.BuyerDocuments;
import org.bluepigeon.admin.model.BuyerOffer;
import org.bluepigeon.admin.model.BuyerPayment;
import org.bluepigeon.admin.model.BuyerUploadDocuments;
import org.bluepigeon.admin.model.BuyingDetails;
import org.bluepigeon.admin.model.Campaign;
import org.bluepigeon.admin.model.CampaignBuyer;
import org.bluepigeon.admin.model.FlatPricingDetails;
import org.bluepigeon.admin.model.GlobalBuyer;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.transform.Transformers;

import com.google.gson.Gson;
import com.sun.org.apache.xml.internal.security.utils.resolver.ResourceResolverSpi;

public class BuyerDAO {
	@Context ServletContext context;
	public ResponseMessage saveBuyer(List<Buyer> buyers){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String get_builder = "from BuilderProject where id = :id";
		Session session = hibernateUtil.openSession();
		Session builderSession = hibernateUtil.openSession();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(Buyer buyerList:buyers){
			if (buyerList.getName() == null || buyerList.getName().trim().length() == 0) {
				response.setStatus(0);
				response.setMessage("Please enter buyer name");
				//responseList.add(response);
			} else {
				Query builderQuery = builderSession.createQuery(get_builder);
				builderQuery.setParameter("id", buyerList.getBuilderProject().getId());
				BuilderProject builderProject = (BuilderProject)builderQuery.list().get(0);
				buyerList.setBuilder(builderProject.getBuilder());
				newsession.save(buyerList);
				response.setId(buyerList.getId());
				response.setData(buyerList);
				response.setStatus(1);
				response.setMessage("Buyer Added Successfully");
				//responseList.add(response);
			}
				
		}
		newsession.getTransaction().commit();
		session.close();
		newsession.close();
		builderSession.close();
		updateFlatStatus(buyers.get(0).getBuilderFlat().getId());
		insertBuilderBuyer(buyers);
		return response;
	}
	
	public ResponseMessage addBuyer(Buyer buyer){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from GlobalBuyer where pancard = :pancard ";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("pancard", buyer.getPancard());
		List<GlobalBuyer> result = query.list();
		
		GlobalBuyer globalBuyer = new GlobalBuyer();
		if(result.size() <= 0) {
			Session newsession = hibernateUtil.openSession();
			globalBuyer.setName(buyer.getName());
			globalBuyer.setPancard(buyer.getPancard());
			globalBuyer.setMobile(buyer.getMobile());
			globalBuyer.setEmail(buyer.getEmail());
			globalBuyer.setAvatar(buyer.getPhoto());
			globalBuyer.setOtp("");
			globalBuyer.setPassword("");
			globalBuyer.setStatus(false);
			newsession.beginTransaction();
			newsession.save(globalBuyer);
			newsession.getTransaction().commit();
			newsession.close();
		} else {
			globalBuyer = result.get(0);
		}
		
		buyer.setGlobalBuyer(globalBuyer);
		Short isDeleted = 0;
		buyer.setIsDeleted(isDeleted);
		Session buyerSession = hibernateUtil.openSession();
		buyerSession.beginTransaction();
		buyerSession.save(buyer);
		buyerSession.getTransaction().commit();
		updateFlatStatus(buyer.getBuilderFlat().getId());
		updateProject(buyer);
		new ProjectDAO().updateProjectInventory(buyer.getBuilderFlat().getId());
		updateBuilding(buyer);
		updateBuildingInventory(buyer.getBuilderFlat().getId());
		buyerSession.close();
		
		response.setId(buyer.getId());
		response.setStatus(1);
		response.setMessage("Buyer Added Successfully");
		return response;
	}
	
	public void updateFlatStatus(int flatId){
		System.out.println("FlatId in buyer DAO :: "+flatId);
		String hql = "UPDATE BuilderFlat set builderFlatStatus.id = 2 WHERE id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id",flatId);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
	public void updateProject(Buyer buyer){
		String projecthql = "from BuilderProject where id = :id";
		String flatTotal = "from FlatPricingDetails where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session projectSession = hibernateUtil.openSession();
		Query projectQuery = projectSession.createQuery(projecthql);
		projectQuery.setParameter("id", buyer.getBuilderProject().getId());
		BuilderProject builderProject = (BuilderProject) projectQuery.list().get(0);
		projectSession.close();
		Session flatSession = hibernateUtil.openSession();
		Query flatQuery = flatSession.createQuery(flatTotal);
		//Session updateSession = hibernateUtil.openSession();
		if(builderProject != null){
			flatQuery.setParameter("flat_id",buyer.getBuilderFlat().getId() );
			FlatPricingDetails flatPricingDetails = (FlatPricingDetails)flatQuery.list().get(0);
			double revenue = builderProject.getRevenue() + flatPricingDetails.getTotalCost();
			builderProject.setRevenue(revenue);
			Session updateProject = hibernateUtil.openSession();
			updateProject.beginTransaction();
			updateProject.update(builderProject);
			updateProject.getTransaction().commit();
			updateProject.close();
			
		}
		
		flatSession.close();
	}
	
	public void insertBuilderBuyer(List<Buyer> buyers){
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(int i=0;i<buyers.size();i++){
			BuilderBuyer builderBuyer = new BuilderBuyer();
			builderBuyer.setBuyer(buyers.get(i));
			builderBuyer.setBuilderFlat(buyers.get(i).getBuilderFlat());
			builderBuyer.setBuilder(buyers.get(i).getBuilder());
			newsession.save(builderBuyer);
		}
		newsession.getTransaction().commit();
		newsession.close();
	}
	public ResponseMessage saveBuyerDocuments(List<BuyerDocuments> buyerDocuments){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(buyerDocuments.size()>0){
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			for(int i=0;i<buyerDocuments.size();i++){
				newsession.save(buyerDocuments.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Success");
		}
		return response;
	}
	public ResponseMessage saveBuyingDetails(BuyingDetails buyingDetails){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(buyingDetails);
		newsession.getTransaction().commit();
		newsession.close();
		response.setStatus(1);
		response.setMessage("Buying Details Added Successfully");
		return response;
	}
	
	public ResponseMessage saveBuyerOffers(List<BuyerOffer> buyerOffer){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(buyerOffer.size()>0){
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			for(int i=0;i<buyerOffer.size();i++){
				newsession.save(buyerOffer.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Buyer Offer Added Successfully");
		}
		return response;
	}
	public ResponseMessage saveBuyerPayment(List<BuyerPayment> buyerPayments){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(buyerPayments.size()>0){
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			for(int i=0;i<buyerPayments.size();i++){
				newsession.save(buyerPayments.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Buyer Payment Added Successfully");
		}
		return response;
		
	}
	
	public ResponseMessage saveBuyerUploadDouments(List<BuyerUploadDocuments> buyerUploadDocuments){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		System.out.println("File Name: ttetet1");
		if(buyerUploadDocuments.size()>0){
			System.out.println("File Name: ttetet2");
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			for(int i=0;i<buyerUploadDocuments.size();i++){
				newsession.save(buyerUploadDocuments.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Document uploaded Successfully");
		}
		return response;
		}

	public List<BuyerList> getBuyerList(){
		String hql = "from Buyer where is_primary=1 order by id desc ";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Buyer> result = query.list();
		List<BuyerList> buyerLists = new ArrayList<BuyerList>();
		String get_project_list = "from BuilderProject where id= :id";
		String get_Building_list = "from BuilderBuilding where builderProject.id = :id";
		String get_flat_list = "from BuilderFlat where id = :id";
		Session projectSession = hibernateUtil.openSession();
		Session buildingSession = hibernateUtil.openSession();
		Session flatSession = hibernateUtil.openSession();
		for(Buyer buyer : result){
			BuyerList buyerList = new BuyerList();
			buyerList.setId(buyer.getId());
			buyerList.setName(buyer.getName());
			if(buyer.getBuilderProject() != null){
				Query projectQuery = projectSession.createQuery(get_project_list);
				projectQuery.setParameter("id", buyer.getBuilderProject().getId());
				List<BuilderProject> project_list = projectQuery.list();
				for(BuilderProject builderProject : project_list){
					buyerList.setProjectName(builderProject.getName());
					Query buildingQuery = buildingSession.createQuery(get_Building_list);
					buildingQuery.setParameter("id", builderProject.getId());
					List<BuilderBuilding> building_list = buildingQuery.list();
					for(BuilderBuilding builderBuilding : building_list){
						buyerList.setBuildingName(builderBuilding.getName());
					}
					Query flatQuery = flatSession.createQuery(get_flat_list);
					flatQuery.setParameter("id", buyer.getBuilderFlat().getId());
					List<BuilderFlat> flat_list = flatQuery.list();
					for(BuilderFlat builderFlat : flat_list){
						buyerList.setFlatNumber(builderFlat.getFlatNo());
					}
				}
				
			}else{
				buyerList.setProjectName("");
				buyerList.setBuildingName("");
				buyerList.setFlatNumber("");
			}
			buyerList.setPhone(buyer.getMobile());
			buyerList.setEmail(buyer.getEmail());
			buyerLists.add(buyerList);
		}
		session.close();
		projectSession.close();
		buildingSession.close();
		flatSession.close();
		return buyerLists;
	}
	
	public List<Buyer> getPrimaryBuyerList(){
		String hql = "from Buyer where is_primary=1 and is_deleted=0 order by id desc ";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Buyer> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuyerList> getBuyerListByCompanyId(int company_id, String name){
		String buyer_list_query = "from Buyer where builderProject.id = :project_id";
		String hql = "from BuilderProject where";
		String where = "";
		if(company_id > 0) {
			where = where + " builderCompanyNames.id = :company_id";
		}
		if(name != "") {
			if(where != "") {
				where = where + " AND name LIKE :name ";
			} else {
				where = where + " name LIKE :name ";
			}
		}
		hql = hql+ where;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		if(company_id > 0) {
			query.setParameter("company_id", company_id);
		}
		if(name != "") {
			query.setParameter("name", "%"+name+"%");
		}
		
		String get_building_list = "from BuilderBuilding where builderProject.id = :id";
		String get_flat_list = "from BuilderFlat where id = :id";
		
		Session buildingSession = hibernateUtil.openSession();
		Session flatSession = hibernateUtil.openSession();
		List<BuilderProject> result = query.list();
		List<BuyerList> buyerLists = new ArrayList<BuyerList>();
		Session innersession =hibernateUtil.openSession();
		for(BuilderProject builderProject : result){
			Query innerquery = innersession.createQuery(buyer_list_query);
			innerquery.setParameter("project_id", builderProject.getId());
			List<Buyer> buyers = innerquery.list();
			for(Buyer buyer : buyers){
				BuyerList buyerList = new BuyerList();
				buyerList.setProjectName(buyer.getBuilderProject().getName());
				buyerList.setId(buyer.getId());
				buyerList.setName(buyer.getName());
				buyerList.setPhone(buyer.getMobile());
				buyerList.setEmail(buyer.getEmail());
				Query buildingQuery = buildingSession.createQuery(get_building_list);
				buildingQuery.setParameter("id", buyer.getBuilderProject().getId());
				List<BuilderBuilding> building_list = buildingQuery.list();
				for(BuilderBuilding builderBuilding : building_list){
					buyerList.setBuildingName(builderBuilding.getName());
				}
				Query flatQuery = flatSession.createQuery(get_flat_list);
				flatQuery.setParameter("id",buyer.getBuilderFlat().getId() );
				List<BuilderFlat> flat_list = flatQuery.list();
				for(BuilderFlat builderFlat : flat_list){
					buyerList.setFlatNumber(builderFlat.getFlatNo());
				}
				buyerLists.add(buyerList);
			}
		}
		session.close();
		buildingSession.close();
		flatSession.close();
		innersession.close();
		return buyerLists;
	}
	public List<Buyer> getAllBuyer(){
		String hql = "from Buyer where is_deleted=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Buyer> result = query.list();
		session.close();
		return result;
	}
	
	public Buyer getBuyerById(int id){
		String hql = "from Buyer where id = :id and is_deleted=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Buyer> result = query.list();
		return result.get(0);
	}

	public List<BuyerDocList> getBuyerDocListById(int id){
		String hql = "from Buyer where id = :id and is_deleted=0";
		String coownerHql = "from Buyer where builderFlat.id = :flat_id and is_deleted=0";
		String docHql = "from BuyerDocuments where buyer.id = :buyer_id";
		List<BuyerDocList> buyerDocLists = new ArrayList<BuyerDocList>();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Session coownerSession = hibernateUtil.openSession();
		Session docSession = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		Buyer result = (Buyer)query.list().get(0);
		if(result != null){
			Query coownerQuery = coownerSession.createQuery(coownerHql);
			coownerQuery.setParameter("flat_id", result.getBuilderFlat().getId());
			List<Buyer> buyerList = coownerQuery.list();
			for(Buyer buyer : buyerList){
				BuyerDocList buyerDocList = new BuyerDocList();
				buyerDocList.setId(buyer.getId());
				buyerDocList.setName(buyer.getName());
				buyerDocList.setMobile(buyer.getMobile());
				buyerDocList.setEmail(buyer.getEmail());
				buyerDocList.setAddress(buyer.getAddress());
				buyerDocList.setPanCard(buyer.getPancard());
				buyerDocList.setPrimary(buyer.getIsPrimary());
				buyerDocList.setPhoto(buyer.getPhoto());
				buyerDocList.setProjectId(buyer.getBuilderProject().getId());
				buyerDocList.setBuildingId(buyer.getBuilderBuilding().getId());
				buyerDocList.setFlatId(buyer.getBuilderFlat().getId());
				buyerDocList.setStatus(buyer.getStatus());
				Query docQuery = docSession.createQuery(docHql);
				docQuery.setParameter("buyer_id",buyer.getId());
				List<BuyerDocuments> docList = docQuery.list();
				List<String> docLists = new ArrayList<String>();
				for(BuyerDocuments documents : docList){
					docLists.add(documents.getDocuments());
				}
				buyerDocList.setDocResult(docLists);
				buyerDocLists.add(buyerDocList);
			}
		}
		session.close();
		coownerSession.close();
		docSession.close();
		return buyerDocLists;
	}
	public List<BuyerDocuments> getBuyerDocumentsByBuyerId(int buyerId){
		String hql = "from BuyerDocuments where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyerDocuments> result = query.list();
		session.close();
		return result;
	}
	
	public BuyingDetails getBuyingDetailsByBuyerId(int buyerId){
		String hql = "from BuyingDetails where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyingDetails> result = query.list();
		session.close();
		if(result.size()>0){
			return result.get(0);
		}else{
			BuyingDetails buyingDetails = new BuyingDetails();
			buyingDetails.setId(0);
			return buyingDetails;
		}
		
	}
	
	public List<BuyerOffer> getBuyerOffersByBuyerId(int buyerId){
		String hql = "from BuyerOffer where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyerOffer> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuyerPayment> getBuyerPaymentsByBuyerId(int buyerId){
		String hql = "from BuyerPayment where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyerPayment> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuyerUploadDocuments> getBuyerUploadDocumentsByBuyerId(int buyerId){
		String hql = "from BuyerUploadDocuments where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyerUploadDocuments> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage updateBuyer(Buyer buyer){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from GlobalBuyer where pancard = :pancard ";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("pancard", buyer.getPancard());
		List<GlobalBuyer> result = query.list();
		
		GlobalBuyer globalBuyer = new GlobalBuyer();
		if(result.size() <= 0) {
			Session newsession = hibernateUtil.openSession();
			globalBuyer.setName(buyer.getName());
			globalBuyer.setPancard(buyer.getPancard());
			globalBuyer.setMobile(buyer.getMobile());
			globalBuyer.setEmail(buyer.getEmail());
			globalBuyer.setAvatar(buyer.getPhoto());
			globalBuyer.setOtp("");
			globalBuyer.setPassword("");
			globalBuyer.setStatus(false);
			newsession.beginTransaction();
			newsession.save(globalBuyer);
			newsession.getTransaction().commit();
			newsession.close();
		} else {
			globalBuyer = result.get(0);
		}
		if(buyer.getId() != null) {
			Short isDeleted = 0;
			buyer.setGlobalBuyer(globalBuyer);
			buyer.setIsDeleted(isDeleted);
			Session updateSession = hibernateUtil.openSession();
			updateSession.beginTransaction();
			updateSession.update(buyer);
			updateSession.getTransaction().commit();
			updateSession.close();
		} else {
			Short isDeleted = 0;
			buyer.setGlobalBuyer(globalBuyer);
			buyer.setIsDeleted(isDeleted);
			Session updateSession = hibernateUtil.openSession();
			updateSession.beginTransaction();
			updateSession.save(buyer);
			updateSession.getTransaction().commit();
			updateSession.close();
		}
		response.setId(buyer.getId());
		response.setStatus(1);
		response.setMessage("Buyer updated successfully");
		return response;
	}
	
	public ResponseMessage updateBuyingDetails(BuyingDetails buyingDetails){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(buyingDetails.getId() > 0)
			newsession.update(buyingDetails);
		else
			newsession.save(buyingDetails);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Buying Details Updated Successfully");
		return responseMessage;
	}
	
	public ResponseMessage updateBuyerDocuments(List<BuyerDocuments> buyerDocuments){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		
		/***************** Delete entry from Buyer Documents *************************/
		String delete_buyer_documents = "DELETE from  BuyerDocuments where buyer.id = :buyer_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_buyer_documents);
		smdelete.setParameter("buyer_id", buyerDocuments.get(0).getBuyer().getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/**********************Save Buyer Documents new entries *************************/ 
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(buyerDocuments.size()>0){
			for(int i=0;i<buyerDocuments.size();i++){
				newsession.save(buyerDocuments.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Buyer Documents Updated Successfully");
		}
		
		return responseMessage;
	}
	
	
	public ResponseMessage updateBuyerOffers(List<BuyerOffer> buyerOffers){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		/**********************Update Buyer Offers new entries *************************/ 
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(buyerOffers.size()>0){
			for(int i=0;i<buyerOffers.size();i++){
				newsession.update(buyerOffers.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Buyer Offers Updated Successfully");
		}
		
		return responseMessage;
	}
	
	public ResponseMessage updateBuyerPayments(List<BuyerPayment> buyerPayment){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		
//		String delete_buyer_documents = "DELETE from  BuyerPayment where buyer.id = :buyer_id";
//		Session newsession1 = hibernateUtil.openSession();
//		newsession1.beginTransaction();
//		Query smdelete = newsession1.createQuery(delete_buyer_documents);
//		smdelete.setParameter("buyer_id", buyerPayment.get(0).getBuyer().getId());
//		smdelete.executeUpdate();
//		newsession1.getTransaction().commit();
//		newsession1.close();
		
		
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(buyerPayment.size()>0){
			for(int i=0;i<buyerPayment.size();i++){
				newsession.update(buyerPayment.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Buyer Payment Updated Successfully");
		}
		return responseMessage;
	}
	
	public ResponseMessage updateBuyerUploadDocuments(List<BuyerUploadDocuments> buyerUploadDocuments){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(buyerUploadDocuments.size()>0){
			for(int i=0;i<buyerUploadDocuments.size();i++){
				newsession.update(buyerUploadDocuments.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Buyer documents Updated Successfully");
		}
		return responseMessage;
	}
	
	public List<ProjectData> getProjectByBuilderId(int builderId){
		  String hql = "from BuilderProject where builder.id = :builder_id and status=1";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("builder_id", builderId);
			List<BuilderProject> result = query.list();
			List<ProjectData> projectDatas = new ArrayList<ProjectData>();
			for(BuilderProject builderBuilding : result){
				ProjectData buildingData = new ProjectData();
				buildingData.setId(builderBuilding.getId());
				buildingData.setName(builderBuilding.getName());
				projectDatas.add(buildingData);
			}
			session.close();
			return projectDatas;
	}
	
	public List<BuildingData> getBuildingByProjectId(int projectId){
		  String hql = "from BuilderBuilding where builderProject.id = :project_id and status=1";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("project_id", projectId);
			List<BuilderBuilding> result = query.list();
			List<BuildingData> buildingDatas = new ArrayList<BuildingData>();
			for(BuilderBuilding builderBuilding : result){
				BuildingData buildingData = new BuildingData();
				buildingData.setId(builderBuilding.getId());
				buildingData.setName(builderBuilding.getName());
				buildingDatas.add(buildingData);
			}
			session.close();
			return buildingDatas;
	}
	public List<FloorData> getBuilderFloorByBuildingId(int buildingId){
		  String hql = "from BuilderFloor where builderBuilding.id = :building_id";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("building_id", buildingId);
			List<BuilderFloor> result = query.list();
			List<FloorData> floorDatas = new ArrayList<FloorData>();
			for(BuilderFloor builderFloor : result){
				FloorData floorData = new FloorData();
				floorData.setId(builderFloor.getId());
				floorData.setName(builderFloor.getName());
				floorDatas.add(floorData);
			}
			session.close();
			return floorDatas;
	}
	
	public List<FlatData> getBuilderFlatTypeByFloorId(int floorId){
		  String hql = "from BuilderFlat where builderFloor.builderBuilding.id = :floor_id and status=1";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("floor_id", floorId);
			List<BuilderFlat> result = query.list();
			List<FlatData> builderFlats = new ArrayList<FlatData>();
			for(BuilderFlat builderFlat : result){
				FlatData flatData = new FlatData();
				flatData.setId(builderFlat.getId());
				flatData.setName(builderFlat.getFlatNo());
				builderFlats.add(flatData);
			}
			session.close();
			return builderFlats;
		  
	}
	
	/**
	 * @author pankaj
	 * @param floorId
	 * @return list of booked flat  
	 */
	public List<FlatData> getBookedFlatByFloorId(int floorId){
		  String hql = "from BuilderFlat where builderFloor.id = :floor_id and builderFlatStatus.id=2 and status=1";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("floor_id", floorId);
			List<BuilderFlat> result = query.list();
			List<FlatData> builderFlats = new ArrayList<FlatData>();
			for(BuilderFlat builderFlat : result){
				FlatData flatData = new FlatData();
				flatData.setId(builderFlat.getId());
				flatData.setName(builderFlat.getFlatNo());
				builderFlats.add(flatData);
			}
			session.close();
			return builderFlats;
	}
	public List<Buyer> getBuyerByFlatId(int flatId){
		String hql = "from Buyer where builderFlat.id = :flat_id and is_deleted=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		List<Buyer> result = query.list();
		List<Buyer> buyers = new ArrayList<Buyer>();
		if(result.size()>0){
			for(Buyer buyer : result){
				Buyer flatData = new Buyer();
				flatData.setId(buyer.getId());
				flatData.setName(buyer.getName());
				flatData.setMobile(buyer.getMobile());
				flatData.setEmail(buyer.getEmail());
				buyers.add(flatData);
			}
		} else {
			Buyer flatData = new Buyer();
			flatData.setId(0);
			flatData.setName("");
			flatData.setMobile("");
			flatData.setEmail("");
			buyers.add(flatData);
		}
		session.close();
		return buyers;
	}
	
	/**
	 * Get List of flats which are not booked/sold
	 * @author pankaj
	 * @param building_id
	 * @return List of available flats
	 */
	public List<FlatData> getBuilderProjectBuildingFlats(int building_id) {
		String hql = "from BuilderFlat where builderFloor.builderBuilding.id = :building_id and builderFlatStatus.id=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderFlat> result = query.list();
		List<FlatData> flatDatas = new ArrayList<FlatData>();
		for(BuilderFlat builderFlat : result){
			FlatData flatData = new FlatData();
			flatData.setId(builderFlat.getId());
			flatData.setName(builderFlat.getFlatNo());
			flatDatas.add(flatData);
		}
		session.close();
		return flatDatas;
	}
	  
	/**
	 * Get List of flats which are booked/sold
	 * @author pankaj
	 * @param building_id
	 * @return List of booked/sold flats
	 */
	public List<FlatData> getBookedFlats(int building_id) {
		String hql = "from BuilderFlat where builderFloor.builderBuilding.id = :building_id and builderFlatStatus.id=2";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderFlat> result = query.list();
		List<FlatData> flatDatas = new ArrayList<FlatData>();
		for(BuilderFlat builderFlat : result){
			FlatData flatData = new FlatData();
			flatData.setId(builderFlat.getId());
			flatData.setName(builderFlat.getFlatNo());
			flatDatas.add(flatData);
		}
		session.close();
		return flatDatas;
	}
	  
	public List<BuildingData> getBuildingsByProjectId(int project_id) {
		String hql = "from BuilderBuilding where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<BuilderBuilding> result = query.list();
		List<BuildingData> buildingDataList = new ArrayList<BuildingData>();
		for(BuilderBuilding builderBuilding : result){
			BuildingData buildingData = new BuildingData();
			buildingData.setId(builderBuilding.getId());
			buildingData.setName(builderBuilding.getName());
			buildingDataList.add(buildingData);
		}
		session.close();
		return buildingDataList;
	}
		
	public ResponseMessage deleteBuyerById(int id){
		ResponseMessage resp = new ResponseMessage();
		String hql = "from Buyer where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Buyer> buyerList = query.list();
		session.close();
		if(!buyerList.get(0).getIsPrimary()){
			Short isDeleted = 1;
			Buyer secondaryBuyer = new Buyer();
			secondaryBuyer = buyerList.get(0);
			secondaryBuyer.setIsDeleted(isDeleted);
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(secondaryBuyer);
			newsession.getTransaction().commit();
			newsession.close();
		}
		resp.setMessage("Buyer deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	/**
	 * @author pankaj
	 * Delete buyer by id
	 * @param id
	 * @return response message
	 */
	public ResponseMessage deleteSecondaryBuyerById(int id){
		ResponseMessage resp = new ResponseMessage();
		String hql = "from BuyerDocuments where buyer.id = :id";
		String bhql = "from Buyer where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		
		Session bsession = hibernateUtil.openSession();
		Query bquery = bsession.createQuery(bhql);
		bquery.setParameter("id", id);
		List<Buyer> bresult = bquery.list();
		if(bresult.get(0).getIsPrimary()) {
			resp.setStatus(0);
			resp.setMessage("You can not delete primary buyer");
		} else {
		
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("id", id);
			List<BuyerDocuments> result = query.list();
			session.beginTransaction();
			for(BuyerDocuments buyerDocuments :result) {
				session.delete(buyerDocuments);
			}
			session.getTransaction().commit();
			session.close();
			
			Buyer buyer = new Buyer();
			buyer.setId(id);
			Session session2 = hibernateUtil.openSession();
			session2.beginTransaction();
			session2.delete(buyer);
			session2.getTransaction().commit();
			session2.close();
			resp.setMessage("Buyer deleted successfully.");
			resp.setStatus(1);
		}
		
		return resp;
	}
		
	/**
	 * 
	 */
	public List<Buyer> getAllBuyerByBuilderId(int builderId){
		String hql = "from Buyer where builder.id = :builder_id and is_deleted=0 and is_primary=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<Buyer> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuyerList> getBuyersByBuilderEmployee(BuilderEmployee builderEmployee){
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
			hql = "SELECT  buy.name as name, buy.email as email, buy.mobile as phone, "
				+"project.name as projectName, building.name as buildingName,flat.id as id, flat.flat_no as flatNumber "
				+" FROM  buyer as buy left join builder_project as project ON buy.project_id = project.id left join builder_building as building "
				+ "ON buy.building_id = building.id left join builder_flat as flat ON buy.flat_id = flat.id left join "
				+ "builder as build ON buy.builder_id = build.id "
				+"WHERE build.id = "+builderEmployee.getBuilder().getId()+" and buy.is_deleted = 0 and buy.is_primary=1 group by buy.id";
		} else {
			hql = "SELECT buy.name as name, buy.email as email, buy.mobile as phone, "
				+"project.name as projectName, building.name as buildingName, flat.id as id, flat.flat_no as flatNumber "
				+"FROM  buyer as buy left join builder_project as project ON buy.project_id = project.id "
				+ "inner join allot_project as ap ON buy.project_id = ap.project_id "
				+ "left join builder_building as building "
				+ "ON buy.building_id = building.id left join builder_flat as flat ON buy.flat_id = flat.id "
				+"left join builder as build ON buy.builder_id = build.id "
				+"WHERE ap.emp_id = "+builderEmployee.getId()+" and buy.is_deleted = 0 and buy.is_primary=1 group by buy.id";
		}
		System.err.println(hql);
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuyerList.class));
		List<BuyerList> result = query.list();
		session.close();
		return result;
	}
		
	public ResponseMessage deleteBuyerOfferInfo(int id) {
		ResponseMessage resp = new ResponseMessage();
		String hql = "delete from BuyerOffer where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		resp.setMessage("Buyer offer deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
		
	public ResponseMessage deleteBuyerPaymentById(int id) {
		ResponseMessage resp = new ResponseMessage();
		String hql = "delete from BuyerPayment where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		resp.setMessage("Buyer payment deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
		
	public List<Buyer> getFlatBuyersByFlatId(int flat_id){
		String hql = "from Buyer where builderFlat.id = :id and is_deleted=0 order by is_primary desc";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", flat_id);
		List<Buyer> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage changeFlatStatus(int status, int flat_id){
		ResponseMessage response = new ResponseMessage();
		String hql = "from BuilderFlat where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", flat_id);
		List<BuilderFlat> result = query.list();
		session.close();
		if(result.size() > 0) {
			BuilderFlat builderFlat = result.get(0);
			BuilderFlatStatus builderFlatStatus = new BuilderFlatStatus();
			builderFlatStatus.setId(status);
			builderFlat.setBuilderFlatStatus(builderFlatStatus);
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.save(builderFlat);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Flat status updated");
		}
		return response;
	}
	//To display total buyers on dash board
	/**
	 * Get total count of buyers by builder id
	 * @author pankaj
	 * @param builderId
	 * @return count of buyers
	 */
	public Long getTotalBuyers(BuilderEmployee builderEmployee){
		Long totalBuyers = (long) 0;
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 1 || builderEmployee.getBuilderEmployeeAccessType().getId() ==2){
			totalBuyers = getTotalBuyersByBuilderId(builderEmployee.getBuilder().getId());
		}else{
			totalBuyers = getTotalBuyersByEmpId(builderEmployee.getId());
		}
		return totalBuyers;
	}
	
	/**
	 * Get total buyers by passing builder id
	 * @param builderId
	 * @return Long
	 */
	public Long getTotalBuyersByBuilderId(int builderId){
		Long totalBuyers = (long) 0;
		String hql = "select COUNT(*) from Buyer where builder.id = :builder_id and is_deleted = 0 and status=0 and is_primary=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setInteger("builder_id", builderId);
		totalBuyers = (Long) query.uniqueResult();
		if(totalBuyers != null){
			return totalBuyers;
		}else{
			return (long)0;
		}
	}
	
	public Long getTotalBuyersByEmpId(int empId){
		Long totalBuyers = (long) 0;
		String hql = "select COUNT(buy.id) from buyer as buy left join  builder_project as project on buy.project_id = project.id left join allot_project as ap on ap.project_id = project.id where ap.emp_id = :emp_id and buy.is_deleted = 0 and buy.is_primary=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(hql);
		query.setInteger("emp_id", empId);
		BigInteger totalBuyer = (BigInteger) query.uniqueResult();
		if(totalBuyers != null){
			totalBuyers = Long.parseLong(totalBuyer.toString());
			return totalBuyers;
		}else{
			return (long)0;
		}
	}
	
	
	public String validateBuyer(String pancard, String password){
		Gson gson = new Gson();
		String json ="";
		Projects projects = null;
		ResponseMessage responseMessage = new ResponseMessage();
		String hql = "from GlobalBuyer where pancard = :pancard";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("pancard", pancard);
		try{
		GlobalBuyer globalBuyer2 = (GlobalBuyer) query.list().get(0);
		if(globalBuyer2 != null){
			if(globalBuyer2.getPassword().equals(password)){
				projects = new ProjectAPIDAO().getProjectAddresses(globalBuyer2.getPancard());
				projects.setBuyerName(globalBuyer2.getName());
				projects.setPancard(globalBuyer2.getPancard());
				if(globalBuyer2.getAvatar()!=null){
				projects.setBuyerImage(globalBuyer2.getAvatar());
				
				}else{
					projects.setBuyerImage("");
				}
				List<Campaign> campaign = new CampaignDAO().getCampaignList(projects.getId());
				if(campaign !=null){
				projects.setCampaignId(campaign.get(0).getId());
				projects.setTitle(campaign.get(0).getTitle());
				projects.setCampaignImage(campaign.get(0).getImage());
				}else{
					projects.setCampaignId(0);
					projects.setTitle("");
					projects.setCampaignImage("");
				}
				json = gson.toJson(projects);
				return json;
			}else{
				responseMessage.setStatus(0);
				responseMessage.setMessage("invalid password");
				json = gson.toJson(responseMessage);
				return json;
			}
		}else{
			responseMessage.setStatus(0);
			responseMessage.setMessage("User doesn't exists");
			json = gson.toJson(responseMessage);
			return json;
		}
		}catch(Exception e){
			e.printStackTrace();
			responseMessage.setStatus(0);
			responseMessage.setMessage("User doesn't exists");
			json = gson.toJson(responseMessage);
			return json;
			//e.printStackTrace();
		}
	}
	
	public ResponseMessage isUserExist(GlobalBuyer globalBuyer){
		String hql = "from GlobalBuyer where pancard=:pancard";
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Session innerSession = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("pancard", globalBuyer.getPancard());
		try{
		GlobalBuyer  globalBuyer2 = (GlobalBuyer) query.list().get(0);
		if(globalBuyer2 != null){
			globalBuyer2.setOtp(globalBuyer.getOtp());
			innerSession.beginTransaction();
			innerSession.update(globalBuyer2);
			innerSession.getTransaction().commit();
			innerSession.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage(globalBuyer.getOtp());
		}else{
			responseMessage.setStatus(0);
			responseMessage.setMessage("Unregistered User");
		}
		}catch(Exception e){
			e.printStackTrace();
			responseMessage.setStatus(0);
			responseMessage.setMessage("Unregistered User");
		}
		return responseMessage;
	}
	
	public String validateOtp(String otp){
		Gson gson = new Gson();
		String json = null;
		Projects projects = null;
		ResponseMessage responseMessage = new ResponseMessage();
		String hql = "from GlobalBuyer where otp = :otp";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("otp", otp);
		GlobalBuyer globalBuyer = (GlobalBuyer) query.uniqueResult();
		if(globalBuyer != null){
			projects = new ProjectAPIDAO().getProjectAddresses(globalBuyer.getPancard());
			projects.setBuyerName(globalBuyer.getName());
			projects.setPancard(globalBuyer.getPancard());
			if(globalBuyer.getAvatar()!=null){
			projects.setBuyerImage(globalBuyer.getAvatar());
			}else{
				projects.setBuyerImage("");
			}
			List<Campaign> campaigns = new CampaignDAO().getCampaignList(projects.getId());
			CampaignBuyer campaignBuyer = new CampaignDAO().getCamapignBuyer(projects.getPancard(),projects.getId());
			if(campaignBuyer !=null){
			projects.setClick(campaignBuyer.getClicks());
			projects.setView(campaignBuyer.getView());
			}else{
				responseMessage.setStatus(0);
				responseMessage.setMessage("Unregisted user");
				json=gson.toJson(responseMessage);
			}
			
			if(campaigns!=null){
				projects.setCampaignId(campaigns.get(0).getId());
				projects.setCampaignImage(campaigns.get(0).getImage());
				projects.setTitle(campaigns.get(0).getTitle());
			}else{
				projects.setCampaignId(0);
				projects.setCampaignImage("");
				projects.setTitle("");
			}
			
			json = gson.toJson(projects);
		}else{
			responseMessage.setStatus(0);
			responseMessage.setMessage("Unregisted user");
			json=gson.toJson(responseMessage);
		}
		
		return json;
	}
	
	public String userChangePassword(String pancard,String oldPassword, String newPassword){
		ResponseMessage responseMessage = new ResponseMessage();
		Gson gson = new Gson();
		String json = null;
		GlobalBuyer globalBuyer = null;
		String hql = "Update GlobalBuyer set password=:password, status=1 where id = :id";
		try{
			if(isValidUserPassword(oldPassword)){
				globalBuyer = new BuyerDAO().getGlobalBuyerByPancard(pancard);
				HibernateUtil hibernateUtil = new HibernateUtil();
				Session session = hibernateUtil.openSession();
				session.beginTransaction();
				Query query = session.createQuery(hql);
				query.setString("password",newPassword);
				query.setInteger("id", globalBuyer.getId());
				int result = query.executeUpdate();
				session.getTransaction().commit();
				session.close();
//				GlobalBuyer globalBuyer2 = new GlobalBuyer();
//				globalBuyer2.setAvatar(globalBuyer.getAvatar());
//				globalBuyer2.setName(globalBuyer.getName());
//				 
			    // json = gson.toJson(globalBuyer2);
				responseMessage.setStatus(1);
				responseMessage.setMessage("Password Rest Successfully");
				json = gson.toJson(responseMessage);
			}else{
				responseMessage.setStatus(0);
				responseMessage.setMessage("Invalid Password");
				json = gson.toJson(responseMessage);
			}
		}catch(Exception e){
			e.printStackTrace();
			responseMessage.setStatus(0);
			responseMessage.setMessage("Invalid Password");
			json = gson.toJson(responseMessage);
		}
		
		return json;
	}
	public boolean isValidUserPassword(String password) {
		boolean isValid = false;
		String hql = "from GlobalBuyer a where a.password =  :password";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setString("password", password);
		try{
		List<Builder> result = query.list();
		session.close();
		if(result.size()>0)
			isValid = true;
			return isValid;
		}catch(Exception e){
			e.printStackTrace();
			isValid = false;
			return isValid;
		}
		
	}
	
	public GlobalBuyer getGlobalBuyerByPancard(String pancard) {
		boolean isValid = false;
		String hql = "from GlobalBuyer a where a.pancard =  :pancard";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setString("pancard", pancard);
		List<GlobalBuyer> result = query.list();
		return result.get(0);
	}
	
	 public String getBuyerAccountDetailsByPancard(String otp){
		 ResponseMessage responseMessage = new ResponseMessage();
			Gson gson = new Gson();
			String json = null;
			Buyer buyer = new Buyer();
			String hql = "from GlobalBuyer where otp = :otp";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("otp", otp);
			List<GlobalBuyer> result = query.list();
			System.err.println("user is prsent :: "+result.size());
			try{
				List<Buyer> buyerList = getBuyerByPancard(result.get(0).getPancard());
				if(buyerList != null){
					buyer.setName(buyerList.get(0).getName());
					buyer.setAddress(buyerList.get(0).getAddress());
					buyer.setEmail(buyerList.get(0).getEmail());
					buyer.setMobile(buyerList.get(0).getMobile());
					buyer.setAadhaarNumber(buyerList.get(0).getAadhaarNumber());
					if(buyerList.get(0).getIsDeleted() == 0)
						buyer.setIsDeleted(buyerList.get(0).getIsDeleted());
					if(buyerList.get(0).getIsPrimary())
						buyer.setIsPrimary(buyerList.get(0).getIsPrimary());
					json = gson.toJson(buyer);
				}
				return json;
			}catch(Exception e){
				e.printStackTrace();
				responseMessage.setStatus(0);
				responseMessage.setMessage("No account Detail found");
				json = gson.toJson(responseMessage);
				return json;
			}
			
	 }
	 
	 public String getProjectDetails(String pancard){
		 ResponseMessage responseMessage = new ResponseMessage();
		 Gson gson = new Gson();
			String json = null;
			String hql = "from Buyer where pancard = :pancard";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			String projectHql = "from BuilderProject where id = :id";
			Session projectSession = hibernateUtil.openSession();
			Query projectQuery = projectSession.createQuery(projectHql);
 			Query query = session.createQuery(hql);
			query.setParameter("pancard", pancard);
			List<Buyer> buyerList = query.list();
			try{
				if(buyerList != null){
					if(buyerList.get(0).getBuilderProject()!= null){
						projectQuery.setParameter("id", buyerList.get(0).getBuilderProject().getId());
						List<BuilderProject> projectList = projectQuery.list();
						BuilderProject project = new BuilderProject();
						project.setName(projectList.get(0).getName());
						project.setAddr1(projectList.get(0).getAddr1());
						project.setAddr2(projectList.get(0).getAddr2());
						project.setCompletionStatus(projectList.get(0).getCompletionStatus());
						project.setProjectArea(projectList.get(0).getProjectArea());
						System.out.println("Project Id :: "+projectList.get(0).getId());
						System.out.println("Possession date :: "+projectList.get(0).getPossessionDate());
						project.setPossessionDate(projectList.get(0).getPossessionDate());
						//projectQuery.list().get(0);
						//project.setProjectImageGalleries(projectList.get(0).getProjectImageGalleries());
						json = gson.toJson(project);
						
					}
				}
				return json;
			}catch(Exception e){
				responseMessage.setStatus(0);
				responseMessage.setMessage("No project Detail found");
				json = gson.toJson(responseMessage);
				return json;
			}
	 }
	 
	 public String getBuildingDetails(String pancard){
		 ResponseMessage responseMessage = new ResponseMessage();
		 Gson gson = new Gson();
			String json = null;
			String hql = "from Buyer where pancard = :pancard";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			String projectHql = "from BuilderBuilding where id = :id";
			Session projectSession = hibernateUtil.openSession();
			Query projectQuery = projectSession.createQuery(projectHql);
 			Query query = session.createQuery(hql);
			query.setParameter("pancard", pancard);
			List<Buyer> buyerList = query.list();
			try{
				if(buyerList != null){
					if(buyerList.get(0).getBuilderProject()!= null){
						projectQuery.setParameter("id", buyerList.get(0).getBuilderBuilding().getId());
						List<BuilderBuilding> buildingList = projectQuery.list();
						BuilderBuilding building = new BuilderBuilding();
						building.setName(buildingList.get(0).getName());
						BuilderProject project = new BuilderProject();
						project.setAddr1(buildingList.get(0).getBuilderProject().getAddr1());
						project.setAddr2(buildingList.get(0).getBuilderProject().getAddr2());
						project.setProjectArea(buildingList.get(0).getBuilderProject().getProjectArea());
						building.setBuilderProject(project);
						building.setCompletionStatus(buildingList.get(0).getCompletionStatus());
						System.out.println("Project Id :: "+buildingList.get(0).getId());
						System.out.println("Possession date :: "+buildingList.get(0).getPossessionDate());
						building.setPossessionDate(buildingList.get(0).getPossessionDate());
						//projectQuery.list().get(0);
						//project.setProjectImageGalleries(projectList.get(0).getProjectImageGalleries());
						json = gson.toJson(building);
						
					}
				}
				return json;
			}catch(Exception e){
				responseMessage.setStatus(0);
				responseMessage.setMessage("No project Detail found");
				json = gson.toJson(responseMessage);
				return json;
			}
	 }
	 public ResponseMessage deleteDocumentById(int id){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage(); 
		String delete_project_type = "DELETE from BuyerUploadDocuments where id = :id";
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		Query smdelete = newsession.createQuery(delete_project_type);
		smdelete.setParameter("id", id);
		smdelete.executeUpdate();
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Document deleted successfully");
		return responseMessage;
	 }
	 
	 public List<BuyerPayment> getBuyerPymentsByBuyerId(int buyerId){
		String hql = "from BuyerPayment where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyerPayment> result = query.list();
		session.close();
		return result;
	}
	 public List<BuyerPayment> getBuyerPayments(int buyerId){
		String hql = "from BuyerPayment where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyerPayment> result = query.list();
		List<BuyerPayment> buyerPayments = new ArrayList<BuyerPayment>();
		for(BuyerPayment buyerPaymentList : result){
			BuyerPayment buyerPayment = new BuyerPayment();
			buyerPayment.setId(buyerPaymentList.getId());
			buyerPayment.setPaid(buyerPaymentList.isPaid());
			buyerPayment.setAmount(buyerPaymentList.getAmount());
			buyerPayments.add(buyerPayment);
		}
		session.close();
		return buyerPayments;
	}
	 
	 public BuyerPayment getBuyerPymentsById(int id){
		String hql = "from BuyerPayment where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuyerPayment> result = query.list();
		session.close();
		return result.get(0);
	}
	 public ResponseMessage updateBuyerPayment(BuyerPayment buyerPayment){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(buyerPayment);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Buyer Payment Updated Successfully");
	
		return responseMessage;
	}
	 public ResponseMessage deleteDemandByPaymentId(int id, int docid,int demandId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage(); 
		String delete_uploaded_document = "DELETE from BuyerUploadDocuments where id = :id";
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		Query smdelete = newsession.createQuery(delete_uploaded_document);
		smdelete.setParameter("id", docid);
		smdelete.executeUpdate();
		newsession.getTransaction().commit();
		newsession.close();
		String delete_demand_letter = "DELETE from DemandLetters where paymentId = :payment_id and paymentStatus = 0 and id = :id";
		Session demandsession = hibernateUtil.openSession();
		demandsession.beginTransaction();
		Query demanddelete = demandsession.createQuery(delete_demand_letter);
		demanddelete.setParameter("id", demandId);
		demanddelete.setParameter("payment_id", id);
		demanddelete.executeUpdate();
		demandsession.getTransaction().commit();
		demandsession.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Demand letter deleted successfully");
		return responseMessage;
	 }
	 
	 public void updateBuilding(Buyer buyer){
		String buildinghql = "from BuilderBuilding where id = :id";
		String flatTotal = "from FlatPricingDetails where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session buildingSession = hibernateUtil.openSession();
		Query buildingQuery = buildingSession.createQuery(buildinghql);
		buildingQuery.setParameter("id", buyer.getBuilderBuilding().getId());
		BuilderBuilding builderBuilding = (BuilderBuilding) buildingQuery.list().get(0);
		buildingSession.close();
		Session flatSession = hibernateUtil.openSession();
		Query flatQuery = flatSession.createQuery(flatTotal);
		//Session updateSession = hibernateUtil.openSession();
		if(builderBuilding != null){
			flatQuery.setParameter("flat_id",buyer.getBuilderFlat().getId() );
			FlatPricingDetails flatPricingDetails = (FlatPricingDetails)flatQuery.list().get(0);
			double revenue = builderBuilding.getRevenue() + flatPricingDetails.getTotalCost();
			builderBuilding.setRevenue(revenue);
			Session updateBuilding = hibernateUtil.openSession();
			updateBuilding.beginTransaction();
			updateBuilding.update(builderBuilding);
			updateBuilding.getTransaction().commit();
			updateBuilding.close();
		}
		flatSession.close();
	 }
	 
	 public void updateBuildingInventory(int flatId){
		String hql = "UPDATE BuilderBuilding set inventorySold =:soldInventory, totalInventory = :totalInventory where id = :building_id ";
		double totalInventory = 0.0;
		double soldInventory = 0.0;
		BuilderFlat builderFlat = getFlatById(flatId);
		int buildingId = builderFlat.getBuilderFloor().getBuilderBuilding().getId();
		totalInventory = getTotalFlatCount(buildingId);
		soldInventory = getSoldFlatCount(buildingId);
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("soldInventory", soldInventory);
		query.setParameter("totalInventory",totalInventory );
		query.setParameter("building_id",buildingId );
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
 
	public int getTotalFlatCount(int buildingId){
		String hql = "select id from BuilderFlat where builderFloor.builderBuilding.id = :building_id  AND status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", buildingId);
		int totalInventory = query.list().size();
		return totalInventory;
	}
	
	public int getSoldFlatCount(int buildingId){
		String hql = "Select id from BuilderFlat where builderFloor.builderBuilding.id = :building_id and builderFlatStatus =2 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", buildingId);
		int soldInventory =  query.list().size();
		return soldInventory;
	}
	public BuilderFlat getFlatById(int flatId){
		String hql = "From BuilderFlat where id=:flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		List<BuilderFlat> result = query.list();
		return result.get(0);
				
	}
	
	public Buyer getBuyerByFlat(int flatId){
		String hql = "From Buyer where builderFlat.id = :flat_id and isPrimary=1 and isDeleted=0 and status=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id",flatId);
		List<Buyer> buyers = query.list();
		return buyers.get(0);
	}
	
	public ResponseMessage getForgotPasswod(String emailId){
		ResponseMessage responseMessage = new ResponseMessage();
		String hql = "from GlobalBuyer where email = :email";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		if(emailId !="" && emailId != null){
			query.setParameter("email", emailId);
		}else{
			responseMessage.setStatus(0);
			responseMessage.setMessage("Please enter your email id");
		}
		try{
		GlobalBuyer result =(GlobalBuyer) query.list().get(0);
			if(result !=null){
				
					responseMessage.setStatus(1);
					responseMessage.setMessage("New password sent to your email."); 
			}
		}catch(Exception e){
			responseMessage.setStatus(0);
			responseMessage.setMessage("invalid email id");
		}
		return responseMessage;
	}
	
	public ResponseMessage updateBuyerAccount(String pancard, String name, String email, String contactNumber,String aadhaarNumber,String address){
		ResponseMessage responseMessage = new ResponseMessage();
		String hql ="";
		boolean validate = false;
		if(name.trim().length() ==0 || email.trim().length() ==0 || contactNumber.trim().length() ==0 || aadhaarNumber.trim().length()==0 || address.trim().length() ==0){
			responseMessage.setStatus(0);
			System.out.println("All fields are mandatory");
			responseMessage.setMessage("All fields are mandatory");
			return responseMessage;
		} 
		else{
			if(email!=null){
				validate = new EmailValidator().validate(email);
				if(!validate){
					System.out.println("Invalid email id");
					responseMessage.setStatus(0);
					responseMessage.setMessage("Invalid email id");
					return responseMessage;
				}
			}
			if(contactNumber != "" && contactNumber != null){
				if(contactNumber.trim().length() < 10 || contactNumber.trim().length() >10){
					try{
						double d = Double.parseDouble(contactNumber);
						responseMessage.setStatus(0);
						responseMessage.setMessage("mobile number must be 10 digits");
						return responseMessage;
					}
					catch(Exception e){
						responseMessage.setStatus(0);
						responseMessage.setMessage("Please enter your 10 digit mobile number");
						return responseMessage;
					}
				}else {
					if(contactNumber.trim().length() == 10){
						try{
							double d= Double.parseDouble(contactNumber);
						}catch(Exception e){
							e.printStackTrace();
							responseMessage.setStatus(0);
							responseMessage.setMessage("Invalid mobile number");
							return responseMessage;
						}
					}
				}
			}
			if(aadhaarNumber != "" && aadhaarNumber != null){
				if(aadhaarNumber.trim().length()<12 || aadhaarNumber.trim().length()>12){
					try{
						double d = Double.parseDouble(aadhaarNumber);
						System.err.println("Aadhaar number must be 12 digits");
						responseMessage.setStatus(0);
						responseMessage.setMessage("Aadhaar number must be 12 digits");
						return responseMessage;
					}catch(Exception e){
						responseMessage.setStatus(0);
						responseMessage.setMessage("Invalid aadhaar number");
						return responseMessage;
					}
				}else if(aadhaarNumber.trim().length() == 12){
					try{
						double d = Double.parseDouble(aadhaarNumber);
					}catch(Exception e){
						e.printStackTrace();
						responseMessage.setStatus(0);
						responseMessage.setMessage("Please enter your 12 digit aadhaar number");
						return responseMessage;
					}
				}
			}
			try{
				 hql = "UPDATE GlobalBuyer set name =:name, email = :email, mobile = :mobile where pancard = :pancard ";
				System.out.println("Your are in update buyer");
				HibernateUtil hibernateUtil = new HibernateUtil();
				Session session = hibernateUtil.openSession();
				session.beginTransaction();
				Query query = session.createQuery(hql);
				query.setParameter("name", name);
				query.setParameter("email",email );
				query.setParameter("mobile", contactNumber);
				query.setParameter("pancard",pancard );
				query.executeUpdate();
				session.getTransaction().commit();
				session.close();
				
				String buyerHql = "UPDATE Buyer set name = :name, email = :email,mobile =:mobile, aadhaar_number = :aadhaar, address = :address where pancard = :pancard";
				Session buyerSession = hibernateUtil.openSession();
				buyerSession.beginTransaction();
				Query buyerQuery = buyerSession.createQuery(buyerHql);
				buyerQuery.setParameter("name", name);
				buyerQuery.setParameter("email", email);
				buyerQuery.setParameter("mobile", contactNumber);
				buyerQuery.setParameter("aadhaar", aadhaarNumber);
				buyerQuery.setParameter("address", address);
				buyerQuery.setParameter("pancard", pancard);
				buyerQuery.executeUpdate();
				buyerSession.getTransaction().commit();
				buyerSession.close();
				responseMessage.setStatus(1);
				responseMessage.setMessage("Account settings updated successfully.");
				
			}catch(Exception e){
				e.printStackTrace();
				responseMessage.setStatus(0);
				responseMessage.setMessage("Fail to update account settings. Please try again");
				return responseMessage;
			}
		return responseMessage;
		}
	}
	
	public List<Buyer> getBuyerByPancard(String pancard){
		String hql ="FROM Buyer where pancard = :pancard";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("pancard", pancard);
		List<Buyer> result = query.list();
		return result;
	}
	
	public BuyerUploadDocuments getBuyerUploadDocument(int id){
		String hql = "from BuyerUploadDocuments where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		BuyerUploadDocuments buyerUploadDocuments = (BuyerUploadDocuments) query.list().get(0);
		return buyerUploadDocuments;
		
	}
 }