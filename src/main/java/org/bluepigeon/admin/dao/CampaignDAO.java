package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.BuyerBuildingList;
import org.bluepigeon.admin.data.BuyerFlatList;
import org.bluepigeon.admin.data.BuyerProjectList;
import org.bluepigeon.admin.data.CampaignList;
import org.bluepigeon.admin.data.CampaignListNew;
import org.bluepigeon.admin.data.CityData;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.data.ProjectList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.Campaign;
import org.bluepigeon.admin.model.CampaignBuyer;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.hibernate.type.DateType;
import org.hibernate.type.IntegerType;
import org.hibernate.type.LongType;
import org.hibernate.type.StandardBasicTypes;
import org.hibernate.type.StringType;

public class CampaignDAO {

	/**
	 * Get project and buyer names by city Id
	 * @author pankaj
	 * @param cityId
	 * @return project and buyer list with respect of city id
	 */
	public List<BuyerProjectList> getBuyerProjectByCityId(int cityId){
		List<BuyerProjectList> buyerProjectLists = new ArrayList<BuyerProjectList>();
		String hql = "from BuilderProject where city.id = :city_id and status=1";
		String buyerHql = "from Buyer where builderProject.id = :project_id and is_deleted=0 and is_primary=1";
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
				buyer2[i].setIsPrimary(buyer_list.get(i).getIsPrimary());
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
		String hql = "from BuilderBuilding where builderProject.id = :project_id and status=1";
		String buyerHql = "from Buyer where builderBuilding.id =:building_id and is_deleted=0 and is_primary=1";
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
				//if(buyer2[i].getIsPrimary() && buyer2[i].getIsDeleted() == 0){
					buyer2[i].setId(buyers.get(i).getId());
					buyer2[i].setName(buyers.get(i).getName());
					buyer2[i].setIsPrimary(buyers.get(i).getIsPrimary());
					System.out.println("BuyerName ::: "+buyer2[i].getName());
					buyerBuildingList.setBuyer(buyer2);
				//}
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
		String hql = "from BuilderFlat where builderFloor.builderBuilding.id = :building_id and status=1";
		String buyerHql = "from Buyer where  builderFlat.id = :flat_id and is_deleted=0 and is_primary=1";
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
				//if(buyer[i].getIsPrimary() && buyer[i].getIsDeleted() == 0){
					buyer[i].setId(buyers.get(i).getId());
					buyer[i].setName(buyers.get(i).getName());
					buyer[i].setIsPrimary(buyers.get(i).getIsPrimary());
					buyerFlatList.setBuyer(buyer);
				//}
			}
			buyerFlatLists.add(buyerFlatList);		
		}
		session.close();
		buyerSession.close();
		return buyerFlatLists;
	}
	/**
	 * Get buyer name by flat id
	 * @author pankaj
	 * @param flatId
	 * @return list of buyers
	 */
	public List<Buyer> getBuyerbyFlatId(int flatId){
		String hql ="from Buyer where builderFlat.id = :flat_id and is_deleted=0 and is_primary=1";
		HibernateUtil hibernateUtil = new HibernateUtil(); 
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		List<Buyer> buyers = query.list();
		List<Buyer> buyerList = new ArrayList<Buyer>();
		for(Buyer buyer: buyers){
			Buyer b = new Buyer();
			//if(b.getIsPrimary()){
				b.setId(buyer.getId());
				b.setName(buyer.getName());
				b.setIsPrimary(buyer.getIsPrimary());
				buyerList.add(b);
			//}
		}
		session.close();
		return buyerList;
	}
	/**
	 * Get all campaign list
	 * @author pankaj
	 * @return campaign list
	 */
	public List<CampaignList> getCampaignList(){
		List<CampaignList> campaignLists = new ArrayList<CampaignList>();
		String hql = "from Campaign where is_deleted=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Campaign> campaigns = query.list();
		session.close();
		for(Campaign campaign : campaigns){
			CampaignList campaignList = new CampaignList();
			campaignList.setCampaignId(campaign.getId());
			campaignList.setTitle(campaign.getTitle());
			campaignList.setCampaignType(campaign.getType());
			campaignList.setSetDate(campaign.getSetDate());
			campaignLists.add(campaignList);
		}
		return campaignLists;
	}
	
	/**
	 * Get all campaign list
	 * @author pankaj
	 * @return campaign list
	 */
	public List<CampaignList> getCampaignListByBuilderId(int builderId){
		List<CampaignList> campaignLists = new ArrayList<CampaignList>();
		String hql = "from Campaign where builderProject.builder.id = :builder_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<Campaign> campaigns = query.list();
		for(Campaign campaign : campaigns){
			CampaignList campaignList = new CampaignList();
			campaignList.setCampaignId(campaign.getId());
			campaignList.setTitle(campaign.getTitle());
			campaignList.setCampaignType(campaign.getType());
			campaignList.setSetDate(campaign.getSetDate());
			campaignLists.add(campaignList);
		}
		session.close();
		return campaignLists;
	}
	/**
	 * Get list of all active campaign
	 * @author pankaj
	 * @param builderId
	 * @return List<CampaignList>
	 */
	public List<CampaignList> getActiveCampaignListByBuilder(BuilderEmployee builderEmployee){
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
			hql = "SELECT camp.id as campaignId, camp.title as title, camp.type as campaignType, camp.set_date as setDate "
				+"FROM  campaign as camp left join builder as build ON camp.builder_id = build.id "
				+"WHERE build.id = "+builderEmployee.getBuilder().getId()+" and camp.is_deleted = 0 group by camp.id";
		} else {
			hql = "SELECT camp.id as campaignId, camp.title as title, camp.type as campaignType, camp.set_date as setDate "
					+"FROM  campaign as camp inner join allot_project ap ON camp.project_id = ap.project_id "
					+"left join builder as build ON camp.builder_id = build.id "
					+"WHERE ap.emp_id = "+builderEmployee.getId()+" and camp.is_deleted = 0 group by camp.id";
		}
		System.err.println(hql);
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(CampaignList.class));
		List<CampaignList> result = query.list();
		session.close();
		return result;
	}
	
	public List<CampaignListNew> getNewCampaignListByBuilderEmployee(BuilderEmployee builderEmployee, int projectId){
//		BuilderEmployee builderEmployee = null;
//		String empHql = "from BuilderEmployee where id = :id";
//		String hql ="";
//		
		HibernateUtil hibernateUtil = new  HibernateUtil();
//		Session session = hibernateUtil.openSession();
//		Query query = session.createQuery(empHql);
//		if(empId > 0)
//		query.setParameter("id", empId);
//		 builderEmployee = (BuilderEmployee)query.uniqueResult();
		String hql ="";
		if(builderEmployee != null){
			try{
			//builderEmployee = result.get(0);
			if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2){
				hql = "SELECT camp.id as id, camp.content as content, camp.term as terms, camp.set_date as startDate, camp.end_date as endDate, camp.image as image,"
						+ " project.name as name, count(lead.id) as leads, count(b.id) as booking FROM campaign as camp "
						+" inner join builder_project as project on project.id = camp.project_id "
						+ " left join builder_lead as lead on project.id = lead.project_id "
						+ " left join buyer as b on b.project_id = project.id "
						+" left join builder as build ON project.group_id = build.id "
						+ " where project.status = 1 AND build.id = "+builderEmployee.getBuilder().getId()+" group by project.id";
			}
			else if(builderEmployee.getBuilderEmployeeAccessType().getId() == 3){
				hql = "SELECT camp.id as id, camp.content as content, camp.terms as terms, camp.set_date as startDate, camp.till_date as endDate, camp.image as image,"
						+ " project.name as name, count(lead.id) as leads, count(b.id) as booking FROM campaign as camp "
						+ " inner join builder_project as project on project.id = camp.project_id "
						+ " left join builder_lead as lead on project.id = lead.project_id "
						+ " left join buyer as b on project.id = b.project_id  "
						+" inner join allot_project as ap on project.id = ap.project_id "
						+ " where project.status=1 AND ap.emp_id = "+builderEmployee.getId()+" group by project.id";
			}else{
//				hql = "SELECT camp.id as id, camp.content as content, camp.set_date as startDate, camp.end_date as endDate, camp.image as image, "
//						+ " project.name as name, 0 as leads, 0 as booking FROM  campaign as camp "
//						+ " inner join builder_project as project on camp.project_id = project.id "
//						+ " where project.status = 1 AND camp.is_delete=0 AND project.id = "+projectId+" group by camp.id order by project.id DESC";
				
				hql = "SELECT camp.id as id, camp.content as content, camp.terms as terms, camp.image as image, camp.set_date as startDate,camp.end_date as endDate, project.name as name "
						+ "FROM campaign as camp "
						+ "inner join builder_project as project on project.id = camp.project_id "
						+ "WHERE project.id="+projectId+" and camp.is_deleted=0 GROUP by camp.id order by project.id";
			}
			    Session sessionCampaign = hibernateUtil.getSessionFactory().openSession();
			    Query queryCampaign = sessionCampaign.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(CampaignListNew.class));
			    System.err.println(hql);
			    try{
			    	List<CampaignListNew> campaignListNews = queryCampaign.list();
			    	return campaignListNews;
			    }catch(Exception e){
			    	e.printStackTrace();
			    	return null;
			    }
			}catch(Exception e){
				e.printStackTrace();
				return null;
			}
			}else{
				System.err.println("hello from else");
		return null;
		}
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
		responseMessage.setMessage("Campaign Updated Successfully");
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
		String delete_buyer_documents = "DELETE from  CampaignBuyer where buyer_id = :buyer_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_buyer_documents);
		smdelete.setParameter("buyer_id", campaignBuyers.get(0).getBuyerId());
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
	
	public Campaign getCampaignById(int id){
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from Campaign where id= :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		Campaign campaign = (Campaign)query.list().get(0);
		return campaign;
	}
	
	public ResponseMessage deleteCampaignById(int id){
		ResponseMessage responseMessage = new ResponseMessage();
		byte deleted = 1;
		Campaign campaign = getCampaignById(id);
		campaign.setIsDeleted(deleted);
		responseMessage = updateCampaign(campaign);
		if(responseMessage.getStatus()==1){
			responseMessage.setMessage("Campaign is deleted successflly");
		}else{
			responseMessage.setStatus(0);
			responseMessage.setMessage("Fail to delete campaign. Please try again");
		}
		return responseMessage;
	}
	
	/* **************** GET CUSTOM CAMPAIGN LIST *************** */
	public List<CampaignListNew> getMyAssignedProjectCampaigns(BuilderEmployee builderEmployee){
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 1) {
			hql = "SELECT a.id, a.title, a.content, a.set_date as startDate, a.end_date as endDate, a.terms, a.image, a.project_id as projectId, b.name,"
					 +" COUNT( c.id ) AS leads, SUM( CASE c.lead_status WHEN 7 THEN 1 ELSE 0 END ) AS booking"
					 +" FROM campaign AS a INNER JOIN builder_project AS b ON a.project_id = b.id"
					 +" LEFT JOIN builder_lead AS c ON a.id = c.campaign_id"
					 +" WHERE b.group_id = "+builderEmployee.getBuilder().getId()+" GROUP BY a.id order by a.id DESC";
		} else {
			hql = "SELECT a.id, a.title, a.content, a.set_date as startDate, a.end_date as endDate, a.terms, a.image, a.project_id as projectId, b.name,"
				 +" COUNT( c.id ) AS leads, SUM( CASE c.lead_status WHEN 7 THEN 1 ELSE 0 END ) AS booking"
				 +" FROM campaign AS a INNER JOIN builder_project AS b ON a.project_id = b.id"
				 +" LEFT JOIN builder_lead AS c ON a.id = c.campaign_id INNER JOIN allot_project AS d ON a.project_id = d.project_id"
				 +" WHERE d.emp_id = "+builderEmployee.getId()+" GROUP BY a.id order by a.id DESC";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.addScalar("id", IntegerType.INSTANCE)
				.addScalar("projectId", IntegerType.INSTANCE)
				.addScalar("leads", LongType.INSTANCE)
				.addScalar("booking", LongType.INSTANCE)
	            .addScalar("title", StringType.INSTANCE)
	            .addScalar("content", StringType.INSTANCE)
	            .addScalar("terms", StringType.INSTANCE)
	            .addScalar("image", StringType.INSTANCE)
	            .addScalar("name", StringType.INSTANCE)
	            .addScalar("startDate", DateType.INSTANCE)
	            .addScalar("endDate", DateType.INSTANCE)
				.setResultTransformer(Transformers.aliasToBean(CampaignListNew.class));
		List<CampaignListNew> result = query.list();
		session.close();
		return result;
	}
	
	public List<CampaignListNew> getMyCampaignsByProjectId(int project_id){
		String hql = "SELECT a.id, a.title, a.content, a.set_date as startDate, a.end_date as endDate, a.terms, a.image, a.project_id as projectId, b.name,"
					 +" count(c.id) AS leads, SUM( CASE c.lead_status WHEN 7 THEN 1 ELSE 0 END ) AS booking"
					 +" FROM campaign AS a INNER JOIN builder_project AS b ON a.project_id = b.id"
					 +" LEFT JOIN builder_lead AS c ON a.id = c.campaign_id"
					 +" WHERE a.project_id = "+project_id+" GROUP BY a.id order by a.id DESC";
		
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.addScalar("id", IntegerType.INSTANCE)
				.addScalar("projectId", IntegerType.INSTANCE)
				.addScalar("leads", LongType.INSTANCE)
				.addScalar("booking", LongType.INSTANCE)
	            .addScalar("title", StringType.INSTANCE)
	            .addScalar("content", StringType.INSTANCE)
	            .addScalar("terms", StringType.INSTANCE)
	            .addScalar("image", StringType.INSTANCE)
	            .addScalar("name", StringType.INSTANCE)
	            .addScalar("startDate", DateType.INSTANCE)
	            .addScalar("endDate", DateType.INSTANCE)
				.setResultTransformer(Transformers.aliasToBean(CampaignListNew.class));
		List<CampaignListNew> result = query.list();
		session.close();
		return result;
	}
	
	public BuilderProject getProjectData(int projectId){
		String hql = "from BuilderProject where id="+projectId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderProject> builderProject = query.list();
		return builderProject.get(0);
	}
	
	public CityData getCityLocalityName(int projectId){
		String hql = "SELECT a.id as id, a.locality_name as localityName,b.name as name,b.id as cityId from builder_project as a join city as b on b.id=a.city_id where a.id="+projectId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.addScalar("id", IntegerType.INSTANCE)
				.addScalar("cityId", IntegerType.INSTANCE)
	            .addScalar("localityName", StringType.INSTANCE)
	            .addScalar("name", StringType.INSTANCE)
				.setResultTransformer(Transformers.aliasToBean(CityData.class));
		List<CityData> result = query.list();
		session.close();
		return result.get(0);
	}
}