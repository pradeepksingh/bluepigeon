package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.bluepigeon.admin.data.ProjectDetail;
import org.bluepigeon.admin.data.ProjectList;
import org.bluepigeon.admin.data.ProjectOffer;
import org.bluepigeon.admin.data.ProjectPaymentSchedule;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
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
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

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
		Session session7 = hibernateUtil.openSession();
		session7.beginTransaction();
		session7.update(newBuilderProject);
		session7.getTransaction().commit();
		session7.close();
		
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
	
	
	/* ******************** Project Floors ******************** */
	
	
	
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
	
}
