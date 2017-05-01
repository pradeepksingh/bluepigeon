package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.bluepigeon.admin.data.FloorData;
import org.bluepigeon.admin.data.FloorDetail;
import org.bluepigeon.admin.data.FloorImageData;
import org.bluepigeon.admin.data.FloorPanoData;
import org.bluepigeon.admin.data.ProjectDetail;
import org.bluepigeon.admin.data.ProjectList;
import org.bluepigeon.admin.data.ProjectOffer;
import org.bluepigeon.admin.data.ProjectPaymentSchedule;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderBuildingFlatType;
import org.bluepigeon.admin.model.BuilderBuildingFlatTypeRoom;
import org.bluepigeon.admin.model.BuilderFlat;
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
import org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo;
import org.bluepigeon.admin.model.BuilderProjectPropertyType;
import org.bluepigeon.admin.model.BuildingAmenityInfo;
import org.bluepigeon.admin.model.BuildingAmenityWeightage;
import org.bluepigeon.admin.model.BuildingImageGallery;
import org.bluepigeon.admin.model.BuildingOfferInfo;
import org.bluepigeon.admin.model.BuildingPanoramicImage;
import org.bluepigeon.admin.model.BuildingPaymentInfo;
import org.bluepigeon.admin.model.FlatAmenityInfo;
import org.bluepigeon.admin.model.FlatAmenityWeightage;
import org.bluepigeon.admin.model.FlatImageGallery;
import org.bluepigeon.admin.model.FlatPanoramicImage;
import org.bluepigeon.admin.model.FlatPaymentSchedule;
import org.bluepigeon.admin.model.FlatTypeImage;
import org.bluepigeon.admin.model.FloorAmenityInfo;
import org.bluepigeon.admin.model.FloorAmenityWeightage;
import org.bluepigeon.admin.model.FloorLayoutImage;
import org.bluepigeon.admin.model.FloorImageGallery;
import org.bluepigeon.admin.model.FloorPanoramicImage;
import org.bluepigeon.admin.model.ProjectAmenityWeightage;
import org.bluepigeon.admin.model.ProjectImageGallery;
import org.bluepigeon.admin.model.ProjectPanoramicImage;
import org.bluepigeon.admin.model.Tax;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;


public class ProjectDAO {
	
	public ResponseMessage saveProject(BuilderProject builderProject) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderProject where name = :name AND locality.id = :locality_id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderProject.getName());
		query.setParameter("locality_id", builderProject.getLocality().getId());
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
	
	public ResponseMessage updateBasicInfo(BuilderProject builderProject) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderProject where name = :name AND locality.id = :locality_id AND id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderProject.getName());
		query.setParameter("locality_id", builderProject.getLocality().getId());
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
		Session session8 = hibernateUtil.openSession();
		session8.beginTransaction();
		session8.update(newBuilderProject);
		session8.getTransaction().commit();
		session8.close();
		
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
			newproject.setCityId(builderproject.getCity().getId());
			newproject.setCityName(builderproject.getCity().getName());
			newproject.setLocalityId(builderproject.getLocality().getId());
			newproject.setLocalityName(builderproject.getLocality().getName());
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
		hql = hql + where;
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
			newproject.setLocalityId(builderproject.getLocality().getId());
			newproject.setLocalityName(builderproject.getLocality().getName());
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
	
	public List<BuilderFlat> getBuilderAllFlats() {
		String hql = "from BuilderFlat order by builderFloor.builderBuilding.builderProject.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
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
	
	public List<FlatAmenityWeightage> getFlatAmenityWeightageByFloorId(int flat_id) {
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
	
	public ResponseMessage addBuildingFlat(BuilderFlat builderFlat) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(builderFlat);
		newsession.getTransaction().commit();
		newsession.close();
		response.setId(builderFlat.getId());
		response.setStatus(1);
		response.setMessage("Building flat Added Successfully.");
		return response;
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
	
}
