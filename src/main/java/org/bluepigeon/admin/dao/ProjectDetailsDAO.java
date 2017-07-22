package org.bluepigeon.admin.dao;

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.bluepigeon.admin.data.BuyerList;
import org.bluepigeon.admin.data.CampaignList;
import org.bluepigeon.admin.data.ProjectDetails;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderEmployee;
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

public class ProjectDetailsDAO {
	public ResponseMessage save(ProjectDetails projectDetails) {
		BuilderProject builderProject= projectDetails.getBuilderProject();
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (builderProject.getName() == null || builderProject.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter project name");
		} else {
			String hql = "from BuilderProject where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", builderProject.getName());
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
				
				Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos = projectDetails.getBuilderProjectPropertyConfigurationInfos();
				Session session2 = hibernateUtil.openSession();
				session2.beginTransaction();
				
				
				Iterator<BuilderProjectPropertyConfigurationInfo> sIterator = builderProjectPropertyConfigurationInfos.iterator();
				while(sIterator.hasNext())
				{
					BuilderProjectPropertyConfigurationInfo builderCompanyNames2 = sIterator.next();
					builderCompanyNames2.setBuilderProject(builderProject);
					session2.save(builderCompanyNames2);
				}
				session2.getTransaction().commit();
				session2.close();
				
				Set<BuilderProjectOfferInfo> builderProjectOfferInfos = projectDetails.getBuilderProjectOfferInfos();
				Session session3 = hibernateUtil.openSession();
				session3.beginTransaction();
				
				
				Iterator<BuilderProjectOfferInfo> sIterator1 = builderProjectOfferInfos.iterator();
				while(sIterator1.hasNext())
				{
					BuilderProjectOfferInfo builderProjectOfferInfo = sIterator1.next();
					builderProjectOfferInfo.setBuilderProject(builderProject);
					session3.save(builderProjectOfferInfo);
				}
				session3.getTransaction().commit();
				session3.close();
				
				Set<BuilderProjectAmenityInfo> builderProjectAmenityInfos = projectDetails.getBuilderProjectAmenityInfos();
				Session session4 = hibernateUtil.openSession();
				session4.beginTransaction();
				
				Iterator<BuilderProjectAmenityInfo> sIterator2 = builderProjectAmenityInfos.iterator();
				while(sIterator2.hasNext())
				{
					BuilderProjectAmenityInfo builderProjectAmenityInfo = sIterator2.next();
					builderProjectAmenityInfo.setBuilderProject(builderProject);
					session4.save(builderProjectAmenityInfo);
				}
				session4.getTransaction().commit();
				session4.close();
				
				Set<BuilderProjectBankInfo> builderProjectBankInfos = projectDetails.getBuilderProjectBankInfos();
				Session session5 = hibernateUtil.openSession();
				session5.beginTransaction();
				
				Iterator<BuilderProjectBankInfo> sIterator3 = builderProjectBankInfos.iterator();
				while(sIterator3.hasNext())
				{
					BuilderProjectBankInfo bankInfo = sIterator3.next();
					bankInfo.setBuilderProject(builderProject);
					session5.save(bankInfo);
				}
				session5.getTransaction().commit();
				session5.close();
				
				Set<BuilderProjectPriceInfo> builderProjectPriceInfos = projectDetails.getBuilderProjectPriceInfos();
				Session session6 = hibernateUtil.openSession();
				session6.beginTransaction();
				
				Iterator<BuilderProjectPriceInfo> sIterator4 = builderProjectPriceInfos.iterator();
				while(sIterator4.hasNext())
				{
					BuilderProjectPriceInfo builderProjectPriceInfo = sIterator4.next();
					builderProjectPriceInfo.setBuilderProject(builderProject);
					session6.save(builderProjectPriceInfo);
				}
				session6.getTransaction().commit();
				session6.close();
				
				Set<BuilderProjectPaymentInfo> builderProjectPaymentInfos = projectDetails.getBuilderProjectPaymentInfos();
				Session session7 = hibernateUtil.openSession();
				session7.beginTransaction();
				
				Iterator<BuilderProjectPaymentInfo> sIterator5 = builderProjectPaymentInfos.iterator();
				while(sIterator5.hasNext())
				{
					BuilderProjectPaymentInfo builderProjectPaymentInfo = sIterator5.next();
					builderProjectPaymentInfo.setBuilderProject(builderProject);
					session7.save(builderProjectPaymentInfo);
				}
				session7.getTransaction().commit();
				session7.close();
				
				Set<BuilderProjectProjectType> builderProjectProjectTypes = projectDetails.getBuilderProjectProjectTypes();
				Session session8 = hibernateUtil.openSession();
				session8.beginTransaction();
				
				Iterator<BuilderProjectProjectType> sIterator6 = builderProjectProjectTypes.iterator();
				while(sIterator6.hasNext())
				{
					BuilderProjectProjectType builderProjectProjectType = sIterator6.next();
					builderProjectProjectType.setBuilderProject(builderProject);
					session8.save(builderProjectProjectType);
				}
				session8.getTransaction().commit();
				session8.close();
				
				Set<BuilderProjectApprovalInfo> builderProjectApprovalInfos = projectDetails.getBuilderProjectApprovalInfos();
				Session session9 = hibernateUtil.openSession();
				session9.beginTransaction();
				
				Iterator<BuilderProjectApprovalInfo> sIterator7 = builderProjectApprovalInfos.iterator();
				while(sIterator7.hasNext())
				{
					BuilderProjectApprovalInfo builderProjectApprovalInfo = sIterator7.next();
					builderProjectApprovalInfo.setBuilderProject(builderProject);
					session9.save(builderProjectApprovalInfo);
				}
				session9.getTransaction().commit();
				session9.close();
				
				
				Set<BuilderProjectPropertyType> builderProjectPropertyTypes = projectDetails.getBuilderProjectPropertyTypes();
				Session session10 = hibernateUtil.openSession();
				session10.beginTransaction();
				
				Iterator<BuilderProjectPropertyType> sIterator8 = builderProjectPropertyTypes.iterator();
				while(sIterator8.hasNext())
				{
					BuilderProjectPropertyType builderProjectPropertyType = sIterator8.next();
					builderProjectPropertyType.setBuilderProject(builderProject);
					session10.save(builderProjectPropertyType);
				}
				session10.getTransaction().commit();
				session10.close();
				
				response.setStatus(1);
				response.setMessage("Project added Successfully");
			}
		}
		return response;
	}

	public ResponseMessage update(ProjectDetails projectDetails) {
		BuilderProject builderProject=projectDetails.getBuilderProject();
		
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from BuilderProject where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderProject.getName());
		query.setParameter("id", builderProject.getId());
		List<BuilderProject> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Projecct name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(builderProject);
			newsession.getTransaction().commit();
			newsession.close();
			
			Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos = projectDetails.getBuilderProjectPropertyConfigurationInfos();
					
			 Set<BuilderProjectOfferInfo> builderProjectOfferInfos = projectDetails.getBuilderProjectOfferInfos();
			 Set<BuilderProjectAmenityInfo> builderProjectAmenityInfos = projectDetails.getBuilderProjectAmenityInfos();
			 Set<BuilderProjectBankInfo> builderProjectBankInfos = projectDetails.getBuilderProjectBankInfos();
			 Set<BuilderProjectPriceInfo> builderProjectPriceInfos = projectDetails.getBuilderProjectPriceInfos();
			 Set<BuilderProjectPaymentInfo> builderProjectPaymentInfos = projectDetails.getBuilderProjectPaymentInfos();
			 Set<BuilderProjectProjectType> builderProjectProjectTypes = projectDetails.getBuilderProjectProjectTypes();
			 Set<BuilderProjectApprovalInfo> builderProjectApprovalInfos = projectDetails.getBuilderProjectApprovalInfos();
			 Set<BuilderProjectPropertyType> builderProjectPropertyTypes = projectDetails.getBuilderProjectPropertyTypes();
			 
			 if(builderProjectPropertyConfigurationInfos.size()>0){
			String deleteBuilderCompanyName = "DELETE from BuilderProjectPropertyConfigurationInfo where builderProject.id = :project_id";
			Session newsession1 = hibernateUtil.openSession();
			newsession1.beginTransaction();
			Query smdelete = newsession1.createQuery(deleteBuilderCompanyName);
			smdelete.setParameter("project_id", builderProject.getId());
			smdelete.executeUpdate();
			newsession1.getTransaction().commit();
			newsession1.close();
			
			Session session2 = hibernateUtil.openSession();
			session2.beginTransaction();
				Iterator<BuilderProjectPropertyConfigurationInfo> bIterator = builderProjectPropertyConfigurationInfos.iterator();
				while(bIterator.hasNext()){
					BuilderProjectPropertyConfigurationInfo builderCompanyNames2 = bIterator.next();
					builderCompanyNames2.setBuilderProject(builderProject);
					session2.save(builderCompanyNames2);
					
				}
			
			session2.getTransaction().commit();
			session2.close();
			
			 }
			 
			 if(builderProjectOfferInfos.size()>0){
					String deleteBuilderCompanyName = "DELETE from BuilderProjectOfferInfo where builderProject.id = :project_id";
					Session newsession21 = hibernateUtil.openSession();
					newsession21.beginTransaction();
					Query smdelete = newsession21.createQuery(deleteBuilderCompanyName);
					smdelete.setParameter("project_id", builderProject.getId());
					smdelete.executeUpdate();
					newsession21.getTransaction().commit();
					newsession21.close();
					
					Session session3 = hibernateUtil.openSession();
					session3.beginTransaction();
						Iterator<BuilderProjectOfferInfo> bIterator = builderProjectOfferInfos.iterator();
						while(bIterator.hasNext()){
							BuilderProjectOfferInfo builderCompanyNames2 = bIterator.next();
							builderCompanyNames2.setBuilderProject(builderProject);
							session3.save(builderCompanyNames2);
							
						}
					
					session3.getTransaction().commit();
					session3.close();
					
			 }
			 
			 if(builderProjectAmenityInfos.size()>0){
					String deleteBuilderCompanyName = "DELETE from BuilderProjectAmenityInfo where builderProject.id = :project_id";
					Session newsession4 = hibernateUtil.openSession();
					newsession4.beginTransaction();
					Query smdelete = newsession4.createQuery(deleteBuilderCompanyName);
					smdelete.setParameter("project_id", builderProject.getId());
					smdelete.executeUpdate();
					newsession4.getTransaction().commit();
					newsession4.close();
					
					Session session5 = hibernateUtil.openSession();
					session5.beginTransaction();
						Iterator<BuilderProjectAmenityInfo> bIterator = builderProjectAmenityInfos.iterator();
						while(bIterator.hasNext()){
							BuilderProjectAmenityInfo builderCompanyNames2 = bIterator.next();
							builderCompanyNames2.setBuilderProject(builderProject);
							session5.save(builderCompanyNames2);
							
						}
					
					session5.getTransaction().commit();
					session5.close();
					
			 }
			 
			 if(builderProjectBankInfos.size()>0){
					String deleteBuilderCompanyName = "DELETE from BuilderProjectBankInfo where builderProject.id = :project_id";
					Session newsession6 = hibernateUtil.openSession();
					newsession6.beginTransaction();
					Query smdelete = newsession6.createQuery(deleteBuilderCompanyName);
					smdelete.setParameter("project_id", builderProject.getId());
					smdelete.executeUpdate();
					newsession6.getTransaction().commit();
					newsession6.close();
					
					Session session7 = hibernateUtil.openSession();
					session7.beginTransaction();
						Iterator<BuilderProjectBankInfo> bIterator = builderProjectBankInfos.iterator();
						while(bIterator.hasNext()){
							BuilderProjectBankInfo builderCompanyNames2 = bIterator.next();
							builderCompanyNames2.setBuilderProject(builderProject);
							session7.save(builderCompanyNames2);
							
						}
					
					session7.getTransaction().commit();
					session7.close();
					
			 }
			 
			 if(builderProjectPriceInfos.size()>0){
					String deleteBuilderCompanyName = "DELETE from BuilderProjectPriceInfo where builderProject.id = :project_id";
					Session newsession8 = hibernateUtil.openSession();
					newsession8.beginTransaction();
					Query smdelete = newsession8.createQuery(deleteBuilderCompanyName);
					smdelete.setParameter("project_id", builderProject.getId());
					smdelete.executeUpdate();
					newsession8.getTransaction().commit();
					newsession8.close();
					
					Session session9 = hibernateUtil.openSession();
					session9.beginTransaction();
						Iterator<BuilderProjectPriceInfo> bIterator = builderProjectPriceInfos.iterator();
						while(bIterator.hasNext()){
							BuilderProjectPriceInfo builderCompanyNames2 = bIterator.next();
							builderCompanyNames2.setBuilderProject(builderProject);
							session9.save(builderCompanyNames2);
							
						}
					
					session9.getTransaction().commit();
					session9.close();
					
			 }
			 
			 if(builderProjectPaymentInfos.size()>0){
					String deleteBuilderCompanyName = "DELETE from BuilderProjectPaymentInfo where builderProject.id = :project_id";
					Session newsession10 = hibernateUtil.openSession();
					newsession10.beginTransaction();
					Query smdelete = newsession10.createQuery(deleteBuilderCompanyName);
					smdelete.setParameter("project_id", builderProject.getId());
					smdelete.executeUpdate();
					newsession10.getTransaction().commit();
					newsession10.close();
					
					Session session11 = hibernateUtil.openSession();
					session11.beginTransaction();
						Iterator<BuilderProjectPaymentInfo> bIterator = builderProjectPaymentInfos.iterator();
						while(bIterator.hasNext()){
							BuilderProjectPaymentInfo builderCompanyNames2 = bIterator.next();
							builderCompanyNames2.setBuilderProject(builderProject);
							session11.save(builderCompanyNames2);
							
						}
					
					session11.getTransaction().commit();
					session11.close();
					
			 }
			 
			 if(builderProjectProjectTypes.size()>0){
					String deleteBuilderCompanyName = "DELETE from BuilderProjectProjectType where builderProject.id = :project_id";
					Session newsession12 = hibernateUtil.openSession();
					newsession12.beginTransaction();
					Query smdelete = newsession12.createQuery(deleteBuilderCompanyName);
					smdelete.setParameter("project_id", builderProject.getId());
					smdelete.executeUpdate();
					newsession12.getTransaction().commit();
					newsession12.close();
					
					Session session13 = hibernateUtil.openSession();
					session13.beginTransaction();
						Iterator<BuilderProjectProjectType> bIterator = builderProjectProjectTypes.iterator();
						while(bIterator.hasNext()){
							BuilderProjectProjectType builderCompanyNames2 = bIterator.next();
							builderCompanyNames2.setBuilderProject(builderProject);
							session13.save(builderCompanyNames2);
						}
					session13.getTransaction().commit();
					session13.close();
			 }
			 if(builderProjectApprovalInfos.size()>0){
					String deleteBuilderCompanyName = "DELETE from BuilderProjectApprovalInfo where builderProject.id = :project_id";
					Session newsession14 = hibernateUtil.openSession();
					newsession14.beginTransaction();
					Query smdelete = newsession14.createQuery(deleteBuilderCompanyName);
					smdelete.setParameter("project_id", builderProject.getId());
					smdelete.executeUpdate();
					newsession14.getTransaction().commit();
					newsession14.close();
					
					Session session15 = hibernateUtil.openSession();
					session15.beginTransaction();
						Iterator<BuilderProjectApprovalInfo> bIterator = builderProjectApprovalInfos.iterator();
						while(bIterator.hasNext()){
							BuilderProjectApprovalInfo builderCompanyNames2 = bIterator.next();
							builderCompanyNames2.setBuilderProject(builderProject);
							session15.save(builderCompanyNames2);
							
						}
					
					session15.getTransaction().commit();
					session15.close();
					
			 }
			 
			 if(builderProjectPropertyTypes.size()>0){
					String deleteBuilderCompanyName = "DELETE from BuilderProjectPropertyType where builderProject.id = :project_id";
					Session newsession16 = hibernateUtil.openSession();
					newsession16.beginTransaction();
					Query smdelete = newsession16.createQuery(deleteBuilderCompanyName);
					smdelete.setParameter("project_id", builderProject.getId());
					smdelete.executeUpdate();
					newsession16.getTransaction().commit();
					newsession16.close();
					
					Session session17 = hibernateUtil.openSession();
					session17.beginTransaction();
						Iterator<BuilderProjectPropertyType> bIterator = builderProjectPropertyTypes.iterator();
						while(bIterator.hasNext()){
							BuilderProjectPropertyType builderCompanyNames2 = bIterator.next();
							builderCompanyNames2.setBuilderProject(builderProject);
							session17.save(builderCompanyNames2);
							
						}
					
					session17.getTransaction().commit();
					session17.close();
					
					 }
			 
			response.setStatus(1);
			response.setMessage("Project Updated Successfully");
		}
		return response;
	}

	public List<BuilderProject> getBuilderProjectList() {
		String hql = "from BuilderProject";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderProject> result = query.list();
		
		session.close();
		return result;
	}
	/**
	 * Get all active project list
	 * @author pankaj
	 * @return List<BuilderProject>
	 */
	public List<BuilderProject> getBuilderActiveProjectList() {
		String hql = "from BuilderProject where status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderProject> result = query.list();
		
		session.close();
		return result;
	}
	
	
	/**
	 * Get active project list
	 * @author pankaj
	 * @param builderId
	 * @return List<BuilderProject>
	 */
	public List<BuilderProject> getBuilderActiveProjectList(int builderId) {
		String hql = "from BuilderProject where builder.id= :builder_id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<BuilderProject> result = query.list();
		session.close();
		return result;
	}

	public List<BuilderProject> getBuilderProjectById(int id) {
		String hql = "from BuilderProject where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderProject> result = query.list();
		session.close();
		return result;
	}
	public List<BuilderProjectBankInfo> getBuilderProjectBankInfoByProjectId(int projectId){
		String hql = "from BuilderProjectBankInfo where project_id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderProjectBankInfo> result = query.list();
		session.close();
		return result;
	}
	public List<BuilderProjectPropertyConfigurationInfo> getBuilderProjectPropertyConfigurationInfoByProjectId(int projectId){
		String hql = "from BuilderProjectPropertyConfigurationInfo where project_id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderProjectPropertyConfigurationInfo> result = query.list();
		session.close();
		return result;
	}
	public List<BuilderProjectApprovalInfo> getBuilderProjectApprovalInfoByProjectId(int projectId){
		String hql = "from BuilderProjectApprovalInfo where project_id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderProjectApprovalInfo> result = query.list();
		session.close();
		return result;
	}
	public List<BuilderProjectProjectType> getBuilderProjectProjectTypeByProjectId(int projectId){
		String hql = "from BuilderProjectProjectType where project_id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderProjectProjectType> result = query.list();
		session.close();
		return result;
	}
	public List<BuilderProjectAmenityInfo> getBuilderProjectAmenityInfoByProjectId(int projectId){
		String hql = "from BuilderProjectAmenityInfo where project_id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderProjectAmenityInfo> result = query.list();
		session.close();
		return result;
	}
	public List<BuilderProjectOfferInfo> getBuilderProjectOfferInfoByProjectId(int projectId){
		String hql = "from BuilderProjectOfferInfo where project_id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderProjectOfferInfo> result = query.list();
		session.close();
		return result;
	}
	public List<BuilderProjectPaymentInfo> getBuilderProjectPaymentInfoByProjectId(int projectId){
		String hql = "from BuilderProjectPaymentInfo where project_id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderProjectPaymentInfo> result = query.list();
		session.close();
		return result;
	}
	public List<BuilderProjectPriceInfo> getBuilderProjectPriceInfoByProjectId(int projectId){
		String hql = "from BuilderProjectPriceInfo where project_id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		List<BuilderProjectPriceInfo> result = query.list();
		session.close();
		return result;
	}
}
