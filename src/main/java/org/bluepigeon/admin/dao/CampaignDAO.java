package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.BuyerBuildingList;
import org.bluepigeon.admin.data.BuyerFlatList;
import org.bluepigeon.admin.data.BuyerProjectList;
import org.bluepigeon.admin.data.CampaignList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.Campaign;
import org.bluepigeon.admin.model.CampaignBuyer;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class CampaignDAO {

	/**
	 * Get project and buyer names by city Id
	 * @author pankaj
	 * @param cityId
	 * @return project and buyer list with respect of city id
	 */
	public List<BuyerProjectList> getBuyerProjectByCityId(int cityId){
		List<BuyerProjectList> buyerProjectLists = new ArrayList<BuyerProjectList>();
		String hql = "from BuilderProject where city.id = :city_id";
		String buyerHql = "from Buyer where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Session BuyerSession = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("city_id", cityId);
		List<BuilderProject> builderProjects = query.list();
		for(BuilderProject builderProject : builderProjects){
			Query BuyerQuery = BuyerSession.createQuery(buyerHql);
			BuyerQuery.setParameter("project_id", builderProject.getId());
			BuyerProjectList buyerProjectList = new BuyerProjectList();
			buyerProjectList.setProjectId(builderProject.getId());
			buyerProjectList.setProjectName(builderProject.getName());
			List<Buyer> buyer_list = BuyerQuery.list();
			Buyer buyer2[] = new Buyer[buyer_list.size()];
			for(int i=0;i< buyer_list.size();i++){
				buyer2[i]=new Buyer();
				buyer2[i].setId(buyer_list.get(i).getId());
				buyer2[i].setName(buyer_list.get(i).getName());
				buyerProjectList.setBuyer(buyer2);
			}
			buyerProjectLists.add(buyerProjectList);
		}
		session.close();
		BuyerSession.close();
		return buyerProjectLists;
	}
	/**
	 * Get Building and Buyer name by Project Id
	 * @author pankaj
	 * @param projectId
	 * @return building and buyer name list
	 */
	public List<BuyerBuildingList> getBuyerBuildingListByProjectId(int projectId){
		List<BuyerBuildingList> buyerBuildingLists = new ArrayList<BuyerBuildingList>();
		String hql = "from BuilderBuilding where builderProject.id = :project_id";
		String buyerHql = "from Buyer where builderFlat.builderFloor.builderBuilding.id =:building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Session BuyerSession = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderBuilding> result = query.list();
		for(BuilderBuilding builderBuilding : result){
			BuyerBuildingList buyerBuildingList = new BuyerBuildingList();
			buyerBuildingList.setBuildingId(builderBuilding.getId());
			buyerBuildingList.setBuildingName(builderBuilding.getName());
			Query buyerQuery = BuyerSession.createQuery(buyerHql);
			buyerQuery.setParameter("building_id", builderBuilding.getId());
			List<Buyer> buyers = buyerQuery.list();
			Buyer buyer2[] = new Buyer[buyers.size()];
			for(int i=0;i<buyers.size();i++){
				buyer2[i] = new Buyer();
				buyer2[i].setId(buyers.get(i).getId());
				buyer2[i].setName(buyers.get(i).getName());
				buyerBuildingList.setBuyer(buyer2);
			}
			buyerBuildingLists.add(buyerBuildingList);
		}
		session.close();
		BuyerSession.close();
		return buyerBuildingLists;
	}
	/**
	 * Get Flat no. with buyer name
	 * @author pankaj
	 * @param buildingId
	 * @return list of flat with buyer's name
	 */
	public List<BuyerFlatList> getBuyerFlatListByBuildingId(int buildingId){
		List<BuyerFlatList> buyerFlatLists = new ArrayList<BuyerFlatList>();
		String hql = "from BuilderFlat where builderFloor.builderBuilding.id = :building_id";
		String buyerHql = "from Buyer where  builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Session buyerSession = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", buildingId);
		List<BuilderFlat> builderFlats = query.list();
		for(BuilderFlat builderFlat : builderFlats){
			BuyerFlatList buyerFlatList = new BuyerFlatList();
			buyerFlatList.setFlatId(builderFlat.getId());
			buyerFlatList.setFlatNo(builderFlat.getFlatNo());
			Query buyerQuery = buyerSession.createQuery(buyerHql);
			buyerQuery.setParameter("flat_id", builderFlat.getId());
			List<Buyer> buyers = buyerQuery.list();
			Buyer buyer[] = new Buyer[buyers.size()];
			for(int i=0;i<buyers.size();i++){
				buyer[i] = new Buyer();
				buyer[i].setId(buyers.get(i).getId());
				buyer[i].setName(buyers.get(i).getName());
				buyerFlatList.setBuyer(buyer);
			}
			buyerFlatLists.add(buyerFlatList);		
		}
		return buyerFlatLists;
	}
	/**
	 * Get buyer name by flat id
	 * @author pankaj
	 * @param flatId
	 * @return list of buyers
	 */
	public List<Buyer> getBuyerbyFlatId(int flatId){
		String hql ="from Buyer where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		List<Buyer> buyers = query.list();
		List<Buyer> buyerList = new ArrayList<Buyer>();
		for(Buyer buyer: buyers){
			Buyer b = new Buyer();
			b.setId(buyer.getId());
			b.setName(buyer.getName());
			buyerList.add(b);
		}
		return buyerList;
	}
	/**
	 * Get all campaign list
	 * @author pankaj
	 * @return campaign list
	 */
	public List<CampaignList> getCampaignList(){
		List<CampaignList> campaignLists = new ArrayList<>();
		String hql = "from Campaign";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Campaign> campaigns = query.list();
		for(Campaign campaign : campaigns){
			CampaignList campaignList = new CampaignList();
			campaignList.setCampaignId(campaign.getId());
			campaignList.setTitle(campaign.getTitle());
			campaignList.setCampaignType(campaign.getType());
			campaignList.setSetdate(campaign.getSetDate());
			campaignLists.add(campaignList);
		}
		return campaignLists;
	}
	public ResponseMessage saveCampaign(Campaign campaign){
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
	public ResponseMessage saveBuyerCampaign(List<CampaignBuyer> campaignBuyers){
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
			response.setMessage("Campaign Added Successfully");
		}
		return response;
	}
	/**
	 * Update Campaign details
	 * @author pankaj
	 * @param campaign
	 * @return message
	 */
	public ResponseMessage updateCampaign(Campaign campaign){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(campaign);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Buying Details Updated Successfully");
		return responseMessage;
	}
	
	/**
	 * @author pankaj
	 * @param buyerOffers
	 * @return message
	 */
	public ResponseMessage updateBuyerOffers(List<CampaignBuyer> campaignBuyers){
		HibernateUtil hibernateUtil = new HibernateUtil();
		ResponseMessage responseMessage = new ResponseMessage();
		
		/***************** Delete entry from Campaign Buyer *************************/
		String delete_buyer_documents = "DELETE from  CampaignBuyer where buyer.id = :buyer_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_buyer_documents);
		smdelete.setParameter("buyer_id", campaignBuyers.get(0).getBuyer().getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/**********************Save Campaign Buyer new entries *************************/ 
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		if(campaignBuyers.size()>0){
			for(int i=0;i<campaignBuyers.size();i++){
				newsession.save(campaignBuyers.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Buyer Offers Updated Successfully");
		}
		
		return responseMessage;
	}
}