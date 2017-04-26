package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.BuildingData;
import org.bluepigeon.admin.data.BuyerData;
import org.bluepigeon.admin.data.BuyerList;
import org.bluepigeon.admin.data.FlatData;
import org.bluepigeon.admin.data.FloorData;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderBuyer;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.BuyerDocuments;
import org.bluepigeon.admin.model.BuyerOffer;
import org.bluepigeon.admin.model.BuyerPayment;
import org.bluepigeon.admin.model.BuyerUploadDocuments;
import org.bluepigeon.admin.model.BuyingDetails;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class BuyerDAO {
	
	public ResponseMessage saveBuyer(List<Buyer> buyers){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		List<ResponseMessage> responseList = new ArrayList<ResponseMessage>();
		String hql = "from Buyer where name = :name";
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
				
				Query query = session.createQuery(hql);
				query.setParameter("name", buyerList.getName());
				List<Buyer> result = query.list();
				if (result.size() > 0) {
					response.setStatus(0);
					response.setMessage("Buyer name already exists");
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
			}
		newsession.getTransaction().commit();
		session.close();
		newsession.close();
		builderSession.close();
		updateFlatStatus(buyers.get(0).getBuilderFlat().getId());
		insertBuilderBuyer(buyers);
		return response;
	}
	
	public void updateFlatStatus(int flatId){
		String hql = "UPDATE BuilderFlat set status_id = 2 "  + 
	             "WHERE id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		org.hibernate.Transaction tx=session.beginTransaction();  
		Query query = session.createQuery(hql);
		query.setParameter("id", flatId);
		query.executeUpdate();
		tx.commit();
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
		if(buyerUploadDocuments.size()>0){
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			for(int i=0;i<buyerUploadDocuments.size();i++){
				newsession.save(buyerUploadDocuments.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Success");
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
			buyerList.setAgreement(buyer.getAgreement());
			buyerList.setPossession(buyer.getPossession());
			buyerList.setPhone(buyer.getContact());
			buyerList.setEmail(buyer.getEmail());
			buyerList.setStatus(buyer.getStatus());
			buyerLists.add(buyerList);
		}
		session.close();
		projectSession.close();
		buildingSession.close();
		flatSession.close();
		return buyerLists;
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
				buyerList.setPhone(buyer.getContact());
				buyerList.setEmail(buyer.getEmail());
				buyerList.setAgreement(buyer.getAgreement());
				System.out.println("Possession :: "+buyer.getPossession());
				buyerList.setPossession(buyer.getPossession());
				buyerList.setStatus(buyer.getStatus());
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
		String hql = "from Buyer";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Buyer> result = query.list();
		session.close();
		return result;
	}
	
	public Buyer getBuyerById(int id){
		String hql = "from Buyer where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Buyer> result = query.list();
		session.close();
		if(result.size()>0){
		return result.get(0);
		}else{
			Buyer buyer = new Buyer();
			buyer.setId(0);
			return buyer;
		}
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
	public ResponseMessage updateBuyer(BuyerData buyerData){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Buyer buyer = buyerData.getBuyer();
		String hql = "from Buyer where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", buyer.getName());
		query.setParameter("id", buyer.getId());
		List<Buyer> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Buyer name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(buyer);
			newsession.getTransaction().commit();
			newsession.close();
			
			String delete_buyer_documents = "DELETE from  BuyerDocuments where buyer.id = :buyer_id";
			Session newsession1 = hibernateUtil.openSession();
			newsession1.beginTransaction();
			Query smdelete = newsession1.createQuery(delete_buyer_documents);
			smdelete.setParameter("buyer_id", buyer.getId());
			smdelete.executeUpdate();
			newsession1.getTransaction().commit();
			newsession1.close();
			
			List<BuyerDocuments> buyerDocuments = buyerData.getBuyerDocuments();
			if(buyerDocuments.size()>0){
				Session session2 = hibernateUtil.openSession();
				session2.beginTransaction();
				for(int i=0;i<buyerDocuments.size();i++){
					BuyerDocuments buyerDocuments2 = new BuyerDocuments();
					buyerDocuments2.setBuyer(buyer);
					session2.save(buyerDocuments2);
				}
				session2.getTransaction().commit();
				session2.close();
			}
			
			response.setStatus(1);
			response.setMessage("Buyer Updated Successfully");
		}
		return response;
	}
	
	public ResponseMessage updateBuyingDetails(BuyingDetails buyingDetails){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(buyingDetails);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Buying Details Updated Successfully");
		return responseMessage;
	}
	
	public ResponseMessage updateBuyerOffers(List<BuyerOffer> buyerOffers){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		
		/***************** Delete entry from Buyer Offers *************************/
		String delete_buyer_documents = "DELETE from  BuyerOffer where buyer.id = :buyer_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_buyer_documents);
		smdelete.setParameter("buyer_id", buyerOffers.get(0).getBuyer().getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/**********************Save Buyer Offers new entries *************************/ 
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(buyerOffers.size()>0){
			for(int i=0;i<buyerOffers.size();i++){
				newsession.save(buyerOffers.get(i));
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
		
		String delete_buyer_documents = "DELETE from  BuyerPayment where buyer.id = :buyer_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_buyer_documents);
		smdelete.setParameter("buyer_id", buyerPayment.get(0).getBuyer().getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(buyerPayment.size()>0){
			for(int i=0;i<buyerPayment.size();i++){
				newsession.save(buyerPayment.get(i));
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
		
		String delete_buyer_documents = "DELETE from  BuyerUploadDocuments where buyer.id = :buyer_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_buyer_documents);
		smdelete.setParameter("buyer_id", buyerUploadDocuments.get(0).getBuyer().getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(buyerUploadDocuments.size()>0){
			for(int i=0;i<buyerUploadDocuments.size();i++){
				newsession.save(buyerUploadDocuments.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Buyer documents Updated Successfully");
		}
		return responseMessage;
	}
	
	 public List<ProjectData> getProjectByBuilderId(int builderId){
		  String hql = "from BuilderProject where builder.id = :builder_id";
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
		  String hql = "from BuilderBuilding where builderProject.id = :project_id";
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
		  String hql = "from BuilderFlat where builderFloor.builderBuilding.id = :floor_id";
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
	  
	  public List<FlatData> getBookedFlatByFloorId(int floorId){
		  String hql = "from BuilderFlat where builderFloor.id = :floor_id and builderFlatStatus.id=2";
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
		 
		  String hql = "from Buyer where builderFlat.id = :flat_id";
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
				  flatData.setContact(buyer.getContact());
				  flatData.setEmail(buyer.getEmail());
				  buyers.add(flatData);
			  }
		  }
		  else{
			  Buyer flatData = new Buyer();
			  flatData.setId(0);
			  flatData.setName("");
			  flatData.setContact("");
			  flatData.setEmail("");
			  buyers.add(flatData);
		  }
		  session.close();
		 return buyers;
	  }
	  /**
	   * Get List of available flats which are not booked/sold
	   * @author pankaj
	   * @param building_id
	   * @return List of available flats
	   */
	  public List<FlatData> getBuilderProjectBuildingFlats(int building_id) {
			String hql = "from BuilderFlat where builderFloor.builderBuilding.id = :building_id and builderFlatStatus.name='available'";
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
		
}