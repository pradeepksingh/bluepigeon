package org.bluepigeon.admin.dao;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.bluepigeon.admin.data.BookingFlatList;
import org.bluepigeon.admin.data.BuilderCompletionStatus;
import org.bluepigeon.admin.data.BuilderFlatList;
import org.bluepigeon.admin.data.BuilderProjectList;
import org.bluepigeon.admin.data.BuildingData;
import org.bluepigeon.admin.data.BuildingList;
import org.bluepigeon.admin.data.BuildingListData;
import org.bluepigeon.admin.data.BuildingPojo;
import org.bluepigeon.admin.data.BuildingPriceInfoData;
import org.bluepigeon.admin.data.BuildingWeightageData;
import org.bluepigeon.admin.data.ConfigData;
import org.bluepigeon.admin.data.EmployeeList;
import org.bluepigeon.admin.data.FlatAmenityTotal;
import org.bluepigeon.admin.data.FlatData;
import org.bluepigeon.admin.data.FlatListData;
import org.bluepigeon.admin.data.FlatPojo;
import org.bluepigeon.admin.data.FlatTotal;
import org.bluepigeon.admin.data.FlatTypeData;
import org.bluepigeon.admin.data.FlatWeightageData;
import org.bluepigeon.admin.data.FlatPayment;
import org.bluepigeon.admin.data.FlatStatusData;
import org.bluepigeon.admin.data.FloorData;
import org.bluepigeon.admin.data.FloorDetail;
import org.bluepigeon.admin.data.FloorImageData;
import org.bluepigeon.admin.data.FloorListData;
import org.bluepigeon.admin.data.FloorPanoData;
import org.bluepigeon.admin.data.FloorPojo;
import org.bluepigeon.admin.data.FloorWeightageData;
import org.bluepigeon.admin.data.InboxBuyerData;
import org.bluepigeon.admin.data.InboxMessageData;
import org.bluepigeon.admin.data.LeadList;
import org.bluepigeon.admin.data.LocalityData;
import org.bluepigeon.admin.data.NewLeadList;
import org.bluepigeon.admin.data.NewProjectList;
import org.bluepigeon.admin.data.PaymentInfoData;
import org.bluepigeon.admin.data.PriceInfoData;
import org.bluepigeon.admin.data.ProjectAmenityData;
import org.bluepigeon.admin.data.ProjectCityData;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.data.ProjectDetail;
import org.bluepigeon.admin.data.ProjectList;
import org.bluepigeon.admin.data.ProjectOffer;
import org.bluepigeon.admin.data.ProjectPaymentSchedule;
import org.bluepigeon.admin.data.ProjectPriceInfoData;
import org.bluepigeon.admin.data.ProjectWeightageData;
import org.bluepigeon.admin.data.RoomData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AllotProject;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderBuildingFlatType;
import org.bluepigeon.admin.model.BuilderBuildingFlatTypeRoom;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderEmployeeAccessType;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFlatStatus;
import org.bluepigeon.admin.model.BuilderFlatType;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderFloorAmenity;
import org.bluepigeon.admin.model.BuilderLead;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuilderProjectAmenityInfo;
import org.bluepigeon.admin.model.BuilderProjectApprovalInfo;
import org.bluepigeon.admin.model.BuilderProjectBankInfo;
import org.bluepigeon.admin.model.BuilderProjectOfferInfo;
import org.bluepigeon.admin.model.BuilderProjectPaymentInfo;
import org.bluepigeon.admin.model.BuilderProjectPriceInfo;
import org.bluepigeon.admin.model.BuilderProjectProjectType;
import org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration;
import org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo;
import org.bluepigeon.admin.model.BuilderProjectPropertyType;
import org.bluepigeon.admin.model.BuildingAmenityInfo;
import org.bluepigeon.admin.model.BuildingAmenityWeightage;
import org.bluepigeon.admin.model.BuildingImageGallery;
import org.bluepigeon.admin.model.BuildingOfferInfo;
import org.bluepigeon.admin.model.BuildingPanoramicImage;
import org.bluepigeon.admin.model.BuildingPaymentInfo;
import org.bluepigeon.admin.model.BuildingPriceInfo;
import org.bluepigeon.admin.model.BuildingWeightage;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.Campaign;
import org.bluepigeon.admin.model.Cancellation;
import org.bluepigeon.admin.model.EmployeeRole;
import org.bluepigeon.admin.model.FlatAmenityInfo;
import org.bluepigeon.admin.model.FlatAmenityWeightage;
import org.bluepigeon.admin.model.FlatImageGallery;
import org.bluepigeon.admin.model.FlatOfferInfo;
import org.bluepigeon.admin.model.FlatPanoramicImage;
import org.bluepigeon.admin.model.FlatPaymentSchedule;
import org.bluepigeon.admin.model.FlatPricingDetails;
import org.bluepigeon.admin.model.FlatTypeImage;
import org.bluepigeon.admin.model.FlatWeightage;
import org.bluepigeon.admin.model.FloorAmenityInfo;
import org.bluepigeon.admin.model.FloorAmenityWeightage;
import org.bluepigeon.admin.model.FloorLayoutImage;
import org.bluepigeon.admin.model.FloorImageGallery;
import org.bluepigeon.admin.model.FloorPanoramicImage;
import org.bluepigeon.admin.model.FloorWeightage;
import org.bluepigeon.admin.model.InboxMessage;
import org.bluepigeon.admin.model.LeadConfig;
import org.bluepigeon.admin.model.NewProject;
import org.bluepigeon.admin.model.ProjectAmenityWeightage;
import org.bluepigeon.admin.model.ProjectImageGallery;
import org.bluepigeon.admin.model.ProjectPanoramicImage;
import org.bluepigeon.admin.model.ProjectStage;
import org.bluepigeon.admin.model.ProjectWeightage;
import org.bluepigeon.admin.model.Source;
import org.bluepigeon.admin.model.Tax;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.transform.Transformers;


public class ProjectDAO { 
	 
	public ResponseMessage saveProject(BuilderProject builderProject) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		//String hql = "from BuilderProject where name = :name AND locality.id = :locality_id";
		//new code
		String hql = "from BuilderProject where name = :name AND locality_name = :locality_name";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderProject.getName());
		//query.setParameter("locality_id", builderProject.getLocality().getId());
		query.setParameter("locality_name", builderProject.getLocalityName());
		List<BuilderProject> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Project name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.save(builderProject);
			newsession.getTransaction().commit();
			newsession.close();
			response.setId(builderProject.getId());
			BuilderProjectPriceInfo builderProjectPriceInfo = new BuilderProjectPriceInfo();
			AreaUnit areaUnit = new AreaUnit();
			areaUnit.setId(builderProject.getAreaUnit().getId());
			builderProjectPriceInfo.setAreaUnit(areaUnit);
			builderProjectPriceInfo.setTenure(0);
			builderProjectPriceInfo.setBuilderProject(builderProject);
			Session newsession1 = hibernateUtil.openSession();
			newsession1.beginTransaction();
			newsession1.save(builderProjectPriceInfo);
			newsession1.getTransaction().commit();
			newsession1.close();
			response.setStatus(1);
			response.setMessage("Project Added Successfully.");
		}
		return response;
	}
	/**
	 * Save new project added by builder
	 * @author pankaj
	 * @param newProject
	 * @return responseMessage
	 */
	public ResponseMessage saveNewProject(NewProject newProject){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.save(newProject);
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Project Added successfully");
		return responseMessage;
	}
	
	public ResponseMessage updateBasicInfo(BuilderProject builderProject) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		//String hql = "from BuilderProject where name = :name AND locality.id = :locality_id AND id != :id";
		String hql = "from BuilderProject where name = :name AND localityName = :locality_name AND id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderProject.getName());
//		query.setParameter("locality_id", builderProject.getLocality().getId());
		query.setParameter("locality_name", builderProject.getLocalityName());
		query.setParameter("id", builderProject.getId());
		List<BuilderProject> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Project name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(builderProject);
			newsession.getTransaction().commit();
			newsession.close();
			response.setId(builderProject.getId());
			response.setStatus(1);
			response.setMessage("Project Updated Successfully.");
		}
		return response;
	}
	
	public ResponseMessage updateProjectImage(BuilderProject builderProject){
		ResponseMessage responeMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.update(builderProject);
		session.getTransaction().commit();
		session.close();
		responeMessage.setStatus(1);
		responeMessage.setMessage("Project Image uploaded succssefuly");
				
		return responeMessage;
	}
	
	public ResponseMessage updateDetailInfo(ProjectDetail projectDetail) {
		ResponseMessage response = new ResponseMessage();
		BuilderProject builderProject = projectDetail.getBuilderProject();
		
		/******* delete enteries **********/
		HibernateUtil hibernateUtil = new HibernateUtil();
		String delete_project_type = "DELETE from BuilderProjectProjectType where builderProject.id = :project_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_project_type);
		smdelete.setParameter("project_id", builderProject.getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		String delete_property_type = "DELETE from BuilderProjectPropertyType where builderProject.id = :project_id";
		Session newsession2 = hibernateUtil.openSession();
		newsession2.beginTransaction();
		Query smdelete2 = newsession2.createQuery(delete_property_type);
		smdelete2.setParameter("project_id", builderProject.getId());
		smdelete2.executeUpdate();
		newsession2.getTransaction().commit();
		newsession2.close();
		String delete_config_type = "DELETE from BuilderProjectPropertyConfigurationInfo where builderProject.id = :project_id";
		Session newsession3 = hibernateUtil.openSession();
		newsession3.beginTransaction();
		Query smdelete3 = newsession3.createQuery(delete_config_type);
		smdelete3.setParameter("project_id", builderProject.getId());
		smdelete3.executeUpdate();
		newsession3.getTransaction().commit();
		newsession3.close();
		String delete_amenity = "DELETE from BuilderProjectAmenityInfo where builderProject.id = :project_id";
		Session newsession4 = hibernateUtil.openSession();
		newsession4.beginTransaction();
		Query smdelete4 = newsession4.createQuery(delete_amenity);
		smdelete4.setParameter("project_id", builderProject.getId());
		smdelete4.executeUpdate();
		newsession4.getTransaction().commit();
		newsession4.close();
		String delete_approval = "DELETE from BuilderProjectApprovalInfo where builderProject.id = :project_id";
		Session newsession5 = hibernateUtil.openSession();
		newsession5.beginTransaction();
		Query smdelete5 = newsession5.createQuery(delete_approval);
		smdelete5.setParameter("project_id", builderProject.getId());
		smdelete5.executeUpdate();
		newsession5.getTransaction().commit();
		newsession5.close();
		String delete_bank = "DELETE from BuilderProjectBankInfo where builderProject.id = :project_id";
		Session newsession6 = hibernateUtil.openSession();
		newsession6.beginTransaction();
		Query smdelete6 = newsession6.createQuery(delete_bank);
		smdelete6.setParameter("project_id", builderProject.getId());
		smdelete6.executeUpdate();
		newsession6.getTransaction().commit();
		newsession6.close();
		
		String delete_weightage = "DELETE from ProjectAmenityWeightage where builderProject.id = :project_id";
		Session newsession7 = hibernateUtil.openSession();
		newsession7.beginTransaction();
		Query smdelete7 = newsession7.createQuery(delete_weightage);
		smdelete7.setParameter("project_id", builderProject.getId());
		smdelete7.executeUpdate();
		newsession7.getTransaction().commit();
		newsession7.close();
		
		/***** Add New Enteries *******/
		
		Set<BuilderProjectProjectType> builderProjectProjectTypes = projectDetail.getBuilderProjectProjectTypes();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		Iterator<BuilderProjectProjectType> sIterator1 = builderProjectProjectTypes.iterator();
		while(sIterator1.hasNext())
		{
			BuilderProjectProjectType builderProjectProjectType = sIterator1.next();
			session1.save(builderProjectProjectType);
		}
		session1.getTransaction().commit();
		session1.close();
		
		Set<BuilderProjectPropertyType> builderProjectPropertyTypes = projectDetail.getBuilderProjectPropertyTypes();
		Session session2 = hibernateUtil.openSession();
		session2.beginTransaction();
		Iterator<BuilderProjectPropertyType> sIterator2 = builderProjectPropertyTypes.iterator();
		while(sIterator2.hasNext())
		{
			BuilderProjectPropertyType builderProjectPropertyType = sIterator2.next();
			session2.save(builderProjectPropertyType);
		}
		session2.getTransaction().commit();
		session2.close();
		
		Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos = projectDetail.getBuilderProjectPropertyConfigurationInfos();
		Session session3 = hibernateUtil.openSession();
		session3.beginTransaction();
		Iterator<BuilderProjectPropertyConfigurationInfo> sIterator3 = builderProjectPropertyConfigurationInfos.iterator();
		while(sIterator3.hasNext())
		{
			BuilderProjectPropertyConfigurationInfo builderProjectPropertyConfigurationInfo = sIterator3.next();
			session3.save(builderProjectPropertyConfigurationInfo);
		}
		session3.getTransaction().commit();
		session3.close();
		
		Set<BuilderProjectAmenityInfo> builderProjectAmenityInfos = projectDetail.getBuilderProjectAmenityInfos();
		Session session4 = hibernateUtil.openSession();
		session4.beginTransaction();
		Iterator<BuilderProjectAmenityInfo> sIterator4 = builderProjectAmenityInfos.iterator();
		while(sIterator4.hasNext())
		{
			BuilderProjectAmenityInfo builderProjectAmenityInfo = sIterator4.next();
			session4.save(builderProjectAmenityInfo);
		}
		session4.getTransaction().commit();
		session4.close();
		
		Set<BuilderProjectApprovalInfo> builderProjectApprovalInfos = projectDetail.getBuilderProjectApprovalInfos();
		Session session5 = hibernateUtil.openSession();
		session5.beginTransaction();
		Iterator<BuilderProjectApprovalInfo> sIterator5 = builderProjectApprovalInfos.iterator();
		while(sIterator5.hasNext())
		{
			BuilderProjectApprovalInfo builderProjectApprovalInfo = sIterator5.next();
			session5.save(builderProjectApprovalInfo);
		}
		session5.getTransaction().commit();
		session5.close();
		
		Set<BuilderProjectBankInfo> builderProjectBankInfos = projectDetail.getBuilderProjectBankInfos();
		Session session6 = hibernateUtil.openSession();
		session6.beginTransaction();
		Iterator<BuilderProjectBankInfo> sIterator6 = builderProjectBankInfos.iterator();
		while(sIterator6.hasNext())
		{
			BuilderProjectBankInfo builderProjectBankInfo = sIterator6.next();
			session6.save(builderProjectBankInfo);
		}
		session6.getTransaction().commit();
		session6.close();
		
		Set<ProjectAmenityWeightage> ProjectAmenityWeightages = projectDetail.getProjectAmenityWeightages();
		Session session7 = hibernateUtil.openSession();
		session7.beginTransaction();
		Iterator<ProjectAmenityWeightage> sIterator7 = ProjectAmenityWeightages.iterator();
		while(sIterator7.hasNext())
		{
			ProjectAmenityWeightage projectAmenityWeightage = sIterator7.next();
			session7.save(projectAmenityWeightage);
		}
		session7.getTransaction().commit();
		session7.close();
		
		/* updateProject */
		String hql = "from BuilderProject where id = :project_id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", builderProject.getId());
		List<BuilderProject> result = query.list();
		session.close();
		BuilderProject newBuilderProject = result.get(0);
		newBuilderProject.setProjectArea(builderProject.getProjectArea());
		newBuilderProject.setAreaUnit(builderProject.getAreaUnit());
		newBuilderProject.setLaunchDate(builderProject.getLaunchDate());
		if(builderProject.getPossessionDate() != null){
			newBuilderProject.setPossessionDate(builderProject.getPossessionDate());
		}
		Session session8 = hibernateUtil.openSession();
		session8.beginTransaction();
		session8.update(newBuilderProject);
		session8.getTransaction().commit();
		session8.close();
		System.out.println("Hi from DB Update Project");
		response.setId(builderProject.getId());
		response.setStatus(1);
		response.setMessage("Project Updated Successfully.");
		return response;
	}
	
	public ResponseMessage updatePriceInfo(BuilderProjectPriceInfo builderProjectPriceInfo) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(builderProjectPriceInfo);
		newsession.getTransaction().commit();
		newsession.close();
		response.setStatus(1);
		response.setMessage("Project Price Updated Successfully.");
		return response;
	}
	
	public ResponseMessage updatePaymentInfo(ProjectPaymentSchedule projectPaymentSchedule) {
		ResponseMessage response = new ResponseMessage();
		BuilderProject builderProject = projectPaymentSchedule.getBuilderProject();
		
		/******* delete enteries **********/
		HibernateUtil hibernateUtil = new HibernateUtil();
		String delete_project_type = "DELETE from BuilderProjectPaymentInfo where builderProject.id = :project_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_project_type);
		smdelete.setParameter("project_id", builderProject.getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/***** Add New Enteries *******/
		
		Set<BuilderProjectPaymentInfo> builderProjectPaymentInfos = projectPaymentSchedule.getBuilderProjectPaymentInfos();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		Iterator<BuilderProjectPaymentInfo> sIterator1 = builderProjectPaymentInfos.iterator();
		while(sIterator1.hasNext())
		{
			BuilderProjectPaymentInfo builderProjectPaymentInfo = sIterator1.next();
			session1.save(builderProjectPaymentInfo);
		}
		session1.getTransaction().commit();
		session1.close();
		
		response.setId(builderProject.getId());
		response.setStatus(1);
		response.setMessage("Project Payment Updated Successfully.");
		return response;
	}
	/******************************************Update Project Payment Info *****************************/
	/**
	 * Update Project payment info (old code)
	 * @param builderProjectPaymentInfos
	 */
//	public void updateProjectPaymentInfo(List<BuilderProjectPaymentInfo> builderProjectPaymentInfos){
//		HibernateUtil hibernateUtil =new HibernateUtil();
//		Session session =hibernateUtil.openSession();
//		session.beginTransaction();
//	    
//		for(BuilderProjectPaymentInfo builderProjectPaymentInfo : builderProjectPaymentInfos){
//			session.update(builderProjectPaymentInfo);
//		}
//		session.getTransaction().commit();
//		session.close();
//	}
	/**
	 *  @author pankaj
	 * Update Project payment info (new code)
	 * @param builderProjectPaymentInfos
	 */
	public ResponseMessage updateProjectPaymentInfo(List<BuilderProjectPaymentInfo> builderProjectPaymentInfos){
		ResponseMessage response = new ResponseMessage();
		BuilderProject builderProject = builderProjectPaymentInfos.get(0).getBuilderProject();
		
		/******* delete enteries **********/
		
		
		HibernateUtil hibernateUtil = new HibernateUtil();
		String delete_project_type = "DELETE from BuilderProjectPaymentInfo where builderProject.id = :project_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_project_type);
		smdelete.setParameter("project_id", builderProject.getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/***** Add New Enteries *******/
		
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		for(BuilderProjectPaymentInfo builderProjectPaymentInfo : builderProjectPaymentInfos){
			session1.save(builderProjectPaymentInfo);
		}
		session1.getTransaction().commit();
		session1.close();
		
		response.setId(builderProject.getId());
		response.setStatus(1);
		response.setMessage("Project Payment Updated Successfully.");
		return response;
	}
	
	public void saveProjectPaymentInfo(List<BuilderProjectPaymentInfo> builderProjectPaymentInfos){
		HibernateUtil hibernateUtil =new HibernateUtil();
		Session session =hibernateUtil.openSession();
		session.beginTransaction();
		for(BuilderProjectPaymentInfo builderProjectPaymentInfo : builderProjectPaymentInfos){
			session.save(builderProjectPaymentInfo);
		}
		session.getTransaction().commit();
		session.close();
	}
	public ResponseMessage updateOfferInfo(ProjectOffer projectOffer) {
		ResponseMessage response = new ResponseMessage();
		BuilderProject builderProject = projectOffer.getBuilderProject();
		
		/******* delete enteries **********/
		HibernateUtil hibernateUtil = new HibernateUtil();
		String delete_project_type = "DELETE from BuilderProjectOfferInfo where builderProject.id = :project_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_project_type);
		smdelete.setParameter("project_id", builderProject.getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/***** Add New Enteries *******/
		
		Set<BuilderProjectOfferInfo> builderProjectOfferInfos = projectOffer.getBuilderProjectOfferInfos();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		Iterator<BuilderProjectOfferInfo> sIterator1 = builderProjectOfferInfos.iterator();
		while(sIterator1.hasNext())
		{
			BuilderProjectOfferInfo builderProjectOfferInfo = sIterator1.next();
			session1.save(builderProjectOfferInfo);
		}
		session1.getTransaction().commit();
		session1.close();
		
		response.setId(builderProject.getId());
		response.setStatus(1);
		response.setMessage("Project Offer Updated Successfully.");
		return response;
	}
	/**
	 * new code for updating project offer details
	 * @author pankaj
	 * @param projectOffer
	 * @return responseMessage
	 */
	public ResponseMessage updateOffers(List<BuilderProjectOfferInfo> updateProjectOfferInfos) {
		ResponseMessage response = new ResponseMessage();
		
		/******* delete enteries **********/
		HibernateUtil hibernateUtil = new HibernateUtil();
		String delete_project_type = "DELETE from BuilderProjectOfferInfo where builderProject.id = :project_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_project_type);
		smdelete.setParameter("project_id", updateProjectOfferInfos.get(0).getBuilderProject().getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/***** Add New Enteries *******/
		
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		
		for(BuilderProjectOfferInfo builderProjectOfferInfo : updateProjectOfferInfos){
			session1.save(builderProjectOfferInfo);
		}
		
		session1.getTransaction().commit();
		session1.close();
		
		response.setId(updateProjectOfferInfos.get(0).getBuilderProject().getId());
		response.setStatus(1);
		response.setMessage("Project Offer Updated Successfully.");
		return response;
	}
	
	public List<ProjectList> getBuilderProjects() {
		String hql = "from BuilderProject order by id desc";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setFirstResult(0);
		query.setMaxResults(100);
		List<BuilderProject> result = query.list();
		List<ProjectList> projects = new ArrayList<ProjectList>();
		for(BuilderProject builderproject : result) {
			ProjectList newproject = new ProjectList();
			newproject.setId(builderproject.getId());
			newproject.setName(builderproject.getName());
			newproject.setStatus(builderproject.getStatus());
			newproject.setBuilderId(builderproject.getBuilder().getId());
			newproject.setBuilderName(builderproject.getBuilder().getName());
			System.out.println("Builder Name :: "+newproject.getBuilderName());
			newproject.setCityId(builderproject.getCity().getId());
			newproject.setCityName(builderproject.getCity().getName());
			//newproject.setLocalityId(builderproject.getLocality().getId());
			//newproject.setLocalityName(builderproject.getLocality().getName());
			newproject.setLocalityName(builderproject.getLocalityName());
			projects.add(newproject);
			
		}
		session.close();
		return projects;
	}
	
	public List<BuilderProject> getBuilderAllProjects() {
		String hql = "from BuilderProject order by id desc";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setFirstResult(0);
		query.setMaxResults(100);
		List<BuilderProject> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderProject> getBuilderActiveProjects() {
		String hql = "from BuilderProject where status = 1 order by id desc";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setFirstResult(0);
		query.setMaxResults(100);
		List<BuilderProject> result = query.list();
		session.close();
		return result;
	}
	
	public List<Tax> getProjectTaxByPincode(String pincode) {
		String hql = "from Tax where pincode = :pincode";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("pincode", pincode);
		List<Tax> result = query.list();
		session.close();
		return result;
	}

	public List<ProjectList> getBuilderProjects(int builder_id, int company_id, String name, int country_id, int state_id, int city_id) {
		String hql = "from BuilderProject where ";
		String where = "";
		if(builder_id > 0) {
			where = where + "builder.id = :builder_id ";
		}
		if(company_id > 0) {
			if(where != "") {
				where = where + "AND builderCompanyNames.id = :company_id ";
			} else {
				where = where + "builderCompanyNames.id = :company_id ";
			}
		}
		if(name != "") {
			if(where != "") {
				where = where + "AND name LIKE :name ";
			} else {
				where = where + "name LIKE :name ";
			}
		}
		if(country_id > 0) {
			if(where != "") {
				where = where + "AND country.id = :country_id ";
			} else {
				where = where + "country.id = :country_id ";
			}
		}
		if(state_id > 0) {
			if(where != "") {
				where = where + "AND state.id = :state_id ";
			} else {
				where = where + "state.id = :state_id ";
			}
		}
		if(city_id > 0) {
			if(where != "") {
				where = where + "AND city.id = :city_id ";
			} else {
				where = where + "city.id = :city_id ";
			}
		}
		hql = hql + where+" and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		if(builder_id > 0) {
			query.setParameter("builder_id", builder_id);
		}
		if(company_id > 0) {
			query.setParameter("company_id", company_id);
		}
		if(name != "") {
			query.setParameter("name", "%"+name+"%");
		}
		if(country_id > 0) {
			query.setParameter("country_id", country_id);
		}
		if(state_id > 0) {
			query.setParameter("state_id", state_id);
		}
		if(city_id > 0) {
			query.setParameter("city_id", city_id);
		}
		List<BuilderProject> result = query.list();
		List<ProjectList> projects = new ArrayList<ProjectList>();
		for(BuilderProject builderproject : result) {
			ProjectList newproject = new ProjectList();
			newproject.setId(builderproject.getId());
			newproject.setName(builderproject.getName());
			newproject.setStatus(builderproject.getStatus());
			newproject.setBuilderId(builderproject.getBuilder().getId());
			newproject.setBuilderName(builderproject.getBuilder().getName());
			newproject.setCityId(builderproject.getCity().getId());
			newproject.setCityName(builderproject.getCity().getName());
			//newproject.setLocalityId(builderproject.getLocality().getId());
		//	newproject.setLocalityName(builderproject.getLocality().getName());
			newproject.setLocalityName(builderproject.getLocalityName());
			newproject.setCompletionStatus(builderproject.getCompletionStatus());
			projects.add(newproject);
			
		}
		session.close();
		return projects;
	}
	
	public BuilderProject getBuilderProjectById(int project_id) {
		String hql = "from BuilderProject where id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<BuilderProject> result = query.list();
		session.close();
		return result.get(0);
	}
	
	public BuilderProject getBuilderActiveProjectById(int project_id) {
		String hql = "from BuilderProject where id = :project_id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<BuilderProject> result = query.list();
		session.close();
		System.err.println(project_id);
		return result.get(0);
	}

	
	public List<ProjectAmenityWeightage> getProjectAmenityWeightageByProjectId(int project_id) {
		String hql = "from ProjectAmenityWeightage where builderProject.id = :project_id order by builderProjectAmenity.id ASC, builderProjectAmenityStages.id ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<ProjectAmenityWeightage> result = query.list();
		session.close();
		return result;
	}
	
	public List<ProjectAmenityWeightage> getActiveProjectAmenityWeightageByProjectId(int project_id) {
		String hql = "from ProjectAmenityWeightage where builderProject.id = :project_id and status=1 order by builderProjectAmenity.id ASC, builderProjectAmenityStages.id ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<ProjectAmenityWeightage> result = query.list();
		session.close();
		return result;
	}
	
	public List<ProjectImageGallery> getProjectImagesByProjectId(int project_id) {
		String hql = "from ProjectImageGallery where builderProject.id = :project_id ";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<ProjectImageGallery> result = query.list();
		session.close();
		return result;
	}
	
	public List<ProjectPanoramicImage> getProjectPanoromicImagesByProjectId(int project_id) {
		String hql = "from ProjectPanoramicImage where builderProject.id = :project_id ";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<ProjectPanoramicImage> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage deleteProjectPayment(int projectId){
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from BuilderProjectPaymentInfo where id = :project_id";
		Query query = session.createQuery(hql);
		query.setInteger("project_id", projectId);
		query.executeUpdate();
		//query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setId(projectId);
		resp.setMessage("Project Payment Schedule deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage deleteProjectImage(int image_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from ProjectImageGallery where id = :image_id";
		Query query = session.createQuery(hql);
		query.setInteger("image_id", image_id);
		query.executeUpdate();
		//query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Project image deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage deleteProjectElevationImage(int image_id) {
		ResponseMessage resp = new ResponseMessage();
		String hql = "delete from ProjectPanoramicImage where id = :image_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("image_id", image_id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		resp.setMessage("Project elevation image deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage updateProjectAmenityWeightage(List<ProjectAmenityWeightage> projectAmenityWeightages, int project_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE ProjectAmenityWeightage set status = 0 where builderProject.id = :project_id";
		Query query1 = session1.createQuery(hql1);
		query1.setParameter("project_id", project_id);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		Session session = hibernateUtil.openSession();
		for(ProjectAmenityWeightage projectAmenityWeightage :projectAmenityWeightages) {
			session.beginTransaction();
			String hql = "UPDATE ProjectAmenityWeightage set status=1 where id = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", projectAmenityWeightage.getId());
			query.executeUpdate();
			session.getTransaction().commit();
		}
		session.close();
		resp.setMessage("Project status updated.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage addProjectImageGallery(List<ProjectImageGallery> projectImageGalleries) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(ProjectImageGallery projectImageGallery :projectImageGalleries) {
			newsession.save(projectImageGallery);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addProjectPanoImage(List<ProjectPanoramicImage> projectPanoramicImages) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(ProjectPanoramicImage projectPanoramicImage :projectPanoramicImages) {
			newsession.save(projectPanoramicImage);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	/* ********************* Project Buildings ****************** */
	
	public List<BuilderBuilding> getBuilderProjectBuildings(int project_id) {
		String hql = "from BuilderBuilding where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<BuilderBuilding> result = query.list();
		session.close();
		return result;
	}
	
	
	/**
	 * Get all active buildings by project id
	 * @author pankaj
	 * @param project_id
	 * @return
	 */
	public List<BuilderBuilding> getBuilderActiveProjectBuildings(int project_id) {
		String hql = "from BuilderBuilding where builderProject.id = :project_id and builderProject.status=1 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<BuilderBuilding> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuildingPojo> getBuilderActiveBuildingsByProjectId(int project_id) {
		String hql = "select a.id as id, a.project_id as projectId,a.name as name,a.emp_id as empId,a.total_floor as totalFloor,a.status_id as statusId, a.amenity_weightage as amenityWeightage,a.floor_weightage as floorWeightage, a.weightage as weightage, a.launch_date as launchDate, a.possession_date as possessionDate, a.total_inventory as totalInventory, a.inventory_sold as inventorySold, a.revenue as revenue, a.completion_status as completionStatus, a.status as status,b.name as projectName,d.name as buildingStatus,e.name as builderName from builder_building as a inner join builder_project as b on a.project_id = b.id inner join builder_building_status as d on a.status_id=d.id inner join builder as e on b.group_id = e.id where a.project_id = "+project_id+" and a.status = 1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuildingPojo.class));
		List<BuildingPojo> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderBuilding> getBuilderBuildings() {
		String hql = "from BuilderBuilding";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderBuilding> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderBuilding> getBuilderProjectBuildingById(int building_id) {
		String hql = "from BuilderBuilding where id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderBuilding> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuildingImageGallery> getBuilderBuildingImagesById(int building_id) {
		String hql = "from BuildingImageGallery where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingImageGallery> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuildingPanoramicImage> getBuilderBuildingElevationImagesById(int building_id) {
		String hql = "from BuildingPanoramicImage where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingPanoramicImage> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuildingPaymentInfo> getBuilderBuildingPaymentInfoById(int building_id) {
		String hql = "from BuildingPaymentInfo where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingPaymentInfo> result = query.list();
		session.close();
		return result;
	}
	
	public List<PaymentInfoData> getBuildingPaymentInfoById(int building_id) {
		List<PaymentInfoData> paymentInfoDatas = new ArrayList<PaymentInfoData>();
		System.out.println("Building Id :: "+building_id);
		String hql = "from BuildingPaymentInfo where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		try{
		List<BuildingPaymentInfo> result = query.list();
		
		if(result.get(0) != null){
			System.err.println("No Error :: "+result.size());
			for(BuildingPaymentInfo buildingPaymentInfo : result){
				PaymentInfoData paymentInfoData = new PaymentInfoData();
				paymentInfoData.setId(buildingPaymentInfo.getId());
				paymentInfoData.setName(buildingPaymentInfo.getMilestone());
				paymentInfoData.setAmount(buildingPaymentInfo.getAmount());
				paymentInfoData.setPayable(buildingPaymentInfo.getPayable());
				paymentInfoDatas.add(paymentInfoData);
			}
		}else{
			
			BuilderBuilding building = getBuilderProjectBuildingById(building_id).get(0);
			System.err.println("Project Id :: "+building.getBuilderProject().getId());
			List<BuilderProjectPaymentInfo> builderProjectPaymentInfos = new BuilderProjectPaymentInfoDAO().getBuilderProjectPaymentInfo(building.getBuilderProject().getId());
			for(BuilderProjectPaymentInfo builderProjectPaymentInfo : builderProjectPaymentInfos){
				PaymentInfoData paymentInfoData = new PaymentInfoData();
				paymentInfoData.setId(0);
				paymentInfoData.setName(builderProjectPaymentInfo.getSchedule());
				paymentInfoData.setAmount(builderProjectPaymentInfo.getAmount());
				paymentInfoData.setPayable(builderProjectPaymentInfo.getPayable());
				paymentInfoDatas.add(paymentInfoData);
			}
			
		}
		}catch(IndexOutOfBoundsException e){
			BuilderBuilding building = getBuilderProjectBuildingById(building_id).get(0);
			System.err.println("Project Id :: "+building.getBuilderProject().getId());
			List<BuilderProjectPaymentInfo> builderProjectPaymentInfos = new BuilderProjectPaymentInfoDAO().getBuilderProjectPaymentInfo(building.getBuilderProject().getId());
			for(BuilderProjectPaymentInfo builderProjectPaymentInfo : builderProjectPaymentInfos){
				PaymentInfoData paymentInfoData = new PaymentInfoData();
				paymentInfoData.setId(0);
				paymentInfoData.setName(builderProjectPaymentInfo.getSchedule());
				paymentInfoData.setAmount(builderProjectPaymentInfo.getAmount());
				paymentInfoData.setPayable(builderProjectPaymentInfo.getPayable());
				paymentInfoDatas.add(paymentInfoData);
			}
		}
		catch(Exception e){
			BuilderBuilding building = getBuilderProjectBuildingById(building_id).get(0);
			System.err.println("Project Id :: "+building.getBuilderProject().getId());
			List<BuilderProjectPaymentInfo> builderProjectPaymentInfos = new BuilderProjectPaymentInfoDAO().getBuilderProjectPaymentInfo(building.getBuilderProject().getId());
			for(BuilderProjectPaymentInfo builderProjectPaymentInfo : builderProjectPaymentInfos){
				PaymentInfoData paymentInfoData = new PaymentInfoData();
				paymentInfoData.setId(0);
				paymentInfoData.setName(builderProjectPaymentInfo.getSchedule());
				paymentInfoData.setAmount(builderProjectPaymentInfo.getAmount());
				paymentInfoData.setPayable(builderProjectPaymentInfo.getPayable());
				paymentInfoDatas.add(paymentInfoData);
			}
			e.printStackTrace();
		}
		session.close();
		return paymentInfoDatas;
	}
	/**
	 * Get Project Payment details by building id
	 * @author pankaj
	 * @param building_id
	 * @return
	 */
	public List<BuilderProjectPaymentInfo> getBuilderBuildingPaymentInfoByBuildingId(int building_id) {
		BuilderBuilding building = getBuilderProjectBuildingById(building_id).get(0);
		String hql = "from BuilderProjectPaymentInfo where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", building.getBuilderProject().getId());
		List<BuilderProjectPaymentInfo> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get active building payment details
	 * @author pankaj
	 * @param building_id
	 * @return List<BuildingPaymentInfo>
	 */
	public List<BuildingPaymentInfo> getActiveBuilderBuildingPaymentInfoById(int building_id) {
		String hql = "from BuildingPaymentInfo where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingPaymentInfo> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuildingOfferInfo> getBuilderBuildingOfferInfoById(int building_id) {
		String hql = "from BuildingOfferInfo where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingOfferInfo> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all active building offer details
	 * @author pankaj
	 * @param building_id
	 * @return List<BuildingOfferInfo>
	 */
	public List<BuildingOfferInfo> getActiveBuilderBuildingOfferInfoById(int building_id) {
		String hql = "from BuildingOfferInfo where builderBuilding.id = :building_id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingOfferInfo> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuildingAmenityInfo> getBuilderBuildingAmenityInfoById(int building_id) {
		String hql = "from BuildingAmenityInfo where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingAmenityInfo> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuildingAmenityWeightage> getBuilderBuildingAmenityWeightageById(int building_id) {
		String hql = "from BuildingAmenityWeightage where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingAmenityWeightage> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all active building amenity weightage
	 * @author pankaj
	 * @param building_id
	 * @return List<BuildingAmenityWeightage>
	 */
	public List<BuildingAmenityWeightage> getActiveBuilderBuildingAmenityWeightageById(int building_id) {
		String hql = "from BuildingAmenityWeightage where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingAmenityWeightage> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage addBuilding(BuilderBuilding builderBuilding) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(builderBuilding);
		newsession.getTransaction().commit();
		newsession.close();
		resp.setId(builderBuilding.getId());
		resp.setMessage("Building added successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage addBuildingImageGallery(List<BuildingImageGallery> buildingImageGalleries) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(BuildingImageGallery buildingImageGallery :buildingImageGalleries) {
			newsession.save(buildingImageGallery);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addBuildingPanoImage(List<BuildingPanoramicImage> buildingPanoramicImages) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(BuildingPanoramicImage buildingPanoramicImage :buildingPanoramicImages) {
			newsession.save(buildingPanoramicImage);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addBuildingPaymentInfo(List<BuildingPaymentInfo> buildingPaymentInfos) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(BuildingPaymentInfo buildingPaymentInfo :buildingPaymentInfos) {
			newsession.save(buildingPaymentInfo);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addBuildingOfferInfo(List<BuildingOfferInfo> buildingOfferInfos) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(BuildingOfferInfo buildingOfferInfo :buildingOfferInfos) {
			newsession.save(buildingOfferInfo);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addFlatOfferInfo(List<FlatOfferInfo> flatOfferInfos) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FlatOfferInfo flatOfferInfo :flatOfferInfos) {
			newsession.save(flatOfferInfo);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addBuildingAmenityInfo(List<BuildingAmenityInfo> buildingAmenityInfos) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(BuildingAmenityInfo buildingAmenityInfo :buildingAmenityInfos) {
			newsession.save(buildingAmenityInfo);
		}
		newsession.getTransaction().commit();
		newsession.close();
		
		return resp;
	}
	
	public ResponseMessage addBuildingAmenityWeightage(List<BuildingAmenityWeightage> buildingAmenityWeightages) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(BuildingAmenityWeightage buildingAmenityWeightage :buildingAmenityWeightages) {
			newsession.save(buildingAmenityWeightage);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage updateBuilding(BuilderBuilding builderBuilding) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(builderBuilding);
		newsession.getTransaction().commit();
		newsession.close();
		resp.setId(builderBuilding.getId());
		resp.setMessage("Building updated successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public void deleteBuildingAmenityInfo(int building_id) {
		String hql = "delete from BuildingAmenityInfo where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
	
	public void deleteBuildingAmenityWeightage(int building_id) {
		String hql = "delete from BuildingAmenityWeightage where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
	
	public ResponseMessage deleteBuildingImage(int image_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from BuildingImageGallery where id = :image_id";
		Query query = session.createQuery(hql);
		query.setInteger("image_id", image_id);
		query.executeUpdate();
		//query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Building image deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage deleteBuildingElevationImage(int image_id) {
		ResponseMessage resp = new ResponseMessage();
		String hql = "delete from BuildingPanoramicImage where id = :image_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("image_id", image_id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		resp.setMessage("Building elevation image deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage updateBuildingPaymentInfo(List<BuildingPaymentInfo> buildingPaymentInfos) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(BuildingPaymentInfo buildingPaymentInfo :buildingPaymentInfos) {
			newsession.update(buildingPaymentInfo);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage updateBuildingOfferInfo(List<BuildingOfferInfo> buildingOfferInfos) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(BuildingOfferInfo buildingOfferInfo :buildingOfferInfos) {
			newsession.update(buildingOfferInfo);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage updateFlatOfferInfo(List<FlatOfferInfo> flatOfferInfos) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FlatOfferInfo flatOfferInfo :flatOfferInfos) {
			newsession.update(flatOfferInfo);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage deleteBuildingPaymentInfo(int id) {
		ResponseMessage resp = new ResponseMessage();
		String hql = "delete from BuildingPaymentInfo where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		resp.setMessage("Building payment deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage deleteBuildingOfferInfo(int id) {
		ResponseMessage resp = new ResponseMessage();
		String hql = "delete from BuildingOfferInfo where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		resp.setMessage("Building offer deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage updateBuildingAmenityWeightage(List<BuildingAmenityWeightage> buildingAmenityWeightages, int building_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE BuildingAmenityWeightage set status = 0 where builderBuilding.id = :building_id";
		Query query1 = session1.createQuery(hql1);
		query1.setParameter("building_id", building_id);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		Session session = hibernateUtil.openSession();
		for(BuildingAmenityWeightage buildingAmenityWeightage :buildingAmenityWeightages) {
			session.beginTransaction();
			String hql = "UPDATE BuildingAmenityWeightage set status=1 where id = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", buildingAmenityWeightage.getId());
			query.executeUpdate();
			session.getTransaction().commit();
		}
		session.close();
		resp.setMessage("Building status updated.");
		resp.setStatus(1);
		return resp;
	}
	
	public List<BuildingPriceInfoData> getBuilderBuildingPriceInfo(int building_id) {
		String hql = "from BuildingPriceInfo where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingPriceInfo> result = query.list();
		session.close();
		List<BuildingPriceInfoData> buildingPrices = new ArrayList<BuildingPriceInfoData>();
		for(BuildingPriceInfo buildingPriceInfo :result) {
			BuildingPriceInfoData bpn = new BuildingPriceInfoData();
			bpn.setId(buildingPriceInfo.getId());
			bpn.setBuildingId(buildingPriceInfo.getBuilderBuilding().getId());
			bpn.setBaseRate(buildingPriceInfo.getBasePrice());
			bpn.setRiseRate(buildingPriceInfo.getRiseRate());
			bpn.setPost(buildingPriceInfo.getPost());
			bpn.setAmenityRate(buildingPriceInfo.getAmenityRate());
			bpn.setParking(buildingPriceInfo.getParking());
			bpn.setMaintainance(buildingPriceInfo.getMaintenance());
			bpn.setStampDuty(buildingPriceInfo.getStampDuty());
			bpn.setTenure(buildingPriceInfo.getTenure());
			bpn.setTax(buildingPriceInfo.getTax());
			bpn.setVat(buildingPriceInfo.getVat());
			bpn.setFee(buildingPriceInfo.getFee());
			bpn.setUnitId(buildingPriceInfo.getAreaUnit().getId());
			buildingPrices.add(bpn);
		}
		return buildingPrices;
	}
	
	/* ******************** Project Floors ******************** */
	/**
	 * Save Floor data
	 * @author pankaj
	 * @param request
	 * @return response
	 */
	public ResponseMessage saveFloor(FloorDetail floorDetail){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		BuilderFloor builderFloor = floorDetail.getBuilderFloor();
		String hql = "from BuilderFloor where name = :name AND builderFloor.builderBuilding.id = :building_id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderFloor.getName());
		query.setParameter("building_id", builderFloor.getBuilderBuilding().getId());
		List<BuilderFloor> result = query.list();
		session.close();
		if (result.size() > 0) {
			 responseMessage.setStatus(0);
			 responseMessage.setMessage("Floor name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.save(builderFloor);
			newsession.getTransaction().commit();
			newsession.close();
			 responseMessage.setId(builderFloor.getId());
			List<FloorAmenityInfo> floorAmenityInfos = floorDetail.getFloorAmenityInfos();
			if(floorAmenityInfos.size()>0){
				Session newsession1 = hibernateUtil.openSession();
				newsession1.beginTransaction();
				for(int i=0;i<floorAmenityInfos.size();i++){
					FloorAmenityInfo floorAmenityInfo = new FloorAmenityInfo();
					floorAmenityInfo.setBuilderFloor(builderFloor);
					floorAmenityInfo.setBuilderFloorAmenity(floorAmenityInfos.get(i).getBuilderFloorAmenity());
					newsession1.save(floorAmenityInfo);
				}
				newsession1.getTransaction().commit();
				newsession1.close();
				responseMessage.setStatus(1);
				responseMessage.setMessage("Floor Added Successfully.");
			}
		}
		return responseMessage;
	}
	
	public ResponseMessage addBuildingFloor(BuilderFloor builderFloor) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(builderFloor);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(builderFloor.getId());
		response.setStatus(1);
		response.setMessage("Building floor Added Successfully.");
		return response;
	}
	
	public ResponseMessage updateBuildingFloor(BuilderFloor builderFloor) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(builderFloor);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(builderFloor.getId());
		response.setStatus(1);
		response.setMessage("Building floor updated Successfully.");
		return response;
	}
	
	public ResponseMessage addBuildingFloorPlan(List<FloorLayoutImage> floorLayoutImages) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FloorLayoutImage floorLayoutImage :floorLayoutImages) {
			newsession.save(floorLayoutImage);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addBuildingFloorAmenityInfo(List<FloorAmenityInfo> floorAmenityInfos) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FloorAmenityInfo floorAmenityInfo :floorAmenityInfos) {
			newsession.save(floorAmenityInfo);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addFloorAmenityWeightage(List<FloorAmenityWeightage> floorAmenityWeightages) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FloorAmenityWeightage floorAmenityWeightage :floorAmenityWeightages) {
			newsession.save(floorAmenityWeightage);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public List<BuilderFloor> getBuildingFloors(int building_id) {
		String hql = "from BuilderFloor where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderFloor> result = query.list();
		
		session.close();
		return result;
	}
	
	public List<FlatListData> getBuildingFloorsFilter(int projectId, int buildingId, int floorId, int evenOrodd) {
		String hql = "from BuilderFlat where ";
		String where = "";
		if(projectId > 0){
		    where += " builderFloor.builderBuilding.builderProject.id = :project_id AND builderFloor.builderBuilding.builderProject.status = 1";	
		}
		if(buildingId > 0){
			if(where != ""){
				where +=" AND builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
			}else{
				where +=" builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
			}
		}
		if(floorId > 0){
			if(where != ""){
				where +=" AND builderFloor.id = :floor_id AND  builderFloor.status = 1";
			}else{
				where +=" builderFloor.id = :floor_id AND  builderFloor.status = 1";
			}
		}
	
		if(evenOrodd > 0){
			//for even floors
			if(evenOrodd % 2 == 0){
				if(where != null){
					where += " AND builderFloor.floorNo % 2 = 0 AND  builderFloor.status = 1";
				}else{
					where +=" builderFloor.floorNo % 2 = 0 AND  builderFloor.status = 1";
				}
			}else{
				if(where != null){
					where +=" AND builderFloor.floorNo %2 <> 0 AND  builderFloor.status = 1";
				}else{
					where +=" builderFloor.floorNo %2 <> 0 AND  builderFloor.status = 1";
				}
			}
		}
		//order by projectid,buildingid, floornumber and flatnumber asc
		hql += where+" AND status = 1 ORDER BY builderFloor.builderBuilding.builderProject.id ASC, builderFloor.builderBuilding.id ASC, builderFloor.floorNo ASC, flatNo ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		String flatHql = "from BuilderFlat where builderFloor.id = :floor_id AND builderFloor.status=1 AND status=1";
		Session flatSession = hibernateUtil.openSession();
		Query flatQuery = flatSession.createQuery(flatHql);
		if(projectId > 0)
			query.setParameter("project_id", projectId);
		if(buildingId > 0)
			query.setParameter("building_id", buildingId);
		if(floorId > 0)
			query.setParameter("floor_id", floorId);
//		if(evenOrodd > 0)
//			query.setParameter("floor_no", evenOrodd);
		List<BuilderFlat> builderFlatList = query.list();
		List<FlatListData> newFlatList = new ArrayList<FlatListData>();
		System.err.println("No of flats :::: "+builderFlatList.size());
		int buildingid = 0;
		int floorid = 0;
		try{
		for(BuilderFlat builderFlat : builderFlatList){
			FlatListData flatListData = new FlatListData();
			List<BuildingListData> buildingListDatas = new ArrayList<BuildingListData>();
			if(buildingid != builderFlat.getBuilderFloor().getBuilderBuilding().getId()){
				List<FloorListData> floorListDatas = new ArrayList<FloorListData>();
				//if(floorid != builderFlat.getBuilderFloor().getId()){
					
//					BuilderFloor builderFloor = new BuilderFloor();
//					builderFloor.setId(floorid);
//					builderFloor.setName(floorName);
					//builderFloor.setBuilderFlats(builder);
					List<FlatStatusData> flatDatas = getFlatsByFloorId(builderFlat.getBuilderFloor().getId());
					FloorListData floorListData = new FloorListData();
					floorListData.setFloorId(builderFlat.getBuilderFloor().getId());
					floorListData.setFloorName(builderFlat.getBuilderFloor().getName());
					
					floorListData.setFlatStatusDatas(flatDatas);
					floorListDatas.add(floorListData);
				//}
//				BuilderFlat builderFlat2 = new BuilderFlat();
//				builderFlat2.setId(builderFlat.getId());
//				builderFlat2.setFlatNo(builderFlat.getFlatNo());
//				builderFlatList.add(builderFlat2);
				floorid = builderFlat.getBuilderFloor().getId();
//				floorName = builderFlat.getBuilderFloor().getName();
				BuildingListData buildingListData = new BuildingListData();
			//	List<BuildingImageGallery> buildingImageGalleries =  getBuilderBuildingImagesById(builderFlat.getBuilderFloor().getBuilderBuilding().getId());
				buildingListData.setBuildingId( builderFlat.getBuilderFloor().getBuilderBuilding().getId());
				try{
//				if(buildingImageGalleries.get(0) != null){	
//					buildingListData.setBuildingImage(buildingImageGalleries.get(0).getImage());
//				}
//				else{
//					buildingListData.setBuildingImage("");
//				}
				buildingListData.setBuildingName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
				buildingListData.setFloorListDatas(floorListDatas);
				buildingListDatas.add(buildingListData);
			}catch(Exception ee){
				buildingListData.setBuildingImage("");
				System.err.println("Inner error "+ee);
			}
//			BuildingData buildingData = new BuildingData();
//			buildingData.setId(builderFlat.getBuilderFloor().getBuilderBuilding().getId());
//			buildingData.setName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
			buildingid = builderFlat.getBuilderFloor().getBuilderBuilding().getId();
//			buildingName = builderFlat.getBuilderFloor().getBuilderBuilding().getName();
			flatListData.setBuildingListDatas(buildingListDatas);
			flatListData.setProjectid(projectId);
			newFlatList.add(flatListData);
		}
		}
		}catch(Exception e){
			e.printStackTrace();
			System.err.println("outer error :: "+e.getMessage());
		}
		
		//session.close();
		return newFlatList;
	}
	
	public List<FlatListData> getFlatDetails(int projectId, int buildingId, int floorId, int evenOrodd) {
		String hql = "from BuilderFlat where ";
		String where = "";
		if(projectId > 0){
		    where += " builderFloor.builderBuilding.builderProject.id = :project_id AND builderFloor.builderBuilding.builderProject.status = 1";	
		}
		if(buildingId > 0){
			if(where != ""){
				where +=" AND builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
			}else{
				where +=" builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
			}
		}
		if(floorId > 0){
			if(where != ""){
				where +=" AND builderFloor.id = :floor_id AND  builderFloor.status = 1";
			}else{
				where +=" builderFloor.id = :floor_id AND  builderFloor.status = 1";
			}
		}
	
		if(evenOrodd > 0){
			//for even floors
			if(evenOrodd % 2 == 0){
				if(where != null){
					where += " AND builderFloor.floorNo % 2 = 0 AND  builderFloor.status = 1";
				}else{
					where +=" builderFloor.floorNo % 2 = 0 AND  builderFloor.status = 1";
				}
			}else{
				if(where != null){
					where +=" AND builderFloor.floorNo %2 <> 0 AND  builderFloor.status = 1";
				}else{
					where +=" builderFloor.floorNo %2 <> 0 AND  builderFloor.status = 1";
				}
			}
		}
		//order by projectid,buildingid, floornumber and flatnumber asc
		hql += where+" AND status = 1 ORDER BY builderFloor.builderBuilding.builderProject.id ASC, builderFloor.builderBuilding.id ASC, builderFloor.floorNo ASC, flatNo ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		//String flatHql = "from BuilderFlat where builderFloor.id = :floor_id AND builderFloor.status=1 AND status=1";
		//Session flatSession = hibernateUtil.openSession();
		//Query flatQuery = flatSession.createQuery(flatHql);
		if(projectId > 0)
			query.setParameter("project_id", projectId);
		if(buildingId > 0)
			query.setParameter("building_id", buildingId);
		if(floorId > 0)
			query.setParameter("floor_id", floorId);
//		if(evenOrodd > 0)
//			query.setParameter("floor_no", evenOrodd);
		List<BuilderFlat> builderFlatList = query.list();
		List<FlatListData> newFlatList = new ArrayList<FlatListData>();
		System.err.println("No of flats :::: "+builderFlatList.size());
		System.out.print("<script>alert('No of Flats :: '"+builderFlatList.size()+"');</script>");
		//int buildingid = 0;
		int floorid = 0;
		try{
		for(int i=0;i<builderFlatList.size();i++){
			FlatListData flatListData = new FlatListData();
			List<BuildingListData> buildingListDatas = new ArrayList<BuildingListData>();
			//if(buildingid != builderFlatList.get(i).getBuilderFloor().getBuilderBuilding().getId()){
				List<FloorListData> floorListDatas = new ArrayList<FloorListData>();
				if(floorid != builderFlatList.get(i).getBuilderFloor().getId()){
					
//					BuilderFloor builderFloor = new BuilderFloor();
//					builderFloor.setId(floorid);
//					builderFloor.setName(floorName);
					//builderFloor.setBuilderFlats(builder);
					List<FlatStatusData> flatDatas = getFlatsByFloorId(builderFlatList.get(i).getBuilderFloor().getId());
					FloorListData floorListData = new FloorListData();
					floorListData.setFloorId(builderFlatList.get(i).getBuilderFloor().getId());
					floorListData.setFloorName(builderFlatList.get(i).getBuilderFloor().getName());
					
					floorListData.setFlatStatusDatas(flatDatas);
					floorListDatas.add(floorListData);
					BuildingListData buildingListData = new BuildingListData();
					try{
					buildingListData.setBuildingId( builderFlatList.get(i).getBuilderFloor().getBuilderBuilding().getId());
					buildingListData.setBuildingName(builderFlatList.get(i).getBuilderFloor().getBuilderBuilding().getName());
					buildingListData.setFloorListDatas(floorListDatas);
					buildingListDatas.add(buildingListData);
					}catch(Exception ee){
						buildingListData.setBuildingImage("");
						System.err.println("Inner error "+ee);
					}
					
				}
//				BuilderFlat builderFlat2 = new BuilderFlat();
//				builderFlat2.setId(builderFlat.getId());
//				builderFlat2.setFlatNo(builderFlat.getFlatNo());
//				builderFlatList.add(builderFlat2);
				floorid = builderFlatList.get(i).getBuilderFloor().getId();
//				floorName = builderFlat.getBuilderFloor().getName();
			
			//	List<BuildingImageGallery> buildingImageGalleries =  getBuilderBuildingImagesById(builderFlat.getBuilderFloor().getBuilderBuilding().getId());
				
				
//				if(buildingImageGalleries.get(0) != null){	
//					buildingListData.setBuildingImage(buildingImageGalleries.get(0).getImage());
//				}
//				else{
//					buildingListData.setBuildingImage("");
//				}
				
			
//			BuildingData buildingData = new BuildingData();
//			buildingData.setId(builderFlat.getBuilderFloor().getBuilderBuilding().getId());
//			buildingData.setName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
			//buildingid = builderFlatList.get(i).getBuilderFloor().getBuilderBuilding().getId();
//			buildingName = builderFlat.getBuilderFloor().getBuilderBuilding().getName();
			flatListData.setBuildingListDatas(buildingListDatas);
			flatListData.setProjectid(projectId);
			newFlatList.add(flatListData);
		//}
		}
		}catch(Exception e){
			e.printStackTrace();
			System.err.println("outer error :: "+e.getMessage());
		}
		
		session.close();
		return newFlatList;
	}
	
	public List<FlatListData> getBookedFlatDetails(int projectId, int buildingId, int floorId, int evenOrodd) {
		String hql = "from BuilderFlat where ";
		String where = "";
		if(projectId > 0){
		    where += " builderFloor.builderBuilding.builderProject.id = :project_id AND builderFloor.builderBuilding.builderProject.status = 1";	
		}
		if(buildingId > 0){
			if(where != ""){
				where +=" AND builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
			}else{
				where +=" builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
			}
		}
		if(floorId > 0){
			if(where != ""){
				where +=" AND builderFloor.id = :floor_id AND  builderFloor.status = 1";
			}else{
				where +=" builderFloor.id = :floor_id AND  builderFloor.status = 1";
			}
		}
	
		if(evenOrodd > 0){
			//for even floors
			if(evenOrodd % 2 == 0){
				if(where != null){
					where += " AND builderFloor.floorNo % 2 = 0 AND  builderFloor.status = 1";
				}else{
					where +=" builderFloor.floorNo % 2 = 0 AND  builderFloor.status = 1";
				}
			}else{
				if(where != null){
					where +=" AND builderFloor.floorNo %2 <> 0 AND  builderFloor.status = 1";
				}else{
					where +=" builderFloor.floorNo %2 <> 0 AND  builderFloor.status = 1";
				}
			}
		}
		//order by projectid,buildingid, floornumber and flatnumber asc
		hql += where+" AND status = 1 AND builderFlatStatus.id=2 ORDER BY builderFloor.builderBuilding.builderProject.id ASC, builderFloor.builderBuilding.id ASC, builderFloor.floorNo ASC, flatNo ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		//String flatHql = "from BuilderFlat where builderFloor.id = :floor_id AND builderFloor.status=1 AND status=1";
		//Session flatSession = hibernateUtil.openSession();
		//Query flatQuery = flatSession.createQuery(flatHql);
		if(projectId > 0)
			query.setParameter("project_id", projectId);
		if(buildingId > 0)
			query.setParameter("building_id", buildingId);
		if(floorId > 0)
			query.setParameter("floor_id", floorId);
//		if(evenOrodd > 0)
//			query.setParameter("floor_no", evenOrodd);
		List<BuilderFlat> builderFlatList = query.list();
		List<FlatListData> newFlatList = new ArrayList<FlatListData>();
		System.err.println("No of flats :::: "+builderFlatList.size());
		System.out.print("<script>alert('No of Flats :: '"+builderFlatList.size()+"');</script>");
		//int buildingid = 0;
		int floorid = 0;
		try{
		for(int i=0;i<builderFlatList.size();i++){
			FlatListData flatListData = new FlatListData();
			List<BuildingListData> buildingListDatas = new ArrayList<BuildingListData>();
			//if(buildingid != builderFlatList.get(i).getBuilderFloor().getBuilderBuilding().getId()){
				List<FloorListData> floorListDatas = new ArrayList<FloorListData>();
				if(floorid != builderFlatList.get(i).getBuilderFloor().getId()){
					
//					BuilderFloor builderFloor = new BuilderFloor();
//					builderFloor.setId(floorid);
//					builderFloor.setName(floorName);
					//builderFloor.setBuilderFlats(builder);
					List<FlatStatusData> flatDatas = getFlatsByFloorId(builderFlatList.get(i).getBuilderFloor().getId());
					FloorListData floorListData = new FloorListData();
					floorListData.setFloorId(builderFlatList.get(i).getBuilderFloor().getId());
					floorListData.setFloorName(builderFlatList.get(i).getBuilderFloor().getName());
					
					floorListData.setFlatStatusDatas(flatDatas);
					floorListDatas.add(floorListData);
					BuildingListData buildingListData = new BuildingListData();
					try{
					buildingListData.setBuildingId( builderFlatList.get(i).getBuilderFloor().getBuilderBuilding().getId());
					buildingListData.setBuildingName(builderFlatList.get(i).getBuilderFloor().getBuilderBuilding().getName());
					buildingListData.setFloorListDatas(floorListDatas);
					buildingListDatas.add(buildingListData);
					}catch(Exception ee){
						buildingListData.setBuildingImage("");
						System.err.println("Inner error "+ee);
					}
					
				}
//				BuilderFlat builderFlat2 = new BuilderFlat();
//				builderFlat2.setId(builderFlat.getId());
//				builderFlat2.setFlatNo(builderFlat.getFlatNo());
//				builderFlatList.add(builderFlat2);
				floorid = builderFlatList.get(i).getBuilderFloor().getId();
//				floorName = builderFlat.getBuilderFloor().getName();
			
			//	List<BuildingImageGallery> buildingImageGalleries =  getBuilderBuildingImagesById(builderFlat.getBuilderFloor().getBuilderBuilding().getId());
				
				
//				if(buildingImageGalleries.get(0) != null){	
//					buildingListData.setBuildingImage(buildingImageGalleries.get(0).getImage());
//				}
//				else{
//					buildingListData.setBuildingImage("");
//				}
				
			
//			BuildingData buildingData = new BuildingData();
//			buildingData.setId(builderFlat.getBuilderFloor().getBuilderBuilding().getId());
//			buildingData.setName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
			//buildingid = builderFlatList.get(i).getBuilderFloor().getBuilderBuilding().getId();
//			buildingName = builderFlat.getBuilderFloor().getBuilderBuilding().getName();
			flatListData.setBuildingListDatas(buildingListDatas);
			flatListData.setProjectid(projectId);
			newFlatList.add(flatListData);
		//}
		}
		}catch(Exception e){
			e.printStackTrace();
			System.err.println("outer error :: "+e.getMessage());
		}
		
		session.close();
		return newFlatList;
	}
	/**
	 * Get all active floor list
	 * @author pankaj
	 * @param building_id
	 * @return List<BuilderFloor>
	 */
	public List<BuilderFloor> getBuildingActiveFloors(int building_id) {
		String hql = "from BuilderFloor where builderBuilding.id = :building_id and builderBuilding.status=1 and builderBuilding.builderProject.status=1 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderFloor> result = query.list();
		session.close();
		return result;
	}
	
	public List<FloorPojo> getBuildingActiveFloorsByBuilderAndBuildingId(BuilderEmployee builderEmployee, int building_id) {
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2) {
			hql = "select a.id as id, a.building_id as buildingId, a.name as name, a.floor_no as floorNo, a.total_flats as totalFlats, a.completion_status as completionStatus,a.status_id as statusId,a.amenity_weightage as amenityWeightage,a.flat_weightage as flatWeightage,a.weightage as weightage,a.status status,b.name as buildingName,c.name as projectName,d.name as floorStatus from builder_floor as a inner join builder_building as b on a.building_id=b.id inner join builder_project as c on b.project_id=c.id inner join builder_floor_status as d on a.status_id=d.id inner join alloted_project as e on c.id=e.project_id where a.building_id = "+building_id+" and e.emp_id = "+builderEmployee.getId()+" and b.status=1 and c.status=1 and a.status=1";
		} else {
			hql = "select a.id as id, a.building_id as buildingId, a.name as name, a.floor_no as floorNo, a.total_flats as totalFlats, a.completion_status as completionStatus,a.status_id as statusId,a.amenity_weightage amenityWeightage,a.flat_weightage as flatWeightage,a.weightage as weightage,a.status status,b.name as buildingName,c.name as projectName,d.name as floorStatus from builder_floor as a inner join builder_building as b on a.building_id=b.id inner join builder_project as c on b.project_id=c.id inner join builder_floor_status as d on a.status_id=d.id where a.building_id = "+building_id+" and c.group_id="+builderEmployee.getBuilder().getId()+" and b.status=1 and c.status=1 and a.status=1";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(FloorPojo.class));
		List<FloorPojo> result = query.list();
		session.close();
		return result;
	}
	
	public List<FloorPojo> getBuildingActiveFloorsByBuilder(BuilderEmployee builderEmployee) {
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2) {
			hql = "select a.id as id, a.building_id as buildingId, a.name as name, a.floor_no as floorNo, a.total_flats as totalFlats, a.completion_status as completionStatus,a.status_id as statusId,a.amenity_weightage as amenityWeightage,a.flat_weightage as flatWeightage,a.weightage as weightage,a.status status,b.name as buildingName,c.name as projectName,d.name as floorStatus from builder_floor as a inner join builder_building as b on a.building_id=b.id inner join builder_project as c on b.project_id=c.id inner join builder_floor_status as d on a.status_id=d.id inner join alloted_project as e on c.id=e.project_id where e.emp_id = "+builderEmployee.getId()+" and b.status=1 and c.status=1 and a.status=1";
		} else {
			hql = "select a.id as id, a.building_id as buildingId, a.name as name, a.floor_no as floorNo, a.total_flats as totalFlats, a.completion_status as completionStatus,a.status_id as statusId,a.amenity_weightage as amenityWeightage,a.flat_weightage as flatWeightage,a.weightage as weightage,a.status status,b.name as buildingName,c.name as projectName,d.name as floorStatus from builder_floor as a inner join builder_building as b on a.building_id=b.id inner join builder_project as c on b.project_id=c.id inner join builder_floor_status as d on a.status_id=d.id where c.group_id="+builderEmployee.getBuilder().getId()+" and b.status=1 and c.status=1 and a.status=1";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(FloorPojo.class));
		List<FloorPojo> result = query.list();
		session.close();
		return result;
	}
	
	public List<FlatPojo> getFloorActiveFlatsByBuilderAndBuildingId(BuilderEmployee builderEmployee, int floor_id) {
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2) {
			hql = "select a.id as id, a.floor_no as floorNo, a.flat_no as flatNo, a.emp_id as empId,a.flat_type_id as flatTypeId,a.bedroom as bedroom, a.bathroom as bathroom, a.balcony as balcony, a.total_inventory as totalInventory,a.inventory_sold as inventorySold,a.revenue as revenue,a.completion_status as completionStatus,a.possession_date as possessionDate,a.status_id as statusId,a.amenity_weightage as amenityWeightage,a.weightage as weightage,a.status status,bf.name as floorName,b.name as buildingName,c.name as projectName,d.name as flatStatus from builder_flat as a inner join builder_floor as bf on a.floor_no=bf.id inner join builder_building as b on bf.building_id=b.id inner join builder_project as c on b.project_id=c.id inner join builder_flat_status as d on a.status_id=d.id inner join alloted_project as e on c.id=e.project_id where a.floor_no = "+floor_id+" and e.emp_id = "+builderEmployee.getId()+" and b.status=1 and c.status=1 and a.status=1 and bf.status = 1";
		} else {
			hql = "select a.id as id, a.floor_no as floorNo, a.flat_no as flatNo, a.emp_id as empId,a.flat_type_id as flatTypeId,a.bedroom as bedroom, a.bathroom as bathroom, a.balcony as balcony, a.total_inventory as totalInventory,a.inventory_sold as inventorySold,a.revenue as revenue,a.completion_status as completionStatus,a.possession_date as possessionDate,a.status_id as statusId,a.amenity_weightage as amenityWeightage,a.weightage as weightage,a.status status,bf.name as floorName,b.name as buildingName,c.name as projectName,d.name as flatStatus from builder_flat as a inner join builder_floor as bf on a.floor_no=bf.id inner join builder_building as b on bf.building_id=b.id inner join builder_project as c on b.project_id=c.id inner join builder_flat_status as d on a.status_id=d.id where a.floor_no = "+floor_id+" and c.group_id="+builderEmployee.getBuilder().getId()+" and b.status=1 and c.status=1 and a.status=1 and bf.status = 1";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(FlatPojo.class));
		List<FlatPojo> result = query.list();
		session.close();
		return result;
	}
	
	public List<FlatPojo> getFloorActiveFlatsByBuilder(BuilderEmployee builderEmployee) {
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2) {
			hql = "select a.id as id, a.floor_no as floorNo, a.flat_no as flatNo, a.emp_id as empId,a.flat_type_id as flatTypeId,a.bedroom as bedroom, a.bathroom as bathroom, a.balcony as balcony, a.total_inventory as totalInventory,a.inventory_sold as inventorySold,a.revenue as revenue,a.completion_status as completionStatus,a.possession_date as possessionDate,a.status_id as statusId,a.amenity_weightage as amenityWeightage,a.weightage as weightage,a.status status,bf.name as floorName,b.name as buildingName,c.name as projectName,d.name as flatStatus from builder_flat as a inner join builder_floor as bf on a.floor_no=bf.id inner join builder_building as b on bf.building_id=b.id inner join builder_project as c on b.project_id=c.id inner join builder_flat_status as d on a.status_id=d.id inner join alloted_project as e on c.id=e.project_id where e.emp_id = "+builderEmployee.getId()+" and b.status=1 and c.status=1 and a.status=1 and bf.status = 1";
		} else {
			hql = "select a.id as id, a.floor_no as floorNo, a.flat_no as flatNo, a.emp_id as empId,a.flat_type_id as flatTypeId,a.bedroom as bedroom, a.bathroom as bathroom, a.balcony as balcony, a.total_inventory as totalInventory,a.inventory_sold as inventorySold,a.revenue as revenue,a.completion_status as completionStatus,a.possession_date as possessionDate,a.status_id as statusId,a.amenity_weightage as amenityWeightage,a.weightage as weightage,a.status status,bf.name as floorName,b.name as buildingName,c.name as projectName,d.name as flatStatus from builder_flat as a inner join builder_floor as bf on a.floor_no=bf.id inner join builder_building as b on bf.building_id=b.id inner join builder_project as c on b.project_id=c.id inner join builder_flat_status as d on a.status_id=d.id where c.group_id="+builderEmployee.getBuilder().getId()+" and b.status=1 and c.status=1 and a.status=1 and bf.status = 1";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(FlatPojo.class));
		List<FlatPojo> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderFloor> getAllFloors() {
		String hql = "from BuilderFloor order by builderBuilding.builderProject.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFloor> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderFloor> getBuildingFloorById(int floor_id) {
		String hql = "from BuilderFloor where id = :floor_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floor_id);
		List<BuilderFloor> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all active floor list by id
	 * @author pankaj
	 * @param floor_id
	 * @return List<BuilderFloor>
	 */
	public List<BuilderFloor> getBuildingActiveFloorById(int floor_id) {
		String hql = "from BuilderFloor where id = :floor_id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floor_id);
		List<BuilderFloor> result = query.list();
		session.close();
		return result;
	}
	
	public List<FloorAmenityInfo> getBuildingFloorAmenityInfo(int floor_id) {
		String hql = "from FloorAmenityInfo where builderFloor.id = :floor_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floor_id);
		List<FloorAmenityInfo> result = query.list();
		session.close();
		return result;
	}
	
	public List<FloorAmenityWeightage> getFloorAmenityWeightages(int floor_id) {
		String hql = "from FloorAmenityWeightage where builderFloor.id = :floor_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floor_id);
		List<FloorAmenityWeightage> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all active floor amenity weight age
	 * @author pankaj
	 * @param floor_id
	 * @return List<FloorAmenityWeightage>
	 */
	public List<FloorAmenityWeightage> getActiveFloorAmenityWeightages(int floor_id) {
		String hql = "from FloorAmenityWeightage where builderFloor.id = :floor_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floor_id);
		List<FloorAmenityWeightage> result = query.list();
		session.close();
		return result;
	}
	
	public List<FloorLayoutImage> getBuildingFloorPlanInfo(int floor_id) {
		String hql = "from FloorLayoutImage where builderFloor.id = :floor_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floor_id);
		List<FloorLayoutImage> result = query.list();
		session.close();
		return result;
	}
	
	public void deleteFloorAmenityInfo(int floor_id) {
		String hql = "delete from FloorAmenityInfo where builderFloor.id = :floor_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floor_id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
	
	public void deleteFloorAmenityWeightage(int floor_id) {
		String hql = "delete from FloorAmenityWeightage where builderFloor.id = :floor_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floor_id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
	
	public ResponseMessage deleteFloorPlan(int image_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from FloorLayoutImage where id = :image_id";
		Query query = session.createQuery(hql);
		query.setInteger("image_id", image_id);
		query.executeUpdate();
		//query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Floor plan deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public List<FloorData> getBuildingFloorNamesByBuildingId(int building_id) {
		String hql = "from BuilderFloor where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderFloor> result = query.list();
		List<FloorData> floorDatas = new ArrayList<FloorData> ();
		for(BuilderFloor builderFloor : result) {
			FloorData floorData = new FloorData();
			floorData.setId(builderFloor.getId());
			floorData.setName(builderFloor.getName());
			floorDatas.add(floorData);
		}
		session.close();
		return floorDatas;
	}
	
	public ResponseMessage updateFloorAmenityWeightage(List<FloorAmenityWeightage> floorAmenityWeightages, int floor_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE FloorAmenityWeightage set status = 0 where builderFloor.id = :floor_id";
		Query query1 = session1.createQuery(hql1);
		query1.setParameter("floor_id", floor_id);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		Session session = hibernateUtil.openSession();
		for(FloorAmenityWeightage floorAmenityWeightage :floorAmenityWeightages) {
			session.beginTransaction();
			String hql = "UPDATE FloorAmenityWeightage set status=1 where id = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", floorAmenityWeightage.getId());
			query.executeUpdate();
			session.getTransaction().commit();
		}
		session.close();
		resp.setMessage("Floor status updated.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage addFloorImageGallery(List<FloorImageGallery> floorImageGalleries) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FloorImageGallery floorImageGallery :floorImageGalleries) {
			newsession.save(floorImageGallery);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addFloorPanoImage(List<FloorPanoramicImage> floorPanoramicImages) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FloorPanoramicImage floorPanoramicImage :floorPanoramicImages) {
			newsession.save(floorPanoramicImage);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage deleteFloorImageGallery(int image_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from FloorImageGallery where id = :image_id";
		Query query = session.createQuery(hql);
		query.setInteger("image_id", image_id);
		query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Floor image deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage deleteFloorPanoImage(int image_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from FloorPanoramicImage where id = :image_id";
		Query query = session.createQuery(hql);
		query.setInteger("image_id", image_id);
		query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Floor elevation image deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	/* ******************** Project Flat Types ******************** */
	public List<BuilderFlatType> getBuilderBuildingFlatTypes(int project_id) {
		String hql = "from BuilderFlatType where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<BuilderFlatType> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderBuildingFlatType> getBuilderBuildingFlatTypeByBuildingId(int building_id) {
		String hql = "from BuilderBuildingFlatType where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderBuildingFlatType> result = query.list();
		session.close();
		return result;
	} 
	
	public List<BuilderFlatType> getBuilderAllFlatTypes() {
		String hql = "from BuilderFlatType order by builderProject.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFlatType> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderFlatType> getBuilderBuildingFlatTypeById(int flat_type_id) {
		String hql = "from BuilderFlatType where id = :flat_type_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_type_id", flat_type_id);
		List<BuilderFlatType> result = query.list();
		session.close();
		return result;
	} 
	
	public List<BuilderBuildingFlatType> getBuildingFlatTypes(int flat_type_id) {
		String hql = "from BuilderBuildingFlatType where builderFlatType.id = :flat_type_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_type_id", flat_type_id);
		List<BuilderBuildingFlatType> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderBuildingFlatTypeRoom> getBuildingFlatTypeRooms(int flat_type_id) {
		String hql = "from BuilderBuildingFlatTypeRoom where builderFlatType.id = :flat_type_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_type_id", flat_type_id);
		List<BuilderBuildingFlatTypeRoom> result = query.list();
		session.close();
		return result;
	}
	
	public List<FlatTypeImage> getBuildingFlatTypeImages(int flat_type_id) {
		String hql = "from FlatTypeImage where builderFlatType.id = :flat_type_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_type_id", flat_type_id);
		List<FlatTypeImage> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage addBuildingFlatType(BuilderFlatType builderFlatType) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(builderFlatType);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(builderFlatType.getId());
		response.setStatus(1);
		response.setMessage("Building flat type Added Successfully.");
		return response;
	}
	
	public ResponseMessage addBuilderBuildingFlatType(List<BuilderBuildingFlatType> builderBuildingFlatTypes) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(BuilderBuildingFlatType builderBuildingFlatType :builderBuildingFlatTypes) {
			newsession.save(builderBuildingFlatType);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addBuilderBuildingFlatTypeRoom(List<BuilderBuildingFlatTypeRoom> builderBuildingFlatTypeRooms) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom :builderBuildingFlatTypeRooms) {
			newsession.save(builderBuildingFlatTypeRoom);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage updateBuildingFlatType(BuilderFlatType builderFlatType) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(builderFlatType);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(builderFlatType.getId());
		response.setStatus(1);
		response.setMessage("Building flat type Updated Successfully.");
		return response;
	}
	
	public ResponseMessage addFlatTypeImages(List<FlatTypeImage> flatTypeImages) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FlatTypeImage flatTypeImage :flatTypeImages) {
			newsession.save(flatTypeImage);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage deleteFlatTypeImage(int id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from FlatTypeImage where id = :id";
		Query query = session.createQuery(hql);
		query.setInteger("id", id);
		query.executeUpdate();
		//query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Flat type image deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public void deleteBuilderBuildingFlatType(int flat_type_id) {
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from BuilderBuildingFlatType where builderFlatType.id = :id";
		Query query = session.createQuery(hql);
		query.setInteger("id", flat_type_id);
		query.executeUpdate();
		//query.executeUpdate();
		transaction.commit();
		session.close();
	}
	
	public void deleteBuilderBuildingFlatTypeRoom(int flat_type_id) {
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from BuilderBuildingFlatTypeRoom where builderFlatType.id = :id";
		Query query = session.createQuery(hql);
		query.setInteger("id", flat_type_id);
		query.executeUpdate();
		//query.executeUpdate();
		transaction.commit();
		session.close();
	}
	
	
	/**
	 * Get Floor by id
	 * @author pankaj
	 * @param floor_id
	 * @return floor object
	 */
	public BuilderFloor getFloorById(int id){
		String hql = "from BuilderFloor where id= :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderFloor> result = query.list();
		session.close();
		return result.get(0);
	}
	/**
	 * Get Floor by building id
	 * @author pankaj
	 * @param building_id
	 * @return Floor object
	 */
	public BuilderFloor getFloorByBuildingId(int building_id){
		String hql = "from BuilderFloor where builderFloor.builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderFloor> result = query.list();
		session.close();
		return result.get(0);
	}
	
	public BuilderFloor getFlooraByBuildingId(int building_id){
		String hql = "from BuilderFloor where builderFloor.builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderFloor> result = query.list();
		session.close();
		return result.get(0);
	}
	/**
	 * Get Floor image by floor id
	 * @author pankaj
	 * @param floor_id 
	 * @return image 
	 */
	public List<FloorImageGallery> getAllFloorImagesById(int floor_id){
		String hql = "from FloorImageGallery where builderFloor.id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", floor_id);
		List<FloorImageGallery> result = query.list();
		session.close();
		List<FloorImageGallery> floorImageGalleries = new ArrayList<FloorImageGallery>();
		for(int i=0; i<result.size(); i++){
			FloorImageGallery floorImageGallery = new FloorImageGallery();
			floorImageGallery.setId(result.get(i).getId());
			floorImageGallery.setBuilderFloor(result.get(i).getBuilderFloor());
			floorImageGallery.setImage(result.get(i).getImage());
			floorImageGalleries.add(floorImageGallery);
		}
		return floorImageGalleries;
	}
	/**
	 * Get Floor Pano images by floor id
	 * @author pankaj
	 * @param floor_id
	 * @return Pano images
	 */
	public List<FloorPanoramicImage> getFloorPanoImagesByFloodId(int floor_id){
		String hql = "from FloorPanoramicImage where builderFloor.id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", floor_id);
		List<FloorPanoramicImage> result = query.list();
		session.close();
		List<FloorPanoramicImage> floorPanoramicImages = new ArrayList<FloorPanoramicImage>();
		for(int i=0; i<result.size(); i++){
			FloorPanoramicImage floorPanoramicImage = new FloorPanoramicImage();
			floorPanoramicImage.setId(result.get(i).getId());
			floorPanoramicImage.setBuilderFloor(result.get(i).getBuilderFloor());
			floorPanoramicImage.setPanoImage(result.get(i).getPanoImage());
			floorPanoramicImages.add(floorPanoramicImage);
		}
		return floorPanoramicImages;
	}
	
	public List<FloorData> getBuildingFlatTypeNamesByBuildingId(int building_id) {
		String hql = "from BuilderBuildingFlatType where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderBuildingFlatType> result = query.list();
		List<FloorData> floorDatas = new ArrayList<FloorData> ();
		for(BuilderBuildingFlatType builderBuildingFlatType : result) {
			FloorData floorData = new FloorData();
			floorData.setId(builderBuildingFlatType.getBuilderFlatType().getId());
			floorData.setName(builderBuildingFlatType.getBuilderFlatType().getName());
			floorDatas.add(floorData);
		}
		session.close();
		return floorDatas;
	}
	
	public List<FlatData> getActiveFlatsByFloorId(int floorId){
		List<FlatData> flatDatas = new ArrayList<FlatData>();
		String hql = "from BuilderFlat where builderFloor.id = :floor_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floorId);
		List<BuilderFlat> builderFlats = query.list();
		for(BuilderFlat builderFlat : builderFlats){
			FlatData flatData = new FlatData();
			flatData.setId(builderFlat.getId());
			flatData.setName(builderFlat.getFlatNo());
			flatDatas.add(flatData);
		}
		return flatDatas;
	}
	
	
	public List<FlatData> getActiveFlatListByFloorId(int floorId){
		List<FlatData> flatDatas = new ArrayList<FlatData>();
		String hql = "from BuilderFlat where builderFloor.id = :floor_id and builderFloor.builderBuilding.builderProject.status = 1 and builderFloor.builderBuilding.status = 1 and builderFloor.status = 1 and status =1 order by builderFloor.builderBuilding.builderProject.id desc";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floorId);
		List<BuilderFlat> builderFlats = query.list();
		for(BuilderFlat builderFlat : builderFlats){
			FlatData flatData = new FlatData();
			flatData.setId(builderFlat.getId());
			flatData.setName(builderFlat.getFlatNo());
			flatDatas.add(flatData);
		}
		return flatDatas;
	}
	
	public List<BuilderFlat> getActiveFlatByFloorId(int floorId){
		String hql = "from BuilderFlat where builderFloor.id = :floor_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floorId);
		List<BuilderFlat> builderFlats = query.list();
		
		return builderFlats;
	}
	
	public List<FlatStatusData> getFlatsByFloorId(int floorId){
		List<FlatStatusData> flatDatas = new ArrayList<FlatStatusData>();
		String hql = "from BuilderFlat where builderFloor.id = :floor_id AND builderFloor.status=1 AND status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floorId);
		List<BuilderFlat> builderFlats = query.list();
		for(BuilderFlat builderFlat : builderFlats){
			FlatStatusData flatData = new FlatStatusData();
			flatData.setId(builderFlat.getId());
			flatData.setName(builderFlat.getFlatNo());
			flatData.setFlatStaus(builderFlat.getBuilderFlatStatus().getName());
			flatDatas.add(flatData);
		}
		return flatDatas;
	}
	
	/* ******************** Project Flats ******************** */
	
	public List<BuilderFlat> getBuilderProjectBuildingFlats(int building_id) {
		String hql = "from BuilderFlat where builderFloor.builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderFlat> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderFlat> getBuildingFlatById(int flat_id) {
		String hql = "from BuilderFlat where id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flat_id);
		List<BuilderFlat> result = query.list();
		session.close();
		return result;
	}
	
	/**
	 * 
	 * @param flat_id
	 * @return List<BuilderFlat>
	 */
	public List<BuilderFlat> getBuildingActiveFlatByBuildingId(int building_id) {
		String hql = "from BuilderFlat where builderFloor.builderBuilding.id = :building_id and builderFlatStatus.id=2 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderFlat> result = query.list();
		for(BuilderFlat builderFlat : result){
			System.out.println("Flat number :: "+builderFlat.getFlatNo());
		}
		session.close();
		return result;
	}
	/**
	 * 
	 * @param flat_id
	 * @return List<BuilderFlat>
	 */
	public List<BuilderFlat> getBuildingActiveFlatById(int flat_id) {
		String hql = "from BuilderFlat where id = :flat_id and builderFloor.status=1 and builderFloor.builderBuilding.status=1 and builderFloor.builderBuilding.builderProject.status=1 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flat_id);
		List<BuilderFlat> result = query.list();
		for(BuilderFlat builderFlat : result){
			System.out.println("Flat number :: "+builderFlat.getFlatNo());
		}
		session.close();
		return result;
	}
	
	public List<BuilderFlat> getActiveBookedUnbookedFlatById(int flat_id) {
		String hql = "from BuilderFlat where id = :flat_id and builderFloor.status=1 "
				+ "and builderFloor.builderBuilding.status=1 "
				+ "and builderFloor.builderBuilding.builderProject.status=1"
				+ " and status=1 "
				+ "and builderFlatStatus.id =1 OR builderFlatStatus.id =2 OR builderFlatStatus.id =4";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flat_id);
		List<BuilderFlat> result = query.list();
		for(BuilderFlat builderFlat : result){
			System.out.println("Flat number :: "+builderFlat.getFlatNo());
		}
		session.close();
		return result;
	}
	
	public List<BuilderFlat> getBuilderFloorFlats(int floor_id) {
		String hql = "from BuilderFlat where builderFloor.id = :floor_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floor_id);
		List<BuilderFlat> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all Active floors by building id
	 * @author pankaj
	 * @param buildingId
	 * @return
	 */
	public List<BuilderFloor> getActiveFloorsByBuildingId(int buildingId){
		String hql = "from BuilderFloor where builderBuilding.id = :building_id and builderBuilding.status = 1 and builderBuilding.builderProject.status = 1 and status = 1 order by builderBuilding.builderProject.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", buildingId);
		List<BuilderFloor> builderFloors = query.list();
		return builderFloors;
				
	}
	
	public List<FloorData> getActiveFloorNamesByBuildingId(int building_id) {
		String hql = "from BuilderFloor where builderBuilding.id = :building_id and builderBuilding.status = 1 and builderBuilding.builderProject.status = 1 and status = 1 order by builderBuilding.builderProject.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuilderFloor> result = query.list();
		List<FloorData> floorDatas = new ArrayList<FloorData> ();
		for(BuilderFloor builderFloor : result) {
			FloorData floorData = new FloorData();
			floorData.setId(builderFloor.getId());
			floorData.setName(builderFloor.getName());
			floorDatas.add(floorData);
		}
		session.close();
		return floorDatas;
	}
	
	
	/**
	 * Get all active flats by floor id
	 * @author pankaj
	 * @param floor_id
	 * @return List<BuilderFlat>
	 */
	public List<BuilderFlat> getBuilderActiveFloorFlats(int floor_id) {
		String hql = "from BuilderFlat where builderFloor.id = :floor_id and builderFloor.status=1 and builderFloor.builderBuilding.status=1 and builderFloor.builderBuilding.builderProject.status=1 and status=1 order by builderFloor.builderBuilding.builderProject.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floor_id);
		List<BuilderFlat> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderFlat> getBuilderAllFlats() {
		String hql = "from BuilderFlat order by builderFloor.builderBuilding.builderProject.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFlat> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderFlat> getBuilderAllFlatsByBuildingId(int building_id) {
		String hql = "from BuilderFlat where builderFloor.builderBuilding.id = :id order by flat_no ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", building_id);
		List<BuilderFlat> result = query.list();
		session.close();
		return result;
	}
	
	public List<FlatAmenityInfo> getBuilderFlatAmenityInfos(int flat_id) {
		String hql = "from FlatAmenityInfo where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flat_id);
		List<FlatAmenityInfo> result = query.list();
		session.close();
		return result;
	}
	public List<FlatAmenityWeightage> getFlatAmenityWeightageByFlatId(int flat_id) {
		String hql = "from FlatAmenityWeightage where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flat_id);
		List<FlatAmenityWeightage> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all active flat amenity weight age
	 * @author pankaj
	 * @param flat_id
	 * @return List<FlatAmenityWeightage>
	 */
	public List<FlatAmenityWeightage> getActiveFlatAmenityWeightageByFlatId(int flat_id) {
		String hql = "from FlatAmenityWeightage where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flat_id);
		List<FlatAmenityWeightage> result = query.list();
		session.close();
		return result;
	}
	
	public List<FlatPaymentSchedule> getBuilderFlatPaymentSchedules(int flat_id) {
		String hql = "from FlatPaymentSchedule where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flat_id);
		List<FlatPaymentSchedule> result = query.list();
		session.close();
		return result;
	}
	
	public List<PaymentInfoData> getFlatPaymentSchedules(int flat_id) {
		System.err.println("FlatId :: "+flat_id);
		List<PaymentInfoData> paymentInfoDatas = new ArrayList<PaymentInfoData>();
		String hql = "from FlatPaymentSchedule where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flat_id);
		try{
		List<FlatPaymentSchedule> result = query.list();
		if(result.get(0)!=null){
			for(FlatPaymentSchedule flatPaymentSchedule : result){
				PaymentInfoData paymentInfoData = new PaymentInfoData();
				paymentInfoData.setId(flatPaymentSchedule.getId());
				paymentInfoData.setName(flatPaymentSchedule.getMilestone());
				paymentInfoData.setAmount(flatPaymentSchedule.getAmount());
				paymentInfoData.setPayable(flatPaymentSchedule.getPayable());
				paymentInfoDatas.add(paymentInfoData);
			}
		}else{
			BuilderFlat flat =  getBuilderFlatById(flat_id);
			List<BuildingPaymentInfo> buildingPaymentInfos = getActiveBuilderBuildingPaymentInfoById(flat.getBuilderFloor().getBuilderBuilding().getId());
			for(BuildingPaymentInfo buildingPaymentInfo : buildingPaymentInfos){
				PaymentInfoData paymentInfoData = new PaymentInfoData();
				paymentInfoData.setId(0);
				paymentInfoData.setName(buildingPaymentInfo.getMilestone());
				paymentInfoData.setAmount(buildingPaymentInfo.getAmount());
				paymentInfoData.setPayable(buildingPaymentInfo.getPayable());
				paymentInfoDatas.add(paymentInfoData);
			}
		}
		}catch(IndexOutOfBoundsException e){
			//e.printStackTrace();
			BuilderFlat flat =  getBuilderFlatById(flat_id);
			try{
				List<BuildingPaymentInfo> buildingPaymentInfos = getActiveBuilderBuildingPaymentInfoById(flat.getBuilderFloor().getBuilderBuilding().getId());
				for(BuildingPaymentInfo buildingPaymentInfo : buildingPaymentInfos){
					PaymentInfoData paymentInfoData = new PaymentInfoData();
					paymentInfoData.setId(0);
					paymentInfoData.setName(buildingPaymentInfo.getMilestone());
					paymentInfoData.setAmount(buildingPaymentInfo.getAmount());
					paymentInfoData.setPayable(buildingPaymentInfo.getPayable());
					paymentInfoDatas.add(paymentInfoData);
				}
			}catch(Exception e1){
				try{
				List<BuilderProjectPaymentInfo> projectPaymentInfo = getActiveProjectPaymentInfo(flat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getId());
					if(projectPaymentInfo != null){
						for(BuilderProjectPaymentInfo builderProjectPaymentInfo : projectPaymentInfo){
							PaymentInfoData paymentInfoData = new PaymentInfoData();
							paymentInfoData.setId(0);
							paymentInfoData.setName(builderProjectPaymentInfo.getSchedule());
							paymentInfoData.setAmount(builderProjectPaymentInfo.getAmount());
							paymentInfoData.setPayable(builderProjectPaymentInfo.getPayable());
							paymentInfoDatas.add(paymentInfoData);
						}
					}
				}catch(Exception e2){
					PaymentInfoData paymentInfoData = new PaymentInfoData();
					paymentInfoData.setId(0);
					paymentInfoData.setName("");
					paymentInfoData.setAmount(0.0);
					paymentInfoData.setPayable(0.0);
					paymentInfoDatas.add(paymentInfoData);
				}
			}
				
		}catch(Exception e){
			e.printStackTrace();
		}
		session.close();
		return paymentInfoDatas;
	}
	
	public List<BuilderProjectPaymentInfo> getActiveProjectPaymentInfo(int projectId){
		String hql = "from BuilderProjectPaymentInfo where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderProjectPaymentInfo> result = query.list();
		if(result != null){
			return result;
		}else{
			return null;
		}
	}
	
	public BuilderFlat getBuilderFlatById(int flatId){
		BuilderFlat builderFlat = null;
		String hql = "from BuilderFlat where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", flatId);
		builderFlat = (BuilderFlat) query.uniqueResult();
		session.close();
		return builderFlat;
	}
	/**
	 * Get all active flat payment schedules by flat id
	 * @author pankaj
	 * @param flat_id
	 * @return List<FlatPaymentSchedule> 
	 */
	public List<FlatPaymentSchedule> getBuilderActiveFlatPaymentSchedules(int flat_id) {
		String hql = "from FlatPaymentSchedule where builderFlat.id = :flat_id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flat_id);
		List<FlatPaymentSchedule> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage addBuildingFlat(BuilderFlat builderFlat) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(builderFlat);
		newsession.getTransaction().commit();
		newsession.close();
		updateProjectInventory(builderFlat.getId());
		response.setId(builderFlat.getId());
		response.setStatus(1);
		response.setMessage("Building flat Added Successfully.");
		return response;
	}
	
	public void updateProjectInventory(int flatId){
		String hql = "UPDATE BuilderProject set availbale = :availbale, inventorySold =:soldInventory, totalInventory = :totalInventory where id = :project_id ";
		int available = 0;
		int totalInventory = 0;
		int soldInventory = 0;
		BuilderFlat builderFlat = getBuilderFlatById(flatId);
		int projectId = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getId();
		available = getAvaiableFlatCount(projectId);
		soldInventory = getSoldFlatCount(projectId);
		totalInventory = available + soldInventory;
		//Double total_inventory =  totalInventory;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("availbale", available);
		query.setParameter("soldInventory", soldInventory);
		query.setParameter("totalInventory",totalInventory );
		query.setParameter("project_id",projectId );
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
	
	public int getAvaiableFlatCount(int project_id){
		String hql = "select id from BuilderFlat where builderFloor.builderBuilding.builderProject.id = :project_id and builderFlatStatus =1 AND status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		int available = query.list().size();
		return available;
	}
	
	public int getSoldFlatCount(int projectId){
		String hql = "Select id from BuilderFlat where builderFloor.builderBuilding.builderProject.id = :project_id and builderFlatStatus =2 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		int available =  query.list().size();
		return available;
	}
	public ResponseMessage updateBuildingFlat(BuilderFlat builderFlat) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(builderFlat);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(builderFlat.getId());
		response.setStatus(1);
		response.setMessage("Building flat Updated Successfully.");
		return response;
	}
	
	public ResponseMessage addFlatAmenityInfo(List<FlatAmenityInfo> flatAmenityInfos) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FlatAmenityInfo flatAmenityInfo :flatAmenityInfos) {
			newsession.save(flatAmenityInfo);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addFlatAmenityWeightage(List<FlatAmenityWeightage> flatAmenityWeightages) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FlatAmenityWeightage flatAmenityWeightage :flatAmenityWeightages) {
			newsession.save(flatAmenityWeightage);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addFlatPaymentInfo(List<FlatPaymentSchedule> flatPaymentSchedules) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FlatPaymentSchedule flatPaymentSchedule :flatPaymentSchedules) {
			newsession.save(flatPaymentSchedule);
		}
		newsession.getTransaction().commit();
		newsession.close();
		resp.setStatus(1);
		resp.setMessage("Payment Schedules Added");
		return resp;
	}
	
	public ResponseMessage updateFlatPaymentInfo(List<FlatPaymentSchedule> flatPaymentSchedules) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FlatPaymentSchedule flatPaymentSchedule :flatPaymentSchedules) {
			newsession.update(flatPaymentSchedule);
		}
		newsession.getTransaction().commit();
		newsession.close();
		resp.setStatus(1);
		resp.setMessage("Payment Schedules Updated");
		return resp;
	}
	
	public ResponseMessage deleteFlatAmenityInfo(int flat_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from FlatAmenityInfo where builderFlat.id = :flat_id";
		Query query = session.createQuery(hql);
		query.setInteger("flat_id", flat_id);
		query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Flat Amenity deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public void deleteFlatAmenityWeightage(int flat_id) {
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from FlatAmenityWeightage where builderFlat.id = :flat_id";
		Query query = session.createQuery(hql);
		query.setInteger("flat_id", flat_id);
		query.executeUpdate();
		transaction.commit();
		session.close();
	}
	
	public ResponseMessage deleteFlatPaymentInfo(int id) {
		ResponseMessage resp = new ResponseMessage();
		String hql = "delete from FlatPaymentSchedule where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		resp.setMessage("Flat payment deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage deleteFlatOfferInfo(int id) {
		
		ResponseMessage resp = new ResponseMessage();
		String resetHql = "from FlatOfferInfo where id = :id";
		String hql = "delete from FlatOfferInfo where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		
		/************** Reset original amount of flat with updated discount before deleting offer***************/
		Session resetSession = hibernateUtil.openSession();
		Query resetQuery = resetSession.createQuery(resetHql);
		resetQuery.setParameter("id", id);
		FlatOfferInfo result = (FlatOfferInfo)resetQuery.list().get(0);
		
		FlatPricingDetails flatPricingDetails = getFlatPriceDetails(result.getBuilderFlat().getId());
		Double totalCost = flatPricingDetails.getTotalCost();
		BuilderFlat flat = getBuildingFlatById(result.getBuilderFlat().getId()).get(0);
		List<FlatPaymentSchedule> flatPaymentSchedules = getBuilderFlatPaymentSchedules(result.getBuilderFlat().getId());
		List<FlatPaymentSchedule> updateFlatPayment = new ArrayList<FlatPaymentSchedule>();
		Double discount = flat.getDiscount();
		
		if(result != null){
			if(result.getType() == 1){
				totalCost = totalCost * result.getAmount();
				discount = discount * result.getAmount();
			}
			if(result.getType() == 2){
				totalCost = totalCost + result.getAmount();
				discount = discount + result.getAmount();
			}
		}
		if(flatPaymentSchedules != null && flatPaymentSchedules.size() > 0){
			for(int w = 0;w < flatPaymentSchedules.size(); w++){
				FlatPaymentSchedule flatPaymentSchedule = new FlatPaymentSchedule();
				flatPaymentSchedule.setId(flatPaymentSchedules.get(w).getId());
				flatPaymentSchedule.setMilestone(flatPaymentSchedules.get(w).getMilestone());
				flatPaymentSchedule.setPayable(flatPaymentSchedules.get(w).getPayable());
				flatPaymentSchedule.setAmount(totalCost*flatPaymentSchedules.get(w).getPayable()/100);
				flatPaymentSchedule.setStatus(flatPaymentSchedules.get(w).getStatus());
				flatPaymentSchedule.setBuilderFlat(flat);
				updateFlatPayment.add(flatPaymentSchedule);
			}
			if(updateFlatPayment.size() > 0){
				updateFlatPaymentInfo(updateFlatPayment);
			}
		}
		flat.setDiscount(discount);
		updateBuildingFlat(flat);
		flatPricingDetails.setTotalCost(totalCost);
		updateFlatPriceInfo(flatPricingDetails);
	 /*********************Delete flat Offer***************/	
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		resp.setMessage("Flat offer deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public List<FlatImageGallery> getAllFlatImagesById(int flat_id){
		String hql = "from FlatImageGallery where builderFlat.id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", flat_id);
		List<FlatImageGallery> result = query.list();
		session.close();
		List<FlatImageGallery> flatImageGalleries = new ArrayList<FlatImageGallery>();
		for(int i=0; i<result.size(); i++){
			FlatImageGallery flatImageGallery = new FlatImageGallery();
			flatImageGallery.setId(result.get(i).getId());
			flatImageGallery.setBuilderFlat(result.get(i).getBuilderFlat());
			flatImageGallery.setImage(result.get(i).getImage());
			flatImageGalleries.add(flatImageGallery);
		}
		return flatImageGalleries;
	}
	
	public List<FlatPanoramicImage> getFlatPanoImagesByFlatId(int flat_id){
		String hql = "from FlatPanoramicImage where builderFlat.id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", flat_id);
		List<FlatPanoramicImage> result = query.list();
		session.close();
		List<FlatPanoramicImage> flatPanoramicImages = new ArrayList<FlatPanoramicImage>();
		for(int i=0; i<result.size(); i++){
			FlatPanoramicImage flatPanoramicImage = new FlatPanoramicImage();
			flatPanoramicImage.setId(result.get(i).getId());
			flatPanoramicImage.setBuilderFlat(result.get(i).getBuilderFlat());
			flatPanoramicImage.setPanoImage(result.get(i).getPanoImage());
			flatPanoramicImages.add(flatPanoramicImage);
		}
		return flatPanoramicImages;
	}
	
	public ResponseMessage updateFlatAmenityWeightage(List<FlatAmenityWeightage> flatAmenityWeightages, int flat_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE FlatAmenityWeightage set status = 0 where builderFlat.id = :flat_id";
		Query query1 = session1.createQuery(hql1);
		query1.setParameter("flat_id", flat_id);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		Session session = hibernateUtil.openSession();
		for(FlatAmenityWeightage flatAmenityWeightage :flatAmenityWeightages) {
			session.beginTransaction();
			String hql = "UPDATE FlatAmenityWeightage set status=1 where id = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", flatAmenityWeightage.getId());
			query.executeUpdate();
			session.getTransaction().commit();
		}
		session.close();
		resp.setMessage("Flat status updated.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage addFlatImageGallery(List<FlatImageGallery> flatImageGalleries) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FlatImageGallery flatImageGallery :flatImageGalleries) {
			newsession.save(flatImageGallery);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage addFlatPanoImage(List<FlatPanoramicImage> flatPanoramicImages) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		for(FlatPanoramicImage flatPanoramicImage :flatPanoramicImages) {
			newsession.save(flatPanoramicImage);
		}
		newsession.getTransaction().commit();
		newsession.close();
		return resp;
	}
	
	public ResponseMessage deleteFlatImageGallery(int image_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from FlatImageGallery where id = :image_id";
		Query query = session.createQuery(hql);
		query.setInteger("image_id", image_id);
		query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Flat image deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public ResponseMessage deleteFlatPanoImage(int image_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Transaction transaction = session.beginTransaction();
		String hql = "delete from FlatPanoramicImage where id = :image_id";
		Query query = session.createQuery(hql);
		query.setInteger("image_id", image_id);
		query.executeUpdate();
		transaction.commit();
		session.close();
		resp.setMessage("Flat elevation image deleted successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	/* ***************** Project Leads ********************** */
	
	public ResponseMessage addProjectLead(BuilderLead builderLead) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(builderLead);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(builderLead.getId());
		response.setStatus(1);
		response.setMessage("Project Lead Added Successfully.");
		return response;
	}
	
	public ResponseMessage updateProjectLead(BuilderLead builderLead) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(builderLead);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(builderLead.getId());
		response.setStatus(1);
		response.setMessage("Project Lead Updated Successfully.");
		return response;
	}
	
	public List<BuilderLead> getBuilderProjectLeads() {
		String hql = "from BuilderLead order by id desc";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderLead> result = query.list();
		session.close();
		return result;
	}
	
	public BuilderLead getBuilderProjectLeadById(int id) {
		String hql = "from BuilderLead where id= :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderLead> result = query.list();
		session.close();
		return result.get(0);
	}
	
	/* **** code by pankaj ********** */
	/**
	 * save Floor image data
	 * @author pankaj
	 * @param request
	 * @return response
	 */
	public ResponseMessage saveFloorImageGallery(FloorImageData floorImageData){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		BuilderFloor builderFloor = floorImageData.getBuilderFloor();
		List<FloorImageGallery> floorImageGalleries = floorImageData.getFloorImageGallery();
		if(floorImageGalleries.size()>0){
			Session newsession1 = hibernateUtil.openSession();
			newsession1.beginTransaction();
			for(int i=0;i<floorImageGalleries.size();i++){
				FloorImageGallery floorImageGallery = new FloorImageGallery();
				floorImageGallery.setBuilderFloor(builderFloor);
				floorImageGallery.setImage(floorImageGalleries.get(i).getImage());
				newsession1.save(floorImageGallery);
			}
			newsession1.getTransaction().commit();
			newsession1.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Floor Image Added Successfully.");
		}
		return responseMessage;
	}
	/**
	 * save Floor Pano images
	 * @author pankaj
	 * @param request
	 * @return response
	 */
	public ResponseMessage saveFloorPanoImage(FloorPanoData floorPanoData){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		List<FloorPanoramicImage> floorPanoramicImages = floorPanoData.getFloorPanoramicImages();
		if(floorPanoramicImages.size()>0){
			Session newsession1 = hibernateUtil.openSession();
			newsession1.beginTransaction();
			for(int i=0;i<floorPanoramicImages.size();i++){
				FloorPanoramicImage floorPanoramicImage = new FloorPanoramicImage();
				floorPanoramicImage.setBuilderFloor(floorPanoData.getBuilderFloor());
				floorPanoramicImage.setPanoImage(floorPanoramicImages.get(i).getPanoImage());
				newsession1.save(floorPanoramicImage);
			}
			newsession1.getTransaction().commit();
			newsession1.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Floor Image Added Successfully.");
		}
		return responseMessage;
	}
	/**
	 * update Floor
	 * @author pankaj
	 * @param request
	 * @return response
	 */
	public ResponseMessage updateFloor(FloorDetail floorDetail){
		ResponseMessage response = new ResponseMessage();
		BuilderFloor builderFloor = floorDetail.getBuilderFloor();
		
		/******* delete enteries **********/
		HibernateUtil hibernateUtil = new HibernateUtil();
		String delete_floor_amenity_type = "DELETE from FloorAmenityInfo where builderFloor.id = :floor_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_floor_amenity_type);
		smdelete.setParameter("floor_id", builderFloor.getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/***** Add New Enteries *******/
		List<FloorAmenityInfo> floorAmenityInfos = floorDetail.getFloorAmenityInfos();
		if(floorAmenityInfos.size()>0){
			Session addsession1 = hibernateUtil.openSession();
			addsession1.beginTransaction();
			for(int i=0;i<floorAmenityInfos.size();i++){
				FloorAmenityInfo floorAmenityInfo = new FloorAmenityInfo();
				floorAmenityInfo.setBuilderFloor(builderFloor);
				floorAmenityInfo.setBuilderFloorAmenity(floorAmenityInfos.get(i).getBuilderFloorAmenity());
				addsession1.save(floorAmenityInfo);
			}
			addsession1.getTransaction().commit();
			addsession1.close();
			response.setStatus(1);
			response.setMessage("Floor Updated sucessfuly");
		}
		return response;
	}
	/**
	 * update Floor Image
	 * @author pankaj
	 * @param request
	 * @return response
	 */
	public ResponseMessage updateFloorImage(FloorImageData floorImageData){
		ResponseMessage response = new ResponseMessage();
		BuilderFloor builderFloor = floorImageData.getBuilderFloor();
		/******* delete enteries **********/
		HibernateUtil hibernateUtil = new HibernateUtil();
		String delete_floor_image_gallery = "DELETE from FloorImageGallery where builderFloor.id = :floor_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_floor_image_gallery);
		smdelete.setParameter("floor_id", builderFloor.getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/***** Add New Enteries *******/
		List<FloorImageGallery> floorImageGalleries = floorImageData.getFloorImageGallery();
		if(floorImageGalleries.size()>0){
			Session addsession1 = hibernateUtil.openSession();
			addsession1.beginTransaction();
			for(int i=0;i<floorImageGalleries.size();i++){
				FloorImageGallery floorImageGallery = new FloorImageGallery();
				floorImageGallery.setBuilderFloor(builderFloor);
				floorImageGallery.setImage(floorImageGalleries.get(i).getImage());;
				addsession1.save(floorImageGallery);
			}
			addsession1.getTransaction().commit();
			addsession1.close();
			response.setStatus(1);
			response.setMessage("Floor Image Updated sucessfuly");
		}
		return response;
	}
	/**
	 * update Floor Pano Image
	 * @author pankaj
	 * @param request
	 * @return response
	 */
	public ResponseMessage updateFloorPanoImage(FloorPanoData floorPanoData){
		ResponseMessage response = new ResponseMessage();
		BuilderFloor builderFloor = floorPanoData.getBuilderFloor();
		
		/******* delete enteries **********/
		HibernateUtil hibernateUtil = new HibernateUtil();
		String delete_floor_pano_images = "DELETE from FloorPanoramicImage where builderFloor.id = :floor_id";
		Session newsession1 = hibernateUtil.openSession();
		newsession1.beginTransaction();
		Query smdelete = newsession1.createQuery(delete_floor_pano_images);
		smdelete.setParameter("floor_id", builderFloor.getId());
		smdelete.executeUpdate();
		newsession1.getTransaction().commit();
		newsession1.close();
		
		/***** Add New Enteries *******/
		List<FloorPanoramicImage> floorPanoramicImages = floorPanoData.getFloorPanoramicImages();
		if(floorPanoramicImages.size()>0){
			Session addsession1 = hibernateUtil.openSession();
			addsession1.beginTransaction();
			for(int i=0;i<floorPanoramicImages.size();i++){
				FloorPanoramicImage floorPanoramicImage = new FloorPanoramicImage();
				floorPanoramicImage.setBuilderFloor(builderFloor);
				floorPanoramicImage.setPanoImage(floorPanoramicImages.get(i).getPanoImage());
				addsession1.save(floorPanoramicImage);
			}
			addsession1.getTransaction().commit();
			addsession1.close();
			response.setStatus(1);
			response.setMessage("Floor Pano Image Updated sucessfuly");
		}
		return response;
	}
	/**
	 * Get all floors
	 * @author pankaj
	 * @return list
	 */
	public List<BuilderFloor> getBuilderFloorList(){
		String hql = "from BuilderFloor";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFloor> result = query.list();
		session.close();
		return result;
	}
	
	/**
	 * Get Active Floor Amenity List 
	 * @author pankaj
	 * @return list
	 */
	public List<BuilderFloorAmenity> getAllFloorAmenity(){
		String hql = "from BuilderFloorAmenity where status=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFloorAmenity> result = query.list();
		session.close();
		return result;
	}
	
	public List<ProjectList> getBuilderProjectsByBuilderId(int builderId) {
		System.err.println("builderId :: "+builderId);
		String hql = "from BuilderProject where builder.id = :builder_id order by id desc";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setFirstResult(0);
		query.setMaxResults(100);
		query.setParameter("builder_id", builderId);
		List<BuilderProject> result = query.list();
		List<ProjectList> projects = new ArrayList<ProjectList>();
		for(BuilderProject builderproject : result) {
			ProjectList newproject = new ProjectList();
			newproject.setId(builderproject.getId());
			newproject.setName(builderproject.getName());
			newproject.setStatus(builderproject.getStatus());
			newproject.setBuilderId(builderproject.getBuilder().getId());
			newproject.setBuilderName(builderproject.getBuilder().getName());
			newproject.setCityId(builderproject.getCity().getId());
			newproject.setCityName(builderproject.getCity().getName());
		//	newproject.setLocalityId(builderproject.getLocality().getId());
			//newproject.setLocalityName(builderproject.getLocality().getName());
			newproject.setLocalityName(builderproject.getLocalityName());
			System.out.println("Project name :: "+builderproject.getName());
			projects.add(newproject);
		}
		session.close();
		return projects;
	}
	/**
	 * Get all active projects by builder id
	 * @author pankaj
	 * @param builderId
	 * @return List<BuilderProject>
	 */
	public List<ProjectList> getBuilderActiveProjectsByBuilder(BuilderEmployee builderEmployee) {
		String hql = "";
		// code by Pradeep Sir
//		if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
//			hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
//				+"project.completion_status as completionStatus,project.inventory_sold as sold, build.id as builderId, "
//				+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
//				+"c.name as cityName, l.id as localityId, l.name as localityName, "
//				+"count(lead.id) as totalLeads "
//				+"FROM  builder_project as project "
//				+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
//				+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id "
//				+"WHERE project.status=1 and project.group_id = "+builderEmployee.getBuilder().getId()+" group by project.id";
//		} else {
//			hql = "SELECT project.id as id, project.name as name, project.status as status,project.revenue as totalRevenu,"
//					+"project.completion_status as completionStatus,project.inventory_sold as sold, build.id as builderId, "
//					+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
//					+"c.name as cityName, l.id as localityId, l.name as localityName, "
//					+"count(lead.id) as totalLeads "
//					+"FROM  builder_project as project inner join allot_project ap ON project.id = ap.project_id "
//					+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
//					+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id "
//					+"WHERE project.status=1 and ap.emp_id = "+builderEmployee.getId()+" group by project.id";
//		}
	//Code by Pankaj	
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
			hql = "SELECT project.id as id, project.name as name, project.image as image, project.locality_name as localityName, project.status as status,project.revenue as totalRevenu,"
				+"project.completion_status as completionStatus,project.inventory_sold as sold, build.id as builderId, "
				+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
				+"c.name as cityName, "
				+"count(lead.id) as totalLeads "
				+"FROM  builder_project as project "
				+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
				+"left join builder_lead as lead ON project.id = lead.project_id "
				+"WHERE project.status=1 and project.group_id = "+builderEmployee.getBuilder().getId()+" group by project.id";
		} else {
			hql = "SELECT project.id as id, project.name as name, project.image as image, project.locality_name as localityName, project.status as status,project.revenue as totalRevenu,"
					+"project.completion_status as completionStatus,project.inventory_sold as sold, build.id as builderId, "
					+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
					+"c.name as cityName, "
					+"count(lead.id) as totalLeads "
					+"FROM  builder_project as project inner join allot_project ap ON project.id = ap.project_id "
					+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
					+"left join builder_lead as lead ON project.id = lead.project_id "
					+"WHERE project.status=1 and ap.emp_id = "+builderEmployee.getId()+" group by project.id";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectList.class));
		List<ProjectList> result = query.list();
		session.close();
		return result;
	}
	
	//To display first 4 active projects on dash board
	/**
	 * Get first 4 active projects by builder id
	 * @author pankaj
	 * @param builderId
	 * @return List<ProjectList>
	 */
	public List<ProjectList> getBuilderFirstFourActiveProjectsByBuilderId(BuilderEmployee builderEmployee) {
		String hql = "";
		//code by Pradeep sir
//		if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
//			hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
//				+"project.completion_status as completionStatus,project.inventory_sold as sold, build.id as builderId, "
//				+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
//				+"c.name as cityName, l.id as localityId, l.name as localityName, "
//				+"count(lead.id) as totalLeads "
//				+"FROM  builder_project as project "
//				+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
//				+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id "
//				+"WHERE project.group_id = "+builderEmployee.getBuilder().getId()+" group by project.id order by project.id desc";
//		} else {
//			hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
//					+"project.completion_status as completionStatus,project.inventory_sold as sold, build.id as builderId, "
//					+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
//					+"c.name as cityName, l.id as localityId, l.name as localityName, "
//					+"count(lead.id) as totalLeads "
//					+"FROM  builder_project as project inner join allot_project ap ON project.id = ap.project_id "
//					+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
//					+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id "
//					+"WHERE ap.emp_id = "+builderEmployee.getId()+" group by project.id order by project.id desc";
//		}
		//code changes done by pankaj
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
			hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
				+"project.completion_status as completionStatus,project.inventory_sold as sold, project.locality_name as localityName, build.id as builderId, "
				+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
				+"c.name as cityName, "
				+"count(lead.id) as totalLeads "
				+"FROM  builder_project as project "
				+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
				+"left join builder_lead as lead ON project.id = lead.project_id "
				+"WHERE project.status=1 and project.group_id = "+builderEmployee.getBuilder().getId()+" group by project.id order by project.id desc";
		} else {
			hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
				+"project.completion_status as completionStatus,project.inventory_sold as sold, project.locality_name as localityName, build.id as builderId, "
				+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
				+"c.name as cityName, "
				+"count(lead.id) as totalLeads "
				+"FROM  builder_project as project inner join allot_project ap ON project.id = ap.project_id "
				+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
				+"left join builder_lead as lead ON project.id = lead.project_id "
				+"WHERE project.status=1 and ap.emp_id = "+builderEmployee.getId()+" group by project.id order by project.id desc";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectList.class));
		System.err.println(hql);
		query.setMaxResults(4);
		List<ProjectList> result = query.list();
		session.close();
		return result;
	}
	

	public ResponseMessage deleteProjectOfferInfo(int id) {
		String hql = "delete from BuilderProjectOfferInfo where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		int result = query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		ResponseMessage resp = new ResponseMessage();
		if(result > 0){
			resp.setStatus(1);;
			resp.setMessage("Project Offer deleted succefully");
		}else{
			resp.setStatus(0);
			resp.setMessage("Fail to deleted project offer");
		}
		return resp;
	}
	
	public List<BuildingList> getBuildingByProjectId(int projectId){
		String hql = "from BuilderBuilding where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		System.out.println("ProjectId ::: :::: :::: :::: "+projectId);
		query.setParameter("projectId", projectId);
		List<BuilderBuilding> building_list = query.list();
		List<BuildingList> buildingList = new ArrayList<BuildingList>();
		for(BuilderBuilding builderBuilding : building_list){
			BuildingList bList = new BuildingList();
			bList.setId(builderBuilding.getId());
			bList.setProjectName(builderBuilding.getName());
			bList.setBuilderName(builderBuilding.getBuilderProject().getBuilder().getName());
			bList.setBuildingName(builderBuilding.getName());
			bList.setStatus(builderBuilding.getStatus());
			buildingList.add(bList);
		}
		return buildingList;
	}
	
	public List<BuilderLead> getBuilderLeadByBuilderId(int builderId){
		String hql = "from BuilderLead where builderProject.builder.id = :builder_id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<BuilderLead> builderLeads = query.list();
		session.close();
		return builderLeads;
	}
	
	public List<LeadList> getBuilderLeadByBuilder(BuilderEmployee builderEmployee){
		
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
			hql = "SELECT lead.id as leadId, lead.name as name, lead.mobile as mobile, lead.email as email, project.name as projectName "
				+"FROM  builder_lead as lead left join builder_project as project ON lead.project_id = project.id "
				+"left join builder as build ON project.group_id = build.id "
				+"WHERE build.id = "+builderEmployee.getBuilder().getId()+" group by lead.id";
		} else {
			hql = "SELECT lead.id as id, lead.name as name, lead.mobile as mobile, lead.email as email, project.name as projectName "
					+"FROM  builder_lead as lead left join builder_project as project ON lead.project_id = project.id inner join allot_project ap ON project.id = ap.project_id "
					+"left join builder as build ON project.group_id = build.id "
					+"WHERE ap.emp_id = "+builderEmployee.getId()+" group by lead.id";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(LeadList.class));
		System.err.println(hql);
		List<LeadList> result = query.list();
		session.close();
		return result;
	}
	
	
	public List<ProjectCityData> getCityareabyproject(int project) {
		String hql = "from BuilderProject where id = :id order by id desc";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", project);
		List<BuilderProject> result = query.list();
		List<ProjectCityData> projects = new ArrayList<ProjectCityData>();
		for(BuilderProject builderproject : result) {
			ProjectCityData newproject = new ProjectCityData();
			newproject.setCityId(builderproject.getCity().getId());
			newproject.setCityName(builderproject.getCity().getName());
			//newproject.setAreaId(builderproject.getLocality().getId());
			//newproject.setAreaName(builderproject.getLocality().getName());
			newproject.setAreaName(builderproject.getLocalityName());
			projects.add(newproject);
		}
		session.close();
		return projects;
	}
	
	public List<BuildingList> getBuildingByBuilderId(int builderId){
		String hql = "from BuilderBuilding where builderProject.builder.id = :builder_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<BuilderBuilding> building_list = query.list();
		List<BuildingList> buildingList = new ArrayList<BuildingList>();
		for(BuilderBuilding builderBuilding : building_list){
			BuildingList bList = new BuildingList();
			bList.setId(builderBuilding.getId());
			bList.setProjectName(builderBuilding.getBuilderProject().getName());
			bList.setBuilderName(builderBuilding.getBuilderProject().getBuilder().getName());
			bList.setBuildingName(builderBuilding.getName());
			bList.setStatus(builderBuilding.getStatus());
			buildingList.add(bList);
		}
		session.close();
		return buildingList;
	}
	
	public List<ProjectData> getProjectsByCityId(int cityId){
		String hql = "from BuilderProject where city.id = :city_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query =session.createQuery(hql);
		query.setParameter("city_id", cityId);
		List<BuilderProject> project_list = query.list();
		List<ProjectData> projectList = new ArrayList<ProjectData>();
		for(BuilderProject builderProject: project_list){
			ProjectData projectData = new ProjectData();
			projectData.setId(builderProject.getId());
			projectData.setName(builderProject.getName());
			projectList.add(projectData);
		}
		session.close();
		return projectList;
	}
	
	public List<ProjectData> getProjectsByLocalityId(int localityId){
		String hql = "from BuilderProject where locality.id = :locality_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query =session.createQuery(hql);
		query.setParameter("locality_id", localityId);
		List<BuilderProject> project_list = query.list();
		List<ProjectData> projectList = new ArrayList<ProjectData>();
		for(BuilderProject builderProject: project_list){
			ProjectData projectData = new ProjectData();
			projectData.setId(builderProject.getId());
			projectData.setName(builderProject.getName());
			projectList.add(projectData);
		}
		session.close();
		return projectList;
	}
	
	public List<BuildingList> getBuildingListFilter(int city_id, int locality_id, int project_id) {
		String hql = "from BuilderBuilding where ";
		String where = "";
		if(city_id > 0) {
			where = where + "builderProject.city.id = :city_id ";
		}
		if(locality_id > 0) {
			if(where != "") {
				where = where + "AND builderProject.locality.id = :locality_id ";
			} else {
				where = where + "builderProject.locality.id = :locality_id ";
			}
		}
		if(project_id > 0) {
			if(where != "") {
				where = where + "AND builderProject.id = :project_id ";
			} else {
				where = where + "builderProject.id = :project_id ";
			}
		}
		hql = hql + where;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		if(city_id > 0) {
			query.setParameter("city_id", city_id);
		}
		if(locality_id > 0) {
			query.setParameter("locality_id", locality_id);
		}
		List<BuilderBuilding> result = query.list();
		List<BuildingList> buildingList = new ArrayList<BuildingList>();
		for(BuilderBuilding builderBuilding : result) {
			BuildingList buildingLists = new BuildingList();
			buildingLists.setId(builderBuilding.getId());
			buildingLists.setBuildingName(builderBuilding.getName());
			buildingLists.setProjectName(builderBuilding.getBuilderProject().getName());
			buildingLists.setBuilderName(builderBuilding.getBuilderProject().getBuilder().getName());
			buildingLists.setStatus(builderBuilding.getStatus());
			buildingList.add(buildingLists);
		}
		session.close();
		return buildingList;
	}
	
	public List<ProjectData> getProjectsByBuilderId(int builderId){
		String hql = "from BuilderProject where builder.id = :builder_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<BuilderProject> projectList = query.list();
		List<ProjectData> projectDataList = new ArrayList<ProjectData>();
		for(BuilderProject builderProject : projectList){
			ProjectData projectData = new ProjectData();
			projectData.setId(builderProject.getId());
			projectData.setName(builderProject.getName());
			projectDataList.add(projectData);
		}
		session.close();
		return projectDataList;
	}
	/**
	 * Get all active project list by builder id
	 * @author pankaj
	 * @param builderId
	 * @return List<ProjectData>
	 */
	public List<ProjectData> getActiveProjectsByBuilderId(int builderId){
		String hql = "from BuilderProject where builder.id = :builder_id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<BuilderProject> projectList = query.list();
		List<ProjectData> projectDataList = new ArrayList<ProjectData>();
		for(BuilderProject builderProject : projectList){
			ProjectData projectData = new ProjectData();
			projectData.setId(builderProject.getId());
			projectData.setName(builderProject.getName());
			projectDataList.add(projectData);
		}
		session.close();
		return projectDataList;
	}
	
	public List<ProjectData> getActiveProjectsByBuilderEmployees(BuilderEmployee builderEmployee){
	    
	    String hql = "";
	    if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
	      hql = "SELECT project.id as id, project.name as name "
	        +"FROM  builder_project as project "
	        +"left join builder as build ON project.group_id = build.id "
	        +"WHERE build.id = "+builderEmployee.getBuilder().getId()+" and project.status=1 group by project.id";
	    } else {
	      hql = "SELECT project.id as id, project.name as name "
	          +"FROM  builder_project as project inner join allot_project ap ON project.id = ap.project_id "
	          +"left join builder as build ON project.group_id = build.id "
	          +"WHERE ap.emp_id = "+builderEmployee.getId()+" group by project.id";
	    }
	    HibernateUtil hibernateUtil = new HibernateUtil();
	    Session session = hibernateUtil.getSessionFactory().openSession();
	    Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectData.class));
	    System.err.println(hql);
	   // query.setMaxResults(4);
	    List<ProjectData> result = query.list();
	    session.close();
	    return result;
	  }
	/**
	 * Get assign projects by passing employee object.
	 * @param builderEmployee
	 * @return List<ProjectData>
	 */
	public List<ProjectData> getAssigProjects(BuilderEmployee builderEmployee){
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
			
		}else{
			hql="SELECT project.name as name, emp.id as id from builder_project as project "
					+ "inner join allot_project as ap on ap.project_id = project.id "
					+ "left join builder_employee as emp on emp.id = ap.emp_id"
					+ " where "
					+ "project.status=1 and emp.id<>"+builderEmployee.getId();
		}
		 HibernateUtil hibernateUtil = new HibernateUtil();
		    Session session = hibernateUtil.getSessionFactory().openSession();
		    Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectData.class));
		    System.err.println(hql);
		   // query.setMaxResults(4);
		    List<ProjectData> result = query.list();
		    session.close();
		    return result;
	}
	public List<BuilderBuilding> getBuildingsByBuilderId(int builder_id) {
		String hql = "from BuilderBuilding where builderProject.builder.id = :builder_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builder_id);
		List<BuilderBuilding> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all active buildings by builder id
	 * @author pankaj
	 * @param builder_id
	 * @return List<BuilderBuilding>
	 */
	public List<BuilderBuilding> getActiveBuildingsByBuilderId(int builder_id) {
		String hql = "from BuilderBuilding where builderProject.builder.id = :builder_id and builderProject.status=1 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builder_id);
		List<BuilderBuilding> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuildingPojo> getActiveBuildingsByBuilder(BuilderEmployee builderEmployee) {
		
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2) {
			hql = "select a.id as id, a.project_id as projectId,a.name as name,a.emp_id as empId,a.total_floor as totalFloor,a.status_id as statusId, a.amenity_weightage as amenityWeightage,a.floor_weightage as floorWeightage, a.weightage as weightage, a.launch_date as launchDate, a.possession_date as possessionDate, a.total_inventory as totalInventory, a.inventory_sold as inventorySold, a.revenue as revenue, a.completion_status as completionStatus, a.status as status,c.name as projectName,d.name as buildingStatus,e.name as builderName from builder_building as a inner join alloted_project as b on a.project_id = b.project_id inner join builder_project as c on a.project_id=c.id inner join builder_building_status as d on a.status_id=d.id inner join builder as e on c.group_id = e.id where b.emp_id = "+builderEmployee.getId()+" and c.status=1 and a.status=1";
		} else {
			hql = "select a.id as id, a.project_id as projectId,a.name as name,a.emp_id as empId,a.total_floor as totalFloor,a.status_id as statusId, a.amenity_weightage as amenityWeightage,a.floor_weightage as floorWeightage, a.weightage as weightage, a.launch_date as launchDate, a.possession_date as possessionDate, a.total_inventory as totalInventory, a.inventory_sold as inventorySold, a.revenue as revenue, a.completion_status as completionStatus, a.status as status,b.name as projectName,d.name as buildingStatus,e.name as builderName from builder_building as a inner join builder_project as b on a.project_id = b.id inner join builder_building_status as d on a.status_id=d.id inner join builder as e on b.group_id = e.id where b.group_id = "+builderEmployee.getBuilder().getId()+" and b.status=1 and b.status=1";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuildingPojo.class));
		List<BuildingPojo> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderFloor> getAllFloorsByBuilderId(int builderId) {
		String hql = "from BuilderFloor where builderBuilding.builderProject.builder.id = :builder_id order by builderBuilding.builderProject.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id",builderId);
		List<BuilderFloor> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all active floor by builder id
	 * @author pankaj
	 * @param builderId
	 * @return List<BuilderFloor>
	 */
	public List<BuilderFloor> getAllActiveFloorsByBuilderId(int builderId) {
		String hql = "from BuilderFloor where builderBuilding.builderProject.builder.id = :builder_id and builderBuilding.status=1 and builderBuilding.builderProject.status=1 and status=1 order by builderBuilding.builderProject.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id",builderId);
		List<BuilderFloor> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderFlat> getBuilderAllFlatsByBuilderId(int builderId) {
		String hql = "from BuilderFlat where builderFloor.builderBuilding.builderProject.builder.id = :builder_id and builderFloor.status=1 and builderFloor.builderBuilding.status=1 and builderFloor.builderBuilding.builderProject.status=1 and status=1 order by builderFloor.builderBuilding.builderProject.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<BuilderFlat> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all active flats by builder id
	 * @author pankaj
	 * @param builderId
	 * @return List<BuilderFlat>
	 */
	public List<BuilderFlat> getBuilderAllActiveFlatsByBuilderId(int builderId) {
		String hql = "from BuilderFlat where builderFloor.builderBuilding.builderProject.builder.id = :builder_id and status=1 order by builderFloor.builderBuilding.builderProject.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<BuilderFlat> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get new project list added by builder
	 * @author pankaj
	 * @return List<NewProjectList>
	 */
	public List<NewProjectList> getNewProjectList(){
		String hql = "from NewProject";
		List<NewProjectList> newProjectLists = new ArrayList<NewProjectList>();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<NewProject> newProjects = query.list();
		if(newProjects != null){
			for(NewProject newProject : newProjects){
				NewProjectList newProjectList = new NewProjectList();
				newProjectList.setBuilderName(newProject.getBuilder().getName());
				newProjectList.setProjectName(newProject.getName());
				newProjectList.setContactNumber(newProject.getBuilder().getMobile());
				newProjectList.setEmail(newProject.getBuilder().getEmail());
				newProjectList.setLocalityName(newProject.getLocality().getName());
				newProjectLists.add(newProjectList);
			}
		}
		session.close();
		return newProjectLists;
		
	}
	//To display total inventory on dash board
	/**
	 * Get total number of inventory by builder id
	 * @author pankaj
	 * @param builderId
	 * @return total number of inventory(Flats)
	 */
	public Long getTotalInventory(BuilderEmployee builderEmployee){
		Long totalInventory= (long) 0;
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <=3|| builderEmployee.getBuilderEmployeeAccessType().getId()==6){
			totalInventory = getTotalFlatsByBuilderId(builderEmployee.getBuilder().getId());
		}
		if(builderEmployee.getBuilderEmployeeAccessType().getId() ==4 || builderEmployee.getBuilderEmployeeAccessType().getId() ==5 || builderEmployee.getBuilderEmployeeAccessType().getId()==7 ){
			totalInventory = getTotalFlatsByEmpId(builderEmployee.getId());
		}
			return totalInventory;
	}
	
		public Long getTotalFlatsByBuilderId(int builderId){
			String hql = "select COUNT(*) from BuilderFlat where builderFloor.builderBuilding.builderProject.builder.id = :builder_id and  builderFlatStatus.id=2 and status = 1";
		
			Long totalInventory= (long) 0;
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setInteger("builder_id", builderId);
			totalInventory = (Long) query.uniqueResult();
			if(totalInventory != null){
				return totalInventory;
			}else{
				return (long)0;
			}
		}
		
		public Long getTotalFlatsByEmpId(int empId){
			Long totalBuyers = (long)0;
			String sql = "Select count(flat.id) from builder_flat as flat join builder_floor as floor on flat.floor_no = floor.id join builder_building as building on floor.building_id = building.id join builder_project as project on building.project_id = project.id join allot_project as ap on project.id=ap.project_id where flat.status_id=2 and ap.emp_id = :emp_id";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createSQLQuery(sql);
			query.setParameter("emp_id", empId);
			BigInteger totalBuyer = (BigInteger) query.uniqueResult();
			try{
			if(totalBuyer != null){
				totalBuyers = Long.parseLong(totalBuyer.toString());
				return totalBuyers;
			}else{
				return (long)0;
			}
			}catch(Exception e){
				e.printStackTrace();
				return (long)0;
			}
		}
	/* **************************** Stages / Substages **************************** */
	
	public List<ProjectWeightage> getProjectWeightage(int project_id) {
		String hql = "from ProjectWeightage where builderProject.id = :project_id order by projectStage.id ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<ProjectWeightage> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage updateProjectSubstage(ProjectWeightageData projectWeightageData) {
		ResponseMessage response = new ResponseMessage();
		int project_id = projectWeightageData.getProjectId();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		String hql = "delete from ProjectWeightage where builderProject.id = :id";
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", project_id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		for(ProjectWeightage projectWeightage :projectWeightageData.getProjectWeightages()) {
			session1.save(projectWeightage);
		}
		session1.getTransaction().commit();
		session1.close();
		response.setStatus(1);
		response.setMessage("Project substage updated successfully");
		return response;
	}
	
	public List<BuildingWeightage> getBuildingWeightage(int building_id) {
		String hql = "from BuildingWeightage where builderBuilding.id = :building_id order by buildingStage.id ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingWeightage> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage updateBuildingSubstage(BuildingWeightageData buildingWeightageData) {
		
		BuilderBuilding builderBuilding = buildingWeightageData.getBuilderBuilding();
		BuilderBuilding builderBuilding2 = getBuilderProjectBuildingById(builderBuilding.getId()).get(0);
		
		builderBuilding2.setAmenityWeightage(builderBuilding.getAmenityWeightage());
		builderBuilding2.setFloorWeightage(builderBuilding.getFloorWeightage());
		updateBuilding(builderBuilding2);
		
		List<BuilderFloor> floors = buildingWeightageData.getBuilderFloors();
		if(floors != null){
			for(BuilderFloor floor : floors){
			 BuilderFloor builderFloor2 =getBuildingActiveFloorById(floor.getId()).get(0);
			 builderFloor2.setWeightage(floor.getWeightage());
			 updateFloors(builderFloor2);
			}
		}
		ResponseMessage response = new ResponseMessage();
		int building_id = buildingWeightageData.getBuildingId();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		String hql = "delete from BuildingWeightage where builderBuilding.id = :id";
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", building_id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		for(BuildingWeightage buildingWeightage :buildingWeightageData.getBuildingWeightages()) {
			session1.save(buildingWeightage);
		}
		session1.getTransaction().commit();
		session1.close();
		response.setStatus(1);
		response.setMessage("Building substage updated successfully");
		return response;
	}
	
	public void updateFloors(BuilderFloor builderFloor){
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.update(builderFloor);
		session.getTransaction().commit();
		session.close();
	}
	
	public List<FloorWeightage> getFloorWeightage(int floor_id) {
		String hql = "from FloorWeightage where builderFloor.id = :floor_id order by floorStage.id ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("floor_id", floor_id);
		List<FloorWeightage> result = query.list();
		session.close();
		return result;
	}
	
//	public ResponseMessage updateFloorSubstage(FloorWeightageData floorWeightageData) {
//		ResponseMessage response = new ResponseMessage();
//		int floor_id = floorWeightageData.getFloorId();
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		Session session = hibernateUtil.openSession();
//		String hql = "delete from FloorWeightage where builderFloor.id = :id";
//		session.beginTransaction();
//		Query query = session.createQuery(hql);
//		query.setParameter("id", floor_id);
//		query.executeUpdate();
//		session.getTransaction().commit();
//		session.close();
//		Session session1 = hibernateUtil.openSession();
//		session1.beginTransaction();
//		for(FloorWeightage floorWeightage :floorWeightageData.getFloorWeightages()) {
//			session1.save(floorWeightage);
//		}
//		session1.getTransaction().commit();
//		session1.close();
//		response.setStatus(1);
//		response.setMessage("Floor substage updated successfully");
//		return response;
//	}
//	
	public ResponseMessage updateFloorAmenity(FloorWeightageData floorWeightageData) {
		
		BuilderFloor builderFloor = floorWeightageData.getBuilderFloor();
		BuilderFloor builderFloor2  =getBuildingActiveFloorById(builderFloor.getId()).get(0);
		builderFloor2.setAmenityWeightage(builderFloor.getAmenityWeightage());
		builderFloor2.setFlatWeightage(builderFloor.getFlatWeightage());
		updateBuildingFloor(builderFloor2);
		
		List<BuilderFlat> builderFlats = floorWeightageData.getBuilderFlats();
		if(builderFlats != null){
			for(BuilderFlat builderFlat : builderFlats){
				BuilderFlat builderFlat2 = getBuilderFlatById(builderFlat.getId());
				builderFlat2.setWeightage(builderFlat.getWeightage());
				updateBuildingFlat(builderFlat2);
			}
		}
		
		ResponseMessage response = new ResponseMessage();
		int floor_id = floorWeightageData.getFloorId();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		String hql = "delete from FloorWeightage where builderFloor.id = :id";
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", floor_id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		for(FloorWeightage floorWeightage :floorWeightageData.getFloorWeightages()) {
			session1.save(floorWeightage);
		}
		session1.getTransaction().commit();
		session1.close();
		response.setStatus(1);
		response.setMessage("Floor substage updated successfully");
		return response;
	}
	
	public List<FlatWeightage> getFlatWeightage(int flat_id) {
		String hql = "from FlatWeightage where builderFlat.id = :flat_id order by flatStage.id ASC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flat_id);
		List<FlatWeightage> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage updateFlatSubstage(FlatWeightageData flatWeightageData) {
		ResponseMessage response = new ResponseMessage();
		int flat_id = flatWeightageData.getFlatId();
		BuilderFlat builderFlat = getBuilderFlatById(flat_id);
		builderFlat.setAmenityWeightage(flatWeightageData.getAmenityWeightage());
		updateBuildingFlat(builderFlat);
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		String hql = "delete from FlatWeightage where builderFlat.id = :id";
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", flat_id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		for(FlatWeightage flatWeightage :flatWeightageData.getFlatWeightages()) {
			session1.save(flatWeightage);
		}
		session1.getTransaction().commit();
		session1.close();
		response.setStatus(1);
		response.setMessage("Flat substage updated successfully");
		return response;
	}
	
	public ResponseMessage updateProjectWeightageStatus(List<ProjectWeightage> projectWeightages, int project_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE ProjectWeightage set status = 0 where builderProject.id = :project_id";
		Query query1 = session1.createQuery(hql1);
		query1.setParameter("project_id", project_id);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		Session session = hibernateUtil.openSession();
		for(ProjectWeightage projectWeightage :projectWeightages) {
			session.beginTransaction();
			String hql = "UPDATE ProjectWeightage set status=1 where id = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", projectWeightage.getId());
			query.executeUpdate();
			session.getTransaction().commit();
		}
		session.close();
		resp.setMessage("Project stage status updated.");
		resp.setStatus(1);
		updateProjectCompletion(project_id);
		return resp;
	}
	
	public ResponseMessage updateBuildingWeightageStatus(List<BuildingWeightage> buildingWeightages, int building_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE BuildingWeightage set status = 0 where builderBuilding.id = :building_id";
		Query query1 = session1.createQuery(hql1);
		query1.setParameter("building_id", building_id);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		Session session = hibernateUtil.openSession();
		for(BuildingWeightage buildingWeightage :buildingWeightages) {
			session.beginTransaction();
			String hql = "UPDATE BuildingWeightage set status=1 where id = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", buildingWeightage.getId());
			query.executeUpdate();
			session.getTransaction().commit();
		}
		session.close();
		resp.setMessage("Building stage status updated.");
		resp.setStatus(1);
		updateBuildingCompletion(building_id);
		return resp;
	}
	
	public ResponseMessage updateFloorWeightageStatus(List<FloorWeightage> floorWeightages, int floor_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE FloorWeightage set status = 0 where builderFloor.id = :floor_id";
		Query query1 = session1.createQuery(hql1);
		query1.setParameter("floor_id", floor_id);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		Session session = hibernateUtil.openSession();
		for(FloorWeightage floorWeightage :floorWeightages) {
			session.beginTransaction();
			String hql = "UPDATE FloorWeightage set status=1 where id = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", floorWeightage.getId());
			query.executeUpdate();
			session.getTransaction().commit();
		}
		session.close();
		resp.setMessage("Floor stage status updated.");
		resp.setStatus(1);
		updateFloorCompletion(floor_id);
		return resp;
	}
	
	public ResponseMessage updateFlatWeightageStatus(List<FlatWeightage> flatWeightages, int flat_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE FlatWeightage set status = 0 where builderFlat.id = :flat_id";
		Query query1 = session1.createQuery(hql1);
		query1.setParameter("flat_id", flat_id);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		Session session = hibernateUtil.openSession();
		for(FlatWeightage flatWeightage :flatWeightages) {
			session.beginTransaction();
			String hql = "UPDATE FlatWeightage set status=1 where id = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", flatWeightage.getId());
			query.executeUpdate();
			session.getTransaction().commit();
		}
		session.close();
		resp.setMessage("Flat stage status updated.");
		resp.setStatus(1);
		updateFlatCompletion(flat_id);
		return resp;
	}
	
	public ResponseMessage updateFlatCompletion(int flat_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String newhql = "from BuilderFlat where id = :flat_id";
		Session newsession = hibernateUtil.openSession();
		Query newquery = newsession.createQuery(newhql);
		newquery.setParameter("flat_id", flat_id);
		List<BuilderFlat> resultnew = newquery.list();
		System.err.println("Builder flat :: "+resultnew.size());
		newsession.close();
		String hql = "SELECT a.stage_id as stageId,a.stage_weightage as stageWeight,sum(IF(a.status=1,a.substage_weightage,0.0)) as totalSubstageWeight from flat_weightage as a where a.flat_id = "+flat_id+" group by a.stage_id";
		System.err.println(hql);
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.setResultTransformer(Transformers.aliasToBean(FlatTotal.class));
		List<FlatTotal> resultRaw = query.list();
		System.err.println("Flat total :: "+resultRaw.size());
		session.close();
		Double finalWeightage = 0.0;
		Double percent = 100.00;
		for(FlatTotal flatTotal :resultRaw) {
			finalWeightage += (flatTotal.getTotalSubstageWeight()/percent*flatTotal.getStageWeight());
		}
		System.err.println("Final weightage :: "+finalWeightage);
		String hql2 = "SELECT a.amenity_id as amenityId,a.amenity_weightage as amenityWeightage,sum(IF(a.status=1,a.substage_weightage,0)*a.stage_weightage/100) as totalSubstageWeightage from flat_amenity_weightage as a where a.flat_id = "+flat_id+" group by a.amenity_id";
		Session session2 = hibernateUtil.getSessionFactory().openSession();
		Query query2 = session2.createSQLQuery(hql2).setResultTransformer(Transformers.aliasToBean(FlatAmenityTotal.class));
		List<FlatAmenityTotal> resultRaw2 = query2.list();
		session2.close();
		Double amenity_weightage = 0.0;
		for(FlatAmenityTotal flatAmenityTotal :resultRaw2) {
			amenity_weightage += (flatAmenityTotal.getTotalSubstageWeightage()*flatAmenityTotal.getAmenityWeightage()/percent);
		}
		amenity_weightage = amenity_weightage * resultnew.get(0).getAmenityWeightage()/100;
		finalWeightage = finalWeightage + amenity_weightage;
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE BuilderFlat set completionStatus = "+finalWeightage+" where id = "+flat_id;
		Query query1 = session1.createQuery(hql1);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		resp.setMessage(finalWeightage.toString());
		return resp;
	}
	
	public ResponseMessage updateFloorCompletion(int floor_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String newhql = "from BuilderFloor where id = :floor_id";
		Session newsession = hibernateUtil.openSession();
		Query newquery = newsession.createQuery(newhql);
		newquery.setParameter("floor_id", floor_id);
		List<BuilderFloor> resultnew = newquery.list();
		System.err.println("builderFloor size :: "+resultnew.size());
		newsession.close();
		String flathql = "SELECT sum(a.completion_status*a.weightage/100) as completionStatus from builder_flat as a where a.floor_no = :floor_id";
		Session flatsession = hibernateUtil.getSessionFactory().openSession();
		Query flatquery = flatsession.createSQLQuery(flathql)
				.setResultTransformer(Transformers.aliasToBean(BuilderCompletionStatus.class));
		flatquery.setParameter("floor_id", floor_id);
		List<BuilderCompletionStatus> flatresult = flatquery.list();
		System.err.println("Building Completion status :: "+flatresult.size());
		flatsession.close();
		String hql = "SELECT a.stage_id as stageId,a.stage_weightage as stageWeight,sum(IF(a.status=1,a.substage_weightage,0.0)) as totalSubstageWeight from floor_weightage as a where a.floor_id = "+floor_id+" group by a.stage_id";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.setResultTransformer(Transformers.aliasToBean(FlatTotal.class));
		List<FlatTotal> resultRaw = query.list();
		System.err.println("Flat total :: "+resultRaw.size());
		session.close();
		Double finalWeightage = 0.0;
		Double percent = 100.00;
		Double flatWeightage = flatresult.get(0).getCompletionStatus()*resultnew.get(0).getFlatWeightage()/percent;
		for(FlatTotal flatTotal :resultRaw) {
			finalWeightage += (flatTotal.getTotalSubstageWeight()*flatTotal.getStageWeight()/percent);
		}
		String hql2 = "SELECT a.amenity_id as amenityId,a.amenity_weightage as amenityWeightage,sum(IF(a.status=1,a.substage_weightage,0)*a.stage_weightage/100) as totalSubstageWeightage from floor_amenity_weightage as a where a.floor_id = "+floor_id+" group by a.amenity_id";
		Session session2 = hibernateUtil.getSessionFactory().openSession();
		Query query2 = session2.createSQLQuery(hql2).setResultTransformer(Transformers.aliasToBean(FlatAmenityTotal.class));
		List<FlatAmenityTotal> resultRaw2 = query2.list();
		System.err.println("Flat Amenity total :: "+resultRaw2.size());
		session2.close();
		Double amenity_weightage = 0.0;
		for(FlatAmenityTotal flatAmenityTotal :resultRaw2) {
			amenity_weightage += (flatAmenityTotal.getTotalSubstageWeightage()*flatAmenityTotal.getAmenityWeightage()/percent);
		}
		amenity_weightage = amenity_weightage * resultnew.get(0).getAmenityWeightage()/100;
		finalWeightage = finalWeightage + amenity_weightage + flatWeightage;
		System.err.println("Final Weightage :: "+finalWeightage+" floor id :: "+floor_id);
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE BuilderFloor set completionStatus = "+finalWeightage+" where id = "+floor_id;
		Query query1 = session1.createQuery(hql1);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		resp.setMessage(finalWeightage.toString());
		return resp;
	}
	
	public ResponseMessage updateBuildingCompletion(int building_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String newhql = "from BuilderBuilding where id = :building_id";
		Session newsession = hibernateUtil.openSession();
		Query newquery = newsession.createQuery(newhql);
		newquery.setParameter("building_id", building_id);
		List<BuilderBuilding> resultnew = newquery.list();
		newsession.close();
		String flathql = "SELECT sum(a.completion_status*a.weightage/100) as completionStatus from builder_floor as a where a.building_id = :building_id";
		Session flatsession = hibernateUtil.getSessionFactory().openSession();
		Query flatquery = flatsession.createSQLQuery(flathql)
				.setResultTransformer(Transformers.aliasToBean(BuilderCompletionStatus.class));
		flatquery.setParameter("building_id", building_id);
		List<BuilderCompletionStatus> flatresult = flatquery.list();
		flatsession.close();
		String hql = "SELECT a.stage_id as stageId,a.stage_weightage as stageWeight,sum(IF(a.status=1,a.substage_weightage,0.0)) as totalSubstageWeight from building_weightage as a where a.building_id = "+building_id+" group by a.stage_id";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.setResultTransformer(Transformers.aliasToBean(FlatTotal.class));
		List<FlatTotal> resultRaw = query.list();
		session.close();
		Double finalWeightage = 0.0;
		Double percent = 100.00;
		
		Double flatWeightage = 0.0;
		if(flatresult.get(0).getCompletionStatus() != null)
		flatWeightage = flatresult.get(0).getCompletionStatus()*resultnew.get(0).getFloorWeightage()/percent;
		for(FlatTotal flatTotal :resultRaw) {
			finalWeightage += (flatTotal.getTotalSubstageWeight()/percent*flatTotal.getStageWeight());
		}
		String hql2 = "SELECT a.amenity_id as amenityId,a.amenity_weightage as amenityWeightage,sum(IF(a.status=1,a.substage_weightage,0)*a.stage_weightage/100) as totalSubstageWeightage from building_amenity_weightage as a where a.building_id = "+building_id+" group by a.amenity_id";
		Session session2 = hibernateUtil.getSessionFactory().openSession();
		Query query2 = session2.createSQLQuery(hql2).setResultTransformer(Transformers.aliasToBean(FlatAmenityTotal.class));
		List<FlatAmenityTotal> resultRaw2 = query2.list();
		session2.close();
		Double amenity_weightage = 0.0;
		for(FlatAmenityTotal flatAmenityTotal :resultRaw2) {
			amenity_weightage += (flatAmenityTotal.getTotalSubstageWeightage()*flatAmenityTotal.getAmenityWeightage()/percent);
		}
		amenity_weightage = amenity_weightage * resultnew.get(0).getAmenityWeightage()/100;
		finalWeightage = finalWeightage + amenity_weightage + flatWeightage;
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE BuilderBuilding set completionStatus = "+finalWeightage+" where id = "+building_id;
		Query query1 = session1.createQuery(hql1);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		resp.setMessage(finalWeightage.toString());
		return resp;
	}
	
	public ResponseMessage updateProjectCompletion(int project_id) {
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String newhql = "from BuilderProject where id = :project_id";
		Session newsession = hibernateUtil.openSession();
		Query newquery = newsession.createQuery(newhql);
		newquery.setParameter("project_id", project_id);
		List<BuilderProject> resultnew = newquery.list();
		newsession.close();
		String flathql = "SELECT sum(a.completion_status*a.weightage/100) as completionStatus from builder_building as a where a.project_id = :project_id";
		Session flatsession = hibernateUtil.getSessionFactory().openSession();
		Query flatquery = flatsession.createSQLQuery(flathql)
				.setResultTransformer(Transformers.aliasToBean(BuilderCompletionStatus.class));
		flatquery.setParameter("project_id", project_id);
		List<BuilderCompletionStatus> flatresult = flatquery.list();
		flatsession.close();
		/*String hql = "SELECT a.stage_id as stageId,a.stage_weightage as stageWeight,sum(IF(a.status=1,a.substage_weightage,0.0)) as totalSubstageWeight from project_weightage as a where a.project_id = "+project_id+" group by a.stage_id";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.setResultTransformer(Transformers.aliasToBean(FlatTotal.class));
		List<FlatTotal> resultRaw = query.list();
		session.close();*/
		Double finalWeightage = 0.0;
		Double percent = 100.00;
		Double flatWeightage = flatresult.get(0).getCompletionStatus()*resultnew.get(0).getBuildingWeightage()/percent;
		System.out.println("Percentage:"+flatWeightage);
		/*for(FlatTotal flatTotal :resultRaw) {
			finalWeightage += (flatTotal.getTotalSubstageWeight()/percent*flatTotal.getStageWeight());
		}*/
		String hql2 = "SELECT a.amenity_id as amenityId,a.amenity_weightage as amenityWeightage,sum(IF(a.status=1,a.substage_weightage,0)*a.stage_weightage/100) as totalSubstageWeightage from project_amenity_weightage as a where a.project_id = "+project_id+" group by a.amenity_id";
		Session session2 = hibernateUtil.getSessionFactory().openSession();
		Query query2 = session2.createSQLQuery(hql2).setResultTransformer(Transformers.aliasToBean(FlatAmenityTotal.class));
		List<FlatAmenityTotal> resultRaw2 = query2.list();
		session2.close();
		Double amenity_weightage = 0.0;
		for(FlatAmenityTotal flatAmenityTotal :resultRaw2) {
			amenity_weightage += (flatAmenityTotal.getTotalSubstageWeightage()*flatAmenityTotal.getAmenityWeightage()/percent);
		}
		amenity_weightage = amenity_weightage * resultnew.get(0).getAmenityWeightage()/100;
		finalWeightage = (double) Math.round(finalWeightage + amenity_weightage + flatWeightage);
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		String hql1 = "UPDATE BuilderProject set completionStatus = "+finalWeightage+" where id = "+project_id;
		Query query1 = session1.createQuery(hql1);
		query1.executeUpdate();
		session1.getTransaction().commit();
		session1.close();
		resp.setMessage(finalWeightage.toString());
		return resp;
	}
	
	/**
	 * Get active flats by project id
	 * @author pankaj
	 * @return List<BuilderFlat>
	 */
	public List<BuilderFlat> getActiveFlatsByProjectId(int projectId){
		String hql = "from BuilderFlat where builderFloor.builderBuilding.builderProject.id = :project_id and builderFlatStatus.id = 1 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderFlat> builderFlatList = query.list();
		return builderFlatList;
		
	}
	/**
	 * Get flat payment by flat id
	 * @author pankaj
	 * @param flatId
	 * @return List<FlatPayment>
	 */
//	public List<FlatPayment> getFlatPaymentByFlatId(int flatId){
//		String hql = "from BuilderFlat where id = :flat_id";
//		String payment = "from BuildingPaymentInfo where builderBuilding.id = :building_id" ;
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		Session session = hibernateUtil.openSession();
//		Query query = session.createQuery(hql);
//		query.setParameter("flat_id",flatId);
//		BuilderFlat builderFlat = (BuilderFlat) query.list().get(0);
//		Session paymentSession = hibernateUtil.openSession();
//		Query paymentQuery = paymentSession.createQuery(payment);
//		paymentQuery.setParameter("building_id", builderFlat.getBuilderFloor().getBuilderBuilding().getId());
//		List<BuildingPaymentInfo> buildingPaymentInfos = paymentQuery.list();
//		List<FlatPayment> flatPaymentList = new ArrayList<FlatPayment>();
//		for(BuildingPaymentInfo buildingPaymentInfo :buildingPaymentInfos ){
//			FlatPayment flatPayment = new FlatPayment();
//			flatPayment.setMilestone(buildingPaymentInfo.getMilestone());
//			flatPayment.setPayable(buildingPaymentInfo.getPayable());
//			flatPayment.setAmount(buildingPaymentInfo.getAmount());
//			flatPaymentList.add(flatPayment);
//		}
//		if(flatPaymentList != null)
//			return flatPaymentList;
//		else
//			return null;
//	}
	
	 public List<FlatPaymentSchedule> getFlatPaymentByFlatId(int flatId){
		 String hql ="from FlatPaymentSchedule where builderFlat.id = :flat_id";
		 HibernateUtil hibernateUtil = new HibernateUtil();
		 Session session = hibernateUtil.openSession();
		 Query query = session.createQuery(hql);
		 query.setParameter("flat_id", flatId);
		 List<FlatPaymentSchedule> result = query.list();
		 return result;
		 
	 }
	/**
	 * Get total leads by builder id
	 * @author pankaj
	 * @param builder_id
	 * @return totalLeads
	 */
	public Long getTotalLeads(BuilderEmployee builderEmployee){
		Long totalLeads =(long) 0;
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2){
			totalLeads = getTotalLeadsByBuilderId(builderEmployee.getBuilder().getId());
		}if((builderEmployee.getBuilderEmployeeAccessType().getId() >=3 && builderEmployee.getBuilderEmployeeAccessType().getId() <= 6) || builderEmployee.getBuilderEmployeeAccessType().getId() ==7){
			totalLeads = getTotalLeadsByEmployeeId(builderEmployee.getId());
		}
		return totalLeads;
	}
	/**
	 * @author pankaj
	 * @param builderId
	 * @return
	 */
	public Long getTotalLeadsByBuilderId(int builderId){
		Long totalLeads =(long) 0;
		String hql = "Select COUNT(*) from BuilderLead where builderProject.builder.id = :builder_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		totalLeads = (Long) query.uniqueResult();
		if(totalLeads != null){
			return totalLeads;
		}else{
			return (long)0;
		}
	}
	
	/**
	 * @author pankaj 
	 * @param empId
	 * @return
	 */
	public Long getTotalLeadsByEmpId(int empId){
		Long totalLeads =(long) 0;
		String hql = "Select COUNT(bl.id) from builder_lead as bl left join allot_leads as al on bl.id = al.lead_id where al.emp_id = :emp_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(hql);
		query.setParameter("emp_id", empId);
		BigInteger totalLead = (BigInteger) query.uniqueResult();
		if(totalLeads != null){
			totalLeads = Long.parseLong(totalLead.toString());
			return totalLeads;
		}else{
			return (long)0;
		}
	}
	/**
	 * Get total number of active project's count by builder id
	 * @author pankaj
	 * @param builder_id
	 * @return total number of project count
	 */
	public Long getTotalNumberOfProjects(BuilderEmployee builderEmployee){
		Long totalProjects =(long) 0;
		if(builderEmployee.getBuilderEmployeeAccessType().getId() >2){
			totalProjects = getTotalNumberOfProjectsByEmpId(builderEmployee.getId());
		}else{
			totalProjects = getTotalNumberOfProjectsByBuilderId(builderEmployee.getBuilder().getId());
		}
		return totalProjects;
	}
	
	public Long getTotalNumberOfProjectsByBuilderId(int builderId){
		Long totalProjects =(long) 0;
		String hql = "Select COUNT(*) from BuilderProject where builder.id = :builder_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		totalProjects = (Long) query.uniqueResult();
		if(totalProjects != null){
			return totalProjects;
		}else{
			return (long)0;
		}
	}
	
	
	public Long getTotalNumberOfProjectsByEmpId(int empId){
		Long totalProjects =(long) 0;
		String hql = "Select COUNT(project.id) from builder_project as project left join allot_project as ap on ap.project_id = project.id where ap.emp_id = :emp_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(hql);
		query.setParameter("emp_id", empId);
		BigInteger totalProject = (BigInteger) query.uniqueResult();
		if(totalProjects != null){
			totalProjects = Long.parseLong(totalProject.toString());
			return totalProjects;
		}else{
			return (long)0;
		}
	}
	/**
	 * Get Total leads by builder id
	 * @author pankaj
	 * @param projectId
	 * @return
	 */
	
	public BigInteger getTotalLeadsByProjectId(int projectId){
		Long totalLeads =(long) 0;
		String hql = "Select COUNT(*) from BuilderLead where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		totalLeads = (Long) query.uniqueResult();
		BigInteger bigInteger = BigInteger.valueOf(totalLeads);
		return bigInteger;
	}
	/**
	 * Get total sold flat count for all projects by builder id
	 * @author pankaj
	 * @param builderId
	 * @return Long
	 */
	public Long getTotalSoldInventory(BuilderEmployee builderEmployee){
		Long totalSoldInventory =(long)0;
		int access_id = builderEmployee.getBuilderEmployeeAccessType().getId();
		String hql = "";
		//if(access_id >= 1 && access_id <= 2)
			 hql ="Select COUNT(*) from BuilderFlat where builderFloor.builderBuilding.builderProject.builder.id = :builder_id and builderFlatStatus.id=2";
		//if(access_id == 4 || access_id ==5 || access_id==6)
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderEmployee.getBuilder().getId());
		totalSoldInventory = (Long) query.uniqueResult();
		if(totalSoldInventory != null){
			return totalSoldInventory;
		}else{
			return (long)0;
		}
	}
	
	
	/**
	 * 
	 * @author pankaj
	 * @param builderId
	 * @return
	 */
	public Double getTotalRevenues(BuilderEmployee builderEmployee){
		Double totalRevenue = 0.0;
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 3 || builderEmployee.getBuilderEmployeeAccessType().getId() ==6){
			totalRevenue = getRevenueOfsoldInventoryByBuilderId(builderEmployee.getBuilder().getId());
		}
		else if(builderEmployee.getBuilderEmployeeAccessType().getId() == 4 || builderEmployee.getBuilderEmployeeAccessType().getId() == 5 || builderEmployee.getBuilderEmployeeAccessType().getId() ==7){
			
			totalRevenue = getTotalRevenueByEmpId(builderEmployee.getId());
		}
	    return totalRevenue;
	}
	public Double getRevenueOfsoldInventoryByBuilderId(int builderId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "SELECT SUM(revenue)from BuilderProject where builder.id = :builder_id ";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		Double totalRevenue = (Double) query.uniqueResult();
		if(totalRevenue != null){
			return totalRevenue;
		}else{
			return 0.0;
		}
	}
	
	public Double getTotalRevenueByEmpId(int empId){
		Double totalRevenue = 0.0;
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "SELECT SUM(project.revenue) from builder_project as project inner join allot_project as ap on ap.project_id = project.id where ap.emp_id = :emp_id ";
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(hql);
		query.setParameter("emp_id", empId);
		Double totalRevenues = (Double) query.uniqueResult();
		if(totalRevenues != null){
			totalRevenue = Double.parseDouble(totalRevenues.toString());
			return totalRevenue;
		}else{
			return totalRevenue;
		}
	}
	/**
	 * Save source
	 * @author pankaj
	 * @param source
	 * @return responseMessage
	 */
	public ResponseMessage saveSource(Source source){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(source.getName().equals(null) && source.getName().isEmpty() || source.getName().trim().length() == 0){
			responseMessage.setStatus(0);
			responseMessage.setMessage("Please Enter source name");
		}else{
			String hql = "from Source where name=:name and builder.id = :builder_id and isDeleted=0";
			Session  sourceSession = hibernateUtil.openSession();
			Query sourceQuery = sourceSession.createQuery(hql);
			sourceQuery.setParameter("name", source.getName());
			sourceQuery.setParameter("builder_id", source.getBuilder().getId());
			List<Source> result = sourceQuery.list();
			sourceSession.close();
			if(result.size() > 0){
				responseMessage.setStatus(0);
				responseMessage.setMessage("Source name already exists");
			}else{
				Session session = hibernateUtil.openSession();
				session.beginTransaction();
				session.save(source);
				session.getTransaction().commit();
				session.close();
				responseMessage.setStatus(1);
				responseMessage.setMessage("Source added successfully");
			}
		}
		return responseMessage;
	}
	/**
	 * Get all source by builder id
	 * @author pankaj
	 * @return List<Source>
	 */
	public List<Source> getAllSourcesByBuilderId(int builderId){
		String hql = "from Source where builder.id = :builder_id and isDeleted=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<Source> sourceList = query.list();
		return sourceList;
	}
	
	public List<Source> getSourceById(int id){
		String hql = "from Source where id = :id and isDeleted=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Source> source = query.list();
		session.close();
		return source;
	}
	
	public ResponseMessage updateSource(Source source){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.update(source);
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Source updated successfully");
		return responseMessage;
	}
	
	public Long getTotalCampaignByEmpId(int empId){
		Long totalCampaign = (long)0;
		String hql = "SELECT COUNT(*) from Campaign where builder.builderEmployees.id = :emp_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("emp_id", empId);
		totalCampaign = (Long) query.uniqueResult();
		return totalCampaign;
	}
	public List<PaymentInfoData> getFlatPaymnetbyFloorId(int floorId){
		
		List<PaymentInfoData> paymentInfoDatas = new ArrayList<PaymentInfoData>();
		
		String hql = "from FlatPaymentSchedule where builderFlat.id = :flat_data_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		
		try{
		
		FlatData flatData = getActiveFlatsByFloorId(floorId).get(0);
		query.setParameter("flat_data_id", flatData.getId() );
		List<FlatPaymentSchedule> result = query.list();
		if(result.get(0) != null){
			System.err.println("No Error :: "+result.size());
			for(FlatPaymentSchedule buildingPaymentInfo : result){
				PaymentInfoData paymentInfoData = new PaymentInfoData();
				paymentInfoData.setId(buildingPaymentInfo.getId());
				paymentInfoData.setName(buildingPaymentInfo.getMilestone());
				paymentInfoData.setAmount(buildingPaymentInfo.getAmount());
				paymentInfoData.setPayable(buildingPaymentInfo.getPayable());
				paymentInfoDatas.add(paymentInfoData);
			}
		}else{
			
			BuilderFloor builderFloor = getFloorById(floorId);
			System.err.println("Building Id :: "+builderFloor.getBuilderBuilding().getId());
			List<BuildingPaymentInfo> buildingPaymentInfos = getActiveBuilderBuildingPaymentInfoById(builderFloor.getBuilderBuilding().getId());
			for(BuildingPaymentInfo builderProjectPaymentInfo : buildingPaymentInfos){
				PaymentInfoData paymentInfoData = new PaymentInfoData();
				paymentInfoData.setId(0);
				paymentInfoData.setName(builderProjectPaymentInfo.getMilestone());
				paymentInfoData.setAmount(builderProjectPaymentInfo.getAmount());
				paymentInfoData.setPayable(builderProjectPaymentInfo.getPayable());
				paymentInfoDatas.add(paymentInfoData);
			}
			
		}
		}catch(IndexOutOfBoundsException e){
			BuilderFloor builderFloor = getFloorById(floorId);
			System.err.println("Building Id :: "+builderFloor.getBuilderBuilding().getId());
			List<BuildingPaymentInfo> buildingPaymentInfos = getActiveBuilderBuildingPaymentInfoById(builderFloor.getBuilderBuilding().getId());
			for(BuildingPaymentInfo builderProjectPaymentInfo : buildingPaymentInfos){
				PaymentInfoData paymentInfoData = new PaymentInfoData();
				paymentInfoData.setId(0);
				paymentInfoData.setName(builderProjectPaymentInfo.getMilestone());
				paymentInfoData.setAmount(builderProjectPaymentInfo.getAmount());
				paymentInfoData.setPayable(builderProjectPaymentInfo.getPayable());
				paymentInfoDatas.add(paymentInfoData);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		session.close();
		return paymentInfoDatas;
	}
	
	public ResponseMessage updateProjectAmenity(ProjectAmenityData projectWeightageData){
		ResponseMessage resp = new ResponseMessage();
		BuilderProject  builderProject = projectWeightageData.getBuilderProject();
		List<BuilderBuilding> builderBuildings = projectWeightageData.getBuilderBuildings();
		BuilderProject builderProject2 = getBuilderProjectById(builderProject.getId());
		builderProject2.setBuildingWeightage(builderProject.getBuildingWeightage());
		builderProject2.setAmenityWeightage(builderProject.getAmenityWeightage());

		updateBasicInfo(builderProject2);
		if(builderBuildings != null){
			for(BuilderBuilding builderBuilding : builderBuildings){
				BuilderBuilding builderBuilding2 = getBuilderProjectBuildingById(builderBuilding.getId()).get(0);
				builderBuilding2.setWeightage(builderBuilding.getWeightage());
				updateBuilding(builderBuilding2);
			}
		  resp.setStatus(1);
		  resp.setMessage("Project Weightage Updated successfully.");
		}
		return resp;
	}
	
	public List<PaymentInfoData> getProjectPaymentScheduleByProjectId(int projectId){
		List<PaymentInfoData> paymentInfoDatas = new ArrayList<PaymentInfoData>();
		String hql = "from BuildingPaymentInfo where builderBuilding.builderProject.id =:project_id ";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		try{
			List<BuildingPaymentInfo> result = query.list();
			if(result.get(0) != null){
				for(BuildingPaymentInfo buildingPaymentInfo : result){
					PaymentInfoData paymentInfoData = new PaymentInfoData();
					paymentInfoData.setId(buildingPaymentInfo.getId());
					paymentInfoData.setAmount(buildingPaymentInfo.getAmount());
					paymentInfoData.setName(buildingPaymentInfo.getMilestone());
					paymentInfoData.setPayable(buildingPaymentInfo.getPayable());
					paymentInfoDatas.add(paymentInfoData);
				}
			}else{
				List<BuilderProjectPaymentInfo> builderProjectPaymentInfos = new BuilderProjectPaymentInfoDAO().getBuilderProjectPaymentInfo(projectId);
				for(BuilderProjectPaymentInfo builderProjectPaymentInfo : builderProjectPaymentInfos){
					PaymentInfoData paymentInfoData = new PaymentInfoData();
					paymentInfoData.setName(builderProjectPaymentInfo.getSchedule());
					paymentInfoData.setPayable(builderProjectPaymentInfo.getPayable());
					paymentInfoData.setAmount(builderProjectPaymentInfo.getAmount());
					paymentInfoDatas.add(paymentInfoData);
				}
			}
		}catch(IndexOutOfBoundsException e){
			List<BuilderProjectPaymentInfo> builderProjectPaymentInfos = new BuilderProjectPaymentInfoDAO().getBuilderProjectPaymentInfo(projectId);
			for(BuilderProjectPaymentInfo builderProjectPaymentInfo : builderProjectPaymentInfos){
				PaymentInfoData paymentInfoData = new PaymentInfoData();
				paymentInfoData.setName(builderProjectPaymentInfo.getSchedule());
				paymentInfoData.setPayable(builderProjectPaymentInfo.getPayable());
				paymentInfoData.setAmount(builderProjectPaymentInfo.getAmount());
				paymentInfoDatas.add(paymentInfoData);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return paymentInfoDatas;
				
	}
	
	public ResponseMessage addBuildingPriceInfo(BuildingPriceInfo buildingPriceInfo) {
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.save(buildingPriceInfo);
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Pricing added successfully");
		return responseMessage;
	}
	
	public ResponseMessage updateBuildingPriceInfo(BuildingPriceInfo buildingPriceInfo) {
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.update(buildingPriceInfo);
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Pricing updated successfully");
		return responseMessage;
	}
	
	public List<BuildingPriceInfo> getBuildingPriceInfos(int building_id) {
		String hql = "from BuildingPriceInfo where builderBuilding.id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", building_id);
		List<BuildingPriceInfo> sourceList = query.list();
		return sourceList;
	}
	
	public ResponseMessage addFlatPriceInfo(FlatPricingDetails flatPriceInfo) {
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.save(flatPriceInfo);
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Pricing added successfully");
		return responseMessage;
	}
	
	public ResponseMessage updateFlatPriceInfo(FlatPricingDetails flatPriceInfo) {
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.update(flatPriceInfo);
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Pricing updated successfully");
		return responseMessage;
	}
	
	public List<FlatPricingDetails> getFlatPriceInfos(int flat_id) {
		String hql = "from FlatPricingDetails where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flat_id);
		List<FlatPricingDetails> sourceList = query.list();
		if(sourceList !=null){
			return sourceList;
		}else{
			return null;
		}
	}
	
	public PriceInfoData getFlatPriceData(int flatId){
		PriceInfoData priceInfoData = new PriceInfoData();
		String hql = "from FlatPricingDetails where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		try{
			FlatPricingDetails flatPriceInfo =(FlatPricingDetails) query.list().get(0);
			priceInfoData.setId(flatPriceInfo.getId());
			priceInfoData.setAreaUnits(flatPriceInfo.getAreaUnit().getId());
			priceInfoData.setBaseRate(flatPriceInfo.getBasePrice());
			priceInfoData.setRiseRate(flatPriceInfo.getRiseRate());
			priceInfoData.setPost(flatPriceInfo.getPost());
			priceInfoData.setMaintainance(flatPriceInfo.getMaintenance());
			priceInfoData.setParkingId(flatPriceInfo.getParkingId());
			priceInfoData.setAmenityRate(flatPriceInfo.getAmenityRate());
			priceInfoData.setTenure(flatPriceInfo.getTenure());
			priceInfoData.setParking(flatPriceInfo.getParking());
			priceInfoData.setStampDuty(flatPriceInfo.getStampDuty());
			priceInfoData.setTax(flatPriceInfo.getTax());
			priceInfoData.setVat(flatPriceInfo.getVat());
			priceInfoData.setFee(flatPriceInfo.getFee());
			priceInfoData.setTotalCost(flatPriceInfo.getTotalCost());
		}catch(Exception e){
			
			try{
				BuilderFlat flat = getBuildingFlatById(flatId).get(0);
				String buildinghql = "from BuildingPriceInfo where builderBuilding.id = :id";
				Session buildingSession = hibernateUtil.openSession();
				Query buildingQuery = buildingSession.createQuery(buildinghql);
				buildingQuery.setParameter("id", flat.getBuilderFloor().getBuilderBuilding().getId());
				BuildingPriceInfo buildingPriceInfo =(BuildingPriceInfo) query.list().get(0);
				priceInfoData.setId(buildingPriceInfo.getId());
				priceInfoData.setAreaUnits(buildingPriceInfo.getAreaUnit().getId());
				priceInfoData.setBaseRate(buildingPriceInfo.getBasePrice());
				priceInfoData.setRiseRate(buildingPriceInfo.getRiseRate());
				priceInfoData.setPost(buildingPriceInfo.getPost());
				priceInfoData.setMaintainance(buildingPriceInfo.getMaintenance());
				priceInfoData.setParkingId(buildingPriceInfo.getParkingId());
				priceInfoData.setAmenityRate(buildingPriceInfo.getAmenityRate());
				priceInfoData.setTenure(buildingPriceInfo.getTenure());
				priceInfoData.setParking(buildingPriceInfo.getParking());
				priceInfoData.setStampDuty(buildingPriceInfo.getStampDuty());
				priceInfoData.setTax(buildingPriceInfo.getTax());
				priceInfoData.setVat(buildingPriceInfo.getVat());
				priceInfoData.setFee(buildingPriceInfo.getFee());
				priceInfoData.setTotalCost(0.0);
			}catch(Exception ee){
				BuilderFlat flat = getBuildingFlatById(flatId).get(0);
				BuilderBuilding building = getBuildingById(flat.getBuilderFloor().getBuilderBuilding().getId());
				String innerHql = "from BuilderProjectPriceInfo where builderProject.id = :project_id";
				Session innerSession = hibernateUtil.openSession();
				Query innerQuery = innerSession.createQuery(innerHql);
				innerQuery.setParameter("project_id", building.getBuilderProject().getId());
				try{
				BuilderProjectPriceInfo builderProjectPriceInfo =(BuilderProjectPriceInfo) innerQuery.list().get(0);
				
				priceInfoData.setAreaUnits(builderProjectPriceInfo.getAreaUnit().getId());
				priceInfoData.setBaseRate(builderProjectPriceInfo.getBasePrice());
				priceInfoData.setRiseRate(builderProjectPriceInfo.getRiseRate());
				priceInfoData.setPost(builderProjectPriceInfo.getPost());
				priceInfoData.setMaintainance(builderProjectPriceInfo.getMaintenance());
				priceInfoData.setParkingId(0);
				priceInfoData.setAmenityRate(builderProjectPriceInfo.getAmenityRate());
				priceInfoData.setTenure(builderProjectPriceInfo.getTenure());
				priceInfoData.setParking(builderProjectPriceInfo.getParking());
				priceInfoData.setStampDuty(builderProjectPriceInfo.getStampDuty());
				priceInfoData.setTax(builderProjectPriceInfo.getTax());
				priceInfoData.setVat(builderProjectPriceInfo.getVat());
				priceInfoData.setFee(builderProjectPriceInfo.getFee());
				priceInfoData.setTotalCost(0.0);
				}catch(Exception e1){
					System.err.println("Fail to load data from project pricing info");
				}
			}
			
			
		}
		return priceInfoData;
	}
	
	public BuilderBuilding getBuildingById(int id){
		String hql = "from BuilderBuilding where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		BuilderBuilding builderBuilding = (BuilderBuilding)query.uniqueResult();
		session.close();
		return builderBuilding;
	}
	/**
	 * Get Flat type details by passing flat type id on ajax call
	 * @author pankaj
	 * @param flatTypeId
	 * @return flatTypeData
	 */
	public FlatTypeData getFlatType(int flatTypeId){
		FlatTypeData flatTypeData = new FlatTypeData();
		String hql = "from BuilderFlatType where id = :id";
		String roomHql = "from BuilderBuildingFlatTypeRoom where builderFlatType.id = :flat_type_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Session roomSession = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", flatTypeId);
		BuilderFlatType builderFlatType = (BuilderFlatType) query.uniqueResult();
		if(builderFlatType != null){
			flatTypeData.setBalcony(builderFlatType.getBalcony());
			flatTypeData.setBathRoom(builderFlatType.getBathroom());
			flatTypeData.setBedRoom(builderFlatType.getBedroom());
			flatTypeData.setDryBalcony(builderFlatType.getDrybalcony());
			flatTypeData.setSuperBuildupArea(builderFlatType.getSuperBuiltupArea().intValue());
			Query roomQuery = roomSession.createQuery(roomHql);
			roomQuery.setParameter("flat_type_id", flatTypeId);
			List<RoomData> roomDataList = new ArrayList<RoomData>();
			List<BuilderBuildingFlatTypeRoom> flatTypeRoomList = roomQuery.list();
			for(BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom : flatTypeRoomList){
				RoomData roomData = new RoomData();
				roomData.setLength(builderBuildingFlatTypeRoom.getLength());
				roomData.setWidth(builderBuildingFlatTypeRoom.getBreadth());
				roomData.setRoomName(builderBuildingFlatTypeRoom.getRoomName());
				if(builderBuildingFlatTypeRoom.getLengthUnit() == 1){
					roomData.setUnitName("Feet");
				}
				else if(builderBuildingFlatTypeRoom.getLengthUnit() == 2){
					roomData.setUnitName("Meter");
				}
				else if(builderBuildingFlatTypeRoom.getLengthUnit() == 3){
					roomData.setUnitName("Inch");
				}
				else if(builderBuildingFlatTypeRoom.getLengthUnit() == 4){
					roomData.setUnitName("Yard");
				}
				roomDataList.add(roomData);
			}
			flatTypeData.setRoomdata(roomDataList);
		}
		session.close();
		roomSession.close();
		return flatTypeData;
	}
	/**
	 * @author pankaj
	 * @param flat_type_id
	 * @return List<BuilderBuildingFlatTypeRoom>
	 */
	public List<BuilderBuildingFlatTypeRoom> getBuilderBuildingFlatTypeRoomById(int flat_type_id){
		String hql = "from BuilderBuildingFlatTypeRoom where builderFlattype.id = :flat_type_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_type_id", flat_type_id);
		List<BuilderBuildingFlatTypeRoom> result = query.list();
		
		session.close();
		return result;
	}
	
	public PriceInfoData getBuildingPriceData(int buildingId){
		PriceInfoData priceInfoData = new PriceInfoData();
		String hql = "from BuildingPriceInfo where builderBuilding.id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", buildingId);
		try{
			BuildingPriceInfo buildingPriceInfo =(BuildingPriceInfo) query.list().get(0);
			priceInfoData.setId(buildingPriceInfo.getId());
			priceInfoData.setAreaUnits(buildingPriceInfo.getAreaUnit().getId());
			priceInfoData.setBaseRate(buildingPriceInfo.getBasePrice());
			priceInfoData.setRiseRate(buildingPriceInfo.getRiseRate());
			priceInfoData.setPost(buildingPriceInfo.getPost());
			priceInfoData.setMaintainance(buildingPriceInfo.getMaintenance());
			priceInfoData.setParkingId(buildingPriceInfo.getParkingId());
			priceInfoData.setAmenityRate(buildingPriceInfo.getAmenityRate());
			priceInfoData.setTenure(buildingPriceInfo.getTenure());
			priceInfoData.setParking(buildingPriceInfo.getParking());
			priceInfoData.setStampDuty(buildingPriceInfo.getStampDuty());
			priceInfoData.setTax(buildingPriceInfo.getTax());
			priceInfoData.setVat(buildingPriceInfo.getVat());
			priceInfoData.setFee(buildingPriceInfo.getFee());
		}catch(Exception e){
			BuilderBuilding building = getBuildingById(buildingId);
			String innerHql = "from BuilderProjectPriceInfo where builderProject.id = :project_id";
			Session innerSession = hibernateUtil.openSession();
			Query innerQuery = innerSession.createQuery(innerHql);
			innerQuery.setParameter("project_id", building.getBuilderProject().getId());
			try{
			BuilderProjectPriceInfo builderProjectPriceInfo =(BuilderProjectPriceInfo) innerQuery.list().get(0);
			
			priceInfoData.setAreaUnits(builderProjectPriceInfo.getAreaUnit().getId());
			priceInfoData.setBaseRate(builderProjectPriceInfo.getBasePrice());
			priceInfoData.setRiseRate(builderProjectPriceInfo.getRiseRate());
			priceInfoData.setPost(builderProjectPriceInfo.getPost());
			priceInfoData.setMaintainance(builderProjectPriceInfo.getMaintenance());
			priceInfoData.setParkingId(0);
			priceInfoData.setAmenityRate(builderProjectPriceInfo.getAmenityRate());
			priceInfoData.setTenure(builderProjectPriceInfo.getTenure());
			priceInfoData.setParking(builderProjectPriceInfo.getParking());
			priceInfoData.setStampDuty(builderProjectPriceInfo.getStampDuty());
			priceInfoData.setTax(builderProjectPriceInfo.getTax());
			priceInfoData.setVat(builderProjectPriceInfo.getVat());
			priceInfoData.setFee(builderProjectPriceInfo.getFee());
			}catch(Exception e1){
				System.err.println("Fail to load data from project pricing info");
			}
		}
		return priceInfoData;
	}
	/**
	 * Get flat offers by flat id
	 * @author pankaj
	 * @param flatId
	 * @return List<FlatOfferInfo> 
	 */
	
	public List<FlatOfferInfo> getFlatOffersByFlatId(int flatId){
		String hql = "from FlatOfferInfo where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		List<FlatOfferInfo> result = query.list();
		return result;
	}
	/**
	 * Get flat type by id
	 * @author pankaj
	 * @param id
	 * @return builderFlatType
	 */
	public BuilderFlatType getBuilderFlatType(int id){
		String hql = "from BuilderFlatType where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id",id);
		BuilderFlatType builderFlatType = (BuilderFlatType) query.list().get(0);
		return builderFlatType;
		
	}
	
	/**
	 * @author pankaj
	 * @param flatId
	 * @return FlatPricingDetails
	 */
    public FlatPricingDetails getFlatPriceDetails(int flatId){
    	String hql = "from FlatPricingDetails where builderFlat.id = :flat_id";
    	HibernateUtil hibernateUtil = new HibernateUtil();
    	Session session = hibernateUtil.openSession();
    	Query query = session.createQuery(hql);
    	query.setParameter("flat_id", flatId);
    	try{
    	FlatPricingDetails flatPricingDetails = (FlatPricingDetails) query.list().get(0);
    	return flatPricingDetails;
    	}catch(Exception e){
    		return null;
    	}
    }
    
    /**
     * @author pankaj
     * @param flatId
     * @return List<FlatPaymentSchedule>
     */
    public List<FlatPaymentSchedule> getFlatPaymentSchedule(int flatId){
    	String hql = "from FlatPaymentSchedule where builderFlat.id = :flat_id";
    	HibernateUtil hibernateUtil = new HibernateUtil();
    	Session session = hibernateUtil.openSession();
    	Query query = session.createQuery(hql);
    	query.setParameter("flat_id", flatId);
    	List<FlatPaymentSchedule> result = query.list();
    	return result;
    }
    
    //on load call
    public BookingFlatList getFlatdetails(int projectId, int buildingId, int floorId,int evenOrodd){
    	boolean booked = false;
    	BookingFlatList booking = new BookingFlatList();
    	String bookedFlat = "from BuilderFlat as flat where builderFloor.builderBuilding.id = :building_id and builderFloor.status=1 and builderFloor.builderBuilding.status=1 and builderFloor.builderBuilding.builderProject.status=1"
    			+ " order by flat.id ASC";
    	HibernateUtil hibernateUtil = new HibernateUtil();
    	Session session = hibernateUtil.openSession();
    	Session bookedSession = hibernateUtil.openSession();
    	Query bookedQuery = bookedSession.createQuery(bookedFlat);
    	bookedQuery.setParameter("building_id", buildingId);
    	try{
	    	BuilderFlat builderFlat =(BuilderFlat) bookedQuery.list().get(0);
	    	if(builderFlat != null){
	    		System.err.println("Booked Flat..");
	    		if(builderFlat.getBuilderFlatStatus().getName().equalsIgnoreCase("booked")){
	    			booked=true;
	    		}else{
	    			booked= false;
	    		}
	    	}
    	}catch(Exception e){
    		e.printStackTrace();
    		booked=false;
    	}
    	
    	if(booked){
    		System.err.println("Hi form Booked Flat");
        	String hql =" from BuilderFlat where ";
        	String where = "";
        	if(projectId > 0){
        		where += " builderFloor.builderBuilding.builderProject.id = :project_id AND builderFloor.builderBuilding.builderProject.status = 1";
        	}
        	if(buildingId > 0){
        		if(where != ""){
        			where += " AND builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
        		}else{
        			where += " builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
        		}
        	}
        	if(floorId > 0){
        		if(where != ""){
        			where +=" AND builderFloor.id = :floor_id AND builderFloor.status = 1 ";
        		}else{
        			where +=" builderFloor.id = :floor_id AND builderFloor.status = 1 ";
        		}
        	}
        	if(evenOrodd > 0){
        		if(evenOrodd % 2 == 0){
    				if(where != null){
    					where += " AND builderFloor.floorNo % 2 = 0 AND builderFloor.status=1";
    				}else{
    					where +=" builderFloor.floorNo % 2 = 0 AND builderFloor.status=1";
    				}
    			}else{
    				if(where != null){
    					where +=" AND builderFloor.floorNo %2 <> 0 AND builderFloor.status=1";
    				}else{
    					where +=" builderFloor.floorNo %2 <> 0 AND builderFloor.status=1";
    				}
    			}
        	}
        	hql += where+" AND status = 1 ORDER BY builderFloor.builderBuilding.builderProject.id ASC, builderFloor.builderBuilding.id DESC, builderFloor.floorNo DESC, flatNo DESC";
        	
        	Query query = session.createQuery(hql);
        	if(projectId > 0){
        		query.setParameter("project_id", projectId);
        	}
        	if(buildingId > 0){
        		query.setParameter("building_id", buildingId);
        	}
        	if(floorId > 0){
        		query.setParameter("floor_id", floorId);
        	}
        	try{
    	    	BuilderFlat builderFlat = (BuilderFlat) query.list().get(0);
    	    	if(builderFlat != null){
    	    		booking.setFlatId(builderFlat.getId());
    	    		booking.setFlatNo(builderFlat.getFlatNo());
    	    		booking.setBalcony(builderFlat.getBalcony());
    	    		booking.setBathroom(builderFlat.getBathroom());
    	    		booking.setBedroom(builderFlat.getBedroom());
    	    		booking.setCarpetArea(builderFlat.getBuilderFlatType().getCarpetArea());
    	    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
    	    		booking.setFlatstatusName(builderFlat.getBuilderFlatStatus().getName());
    	    		if(builderFlat.getImage() != null && builderFlat.getImage() != "")
    	    			booking.setImage(builderFlat.getImage());
    	    		else
    	    			booking.setImage("");
    	    		booking.setFlatType(builderFlat.getBuilderFlatType().getBuilderProjectPropertyConfiguration().getName());
    	    		List<BuilderBuildingFlatTypeRoom> room = getFlatTypeRoom(builderFlat.getBuilderFlatType().getId());
    	    		List<BuilderBuildingFlatTypeRoom>  roomList = new ArrayList<BuilderBuildingFlatTypeRoom>();
    	    		
    	    		for(BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom: room){
    	    		BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom2 = new BuilderBuildingFlatTypeRoom();
    	    			builderBuildingFlatTypeRoom2.setRoomName(builderBuildingFlatTypeRoom.getRoomName());
    	    			builderBuildingFlatTypeRoom2.setLength(builderBuildingFlatTypeRoom.getLength());
    	    			builderBuildingFlatTypeRoom2.setBreadth(builderBuildingFlatTypeRoom.getBreadth());
    	    			builderBuildingFlatTypeRoom2.setLengthUnit(builderBuildingFlatTypeRoom.getLengthUnit());
    	    			roomList.add(builderBuildingFlatTypeRoom2);
    	    		}
    	    		booking.setBuilderBuildingFlatTypeRooms(roomList);
    	    		booking.setBreadth(room.get(0).getBreadth());
    	    		booking.setLength(room.get(0).getLength());
    	    		if(room.get(0).getLengthUnit() == 1)
    	    			booking.setAreaUint("Feet");
    	    		if(room.get(0).getLengthUnit() == 2)
    	    			booking.setAreaUint("Meter");
    	    		if(room.get(0).getLengthUnit() == 3)
    	    			booking.setAreaUint("Inch");
    	    		if(room.get(0).getLengthUnit() == 4)
    	    			booking.setRoomName("Yard");
    	    	//	booking.setCarpetAreaunit(builderFlat.getBuilderFlatType().get);
    	    	}else if(builderFlat.getBuilderFlatStatus().getId() == 2){
    	    		Buyer buyer = getBuyerByFlatId(builderFlat.getId());
    	    		booking.setFlatNo(builderFlat.getFlatNo());
    	    		booking.setBuildingName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
    	    		booking.setProjectName(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName());
    	    		booking.setBuyerName(buyer.getName());
    	    		booking.setBuyerEmail(buyer.getEmail());
    	    		booking.setBuyerMobile(buyer.getMobile());
    	    		booking.setBuyerPanNo(buyer.getPancard());
    	    		booking.setBuyerAadhaarNumber(buyer.getAadhaarNumber());
    	    		booking.setBuyerCurrentAddress(buyer.getCurrentAddress());
    	    		booking.setBuyerPermanentAddress(buyer.getAddress());
    	    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
    	    		booking.setFlatstatusName(builderFlat.getBuilderFlatStatus().getName());
    	    		if(buyer.getPhoto() != null){
    	    		booking.setBuyerPhoto(buyer.getPhoto());
    	    		}else{
    	    			booking.setBuyerPhoto("");
    	    		}
    	    	}
        	}catch(Exception e){
        		System.err.println("Error in booked flat");
        		e.printStackTrace();
        		booking = null;
        	}
        	//System.err.println(hql);
        	return booking;
    		
    	}else{
    		System.err.println("Hi from !booked");
        	String hql =" from BuilderFlat where ";
        	String where = "";
        	if(projectId > 0){
        		where += " builderFloor.builderBuilding.builderProject.id = :project_id AND builderFloor.builderBuilding.builderProject.status = 1";
        	}
        	if(buildingId > 0){
        		if(where != ""){
        			where += " AND builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
        		}else{
        			where += " builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
        		}
        	}
        	if(floorId > 0){
        		if(where != ""){
        			where +=" AND builderFloor.id = :floor_id AND builderFloor.status = 1 ";
        		}else{
        			where +=" builderFloor.id = :floor_id AND builderFloor.status = 1 ";
        		}
        	}
        	if(evenOrodd > 0){
        		if(evenOrodd % 2 == 0){
    				if(where != null){
    					where += " AND builderFloor.floorNo % 2 = 0 AND builderFloor.status=1";
    				}else{
    					where +=" builderFloor.floorNo % 2 = 0 AND builderFloor.status=1";
    				}
    			}else{
    				if(where != null){
    					where +=" AND builderFloor.floorNo %2 <> 0 AND builderFloor.status=1";
    				}else{
    					where +=" builderFloor.floorNo %2 <> 0 AND builderFloor.status=1";
    				}
    			}
        	}
        	hql += where+" AND status = 1 ORDER BY builderFloor.builderBuilding.builderProject.id ASC, builderFloor.builderBuilding.id DESC, builderFloor.floorNo DESC, flatNo DESC";
        	
        	Query query = session.createQuery(hql);
        	if(projectId > 0){
        		query.setParameter("project_id", projectId);
        	}
        	if(buildingId > 0){
        		query.setParameter("building_id", buildingId);
        	}
        	if(floorId > 0){
        		query.setParameter("floor_id", floorId);
        	}
        	try{
    	    	BuilderFlat builderFlat = (BuilderFlat) query.list().get(0);
    	    	if(builderFlat != null){
    	    		booking.setFlatId(builderFlat.getId());
    	    		booking.setFlatNo(builderFlat.getFlatNo());
    	    		booking.setBalcony(builderFlat.getBalcony());
    	    		booking.setBathroom(builderFlat.getBathroom());
    	    		booking.setBedroom(builderFlat.getBedroom());
    	    		booking.setCarpetArea(builderFlat.getBuilderFlatType().getCarpetArea());
    	    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
    	    		if(builderFlat.getImage() != null && builderFlat.getImage() != "")
    	    			booking.setImage(builderFlat.getImage());
    	    		else
    	    			booking.setImage("");
    	    		booking.setFlatType(builderFlat.getBuilderFlatType().getBuilderProjectPropertyConfiguration().getName());
    	    		List<BuilderBuildingFlatTypeRoom> room = getFlatTypeRoom(builderFlat.getBuilderFlatType().getId());
    	    		List<BuilderBuildingFlatTypeRoom>  roomList = new ArrayList<BuilderBuildingFlatTypeRoom>();
    	    		
    	    		for(BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom: room){
    	    		BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom2 = new BuilderBuildingFlatTypeRoom();
    	    			builderBuildingFlatTypeRoom2.setRoomName(builderBuildingFlatTypeRoom.getRoomName());
    	    			builderBuildingFlatTypeRoom2.setLength(builderBuildingFlatTypeRoom.getLength());
    	    			builderBuildingFlatTypeRoom2.setBreadth(builderBuildingFlatTypeRoom.getBreadth());
    	    			builderBuildingFlatTypeRoom2.setLengthUnit(builderBuildingFlatTypeRoom.getLengthUnit());
    	    			roomList.add(builderBuildingFlatTypeRoom2);
    	    		}
    	    		booking.setBuilderBuildingFlatTypeRooms(roomList);
    	    		booking.setBreadth(room.get(0).getBreadth());
    	    		booking.setLength(room.get(0).getLength());
    	    		if(room.get(0).getLengthUnit() == 1)
    	    			booking.setAreaUint("Feet");
    	    		if(room.get(0).getLengthUnit() == 2)
    	    			booking.setAreaUint("Meter");
    	    		if(room.get(0).getLengthUnit() == 3)
    	    			booking.setAreaUint("Inch");
    	    		if(room.get(0).getLengthUnit() == 4)
    	    			booking.setRoomName("Yard");
    	    	//	booking.setCarpetAreaunit(builderFlat.getBuilderFlatType().get);
    	    	}else if(builderFlat.getBuilderFlatStatus().getId() == 2){
    	    		Buyer buyer = getBuyerByFlatId(builderFlat.getId());
    	    		booking.setFlatNo(builderFlat.getFlatNo());
    	    		booking.setBuildingName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
    	    		booking.setProjectName(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName());
    	    		booking.setBuyerName(buyer.getName());
    	    		booking.setBuyerEmail(buyer.getEmail());
    	    		booking.setBuyerMobile(buyer.getMobile());
    	    		booking.setBuyerPanNo(buyer.getPancard());
    	    		booking.setBuyerAadhaarNumber(buyer.getAadhaarNumber());
    	    		booking.setBuyerCurrentAddress(buyer.getCurrentAddress());
    	    		booking.setBuyerPermanentAddress(buyer.getAddress());
    	    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
    	    		if(buyer.getPhoto() != null){
    	    		booking.setBuyerPhoto(buyer.getPhoto());
    	    		}else{
    	    			booking.setBuyerPhoto("");
    	    		} 
    	    	}
        	}catch(Exception e){
        		System.err.println("Hi from !booked error");
        		booking = null;
        	}
        	//System.err.println(hql);
        	return booking;
    	}
    }
    
    
    public BookingFlatList getFlatBookeddetails(int projectId, int buildingId, int floorId,int evenOrodd){
    	BookingFlatList booking = new BookingFlatList();
    	String hql =" from BuilderFlat where ";
    	String where = "";
    	if(projectId > 0){
    		where += " builderFloor.builderBuilding.builderProject.id = :project_id AND builderFloor.builderBuilding.builderProject.status = 1";
    	}
    	if(buildingId > 0){
    		if(where != ""){
    			where += " AND builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
    		}else{
    			where += " builderFloor.builderBuilding.id = :building_id AND builderFloor.builderBuilding.status = 1";
    		}
    	}
    	if(floorId > 0){
    		if(where != ""){
    			where +=" AND builderFloor.id = :floor_id AND builderFloor.status = 1 ";
    		}else{
    			where +=" builderFloor.id = :floor_id AND builderFloor.status = 1 ";
    		}
    	}
    	if(evenOrodd > 0){
    		if(evenOrodd % 2 == 0){
				if(where != null){
					where += " AND builderFloor.floorNo % 2 = 0 AND builderFloor.status=1";
				}else{
					where +=" builderFloor.floorNo % 2 = 0 AND builderFloor.status=1";
				}
			}else{
				if(where != null){
					where +=" AND builderFloor.floorNo %2 <> 0 AND builderFloor.status=1";
				}else{
					where +=" builderFloor.floorNo %2 <> 0 AND builderFloor.status=1";
				}
			}
    	}
    	hql += where+" AND status = 1 AND builderFlatStatus.id=2 ORDER BY builderFloor.builderBuilding.builderProject.id ASC, builderFloor.builderBuilding.id ASC, builderFloor.floorNo ASC, flatNo ASC";
    	HibernateUtil hibernateUtil = new HibernateUtil();
    	Session session = hibernateUtil.openSession();
    	Query query = session.createQuery(hql);
    	if(projectId > 0){
    		query.setParameter("project_id", projectId);
    	}
    	if(buildingId > 0){
    		query.setParameter("building_id", buildingId);
    	}
    	if(floorId > 0){
    		query.setParameter("floor_id", floorId);
    	}
    	try{
	    	BuilderFlat builderFlat = (BuilderFlat) query.list().get(0);
	    	if(builderFlat != null){
	    		booking.setFlatId(builderFlat.getId());
	    		booking.setFlatNo(builderFlat.getFlatNo());
	    		booking.setBalcony(builderFlat.getBalcony());
	    		booking.setBathroom(builderFlat.getBathroom());
	    		booking.setBedroom(builderFlat.getBedroom());
	    		booking.setCarpetArea(builderFlat.getBuilderFlatType().getCarpetArea());
	    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
	    		if(builderFlat.getImage() != null && builderFlat.getImage() != "")
	    			booking.setImage(builderFlat.getImage());
	    		else
	    			booking.setImage("");
	    		booking.setFlatType(builderFlat.getBuilderFlatType().getBuilderProjectPropertyConfiguration().getName());
	    		List<BuilderBuildingFlatTypeRoom> room = getFlatTypeRoom(builderFlat.getBuilderFlatType().getId());
	    		List<BuilderBuildingFlatTypeRoom>  roomList = new ArrayList<BuilderBuildingFlatTypeRoom>();
	    		for(BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom: room){
	    		BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom2 = new BuilderBuildingFlatTypeRoom();
	    			builderBuildingFlatTypeRoom2.setRoomName(builderBuildingFlatTypeRoom.getRoomName());
	    			builderBuildingFlatTypeRoom2.setLength(builderBuildingFlatTypeRoom.getLength());
	    			builderBuildingFlatTypeRoom2.setBreadth(builderBuildingFlatTypeRoom.getBreadth());
	    			builderBuildingFlatTypeRoom2.setLengthUnit(builderBuildingFlatTypeRoom.getLengthUnit());
	    			roomList.add(builderBuildingFlatTypeRoom2);
	    		}
	    		booking.setBuilderBuildingFlatTypeRooms(roomList);
//	    		booking.setBreadth(room.getBreadth());
//	    		booking.setLength(room.getLength());
//	    		if(room.getLengthUnit() == 1)
//	    			booking.setAreaUint("Feet");
//	    		if(room.getLengthUnit() == 2)
//	    			booking.setAreaUint("Meter");
//	    		if(room.getLengthUnit() == 3)
//	    			booking.setAreaUint("Inch");
//	    		if(room.getLengthUnit() == 4)
//	    			booking.setRoomName("Yard");
	    	//	booking.setCarpetAreaunit(builderFlat.getBuilderFlatType().);
	    	}else if(builderFlat.getBuilderFlatStatus().getId() == 2){
	    		try{
		    		Buyer buyer = getBuyerByFlatId(builderFlat.getId());
		    		Cancellation cancellation = new CancellationDAO().getCancellationByFlatId(builderFlat.getId());
		    		booking.setFlatNo(builderFlat.getFlatNo());
		    		booking.setBuildingName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
		    		booking.setProjectName(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName());
		    		booking.setBuyerName(buyer.getName());
		    		booking.setBuyerEmail(buyer.getEmail());
		    		booking.setBuyerMobile(buyer.getMobile());
		    		booking.setBuyerPanNo(buyer.getPancard());
		    		booking.setBuyerAadhaarNumber(buyer.getAadhaarNumber());
		    		booking.setBuyerCurrentAddress(buyer.getCurrentAddress());
		    		booking.setBuyerPermanentAddress(buyer.getAddress());
		    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
		    		if(buyer.getPhoto() != null){
		    		booking.setBuyerPhoto(buyer.getPhoto());
		    		}else{
		    			booking.setBuyerPhoto("");
		    		}
		    		if(cancellation != null){
		    			booking.setIsApproved(cancellation.isApproved());
		    			booking.setCancelStatus(cancellation.getCancelStatus());
		    			booking.setCancelReason(cancellation.getReason());
		    			booking.setCharges(cancellation.getCharges());
		    		}else{
		    			booking.setIsApproved(false);
		    			booking.setCancelStatus(0);
		    			booking.setCancelReason("");
		    			booking.setCharges(0.0);
		    		}
	    		}catch(Exception e){
	    			e.printStackTrace();
	    			Buyer buyer = getBuyerByFlatId(builderFlat.getId());
		    		booking.setFlatNo(builderFlat.getFlatNo());
		    		booking.setBuildingName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
		    		booking.setProjectName(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName());
		    		booking.setBuyerName(buyer.getName());
		    		booking.setBuyerEmail(buyer.getEmail());
		    		booking.setBuyerMobile(buyer.getMobile());
		    		booking.setBuyerPanNo(buyer.getPancard());
		    		booking.setBuyerAadhaarNumber(buyer.getAadhaarNumber());
		    		booking.setBuyerCurrentAddress(buyer.getCurrentAddress());
		    		booking.setBuyerPermanentAddress(buyer.getAddress());
		    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
		    		if(buyer.getPhoto() != null){
		    		booking.setBuyerPhoto(buyer.getPhoto());
		    		}else{
		    			booking.setBuyerPhoto("");
		    		}
	    		}
	    	}
    	}catch(Exception e){
    		booking = null;
    	}
    	//System.err.println(hql);
    	return booking;
    }
    
//    public int getFloorCountByBuildingId(int buildingId){
//    	int floorCount = 0;
//    	String hql = "select COUNT(id) from BuilderFloor where builderBuilding.id = :building_id";
//    	HibernateUtil hibernateUtil = new HibernateUtil();
//    	Session session = hibernateUtil.openSession();
//    	Query query = session.createQuery(hql);
//    	query.setParameter("building_id", buildingId);
//    	floorCount = (int)query.uniqueResult();
//    	return floorCount;
//    }
    
    public List<BuilderBuildingFlatTypeRoom> getFlatTypeRoom(int flatTypeId){
    	String hql = "from BuilderBuildingFlatTypeRoom where builderFlatType.id = :flat_type_id";
    	HibernateUtil hibernateUtil = new HibernateUtil();
    	Session session = hibernateUtil.openSession();
    	Query query = session.createQuery(hql);
    	query.setParameter("flat_type_id", flatTypeId);
    	List<BuilderBuildingFlatTypeRoom> builderBuildingFlatTypeRoom =  query.list();
    	return builderBuildingFlatTypeRoom;		
    }
    /**
     * Get all project offers by project id
     * @author pankaj
     * @param projectId
     * @return
     */
    public List<BuilderProjectOfferInfo> getProjectOffersByProjectId(int projectId){
    	String hql = "from BuilderProjectOfferInfo where builderProject.id = :project_id";
    	HibernateUtil hibernateUtil = new HibernateUtil();
    	Session session = hibernateUtil.openSession();
    	Query query =session.createQuery(hql);
    	query.setParameter("project_id", projectId);
    	List<BuilderProjectOfferInfo> result = query.list();
    	return result;
    }
    
    public BookingFlatList getFlatdetails(int flatId,int empId){
    	
    	String emphql = " from BuilderEmployee where id=:id";
      //  System.err.println("flat id "+flatId);
    	
    	BookingFlatList booking = new BookingFlatList();
    	String hql =" from BuilderFlat where id = :flat_id AND builderFloor.builderBuilding.builderProject.status = 1 AND "
    			+ " builderFloor.builderBuilding.status = 1 AND builderFloor.status = 1 ";
    	hql += " AND status = 1 ORDER BY builderFloor.builderBuilding.builderProject.id DESC, builderFloor.builderBuilding.id DESC, builderFloor.floorNo DESC, flatNo DESC";
    	HibernateUtil hibernateUtil = new HibernateUtil();
    	Session session = hibernateUtil.openSession();
    	Query query = session.createQuery(hql);
    	query.setParameter("flat_id", flatId);
    	
    	Session empSession = hibernateUtil.openSession();
    	Query empQuery = empSession.createQuery(emphql);
    	empQuery.setParameter("id", empId);
    	BuilderEmployee employee = (BuilderEmployee) empQuery.list().get(0);
    	empSession.close();
    	booking.setAccessId(employee.getBuilderEmployeeAccessType().getId());
    	try{
	    	BuilderFlat builderFlat = (BuilderFlat) query.list().get(0);
	    	if(builderFlat != null){
	    		if(builderFlat.getBuilderFlatStatus().getId() == 1){
	    			System.err.println("FlatStatus :: "+builderFlat.getBuilderFlatStatus().getName());
	    		booking.setFlatId(builderFlat.getId());
	    		booking.setFlatNo(builderFlat.getFlatNo());
	    		booking.setBalcony(builderFlat.getBalcony());
	    		booking.setBathroom(builderFlat.getBathroom());
	    		booking.setBedroom(builderFlat.getBedroom());
	    		booking.setCarpetArea(builderFlat.getBuilderFlatType().getCarpetArea());
	    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
	    		if(builderFlat.getImage() != null && builderFlat.getImage() != "")
	    			booking.setImage(builderFlat.getImage());
	    		else
	    			booking.setImage("");
	    		booking.setFlatType(builderFlat.getBuilderFlatType().getBuilderProjectPropertyConfiguration().getName());
	    		List<BuilderBuildingFlatTypeRoom> room = getFlatTypeRoom(builderFlat.getBuilderFlatType().getId());
	    		List<BuilderBuildingFlatTypeRoom>  roomList = new ArrayList<BuilderBuildingFlatTypeRoom>();
	    		for(BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom: room){
	    		BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom2 = new BuilderBuildingFlatTypeRoom();
	    			builderBuildingFlatTypeRoom2.setRoomName(builderBuildingFlatTypeRoom.getRoomName());
	    			builderBuildingFlatTypeRoom2.setLength(builderBuildingFlatTypeRoom.getLength());
	    			builderBuildingFlatTypeRoom2.setBreadth(builderBuildingFlatTypeRoom.getBreadth());
	    			builderBuildingFlatTypeRoom2.setLengthUnit(builderBuildingFlatTypeRoom.getLengthUnit());
	    			roomList.add(builderBuildingFlatTypeRoom2);
	    		}
	    		booking.setBuilderBuildingFlatTypeRooms(roomList);
	    		booking.setBreadth(room.get(0).getBreadth());
	    		booking.setLength(room.get(0).getLength());
	    		if(room.get(0).getLengthUnit() == 1)
	    			booking.setAreaUint("Feet");
	    		if(room.get(0).getLengthUnit() == 2)
	    			booking.setAreaUint("Meter");
	    		if(room.get(0).getLengthUnit() == 3)
	    			booking.setAreaUint("Inch");
	    		if(room.get(0).getLengthUnit() == 4)
	    			booking.setRoomName("Yard");
	    	//	booking.setCarpetAreaunit(builderFlat.getBuilderFlatType().);
	    	}
	    	else if(builderFlat.getBuilderFlatStatus().getId() == 2){
	    		try{
	    		Buyer buyer = getBuyerByFlatId(builderFlat.getId());
	    		Cancellation cancellation = new CancellationDAO().getCancellationByFlatId(builderFlat.getId());
	    		
	    		booking.setFlatId(builderFlat.getId());
	    		booking.setFlatNo(builderFlat.getFlatNo());
	    		booking.setBuildingName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
	    		booking.setProjectName(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName());
	    		booking.setBuyerName(buyer.getName());
	    		booking.setBuyerEmail(buyer.getEmail());
	    		booking.setBuyerMobile(buyer.getMobile());
	    		booking.setBuyerPanNo(buyer.getPancard());
	    		if(buyer.getAadhaarNumber() != null)
	    			booking.setBuyerAadhaarNumber(buyer.getAadhaarNumber());
	    		else
	    			booking.setBuyerAadhaarNumber("");
	    		if(buyer.getCurrentAddress()!=null)
	    			booking.setBuyerCurrentAddress(buyer.getCurrentAddress());
	    		else
	    			booking.setBuyerCurrentAddress("");
	    		booking.setBuyerPermanentAddress(buyer.getAddress());
	    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
	    		if(buyer.getIsDeleted() != null){
	    			booking.setIsDeleted(buyer.getIsDeleted());
	    		}else{
	    			Short isDeleted =1;
	    			booking.setIsDeleted(isDeleted);
	    		}
	    		
	    		if(buyer.getPhoto() != null){
	    		booking.setBuyerPhoto(buyer.getPhoto());
	    		}else{
	    			booking.setBuyerPhoto("");
	    		}
	    		if(cancellation != null && employee.getBuilderEmployeeAccessType().getId() == 5){
	    			booking.setCancellationId(cancellation.getId());
	    			booking.setIsApproved(cancellation.isApproved());
	    			booking.setCancelStatus(cancellation.getCancelStatus());
	    			booking.setCancelReason(cancellation.getReason());
	    			booking.setCharges(cancellation.getCharges());
	    			System.err.println("From cancellation if condtion");
	    		}else{
	    			booking.setIsApproved(false);
	    			booking.setCancelStatus(cancellation.getCancelStatus());
	    			booking.setCancelReason("");
	    			booking.setCharges(0.0);
	    			System.err.println("From cancellation else");
	    		}
    		}catch(Exception e){
    			e.printStackTrace();
    			System.err.println("From exception of cancellation");
    			Buyer buyer = getBuyerByFlatId(builderFlat.getId());
	    		booking.setFlatNo(builderFlat.getFlatNo());
	    		booking.setBuildingName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
	    		booking.setProjectName(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName());
	    		booking.setBuyerName(buyer.getName());
	    		booking.setBuyerEmail(buyer.getEmail());
	    		booking.setBuyerMobile(buyer.getMobile());
	    		booking.setBuyerPanNo(buyer.getPancard());
	    		booking.setBuyerAadhaarNumber(buyer.getAadhaarNumber());
	    		booking.setBuyerCurrentAddress(buyer.getCurrentAddress());
	    		booking.setBuyerPermanentAddress(buyer.getAddress());
	    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
	    		if(buyer.getPhoto() != null){
	    		booking.setBuyerPhoto(buyer.getPhoto());
	    		}else{
	    			booking.setBuyerPhoto("");
	    		}
    		}
	    }else if( builderFlat.getBuilderFlatStatus().getId() == 3){
			System.err.println("FlatStatus :: "+builderFlat.getBuilderFlatStatus().getName());
    		booking.setFlatId(builderFlat.getId());
    		booking.setFlatNo(builderFlat.getFlatNo());
    		booking.setBalcony(builderFlat.getBalcony());
    		booking.setBathroom(builderFlat.getBathroom());
    		booking.setBedroom(builderFlat.getBedroom());
    		booking.setCarpetArea(builderFlat.getBuilderFlatType().getCarpetArea());
    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
    		if(builderFlat.getImage() != null && builderFlat.getImage() != "")
    			booking.setImage(builderFlat.getImage());
    		else
    			booking.setImage("");
    		booking.setFlatType(builderFlat.getBuilderFlatType().getBuilderProjectPropertyConfiguration().getName());
    		List<BuilderBuildingFlatTypeRoom> room = getFlatTypeRoom(builderFlat.getBuilderFlatType().getId());
    		List<BuilderBuildingFlatTypeRoom>  roomList = new ArrayList<BuilderBuildingFlatTypeRoom>();
    		for(BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom: room){
    		BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom2 = new BuilderBuildingFlatTypeRoom();
    			builderBuildingFlatTypeRoom2.setRoomName(builderBuildingFlatTypeRoom.getRoomName());
    			builderBuildingFlatTypeRoom2.setLength(builderBuildingFlatTypeRoom.getLength());
    			builderBuildingFlatTypeRoom2.setBreadth(builderBuildingFlatTypeRoom.getBreadth());
    			builderBuildingFlatTypeRoom2.setLengthUnit(builderBuildingFlatTypeRoom.getLengthUnit());
    			roomList.add(builderBuildingFlatTypeRoom2);
    		}
    		booking.setBuilderBuildingFlatTypeRooms(roomList);
    		booking.setBreadth(room.get(0).getBreadth());
    		booking.setLength(room.get(0).getLength());
    		if(room.get(0).getLengthUnit() == 1)
    			booking.setAreaUint("Feet");
    		if(room.get(0).getLengthUnit() == 2)
    			booking.setAreaUint("Meter");
    		if(room.get(0).getLengthUnit() == 3)
    			booking.setAreaUint("Inch");
    		if(room.get(0).getLengthUnit() == 4)
    			booking.setRoomName("Yard");
	    	
	    }
    }}catch(Exception e){
    		e.printStackTrace();
    		booking = null;
    	}
    	//System.err.println(hql);
    	return booking;
    }
    
    public Buyer getBuyerByFlatId(int flatId){
    	String hql = "from Buyer where builderFlat.id = :flat_id and isPrimary = 1 and isDeleted=0";
    	HibernateUtil hibernateUtil = new HibernateUtil();
    	Session session = hibernateUtil.openSession();
    	Query query = session.createQuery(hql);
    	query.setParameter("flat_id", flatId);
    	try{
	    	Buyer buyer = (Buyer) query.list().get(0);
	    	session.close();
	    	return buyer;
    	}catch(Exception e){
    		return null;
    	}
    }
    
    /**
     * Get source name by builder id
     * @author pankaj
     * @param builderId
     * @return List<Source>
     */
    public List<Source> getSourceListByBuilderId(int builderId){
    	String hql = " from Source as s where builder.id = :builder_id and s.isDeleted=0 order by s.id DESC";
    	HibernateUtil hibernateUtil = new HibernateUtil();
    	Session session = hibernateUtil.openSession();
    	Query query = session.createQuery(hql);
    	query.setParameter("builder_id", builderId);
    	List<Source> sourceList =  query.list();
    	session.close();
    	return sourceList;
    }
    
public List<InboxBuyerData> getAllBuyersByBuilderEmployee(BuilderEmployee builderEmployee){
	    
	    String hql = "";
	    if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
	      hql = "SELECT buy.id as id, buy.name as name "
	      		+ "FROM buyer as buy left join builder_project as project on project.id=buy.project_id"
	      		+ " left join builder as build on build.id=project.group_id"
	      		+ " WHERE build.id = "+builderEmployee.getBuilder().getId()+" and buy.is_deleted=0 and buy.is_primary=1 and buy.status=0 and project.status=1 group by buy.id ";
	    } else {
	      hql = "SELECT buy.id as id, buy.name as name "
	          +"FROM  buyer as buy inner join allot_project ap ON buy.project_id = ap.project_id "
	          +"WHERE ap.emp_id = "+builderEmployee.getId()+" and buy.is_deleted=0 and buy.is_primary=1 and buy.status=0 group by buy.id";
	    }
	    HibernateUtil hibernateUtil = new HibernateUtil();
	    Session session = hibernateUtil.getSessionFactory().openSession();
	    Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(InboxBuyerData.class));
	    System.err.println(hql);
	   // query.setMaxResults(4);
	    List<InboxBuyerData> result = query.list();
	    session.close();
	    return result;
	  }
/**
 * Get buyer by id
 * @author pankaj
 * @param id
 * @return buyer 
 */
public Buyer getBuyerById(int id){
	String hql = "from Buyer where id = :id and isPrimary = 1 and isDeleted=0 and status=0";
	HibernateUtil hibernateUtil = new HibernateUtil();
	Session session = hibernateUtil.openSession();
	Query query = session.createQuery(hql);
	query.setParameter("id",id);
	Buyer buyer = (Buyer) query.list().get(0);
	session.close();
	return buyer;
}

/**
 * Get inbox message by emp id
 * @author pankaj
 * @param empId
 * @return List<InboxMessage>
 */
public List<InboxMessage> getInboxMessagesByEmpId(int empId){
	String hql = "from InboxMessage as ib where emp_id = :emp_id order by ib.id DESC";
	HibernateUtil hibernateUtil = new HibernateUtil();
	Session session = hibernateUtil.openSession();
	Query query = session.createQuery(hql);
	query.setParameter("emp_id",empId);
	List<InboxMessage> result = query.list();
	session.close();
	return result;
}

public List<InboxMessageData> getBookedBuyerList(int empId){
	List<InboxMessageData> result = null;
	//String hql = "SELECT b.name as name, b.photo as image, im.subject as subject, im.im_date as date  ";
	String hql = " SELECT b.id as id, a.name as name, a.photo as image, b.im_date as date, b.subject as subject  ";
	String where = "";
	String hqlnew = "from BuilderEmployee where id = "+empId;
	HibernateUtil hibernateUtil = new HibernateUtil();
	Session sessionnew = hibernateUtil.openSession();
	Query querynew = sessionnew.createQuery(hqlnew);
	List<BuilderEmployee> employees = querynew.list();
	BuilderEmployee builderEmployee = employees.get(0);
	sessionnew.close();
	if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2){
		
		hql += "from buyer as a join inbox_message as b on b.buyer_id=a.id"
				+ " where"
				+ " b.emp_id="+builderEmployee.getId();
		
//		hql += " FROM buyer as b inner join inbox_message as im on im.buyer_id=b.id "
//				+ "left join builder_project as bproject on bproject.id = b.project_id "
//				+ "inner join allot_project as ap on ap.project_id = bproject.id   "
//				+ "WHERE ";
//				where+= "ap.emp_id="+builderEmployee.getId();
	}else{
		hql = hql+" FROM buyer as a inner join inbox_message as b on b.buyer_id=a.id "
				+ "left join builder_project as bproject on bproject.id = a.project_id "
				+ "left join builder as build on build.id = a.builder_id  "
				+ "WHERE ";
				where+= "a.builder_id="+builderEmployee.getBuilder().getId();
	}
	hql += where + " AND a.is_primary=1 and a.is_deleted=0 and a.status=0 GROUP by b.id ORDER by b.id DESC";
	try {
	Session session = hibernateUtil.getSessionFactory().openSession();
	Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(InboxMessageData.class));
	System.err.println(hql);
	
	 result = query.list();
	 session.close();
	} catch(Exception e) {
		//
		e.printStackTrace();
	}
	
	return result;
}
	public ResponseMessage deleteSource(int id){
		ResponseMessage responseMessage = new ResponseMessage();
		String hql = "UPDATE Source set is_deleted=1 where id=:id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id",id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Source is deleted successfully.");
		return responseMessage;
		
	}

	public  List<BuilderProjectPropertyConfigurationInfo> getPropertyConfigByProjectId(int projectId){
		String hql = "from BuilderProjectPropertyConfigurationInfo where builderProject.id = :projectId";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("projectId", projectId);
		List<BuilderProjectPropertyConfigurationInfo> result = query.list();
		return result;
	}

	public void addLeadConfig(List<LeadConfig> leadConfigs){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		for(LeadConfig leadConfig : leadConfigs){
			session.save(leadConfig);
		}
		session.getTransaction().commit();
		session.close();
	}
	
	public List<NewLeadList> getNewLeadList(int projectId){
		List<NewLeadList> leadLists = new ArrayList<>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd MMMM yyyy");
		String strDate = "";
		String hql = "from BuilderLead as where builderProject.id = :projectId";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("projectId", projectId);
		try{
			List<BuilderLead> builderLeads =  query.list();
			System.err.println(builderLeads.size());
			System.err.println("ProjectId :: "+projectId);
			if(builderLeads != null){
				if(builderLeads.size() > 0 && !builderLeads.isEmpty()){
				for(BuilderLead builderLead : builderLeads){
					NewLeadList newLeadList =new NewLeadList();
					newLeadList.setId(builderLead.getId());
					System.err.println(builderLead.getName());
					if(builderLead.getName()!=null && builderLead.getName() != ""){
					newLeadList.setLeadName(builderLead.getName());
					}else{
						newLeadList.setLeadName("No Name fond..");
					}
					newLeadList.setPhoneNo(builderLead.getMobile());
					newLeadList.setEmail(builderLead.getEmail());
					if(builderLead.getLdate() != null){
						strDate = simpleDateFormat.format(builderLead.getLdate());
						newLeadList.setStrDate(strDate);
					newLeadList.setlDate(builderLead.getLdate());
					}
					System.err.println("Employee Id :: "+builderLead.getAddedBy());
					BuilderEmployee builderEmployee = new BuilderDetailsDAO().getBuilderEmployeeById(builderLead.getAddedBy());
					newLeadList.setMax(builderLead.getMax());
					newLeadList.setMin(builderLead.getMin());
					System.err.println(builderEmployee.getName());
					newLeadList.setSalemanName(builderEmployee.getName());
					if(builderLead.getLeadStatus() == 0){
						newLeadList.setLeadName("");
					} 
					if(builderLead.getLeadStatus() == 1){
						newLeadList.setLeadName("No Response");
					}
					if(builderLead.getLeadStatus() == 2){
						newLeadList.setLeadStatusName("Call Again");
					}
					if(builderLead.getLeadStatus() == 3){
						newLeadList.setLeadStatusName("Email Sent");
					}
					if(builderLead.getLeadStatus() == 4){
						newLeadList.setLeadStatusName("Visit Again");
					}
					if(builderLead.getLeadStatus() == 5){
						newLeadList.setLeadStatusName("Visit Complete");
					}
					if(builderLead.getLeadStatus() == 6){
						newLeadList.setLeadStatusName("Follow up");
					}
					if(builderLead.getLeadStatus() == 7){
						newLeadList.setLeadStatusName("Booked");
					}
					if(builderLead.getLeadStatus() == 8){
						newLeadList.setLeadStatusName("Not Interested");
					}
					Source source = getSourceById(builderLead.getSource().getId()).get(0);
					newLeadList.setSource(source.getName());
					List<LeadConfig> leadConfig  =  getLeadConfig(builderLead.getId());
					List<ConfigData> configDatas = new ArrayList<ConfigData>();
					for(LeadConfig leadConfig2: leadConfig){
						ConfigData configData = new ConfigData();
						configData.setName(leadConfig2.getBuilderProjectPropertyConfiguration().getName());
						configDatas.add(configData);
					}
					newLeadList.setConfigDatas(configDatas);
					leadLists.add(newLeadList);
				}
			}else{
				System.err.println("No Lead name found....");
			}
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return leadLists;
	}
	
	
	public List<NewLeadList> getNewLeadList(int projectId,BuilderEmployee builderEmployee){
	
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 7){
			hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(DISTINCT(f.name)) as configName, c.id as salesmanId, c.name as salemanName "
				+ "FROM builder_lead as b join allot_leads as a on a.lead_id = b.id "
				+ "join source as d on d.id = b.source "
				+ "join builder_employee as c on a.emp_id = c.id "
				+ "inner join lead_config as e on e.lead_id=a.lead_id "
				+ "join builder_project_property_configuration as f on f.id=e.config_id "
				+ "where a.emp_id="+builderEmployee.getId()+" AND b.project_id="+projectId+" group by a.id order by b.id desc";
		}
		else{
			if(builderEmployee.getBuilderEmployeeAccessType().getId() == 5){
				hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(DISTINCT(f.name)) as configName, c.id as salesmanId,c.name as salesheadName "
						+ "FROM builder_lead as b "
						+ "join builder_project as project on project.id = b.project_id "
						+ "inner join allot_project as ap on ap.project_id = project.id "
						+ "join source as d on d.id = b.source "
						+ "join builder_employee as c on c.id = b.added_by "
						+ "inner join lead_config as e on e.lead_id=b.id "
						+ "join builder_project_property_configuration as f on f.id=e.config_id "
						+ "where "
						+ "ap.project_id="+projectId+" group by b.id order by b.id desc";
			}
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NewLeadList.class));
		System.err.println(hql);
		List<NewLeadList> result = query.list();
		session.close();
		return result;
	}
	
	
	public List<LeadConfig> getLeadConfig(int id){
		String hql = "From LeadConfig where builderLead.id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session =  hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<LeadConfig> leadConfig =  query.list();
		return leadConfig;
	}
	
	public List<ConfigData> getConfigData(List<String> projectIds){
		List<ConfigData> configDatas = new ArrayList<ConfigData>();
		String projectIdList = Arrays.toString(projectIds.toArray());
		String strSeparator = "";
		projectIdList = projectIdList.replace("[", strSeparator).replace("]", strSeparator);
		
		String  hql="select DISTINCT(a.property_config_id) as id, b.name as name FROM builder_project_property_configuration_info "
				+ "as a join builder_project_property_configuration as b on a.property_config_id= b.id "
				+ "where "
				+ "a.project_id IN("+projectIdList+");";
		HibernateUtil hibernateUtil = new HibernateUtil();
		try {
				Session session = hibernateUtil.getSessionFactory().openSession();
				Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ConfigData.class));
				System.err.println("hql : "+hql);
				configDatas = query.list();
			} catch(Exception e) {
				//
			}
		return configDatas;
	
	}
	
	public List<LocalityData> getLocalityNames(int cityId){
		List<LocalityData> localityData = new ArrayList<LocalityData>();
		String hql = "select project.id as id, project.locality_name as name from builder_project as project inner join city as city on city.id = project.city_id where city_id = "+cityId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		try {
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(LocalityData.class));
			System.err.println("hql : "+hql);
			localityData = query.list();
			} catch(Exception e) {
				//
			}
		return localityData;
	}
	
	public List<NewLeadList> getNewLeadListFilter(int empId,int projectId,String name,int contactNumber){
		String emphql="From BuilderEmployee where id=:id";
		
		List<NewLeadList> leadLists = new ArrayList<>();
		String hql = "from BuilderLead as bl where ";
		String where = "";
		if(projectId > 0){
			
			where = where + "builderProject.id = :projectId ";
		}
		if(name != null){
			if(where != ""){
				where = where + " AND bl.name = :name";
			}else{
				where = where + " bl.name = :name";
			}
		}
		if(contactNumber > 0){
			if(where != ""){
				where = where + " AND bl.mobile = :contactNo";
			}else{
				where = where + " bl.mobile = :contactNo";
			}
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd MMMM yyyy");
		String strDate = "";
		if(projectId > 0){
		query.setParameter("projectId", projectId);
		}
		if(name != null && !name.isEmpty()){
			query.setParameter("name", name);
		}
		if(contactNumber > 0){
			query.setParameter("contactNo", contactNumber);
		}
		Session empSession = hibernateUtil.openSession();
		Query empQuery = empSession.createQuery(emphql);
		empQuery.setParameter("id", empId);
		BuilderEmployee builderEmployee2 = (BuilderEmployee)empQuery.list().get(0);
		
		try{
		List<BuilderLead> builderLeads =  query.list();
		System.err.println(builderLeads.size());
		System.err.println("ProjectId :: "+projectId);
		if(builderEmployee2.getBuilderEmployeeAccessType().getId() == 7){
		if(builderLeads != null && builderEmployee2 != null){
			for(BuilderLead builderLead : builderLeads){
				NewLeadList newLeadList =new NewLeadList();
				newLeadList.setId(builderLead.getId());
				newLeadList.setLeadName(builderLead.getName());
				newLeadList.setPhoneNo(builderLead.getMobile());
				newLeadList.setEmail(builderLead.getEmail());
				if(builderLead.getLdate() != null){
					strDate = simpleDateFormat.format(builderLead.getLdate());
					newLeadList.setStrDate(strDate);
				newLeadList.setlDate(builderLead.getLdate());
				}
				System.err.println("Employee Id :: "+builderLead.getAddedBy());
				BuilderEmployee builderEmployee = new BuilderDetailsDAO().getBuilderEmployeeById(builderLead.getAddedBy());
				newLeadList.setMax(builderLead.getMax());
				newLeadList.setMin(builderLead.getMin());
				newLeadList.setSalemanName(builderEmployee.getName());
				if(builderLead.getLeadStatus() == 0){
					newLeadList.setLeadName("");
				} 
				if(builderLead.getLeadStatus() == 1){
					newLeadList.setLeadName("No Response");
				}
				if(builderLead.getLeadStatus() == 2){
					newLeadList.setLeadStatusName("Call Again");
				}
				if(builderLead.getLeadStatus() == 3){
					newLeadList.setLeadStatusName("Email Sent");
				}
				if(builderLead.getLeadStatus() == 4){
					newLeadList.setLeadStatusName("Visit Again");
				}
				if(builderLead.getLeadStatus() == 5){
					newLeadList.setLeadStatusName("Visit Complete");
				}
				if(builderLead.getLeadStatus() == 6){
					newLeadList.setLeadStatusName("Follow up");
				}
				if(builderLead.getLeadStatus() == 7){
					newLeadList.setLeadStatusName("Booked");
				}
				if(builderLead.getLeadStatus() == 8){
					newLeadList.setLeadStatusName("Not Interested");
				}
				Source source = getSourceById(builderLead.getSource().getId()).get(0);
				newLeadList.setSource(source.getName());
				List<LeadConfig> leadConfig  =  getLeadConfig(builderLead.getId());
				List<ConfigData> configDatas = new ArrayList<ConfigData>();
				for(LeadConfig leadConfig2: leadConfig){
					ConfigData configData = new ConfigData();
					configData.setName(leadConfig2.getBuilderProjectPropertyConfiguration().getName());
					configDatas.add(configData);
				}
				newLeadList.setConfigDatas(configDatas);
				leadLists.add(newLeadList);
				}
			}
		}
		if(builderEmployee2.getBuilderEmployeeAccessType().getId() == 5){
			if(builderLeads != null && builderEmployee2 != null){
				for(BuilderLead builderLead : builderLeads){
					NewLeadList newLeadList =new NewLeadList();
					newLeadList.setId(builderLead.getId());
					newLeadList.setLeadName(builderLead.getName());
					newLeadList.setPhoneNo(builderLead.getMobile());
					newLeadList.setEmail(builderLead.getEmail());
					if(builderLead.getLdate() != null){
						strDate = simpleDateFormat.format(builderLead.getLdate());
						newLeadList.setStrDate(strDate);
					newLeadList.setlDate(builderLead.getLdate());
					}
					System.err.println("Employee Id :: "+builderLead.getAddedBy());
					BuilderEmployee builderEmployee = new BuilderDetailsDAO().getBuilderEmployeeById(builderLead.getAddedBy());
					newLeadList.setMax(builderLead.getMax());
					newLeadList.setMin(builderLead.getMin());
					newLeadList.setSalemanName(builderEmployee.getName());
					if(builderLead.getLeadStatus() == 0){
						newLeadList.setLeadName("");
					} 
					if(builderLead.getLeadStatus() == 1){
						newLeadList.setLeadName("No Response");
					}
					if(builderLead.getLeadStatus() == 2){
						newLeadList.setLeadStatusName("Call Again");
					}
					if(builderLead.getLeadStatus() == 3){
						newLeadList.setLeadStatusName("Email Sent");
					}
					if(builderLead.getLeadStatus() == 4){
						newLeadList.setLeadStatusName("Visit Again");
					}
					if(builderLead.getLeadStatus() == 5){
						newLeadList.setLeadStatusName("Visit Complete");
					}
					if(builderLead.getLeadStatus() == 6){
						newLeadList.setLeadStatusName("Follow up");
					}
					if(builderLead.getLeadStatus() == 7){
						newLeadList.setLeadStatusName("Booked");
					}
					if(builderLead.getLeadStatus() == 8){
						newLeadList.setLeadStatusName("Not Interested");
					}
					Source source = getSourceById(builderLead.getSource().getId()).get(0);
					newLeadList.setSource(source.getName());
					List<LeadConfig> leadConfig  =  getLeadConfig(builderLead.getId());
					List<ConfigData> configDatas = new ArrayList<ConfigData>();
					for(LeadConfig leadConfig2: leadConfig){
						ConfigData configData = new ConfigData();
						configData.setName(leadConfig2.getBuilderProjectPropertyConfiguration().getName());
						configDatas.add(configData);
					}
					newLeadList.setConfigDatas(configDatas);
					leadLists.add(newLeadList);
					}
				}
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return leadLists;
	}
	//on load
	/**
	 * @author pankaj
	 * @param projectId
	 * @param builderEmployee
	 * @return
	 */
	public List<NewLeadList> getNewLeadLists(List<Integer> projectId,BuilderEmployee builderEmployee){
		
		String hql = "";
		String projectIdList = Arrays.toString(projectId.toArray());
		String strSeparator = "";
		projectIdList = projectIdList.replace("[", strSeparator).replace("]", strSeparator);
		hql = "SELECT a.name as leadName, a.mobile as phoneNo, a.email as email, a.min as min, a.max as max, b.name as salemanName , GROUP_CONCAT(d.name) as configName , e.name as source ";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 1){
			
				hql+= "from builder_lead as a join builder_project as b on b.id= a.project_id "
					+ "join lead_config as c on c.lead_id = a.id "
					+ "join builder_project_property_configuration as d on d.id = c.config_id "
					+ "join source as e on e.id=a.source "
					+ "where b.group_id ="+builderEmployee.getBuilder().getId()+" AND b.id IN("+projectIdList+")"
					+ " GROUP by a.id order by a.id desc";
		}
		
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 7){
			hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(f.name) as configName, c.name as salemanName "
					+ "FROM allot_leads as a join builder_lead as b on a.lead_id = b.id "
					+ "join source as d on d.id = b.source "
					+ "join builder_employee as c on a.emp_id = c.id "
					+ "inner join lead_config as e on e.lead_id=a.lead_id "
					+ "join builder_project_property_configuration as f on f.id=e.config_id "
					+ "where a.emp_id="+builderEmployee.getId()+" group by a.id order by b.id desc";
		}
		else{
			if(builderEmployee.getBuilderEmployeeAccessType().getId() == 4 || builderEmployee.getBuilderEmployeeAccessType().getId() == 5){
				hql = "SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(DISTINCT(f.name)) as configName, c.name as salemanName "
						+ "FROM builder_lead as b "
						+ "join builder_project as c on c.id = b.project_id "
						+" inner join allot_project as ap on ap.project_id = c.id "
						+ "join source as d on d.id = b.source "
						+ "inner join lead_config as e on e.lead_id=b.id "
						+ "join builder_project_property_configuration as f on f.id=e.config_id "
						+ "where ap.emp_id="+builderEmployee.getId()+" group by b.id order by b.id desc";
			}
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NewLeadList.class));
		System.err.println(hql);
		List<NewLeadList> result = query.list();
		session.close();
		return result;
	}
	
	public List<NewLeadList> getNewLeadLists(int emp_id,int projectId, String keyword){
		List<NewLeadList> result =null;
		String hqlnew = "from BuilderEmployee where id = "+emp_id;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session sessionnew = hibernateUtil.openSession();
		Query querynew = sessionnew.createQuery(hqlnew);
		List<BuilderEmployee> employees = querynew.list();
		BuilderEmployee builderEmployee = employees.get(0);
		sessionnew.close();
		String hql = "";
		String where = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() ==1){
			if(keyword == ""){
				hql = "SELECT a.name as leadName, a.mobile as phoneNo, a.email as email, a.min as min, a.max as max,"
					+ " b.name as salemanName , GROUP_CONCAT(d.name) as configName , e.name as source ";
				hql	=hql+"from builder_lead as a join builder_project as b on b.id= a.project_id "
					+ "join lead_config as c on c.lead_id = a.id "
					+ "join builder_project_property_configuration as d on d.id = c.config_id "
					+ "join source as e on e.id=a.source ";
				where+= "where b.group_id="+builderEmployee.getBuilder().getId();
				if(projectId > 0){
					if(where != ""){
						where += " AND b.id="+projectId;
					}else{
						where +=" AND b.id="+projectId;
					}
				}
			}else{
				hql = "SELECT a.name as leadName, a.mobile as phoneNo, a.email as email, a.min as min, a.max as max,"
					+ " b.name as salemanName , GROUP_CONCAT(d.name) as configName , e.name as source ";
				hql	=hql+"from builder_lead as a join builder_project as b on b.id= a.project_id "
					+ "join lead_config as c on c.lead_id = a.id "
					+ "join builder_project_property_configuration as d on d.id = c.config_id "
					+ "join source as e on e.id=a.source ";
				where+= "where  b.group_id="+builderEmployee.getBuilder().getId();
				hql += " AND (a.name like '%"+keyword+"%' OR a.mobile like '%"+keyword+"%')";
				if(projectId > 0){
					if(where!=""){
						where +=" AND b.id="+projectId;
					}else{
						where +=" AND b.id="+projectId;
					}
				}
			}
			hql += where + " group by a.id order by a.id desc";
		}
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 7){
			if(keyword == ""){
				hql = " SELECT b.id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(DISTINCT(f.name)) as configName, c.name as salemanName "
						+ "FROM builder_lead as b  "
						+ "join allot_leads as a on a.lead_id = b.id "
						+ "join source as d on d.id = b.source "
						+ "join builder_project as c on c.id = b.project_id "
						+ "inner join lead_config as e on e.lead_id=a.lead_id "
						+ "join builder_project_property_configuration as f on f.id=e.config_id "
						+ "where a.emp_id="+builderEmployee.getId();
				if(projectId > 0){
					if(where != ""){
						hql += " AND b.project_id="+projectId;
					}else{
						hql +=" AND b.project_id = "+projectId;
					}
				}
			}else{
				hql = " SELECT b.id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(DISTINCT(f.name)) as configName, c.name as salemanName "
						+ "FROM builder_lead as b "
						+ "join allot_leads as a on a.lead_id = b.id "
						+ "join source as d on d.id = b.source "
						+ "join builder_project as c on c.id = b.project_id "
						+ "inner join lead_config as e on e.lead_id=a.lead_id "
						+ "join builder_project_property_configuration as f on f.id=e.config_id "
						+ "where a.emp_id= "+builderEmployee.getId()+" ";
				hql +=" AND (b.name like '%"+keyword+"%' OR b.mobile like '%"+keyword+"%')";
				if(projectId > 0){
					if(where != ""){
						hql +=" AND b.project_id="+projectId;
					}else{
						hql +=" AND b.project_id="+projectId;
					}
				}
			}
			hql += where + " group by b.id order by b.id desc";
		}
		else{
			if(builderEmployee.getBuilderEmployeeAccessType().getId() ==4 || builderEmployee.getBuilderEmployeeAccessType().getId() == 5){
				if(keyword == ""){
					hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(DISTINCT(f.name)) as configName, c.name as salemanName "
						+ "FROM builder_lead as b "
						+ "join builder_project as c on c.id = b.project_id "
						+" inner join allot_project as ap on ap.project_id = c.id "
						+ "join source as d on d.id = b.source "
						+ "inner join lead_config as e on e.lead_id=b.id "
						+ "join builder_project_property_configuration as f on f.id=e.config_id "
						+ "where ap.emp_id="+builderEmployee.getId();
					if(projectId > 0){
						if(where!= ""){
							hql+=" AND b.project_id="+projectId;
						}else{
							hql+=" AND b.project_id="+projectId;
						}
					}
				}else{
					hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(DISTINCT(f.name)) as configName, c.name as salemanName "
						+ "FROM builder_lead as b "
						+ "join builder_project as c on c.id = b.project_id "
						+" inner join allot_project as ap on ap.project_id = c.id "
						+ "join source as d on d.id = b.source "
						+ "inner join lead_config as e on e.lead_id=b.id "
						+ "join builder_project_property_configuration as f on f.id=e.config_id "
						+ "where ap.emp_id ="+builderEmployee.getId()+" ";
					hql +=" AND (b.name like '%"+keyword+"%' OR b.mobile like '%"+keyword+"%')";
					if(projectId > 0){
						if(where != ""){
							hql +=" AND b.project_id="+projectId;
						}else{
							hql +=" AND b.project_id="+projectId;
						}
					}
				}
				hql += where + " group by b.id order by b.id desc";
			}
		}
		try{
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NewLeadList.class));
		result = query.list();
		session.close();
		System.err.println(hql);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return result;
	}

	public List<ProjectList> getActiveProjectListByBuilder(BuilderEmployee builderEmployee) {
		String hql = "";
		//code by Pradeep sir
		//	if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
		//		hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
		//			+"project.completion_status as completionStatus,project.inventory_sold as sold, build.id as builderId, "
		//			+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
		//			+"c.name as cityName, l.id as localityId, l.name as localityName, "
		//			+"count(lead.id) as totalLeads "
		//			+"FROM  builder_project as project "
		//			+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
		//			+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id "
		//			+"WHERE project.group_id = "+builderEmployee.getBuilder().getId()+" group by project.id order by project.id desc";
		//	} else {
		//		hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
		//				+"project.completion_status as completionStatus,project.inventory_sold as sold, build.id as builderId, "
		//				+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
		//				+"c.name as cityName, l.id as localityId, l.name as localityName, "
		//				+"count(lead.id) as totalLeads "
		//				+"FROM  builder_project as project inner join allot_project ap ON project.id = ap.project_id "
		//				+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
		//				+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id "
		//				+"WHERE ap.emp_id = "+builderEmployee.getId()+" group by project.id order by project.id desc";
		//	}
		//code changes done by pankaj
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
			hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
				+"project.completion_status as completionStatus,project.inventory_sold as sold, project.locality_name as localityName, build.id as builderId, "
				+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
				+"c.name as cityName, "
				+"count(lead.id) as totalLeads "
				+"FROM  builder_project as project "
				+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
				+"left join builder_lead as lead ON project.id = lead.project_id "
				+"WHERE project.status=1 and project.group_id = "+builderEmployee.getBuilder().getId()+" group by project.id order by project.id desc";
		} else {
			hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
					+"project.completion_status as completionStatus,project.inventory_sold as sold, project.locality_name as localityName, build.id as builderId, "
					+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
					+"c.name as cityName, "
					+"count(lead.id) as totalLeads "
					+"FROM  builder_project as project inner join allot_project ap ON project.id = ap.project_id "
					+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
					+"left join builder_lead as lead ON project.id = lead.project_id "
					+"WHERE project.status=1 and ap.emp_id = "+builderEmployee.getId()+" group by project.id order by project.id desc";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectList.class));
		System.err.println(hql);
		List<ProjectList> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderFlatList> getProjectFlatListByBuilder(int project_id,int building_id, String keyword){
		String hql = "";
		if(keyword == "") {
			hql = "SELECT a.id,a.flat_no as flatNo,b.floor_no as floorNo,d.name as flatStatus,(select e.name from buyer as e where e.flat_id=a.id and e.is_primary=1 and e.is_deleted = 0 limit 1) as buyerName from builder_flat as a inner join builder_floor as b on a.floor_no=b.id inner join builder_building as c on b.building_id=c.id inner join builder_flat_status as d on a.status_id=d.id where c.project_id = "+project_id+" and c.status = 1 and b.status = 1 and a.status = 1";
		    if(building_id > 0) {
		    	hql = hql + " AND c.id = "+building_id;
		    }
		    hql = hql + " order by b.floor_no ASC";
		} else {
			hql = "SELECT a.id,a.flat_no as flatNo,b.floor_no as floorNo,d.name as flatStatus,e.name as buyerName from builder_flat as a inner join builder_floor as b on a.floor_no=b.id inner join builder_building as c on b.building_id=c.id inner join builder_flat_status as d on a.status_id=d.id inner join buyer as e on a.id=e.flat_id where c.project_id = "+project_id+" and c.status = 1 and b.status = 1 and a.status = 1 and e.is_primary = 1 and e.is_deleted = 0 and (e.name like '%"+keyword+"%' OR e.mobile like '%"+keyword+"%')";
			if(building_id > 0) {
		    	hql = hql + " AND c.id = "+building_id;
		    }
		}
		System.out.println(hql);
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuilderFlatList.class));
		List<BuilderFlatList> result = query.list();
		session.close();
		System.out.println(hql);
		return result;
	}
	
	public ResponseMessage putFlatsOnHold(String flatIds) {
		
		String[] myids = flatIds.split(",");
		List<Integer> ids = new ArrayList<Integer>();
		for(String myid:myids) {
			ids.add(Integer.parseInt(myid));
		}
		ResponseMessage responseMessage = new ResponseMessage();
		BuilderFlatStatus flatStatus = new BuilderFlatStatus();
		flatStatus.setId(3);
		String hql = "UPDATE BuilderFlat set builderFlatStatus = :flatStatus where id IN(:list)";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("flatStatus",flatStatus);
		query.setParameterList("list",ids);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Flats put on hold.");
		return responseMessage;
		
	}
	
	public ResponseMessage putFlatsOnUnHold(String flatIds) {
		
		String[] myids = flatIds.split(",");
		List<Integer> ids = new ArrayList<Integer>();
		for(String myid:myids) {
			ids.add(Integer.parseInt(myid));
		}
		ResponseMessage responseMessage = new ResponseMessage();
		BuilderFlatStatus flatStatus = new BuilderFlatStatus();
		flatStatus.setId(1);
		String hql = "UPDATE BuilderFlat set builderFlatStatus = :flatStatus where id IN(:list)";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("flatStatus",flatStatus);
		query.setParameterList("list",ids);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Flats put on unhold.");
		return responseMessage;
		
	}
	
	public List<ProjectImageGallery> getProjectStatusImages(int project_id) {
		String hql = "from ProjectImageGallery where builderProject.id = :projectId";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("projectId", project_id);
		List<ProjectImageGallery> result = query.list();
		return result;
	}
	/**
	 * @author pankaj
	 * @param builderEmployee
	 * @return
	 */
	public List<EmployeeList> getBuilderEmployeeList(BuilderEmployee builderEmployee){
		String hql = "select emp.id as id, emp.name as name, emp.photo as image, emp.mobile as mobileNo, emp.email as email,GROUP_CONCAT(access.name SEPARATOR ', ') as access from builder_employee as emp join employee_role as er on er.emp_id=emp.id join builder_employee_access_type as access on access.id=er.role_id where emp.builder_id="+builderEmployee.getBuilder().getId()+" GROUP by emp.id order by emp.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(EmployeeList.class));
		System.err.println(hql);
		List<EmployeeList> result = query.list();
		session.close();
		return result;
	}
	/**
	 * @author pankaj
	 * @param builderEmployee
	 * @param projectId
	 * @return
	 */
	public List<EmployeeList> getBuilderEmployeeList(BuilderEmployee builderEmployee,int projectId){
		String hql = "select emp.id as id, emp.name as name,  emp.photo as image, emp.mobile as mobileNo, emp.email as email, access.name as access from builder_employee as emp join builder_employee_access_type as access on access.id= emp.access_type_id join builder_project as project on project.group_id=emp.builder_id where emp.access_type_id in(3,4,5) and emp.builder_id="+builderEmployee.getBuilder().getId()+" and project.id="+projectId+" group by emp.id order by emp.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(EmployeeList.class));
		System.err.println(hql);
		List<EmployeeList> result = query.list();
		session.close();
		return result;
	}
	/**
	 * 
	 * @param builderEmployee
	 * @param projectId
	 * @return
	 */
	public List<EmployeeList> getBuilderEmployeeList(int builderId, int roleId, String keyword){
		String hql = "";
		if(keyword == "") {
			 hql = "select emp.id as id, emp.name as name,  emp.photo as image, emp.mobile as mobileNo, emp.email as email,GROUP_CONCAT(access.name) as access from builder_employee as emp join employee_role as er on er.emp_id=emp.id join builder_employee_access_type as access on access.id=er.role_id join builder as builder on builder.id=emp.builder_id where emp.builder_id="+builderId;
			 if(roleId > 0){		
				 hql=hql+" and access.id="+roleId;
			 }
			 hql=hql+ " group by emp.id order by emp.id DESC";
		}else{
			 hql = "select emp.id as id, emp.name as name, emp.mobile as mobileNo, emp.email as email,GROUP_CONCAT(access.name) as access from builder_employee as emp join employee_role as er on er.emp_id=emp.id join builder_employee_access_type as access on access.id=er.role_id join builder as builder on builder.id=emp.builder_id where emp.builder_id="+builderId+"  and (emp.name like '%"+keyword+"%' OR emp.mobile like '%"+keyword+"%')";
			 if(roleId > 0){
				 hql=hql+" and access.id="+roleId;
			 }
			 hql=hql+" group by emp.id order by emp.id DESC";
		}
		
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(EmployeeList.class));
		System.err.println(hql);
		List<EmployeeList> result = query.list();
		session.close();
		return result;
	}
	/**
	 * @author pankaj
	 * @param projectId
	 * @param builderEmployee
	 * @param keyword
	 * @return List<NewLeadList>
	 */
	public List<NewLeadList> getNewLeadList(int projectId,BuilderEmployee builderEmployee,String keyword){
		
		String hql = "";
		String where = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 7){
			if(keyword == ""){
			hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(f.name) as configName, c.name as salemanName "
					+ "FROM allot_leads as a join builder_lead as b on a.lead_id = b.id "
					+ "join source as d on d.id = b.source "
					+ "join builder_employee as c on a.emp_id = c.id "
					+ "inner join lead_config as e on e.lead_id=a.lead_id "
					+ "join builder_project_property_configuration as f on f.id=e.config_id "
					+ "where a.emp_id="+builderEmployee.getId()+" group by a.id order by b.id desc";
			}else{
				hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(f.name) as configName, c.name as salemanName "
						+ "FROM allot_leads as a join builder_lead as b on a.lead_id = b.id "
						+ "join source as d on d.id = b.source "
						+ "join builder_employee as c on a.emp_id = c.id "
						+ "inner join lead_config as e on e.lead_id=a.lead_id "
						+ "join builder_project_property_configuration as f on f.id=e.config_id "
						+ "where a.emp_id="+builderEmployee.getId();
				hql +=" AND (b.name like '%"+keyword+"%' OR b.mobile like '%"+keyword+"%') group by a.id order by b.id desc";
			}
		}
		else{
			if(builderEmployee.getBuilderEmployeeAccessType().getId() == 5){
				if(keyword == ""){
					hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(f.name) as configName, c.name as salemanName "
							+ "FROM allot_leads as a join builder_lead as b on a.lead_id = b.id "
							+ "join source as d on d.id = b.source "
							+ "join builder_employee as c on a.emp_id = c.id "
							+ "inner join lead_config as e on e.lead_id=a.lead_id "
							+ "join builder_project_property_configuration as f on f.id=e.config_id "
							+ "where b.added_by="+builderEmployee.getId()+" group by a.id order by b.id desc";
				}else{
					hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(f.name) as configName, c.name as salemanName "
							+ "FROM allot_leads as a join builder_lead as b on a.lead_id = b.id "
							+ "join source as d on d.id = b.source "
							+ "join builder_employee as c on a.emp_id = c.id "
							+ "inner join lead_config as e on e.lead_id=a.lead_id "
							+ "join builder_project_property_configuration as f on f.id=e.config_id "
							+ "where b.added_by="+builderEmployee.getId()
							+" AND (b.name like '%"+keyword+"%' OR b.mobile like '%"+keyword+"%' OR c.name like '%"+keyword+"%') group by a.id order by b.id desc";
				}
			}
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NewLeadList.class));
		System.err.println(hql);
		System.err.println(keyword);
		List<NewLeadList> result = query.list();
		System.err.println(result.size());
		session.close();
		return result;
	}
	/**
	 * @author pankaj
	 * @param projectId
	 * @param empId
	 * @param keyword
	 * @return
	 */
	public List<NewLeadList> getNewLeadList(int projectId,int empId,String keyword){
			
		String hql = "";
		String where = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		String empHql = " from BuilderEmployee where id ="+empId;
		Session empSession = hibernateUtil.openSession();
		Query empQuery = empSession.createQuery(empHql);
		BuilderEmployee builderEmployee =(BuilderEmployee) empQuery.list().get(0);
		
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 7){
			if(keyword == ""){
			hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(f.name) as configName, c.name as salemanName "
					+ "FROM allot_leads as a join builder_lead as b on a.lead_id = b.id "
					+ "join source as d on d.id = b.source "
					+ "join builder_employee as c on a.emp_id = c.id "
					+ "inner join lead_config as e on e.lead_id=a.lead_id "
					+ "join builder_project_property_configuration as f on f.id=e.config_id "
					+ "where a.emp_id="+builderEmployee.getId()+" group by a.id order by b.id desc";
				if(projectId > 0){
					if(where != ""){
						where +=" AND b.project_id = "+projectId;
					}else{
						where +=" AND b.project_id = "+projectId;
					}
				}
			}else{
				hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(f.name) as configName, c.name as salemanName "
						+ "FROM allot_leads as a join builder_lead as b on a.lead_id = b.id "
						+ "join source as d on d.id = b.source "
						+ "join builder_employee as c on a.emp_id = c.id "
						+ "inner join lead_config as e on e.lead_id=a.lead_id "
						+ "join builder_project_property_configuration as f on f.id=e.config_id "
						+ "where a.emp_id="+builderEmployee.getId();
				hql +=" AND (b.name like '%"+keyword+"%' OR b.mobile like '%"+keyword+"%') group by a.id order by b.id desc";
			}
		}
		else{
			if(builderEmployee.getBuilderEmployeeAccessType().getId() == 5){
				if(keyword == ""){
					hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(DISTINCT(f.name)) as configName, c.id as salesmanId,c.name as salesheadName "
							+ "FROM builder_lead as b "
							+ "join builder_project as project on project.id = b.project_id "
							+ "inner join allot_project as ap on ap.project_id = project.id "
							+ "join source as d on d.id = b.source "
							+ "join builder_employee as c on c.id = b.added_by "
							+ "inner join lead_config as e on e.lead_id=b.id "
							+ "join builder_project_property_configuration as f on f.id=e.config_id "
							+ "where ";
					if(projectId > 0){
							hql +=" ap.project_id ="+projectId+" group by b.id order by b.id desc";
					}
				}else{
					hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(DISTINCT(f.name)) as configName, c.id as salesmanId,c.name as salesheadName "
							+ "FROM builder_lead as b "
							+ "join builder_project as project on project.id = b.project_id "
							+ "inner join allot_project as ap on ap.project_id = project.id "
							+ "join source as d on d.id = b.source "
							+ "join builder_employee as c on c.id = b.added_by "
							+ "inner join lead_config as e on e.lead_id=b.id "
							+ "join builder_project_property_configuration as f on f.id=e.config_id "
							+ "where "
							+" (b.name like '%"+keyword+"%' OR b.mobile like '%"+keyword+"%' OR c.name like '%"+keyword+"%')";
					if(projectId > 0){
						hql +=" AND ap.project_id="+projectId;
					}
				}
			}
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NewLeadList.class));
		System.err.println(hql);
		System.err.println(keyword);
		List<NewLeadList> result = query.list();
		System.err.println(result.size());
		session.close();
		return result;
	}
	/**
	 * @author pankaj
	 * @param projectId
	 * @param builderEmployee
	 * @return
	 */
	public List<NewLeadList> getNewLeadListsByEmp(List<Integer> projectId,BuilderEmployee builderEmployee){
		
		String hql = "";
		String projectIdList = Arrays.toString(projectId.toArray());
		String strSeparator = "";
		projectIdList = projectIdList.replace("[", strSeparator).replace("]", strSeparator);
		hql = "SELECT a.name as leadName, a.mobile as phoneNo, a.email as email, a.min as min, a.max as max, b.name as salemanName , GROUP_CONCAT(DISTINCT(d.name)) as configName , e.name as source ";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 1){
			
				hql+= "from builder_lead as a join builder_project as b on b.id= a.project_id "
					+ "join lead_config as c on c.lead_id = a.id "
					+ "join builder_project_property_configuration as d on d.id = c.config_id "
					+ "join source as e on e.id=a.source "
					+ "where b.group_id ="+builderEmployee.getBuilder().getId()+" AND b.id IN("+projectIdList+")"
					+ " GROUP by a.id order by a.id desc";
		}
		
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 7){
			hql = " SELECT b.id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(DISTINCT(f.name)) as configName, c.name as salemanName"
					+ " FROM builder_lead as b "
					+ "join allot_leads as a on a.lead_id=b.id "
					+ "join source as d on d.id = b.source "
					+ "join builder_project as c on c.id = b.project_id "
					+ "inner join lead_config as e on e.lead_id=a.lead_id "
					+ "join builder_project_property_configuration as f on f.id=e.config_id "
					+ "where a.emp_id= "+builderEmployee.getId()
					+ " group by b.id order by b.id desc";
		}
		else{
			if(builderEmployee.getBuilderEmployeeAccessType().getId() == 4 || builderEmployee.getBuilderEmployeeAccessType().getId() == 5){
			//	hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(f.name) as configName, c.name as salemanName "
				hql+= "from builder_lead as a join builder_project as b on b.id= a.project_id "
					+" inner join allot_project as ap on ap.project_id = b.id "
					+ "join lead_config as c on c.lead_id = a.id "
					+ "join builder_project_property_configuration as d on d.id = c.config_id "
					+ "join source as e on e.id=a.source "
					+ "where ap.emp_id="+builderEmployee.getId()+" AND b.id IN("+projectIdList+")"
					+" group by a.id order by a.id desc";
			}
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NewLeadList.class));
		System.err.println(hql);
		List<NewLeadList> result = query.list();
		session.close();
		return result;
	}
	/**
	 * @author pankaj
	 * @param projectId
	 * @param builderEmployee
	 * @return
	 */
	public List<NewLeadList> getNewLeadListonLoad(int projectId,BuilderEmployee builderEmployee){
		
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 7){
			hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(f.name) as configName, c.id as salesmanId, c.name as salemanName "
				+ "FROM allot_leads as a join builder_lead as b on a.lead_id = b.id "
				+ "join source as d on d.id = b.source "
				+ "join builder_employee as c on a.emp_id = c.id "
				+ "inner join lead_config as e on e.lead_id=a.lead_id "
				+ "join builder_project_property_configuration as f on f.id=e.config_id "
				+ "where a.emp_id="+builderEmployee.getId()+" group by a.id order by b.id desc";
		}
		else{
			if(builderEmployee.getBuilderEmployeeAccessType().getId() == 5){
				hql = " SELECT b.id as id, b.name as leadName, b.mobile as phoneNo, b.email as email, b.lead_status as leadStatus, b.min as min, b.max as max, DATE_FORMAT(b.l_date,'%D %M %Y') as strDate,d.name as source, GROUP_CONCAT(f.name) as configName, c.id as salesmanId, c.name as salemanName,"
						+ "(select name from builder_employee where id="+builderEmployee.getId()+") as salesheadName "
					+ "FROM allot_leads as a join builder_lead as b on a.lead_id = b.id "
					+ "join source as d on d.id = b.source "
					+ "join builder_employee as c on a.emp_id = c.id "
					+ "inner join lead_config as e on e.lead_id=a.lead_id "
					+ "join builder_project_property_configuration as f on f.id=e.config_id "
					+ "where b.added_by="+builderEmployee.getId()+" group by a.id order by b.id desc";
			}
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NewLeadList.class));
		System.err.println(hql);
		List<NewLeadList> result = query.list();
		session.close();
		return result;
	}
	
	public List<ConfigData> getConfigDataByProject(String projectIds){
		List<ConfigData> configDatas = new ArrayList<ConfigData>();
		
		String  hql="select DISTINCT(a.property_config_id) as value, b.name as name FROM builder_project_property_configuration_info "
				+ "as a join builder_project_property_configuration as b on a.property_config_id= b.id "
				+ "where "
				+ "a.project_id IN("+projectIds+");";
		HibernateUtil hibernateUtil = new HibernateUtil();
		try {
				Session session = hibernateUtil.getSessionFactory().openSession();
				Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ConfigData.class));
				System.err.println("hql : "+hql);
				configDatas = query.list();
			} catch(Exception e) {
				//
			}
		return configDatas;
	
	}
	
	/**
	 * Get assign projects by passing employee object.
	 * @param builderEmployee
	 * @return List<ProjectData>
	 */
	public List<ProjectData> getAssigProjects(int empId){
		String hql = "";
		String hqlnew = "from BuilderEmployee where id = "+empId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session sessionnew = hibernateUtil.openSession();
		Query querynew = sessionnew.createQuery(hqlnew);
		List<BuilderEmployee> employees = querynew.list();
		BuilderEmployee builderEmployee = employees.get(0);
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
			
		}else{
			hql="SELECT project.name as name, project.id as id from builder_project as project "
					+ "inner join allot_project as ap on ap.project_id = project.id "
					+ "left join builder_employee as emp on emp.id = ap.emp_id"
					+ " where "
					+ "project.status=1 and ap.emp_id="+builderEmployee.getId();
		}
	    Session session = hibernateUtil.getSessionFactory().openSession();
	    Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectData.class));
	    System.err.println(hql);
	   // query.setMaxResults(4);
	    List<ProjectData> result = query.list();
	    session.close();
	    return result;
	}
	
	public List<InboxMessageData> getBookedBuyer(int buyerId){
		List<InboxMessageData> result = null;
		//String hql = "SELECT b.name as name, b.photo as image, im.subject as subject, im.im_date as date  ";
		String hql = " SELECT b.id as id, a.name as name, a.photo as image, b.im_date as date, b.subject as subject  ";
		String where = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		hql += "from buyer as a join inbox_message as b on b.buyer_id=a.id"
			+ " where"
			+ " b.buyer_id="+buyerId;
		hql += where + " AND a.is_primary=1 and a.is_deleted=0 and a.status=0 GROUP by b.id ORDER by b.id DESC";
		try {
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(InboxMessageData.class));
		System.err.println(hql);
		
		 result = query.list();
		
		} catch(Exception e) {
			//
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * @author pankaj 
	 * @param empId
	 * @return
	 */
	public Long getTotalLeadsByEmployeeId(int empId){
		Long totalLeads =(long) 0;
		String hql = "Select COUNT(lead.id) as totalLeads from builder_lead as lead join builder_project as project on project.id=lead.project_id inner join allot_project as ap on ap.project_id=project.id where ap.emp_id=:emp_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(hql);
		System.err.println(hql);
		query.setParameter("emp_id", empId);
		try{
		BigInteger totalLead = (BigInteger) query.uniqueResult();
		//if(totalLeads != null){
			totalLeads = Long.parseLong(totalLead.toString());
			return totalLeads;
		//}else{
		//	return (long)0;
		//}
		}catch(Exception e){
			e.printStackTrace();
			return (long)0;
		}
		
	}
	/**
	 * Get Project name by locality name
	 * @author pankaj
	 * @param cityId
	 * @return List<ProjectData>
	 */
	public List<ProjectData> getProjectNames(String localityName,int empId, int accessId){
		List<ProjectData> localityData = new ArrayList<ProjectData>();
		HibernateUtil hibernateUtil = new HibernateUtil();
		
		String empHql = "from EmployeeRole where builderEmployee.id = "+empId+" AND builderEmployeeAccessType.id="+accessId;
		Session empSession = hibernateUtil.openSession();
		Query empQuery = empSession.createQuery(empHql);
		System.err.println(empHql);
		List<EmployeeRole> employeeRole = empQuery.list();
		String hql = "";
		System.err.println(employeeRole.size());
		if(employeeRole.get(0).getBuilderEmployeeAccessType().getId() > 2)
			hql = "select project.id as id, project.name as name from builder_project as project inner join allot_project as ap on ap.project_id=project.id where project.locality_name = '"+localityName+"' AND ap.emp_id = "+empId+" AND project.status=1 GROUP BY project.id order by project.id desc";
		else{
			hql = "select project.id as id, project.name as name from builder_project as project left join builder as builder on builder.id = project.group_id where project.group_id ="+employeeRole.get(0).getBuilderEmployee().getBuilder().getId()+" and project.status=1 and project.locality_name = '"+localityName+"' GROUP by project.id ORDER by project.id DESC";
		}
		try {
				Session session = hibernateUtil.getSessionFactory().openSession();
				Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectData.class));
				System.err.println("hql : "+hql);
				localityData = query.list();
			} catch(Exception e) {
				//
			}
		return localityData;
	}
	
	//new query
	//To display first 4 active projects on dash board
		/**
		 * Get first 4 active projects by builder id
		 * @author pankaj
		 * @param builderId
		 * @return List<ProjectList>
		 */
		public List<ProjectList> getFirstFourActiveProjectsByBuilderId(BuilderEmployee builderEmployee) {
			String hql = "";
			//code by Pradeep sir
//			if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
//				hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
//					+"project.completion_status as completionStatus,project.inventory_sold as sold, build.id as builderId, "
//					+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
//					+"c.name as cityName, l.id as localityId, l.name as localityName, "
//					+"count(lead.id) as totalLeads "
//					+"FROM  builder_project as project "
//					+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
//					+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id "
//					+"WHERE project.group_id = "+builderEmployee.getBuilder().getId()+" group by project.id order by project.id desc";
//			} else {
//				hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
//						+"project.completion_status as completionStatus,project.inventory_sold as sold, build.id as builderId, "
//						+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
//						+"c.name as cityName, l.id as localityId, l.name as localityName, "
//						+"count(lead.id) as totalLeads "
//						+"FROM  builder_project as project inner join allot_project ap ON project.id = ap.project_id "
//						+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
//						+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id "
//						+"WHERE ap.emp_id = "+builderEmployee.getId()+" group by project.id order by project.id desc";
//			}
			//code changes done by pankaj
			if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
				hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
					+"project.completion_status as completionStatus,project.inventory_sold as sold, project.locality_name as localityName, build.id as builderId, "
					+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
					+"c.name as cityName, "
					+"count(lead.id) as totalLeads "
					+"FROM  builder_project as project "
					+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
					+"left join builder_lead as lead ON project.id = lead.project_id "
					+"WHERE project.status=1 and project.group_id = "+builderEmployee.getBuilder().getId()+" group by project.id order by project.id desc";
			} else {
				hql = "SELECT project.id as id, project.name as name, project.image as image, project.status as status,project.revenue as totalRevenu,"
					+"project.completion_status as completionStatus,project.inventory_sold as sold, project.locality_name as localityName, build.id as builderId, "
					+"project.total_inventory as totalSold ,build.name as builderName, c.id as cityId,"
					+"c.name as cityName, "
					+"count(lead.id) as totalLeads "
					+"FROM  builder_project as project inner join allot_project ap ON project.id = ap.project_id "
					+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
					+"left join builder_lead as lead ON project.id = lead.project_id "
					+"WHERE project.status=1 and ap.emp_id = "+builderEmployee.getId()+" group by project.id order by project.id desc";
			}
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectList.class));
			System.err.println(hql);
			query.setMaxResults(4);
			List<ProjectList> result = query.list();
			session.close();
			return result;
		}
		
		
		  public List<BookingFlatList> getFlatdetailsByFlatEmpIds(int flatId,int empId){
		    	
		    	String emphql = " from BuilderEmployee where id=:id";
		      //  System.err.println("flat id "+flatId);
		    	
		    	List<BookingFlatList> bookings = new ArrayList<BookingFlatList>(); 
		    	BookingFlatList booking = new BookingFlatList();
		    	String hql =" from BuilderFlat where id = :flat_id AND builderFloor.builderBuilding.builderProject.status = 1 AND "
		    			+ " builderFloor.builderBuilding.status = 1 AND builderFloor.status = 1 ";
		    	hql += " AND status = 1 ORDER BY builderFloor.builderBuilding.builderProject.id DESC, builderFloor.builderBuilding.id DESC, builderFloor.floorNo DESC, flatNo DESC";
		    	HibernateUtil hibernateUtil = new HibernateUtil();
		    	Session session = hibernateUtil.openSession();
		    	Query query = session.createQuery(hql);
		    	query.setParameter("flat_id", flatId);
		    	
		    	Session empSession = hibernateUtil.openSession();
		    	Query empQuery = empSession.createQuery(emphql);
		    	empQuery.setParameter("id", empId);
		    	BuilderEmployee employee = (BuilderEmployee) empQuery.list().get(0);
		    	empSession.close();
		    	booking.setAccessId(employee.getBuilderEmployeeAccessType().getId());
		    	try{
			    	BuilderFlat builderFlat = (BuilderFlat) query.list().get(0);
			    	if(builderFlat != null){
			    		if(builderFlat.getBuilderFlatStatus().getId() == 1){
			    			System.err.println("FlatStatus :: "+builderFlat.getBuilderFlatStatus().getName());
			    		booking.setFlatId(builderFlat.getId());
			    		booking.setFlatNo(builderFlat.getFlatNo());
			    		booking.setBalcony(builderFlat.getBalcony());
			    		booking.setBathroom(builderFlat.getBathroom());
			    		booking.setBedroom(builderFlat.getBedroom());
			    		booking.setCarpetArea(builderFlat.getBuilderFlatType().getCarpetArea());
			    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
			    		if(builderFlat.getImage() != null && builderFlat.getImage() != "")
			    			booking.setImage(builderFlat.getImage());
			    		else
			    			booking.setImage("");
			    		booking.setFlatType(builderFlat.getBuilderFlatType().getBuilderProjectPropertyConfiguration().getName());
			    		List<BuilderBuildingFlatTypeRoom> room = getFlatTypeRoom(builderFlat.getBuilderFlatType().getId());
			    		List<BuilderBuildingFlatTypeRoom>  roomList = new ArrayList<BuilderBuildingFlatTypeRoom>();
			    		for(BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom: room){
			    		BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom2 = new BuilderBuildingFlatTypeRoom();
			    			builderBuildingFlatTypeRoom2.setRoomName(builderBuildingFlatTypeRoom.getRoomName());
			    			builderBuildingFlatTypeRoom2.setLength(builderBuildingFlatTypeRoom.getLength());
			    			builderBuildingFlatTypeRoom2.setBreadth(builderBuildingFlatTypeRoom.getBreadth());
			    			builderBuildingFlatTypeRoom2.setLengthUnit(builderBuildingFlatTypeRoom.getLengthUnit());
			    			roomList.add(builderBuildingFlatTypeRoom2);
			    		}
			    		booking.setBuilderBuildingFlatTypeRooms(roomList);
			    		booking.setBreadth(room.get(0).getBreadth());
			    		booking.setLength(room.get(0).getLength());
			    		if(room.get(0).getLengthUnit() == 1)
			    			booking.setAreaUint("Feet");
			    		if(room.get(0).getLengthUnit() == 2)
			    			booking.setAreaUint("Meter");
			    		if(room.get(0).getLengthUnit() == 3)
			    			booking.setAreaUint("Inch");
			    		if(room.get(0).getLengthUnit() == 4)
			    			booking.setRoomName("Yard");
			    	//	booking.setCarpetAreaunit(builderFlat.getBuilderFlatType().);
			    	}
			    	else if(builderFlat.getBuilderFlatStatus().getId() == 2){
			    		try{
			    		Buyer buyer = getBuyerByFlatId(builderFlat.getId());
			    		Cancellation cancellation = new CancellationDAO().getCancellationByFlatId(builderFlat.getId());
			    		
			    		booking.setFlatId(builderFlat.getId());
			    		booking.setFlatNo(builderFlat.getFlatNo());
			    		booking.setBuildingName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
			    		booking.setProjectName(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName());
			    		booking.setBuyerName(buyer.getName());
			    		booking.setBuyerEmail(buyer.getEmail());
			    		booking.setBuyerMobile(buyer.getMobile());
			    		booking.setBuyerPanNo(buyer.getPancard());
			    		if(buyer.getAadhaarNumber() != null)
			    			booking.setBuyerAadhaarNumber(buyer.getAadhaarNumber());
			    		else
			    			booking.setBuyerAadhaarNumber("");
			    		if(buyer.getCurrentAddress()!=null)
			    			booking.setBuyerCurrentAddress(buyer.getCurrentAddress());
			    		else
			    			booking.setBuyerCurrentAddress("");
			    		booking.setBuyerPermanentAddress(buyer.getAddress());
			    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
			    		if(buyer.getIsDeleted() != null){
			    			booking.setIsDeleted(buyer.getIsDeleted());
			    		}else{
			    			Short isDeleted =1;
			    			booking.setIsDeleted(isDeleted);
			    		}
			    		
			    		if(buyer.getPhoto() != null){
			    		booking.setBuyerPhoto(buyer.getPhoto());
			    		}else{
			    			booking.setBuyerPhoto("");
			    		}
			    		if(cancellation != null && employee.getBuilderEmployeeAccessType().getId() == 5){
			    			booking.setCancellationId(cancellation.getId());
			    			booking.setIsApproved(cancellation.isApproved());
			    			booking.setCancelStatus(cancellation.getCancelStatus());
			    			booking.setCancelReason(cancellation.getReason());
			    			booking.setCharges(cancellation.getCharges());
			    			System.err.println("From cancellation if condtion");
			    		}else{
			    			booking.setIsApproved(false);
			    			booking.setCancelStatus(cancellation.getCancelStatus());
			    			booking.setCancelReason("");
			    			booking.setCharges(0.0);
			    			System.err.println("From cancellation else");
			    		}
		    		}catch(Exception e){
		    			e.printStackTrace();
		    			System.err.println("From exception of cancellation");
		    			Buyer buyer = getBuyerByFlatId(builderFlat.getId());
			    		booking.setFlatNo(builderFlat.getFlatNo());
			    		booking.setBuildingName(builderFlat.getBuilderFloor().getBuilderBuilding().getName());
			    		booking.setProjectName(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName());
			    		booking.setBuyerName(buyer.getName());
			    		booking.setBuyerEmail(buyer.getEmail());
			    		booking.setBuyerMobile(buyer.getMobile());
			    		booking.setBuyerPanNo(buyer.getPancard());
			    		booking.setBuyerAadhaarNumber(buyer.getAadhaarNumber());
			    		booking.setBuyerCurrentAddress(buyer.getCurrentAddress());
			    		booking.setBuyerPermanentAddress(buyer.getAddress());
			    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
			    		if(buyer.getPhoto() != null){
			    		booking.setBuyerPhoto(buyer.getPhoto());
			    		}else{
			    			booking.setBuyerPhoto("");
			    		}
		    		}
			    }else if( builderFlat.getBuilderFlatStatus().getId() == 3){
					System.err.println("FlatStatus :: "+builderFlat.getBuilderFlatStatus().getName());
		    		booking.setFlatId(builderFlat.getId());
		    		booking.setFlatNo(builderFlat.getFlatNo());
		    		booking.setBalcony(builderFlat.getBalcony());
		    		booking.setBathroom(builderFlat.getBathroom());
		    		booking.setBedroom(builderFlat.getBedroom());
		    		booking.setCarpetArea(builderFlat.getBuilderFlatType().getCarpetArea());
		    		booking.setFlatStatus(builderFlat.getBuilderFlatStatus().getId());
		    		if(builderFlat.getImage() != null && builderFlat.getImage() != "")
		    			booking.setImage(builderFlat.getImage());
		    		else
		    			booking.setImage("");
		    		booking.setFlatType(builderFlat.getBuilderFlatType().getBuilderProjectPropertyConfiguration().getName());
		    		List<BuilderBuildingFlatTypeRoom> room = getFlatTypeRoom(builderFlat.getBuilderFlatType().getId());
		    		List<BuilderBuildingFlatTypeRoom>  roomList = new ArrayList<BuilderBuildingFlatTypeRoom>();
		    		for(BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom: room){
		    		BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom2 = new BuilderBuildingFlatTypeRoom();
		    			builderBuildingFlatTypeRoom2.setRoomName(builderBuildingFlatTypeRoom.getRoomName());
		    			builderBuildingFlatTypeRoom2.setLength(builderBuildingFlatTypeRoom.getLength());
		    			builderBuildingFlatTypeRoom2.setBreadth(builderBuildingFlatTypeRoom.getBreadth());
		    			builderBuildingFlatTypeRoom2.setLengthUnit(builderBuildingFlatTypeRoom.getLengthUnit());
		    			roomList.add(builderBuildingFlatTypeRoom2);
		    		}
		    		booking.setBuilderBuildingFlatTypeRooms(roomList);
		    		booking.setBreadth(room.get(0).getBreadth());
		    		booking.setLength(room.get(0).getLength());
		    		if(room.get(0).getLengthUnit() == 1)
		    			booking.setAreaUint("Feet");
		    		if(room.get(0).getLengthUnit() == 2)
		    			booking.setAreaUint("Meter");
		    		if(room.get(0).getLengthUnit() == 3)
		    			booking.setAreaUint("Inch");
		    		if(room.get(0).getLengthUnit() == 4)
		    			booking.setRoomName("Yard");
			    	
			    }
		    }}catch(Exception e){
		    		e.printStackTrace();
		    		booking = null;
		    	}
		    	//System.err.println(hql);
		    	bookings.add(booking);
		    	return bookings;
		    }
		
}