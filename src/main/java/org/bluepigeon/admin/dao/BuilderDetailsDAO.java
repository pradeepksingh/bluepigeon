package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AllotProject;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderEmployeeAccessType;
import org.bluepigeon.admin.model.BuilderLogo;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.ProjectImageGallery;
import org.bluepigeon.admin.data.BarGraphData;
import org.bluepigeon.admin.data.BuilderDetails;
import org.bluepigeon.admin.data.BuilderProjectList;
import org.bluepigeon.admin.data.EmployeeList;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderDetailsDAO {
	public ResponseMessage save(BuilderDetails builderDetails) {
		Builder builder= builderDetails.getBuilder();
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (builder.getName() == null || builder.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter builder name");
		} else {
			String hql = "from Builder where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", builder.getName());
			List<Builder> result = query.list();
			session.close();
			if (result.size() > 0) {
				
				response.setStatus(0);
				response.setMessage("Builder name already exists");
				
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(builder);
				
				newsession.getTransaction().commit();
				newsession.close();
				
				List<BuilderCompanyNames> builderCompanyNames = builderDetails.getBuilderCompanyNames();
				if(builderCompanyNames.size()>0){
				Session session2 = hibernateUtil.openSession();
				session2.beginTransaction();
				
				Iterator<BuilderCompanyNames> sIterator = builderCompanyNames.iterator();
				while(sIterator.hasNext())
				{
					BuilderCompanyNames builderCompanyNames2 = sIterator.next();
					builderCompanyNames2.setBuilder(builder);
					session2.save(builderCompanyNames2);
				}
				session2.getTransaction().commit();
				session2.close();
				response.setStatus(1);
				response.setMessage("Builder added Successfully");
				}
				else{
					response.setStatus(0);
					response.setMessage("Unable to update company details. Please try again");
				}
			}
		}
		return response;
	}

	public ResponseMessage update(BuilderDetails builderDetails) {
		Builder builder=builderDetails.getBuilder();
		
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from Builder where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builder.getName());
		query.setParameter("id", builder.getId());
		List<Builder> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Builder name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(builder);
			newsession.getTransaction().commit();
			newsession.close();
			List<BuilderCompanyNames> builderCompanyNames= builderDetails.getBuilderCompanyNames();
			 if(builderCompanyNames.size()>0){
			String deleteBuilderCompanyName = "DELETE from BuilderCompanyNames  where builder.id = :builder_id";
			Session newsession1 = hibernateUtil.openSession();
			
			newsession1.beginTransaction();
			Query smdelete = newsession1.createQuery(deleteBuilderCompanyName);
			smdelete.setParameter("builder_id", builder.getId());
			smdelete.executeUpdate();
			newsession1.getTransaction().commit();
			newsession1.close();
			
			
			Session session2 = hibernateUtil.openSession();
			session2.beginTransaction();
			
			if(builderCompanyNames.size()>0){
				Iterator<BuilderCompanyNames> bIterator = builderCompanyNames.iterator();
				while(bIterator.hasNext()){
					BuilderCompanyNames builderCompanyNames2 = bIterator.next();
					builderCompanyNames2.setBuilder(builder);
					System.out.println("BuilderComapanyName : "+builderCompanyNames2.getName()+"\nEmail :: "+builderCompanyNames2.getEmail()+"\nContact :: "+builderCompanyNames2.getContact());
					session2.save(builderCompanyNames2);
					
				}
			}
			session2.getTransaction().commit();
			session2.close();
			response.setStatus(1);
			response.setMessage("Builder Updated Successfully");
		  }
		}
		return response;
	}
     
	public ResponseMessage saveBuilder(Builder builder){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.save(builder);
		session.getTransaction().commit();
		session.close();
		responseMessage.setId(builder.getId());
		return responseMessage;
	}
	public void updateBuilder(Builder builder){
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(builder);
		newsession.getTransaction().commit();
		newsession.close();
	}
	
	public ResponseMessage updateBuilderCompanyName(List<BuilderCompanyNames> builderCompanyNames){
		ResponseMessage msg = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(builderCompanyNames.size()>0){
			try{
				String deleteBuilderCompanyName = "Update from BuilderCompanyNames  set name=:name,email=:email,contact=:contact where id = :id";
				Session newsession1 = hibernateUtil.openSession();
				newsession1.beginTransaction();
				for(BuilderCompanyNames builderCompanyNames2 : builderCompanyNames){
					Query smupdate = newsession1.createQuery(deleteBuilderCompanyName);
					smupdate.setParameter("id", builderCompanyNames2.getId());
					smupdate.setParameter("name", builderCompanyNames2.getName());
					smupdate.setParameter("email", builderCompanyNames2.getEmail());
					smupdate.setParameter("contact", builderCompanyNames2.getContact());
					smupdate.executeUpdate();
					//newsession1.update(builderCompanyNames2);
				}
				newsession1.getTransaction().commit();
				newsession1.close();
				msg.setStatus(1);
				msg.setMessage("Builder updated successfully.");
			}catch(Exception e){
			//	org.hibernate.Transaction t;
				//t.rollback();
				//throw e;
				e.printStackTrace();
				
//				Session session2 = hibernateUtil.openSession();
//				session2.beginTransaction();
//				for(int i=count;count<objectCount;i++){
//					session2.save(builderCompanyNames.get(i));
//				}
//				session2.getTransaction().commit();
//				session2.close();
				msg.setStatus(0);
				msg.setMessage("Builder updated Fail.");
			}
			
		 }
		return msg;
	}
	
	public void saveBuilderCompany(List<BuilderCompanyNames> builderCompanyNames){
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		for(BuilderCompanyNames builderCompanyNames2 : builderCompanyNames)
			session.save(builderCompanyNames2);
		session.getTransaction().commit();
		session.close();
	}
	public List<Builder> getBuilderList() {
		String hql = "from Builder";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Builder> result = query.list();
		
		session.close();
		return result;
	}
	
	public List<Builder> getActiveBuilderList() {
		String hql = "from Builder where status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Builder> result = query.list();
		
		session.close();
		return result;
	}
	
	public Builder getBuilderById(int id){
		Builder builder = null;
		String hql = "from Builder where id =:id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		builder = (Builder) query.list().get(0);
		return builder;
	}
	public List<BuilderEmployeeAccessType> getBuilderAccessList(int accessId) {
		List<BuilderEmployeeAccessType> result = null;
		String hql = "from BuilderEmployeeAccessType where id > :access_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		if(accessId != 3 || accessId !=6 || accessId != 7){
		Query query = session.createQuery(hql);
		query.setParameter("access_id", accessId);
		result = query.list();
		}
		session.close();
		
		return result;
	}
	
	public List<Builder> getActiveBuilderById(int id) {
		String hql = "from Builder where id = :id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Builder> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderCompanyNames> getBuilderCompanyNameList(int builderId) {
		String hql = "from BuilderCompanyNames where builder.id=:builder_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<BuilderCompanyNames> result = query.list();
		List<BuilderCompanyNames> builderCompanyNamesList = new ArrayList<BuilderCompanyNames>();
		for(int i=0; i<result.size(); i++){
			BuilderCompanyNames builderCompanyNames = new BuilderCompanyNames();
			builderCompanyNames.setId(result.get(i).getId());
			builderCompanyNames.setName(result.get(i).getName());
			builderCompanyNamesList.add(builderCompanyNames);
		}
		
		session.close();
		return builderCompanyNamesList;
	}
	
	public List<BuilderCompanyNames> getAllBuilderCompanyNameByBuilderId(int builderId) {
		String hql = "from BuilderCompanyNames where builder.id=:builder_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<BuilderCompanyNames> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderEmployee> getBuilderEmployees(int builder_id) {
		String hql = "from BuilderEmployee where builder.id=:builder_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builder_id);
		List<BuilderEmployee> result = query.list();
		session.close();
		return result;
	}
	public ResponseMessage updateBuilderPassword(String oldPassword, String newPassword){
		ResponseMessage responseMessage = new ResponseMessage();
		String passwordHql = "from BuilderEmployee where password = :password";
		String hql = "UPDATE BuilderEmployee set password = :password, loginStatus=1 "  + 
	             "WHERE id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session passwordSession = hibernateUtil.openSession();
		Session updatePasswordSession = hibernateUtil.openSession();
		Query passwordQuery = passwordSession.createQuery(passwordHql);
		passwordQuery.setParameter("password", oldPassword);
		BuilderEmployee builder = (BuilderEmployee) passwordQuery.list().get(0);
		if(builder != null){
			updatePasswordSession.beginTransaction();
			Query query = updatePasswordSession.createQuery(hql);
			query.setParameter("password", newPassword);
			query.setParameter("id", builder.getId());
			System.out.println("Password in DB ::: "+oldPassword);
			System.out.println("New Password ::: "+newPassword);
			int result = query.executeUpdate();
			updatePasswordSession.getTransaction().commit();
			System.out.println("Rows affected: " + result);
			if(result >0){
				responseMessage.setStatus(1);
				responseMessage.setMessage("Your Password is suceessfuly change");
			}else{
				responseMessage.setStatus(0);
				responseMessage.setMessage("Fail to update you password. Please try again");
			}
		}else{
			responseMessage.setStatus(0);
			responseMessage.setMessage("Fail to update you password. Please try again");
		}
		passwordSession.close();
		updatePasswordSession.close();
		return responseMessage;
	}
	
	public ResponseMessage saveEmployee(BuilderEmployee builderEmployee){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(builderEmployee);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setId(builderEmployee.getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Empolyee Added Successfully.");
		return responseMessage;
	}
	public List<EmployeeList> getBuilderEmployeeList(BuilderEmployee builderEmployeeList) {
		String hql = "from BuilderEmployee where builder.id=:builder_id";
		String empHql = "from BuilderEmployee where builder.id = :builder_id and builderEmployee.id = :reporting_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = null;
		if(builderEmployeeList.getBuilderEmployeeAccessType().getId() == 1 || builderEmployeeList.getBuilderEmployeeAccessType().getId()==2){
			query = session.createQuery(hql);
			query.setParameter("builder_id", builderEmployeeList.getBuilder().getId());
		}
		if(builderEmployeeList.getBuilderEmployeeAccessType().getId() == 4 || builderEmployeeList.getBuilderEmployeeAccessType().getId() ==5){
			query = session.createQuery(empHql);
			query.setParameter("builder_id", builderEmployeeList.getBuilder().getId());
			query.setParameter("reporting_id",builderEmployeeList.getId() );
		}
			
		List<BuilderEmployee> result = query.list();
		List<EmployeeList> employeeLists = new ArrayList<EmployeeList>();
		int count=1;
		for(BuilderEmployee builderEmployee : result){
			EmployeeList employeeList = new EmployeeList();
			employeeList.setCount(count);
			employeeList.setName(builderEmployee.getName());
			employeeList.setId(builderEmployee.getId());
			employeeList.setAccess(builderEmployee.getBuilderEmployeeAccessType().getName());
			employeeList.setDesgnation(builderEmployee.getDesignation());
			employeeLists.add(employeeList);
			count++;
		}
		session.close();
		return employeeLists;
	}
	/**
	 * Get All active builder's employee list
	 * @author pankaj
	 * @param builder_id
	 * @return  List<EmployeeList>
	 */
	public List<EmployeeList> getBuilderActiveEmployeeListByBuilderId(int builder_id) {
		String hql = "from BuilderEmployee where builder.id=:builder_id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builder_id);
		List<BuilderEmployee> result = query.list();
		List<EmployeeList> employeeLists = new ArrayList<EmployeeList>();
		int count=1;
		for(BuilderEmployee builderEmployee : result){
			EmployeeList employeeList = new EmployeeList();
			employeeList.setCount(count);
			employeeList.setName(builderEmployee.getName());
			employeeList.setId(builderEmployee.getId());
			employeeList.setAccess(builderEmployee.getBuilderEmployeeAccessType().getName());
			employeeList.setDesgnation(builderEmployee.getDesignation());
			employeeLists.add(employeeList);
			count++;
		}
		session.close();
		return employeeLists;
	}
	
	public List<EmployeeList> getEmployeeListFilter(int city_id,int project_id) {
		String hql = "from BuilderEmployee where ";
		String where = "";
		
		if(project_id > 0) {
			where = where + "builderProject.id = :project_id ";
		}
		if(city_id > 0) {
			if(where != "") {
				where = where + "AND builderBuilding.id = :city_id ";
			} else {
				where = where + "builderBuilding.id = :city_id ";
			}
		}
		
		hql = hql + where;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		if(project_id > 0) {
			query.setParameter("project_id", project_id);
		}
		if(city_id > 0) {
			query.setParameter("city_id", city_id);
		}
		
		List<BuilderEmployee> result = query.list();
		List<EmployeeList> employeeList = new ArrayList<EmployeeList>();
		int i=1;
		for(BuilderEmployee employee : result) {
			EmployeeList bList = new EmployeeList();
			bList.setCount(i);
			bList.setName(employee.getName());
			bList.setAccess(employee.getBuilderEmployeeAccessType().getName());
			employeeList.add(bList);
			i++;
		}
		session.close();
		return employeeList;
	}
	
	public ResponseMessage updateProjectDetails(int buildingId,int projectId,String name,int totalFloor){
		ResponseMessage msg = new ResponseMessage();
		String hql = "update BuilderBuilding set builderProject.id=:project_id, name=:name,total_floor = :total_floor where id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", buildingId);
		query.setParameter("project_id", projectId);
		query.setParameter("name", name);
		query.setParameter("total_floor", totalFloor);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		msg.setStatus(1);
		msg.setMessage("Updated Successfully");
		return msg;
	}
	
	public ResponseMessage updateBuilding(int buildingId, Date launchDate,Date possessionDate,Integer status) {
		ResponseMessage resp = new ResponseMessage();
		String hql = "update BuilderBuilding set launch_date=:launch_date,possession_date = :possession_date,builderBuildingStatus.id=:status_id  where id = :building_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		Query query = newsession.createQuery(hql);
		query.setParameter("building_id", buildingId);
		query.setParameter("launch_date", launchDate);
		query.setParameter("possession_date", possessionDate);
		query.setParameter("status_id", status);
		query.executeUpdate();
		newsession.getTransaction().commit();
		newsession.close();
		
		resp.setId(buildingId);
		resp.setMessage("Building updated successfully.");
		resp.setStatus(1);
		return resp;
	}
	
	public BuilderEmployee getBuilderEmployeeById(int id) {
		String hql = "from BuilderEmployee where id=:id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderEmployee> result = query.list();
		session.close();
		return result.get(0);
	}
	/**
	 * Get active builder employee by id
	 * @author pankaj
	 * @param id
	 * @return employee
	 */
	public BuilderEmployee getBuilderActiveEmployeeById(int id) {
		String hql = "from BuilderEmployee where id=:id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderEmployee> result = query.list();
		session.close();
		return result.get(0);
	}
	
	public ResponseMessage updateBuilderEmployee(BuilderEmployee builderEmployee){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(builderEmployee);
		newsession.getTransaction().commit();
		newsession.close();
		response.setStatus(1);
		response.setMessage("Employee updated Successfully");
		return response;
	}
	/**
	 * Save builder logo
	 * @author pankaj
	 * @param builderLogo
	 */
	public void saveBuilderLogo(List<BuilderLogo> builderLogos){
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		for(BuilderLogo builderLogo : builderLogos){
			session.save(builderLogo);
		}
		session.getTransaction().commit();
		session.close();
	}
	/**
	 * Filter Project list by passing builderId, countryId, stateId, cityId and localityId 
	 * @author pankaj
	 * @param builderId
	 * @param countryId
	 * @param stateId
	 * @param cityId
	 * @param localityId
	 * @return List<BuilderProjectList>
	 */
	public List<BuilderProjectList> getProjectFilters(int builderId,int countryId,int stateId,int cityId, int localityId){
		List<BuilderProjectList> builderProjectLists = new ArrayList<BuilderProjectList>();
		String hql = "from BuilderProject where ";
		String where = "";
		
		if(builderId > 0){
			where +="builder.id = :builder_id";
		}
		if(countryId > 0){
			if(where!="")
				where += " AND country.id = :country_id";
			else
				where += "country.id = :country_id";
		}
		if(stateId > 0){
			if(where !="")
				where += " AND state.id = :state_id";
			else
				where += "state.id = :state_id";
		}
		if(cityId > 0){
			if(where != "")
				where +=" AND city.id = :city_id";
			else
				where +="city.id = :city_id";
		}
		if(localityId > 0){
			if(where != "")
				where +=" AND locality.id = :locality_id";
			else
				where +="locality.id = :locality_id";
			
		}
		hql += where + " AND status=1 order by id desc";
	//	String imageHql = "from ProjectImageGallery where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		if(builderId > 0)
			query.setParameter("builder_id", builderId);
		if(countryId > 0)
			query.setParameter("country_id", countryId);
		if(stateId > 0)
			query.setParameter("state_id", stateId);
		if(cityId > 0)
			query.setParameter("city_id",cityId);
		if(localityId > 0)
			query.setParameter("locality_id", localityId);
		List<BuilderProject> builderProjects = query.list();
		for(BuilderProject builderProject : builderProjects){
			BuilderProjectList builderProjectList = new BuilderProjectList();
			builderProjectList.setId(builderProject.getId());
			builderProjectList.setName(builderProject.getName());
			builderProjectList.setCity(builderProject.getCity().getName());
			if(builderProject.getTotalInventory()!=null)
				builderProjectList.setTotalSold(builderProject.getTotalInventory());
			if(builderProject.getInventorySold() != null)
				builderProjectList.setSold(builderProject.getInventorySold());
			builderProjectList.setCompletionStatus(builderProject.getCompletionStatus());
			ProjectDAO projectDAO = new ProjectDAO();
			builderProjectList.setTotalLeads(projectDAO.getTotalLeadsByProjectId(builderProject.getId()));
			try{
				builderProjectList.setImage(projectDAO.getProjectImagesByProjectId(builderProject.getId()).get(0).getImage());
			}catch(Exception e){
				builderProjectList.setImage("");
			}
			builderProjectLists.add(builderProjectList);
		}
		return builderProjectLists;
	}
	/**
	 * Get project by filter's projectid
	 * @author pankaj
	 * @param projectId
	 * @return List<BuilderProjectList>
	 */
	public List<BuilderProjectList> getProjectFilterListByProjectId(int projectId){
		List<BuilderProjectList> builderProjectLists = new ArrayList<BuilderProjectList>();
		String hql ="from BuilderProject where id = :id AND status=1 order by id desc";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", projectId);
		List<BuilderProject> builderProjects = query.list();
		for(BuilderProject builderProject : builderProjects){
			BuilderProjectList builderProjectList = new BuilderProjectList();
			builderProjectList.setId(builderProject.getId());
			builderProjectList.setName(builderProject.getName());
			builderProjectList.setCity(builderProject.getCity().getName());
			if(builderProject.getTotalInventory()!=null)
				builderProjectList.setTotalSold(builderProject.getTotalInventory());
			if(builderProject.getInventorySold() != null)
				builderProjectList.setSold(builderProject.getInventorySold());
			builderProjectList.setCompletionStatus(builderProject.getCompletionStatus());
			ProjectDAO projectDAO = new ProjectDAO();
			builderProjectList.setTotalLeads(projectDAO.getTotalLeadsByProjectId(builderProject.getId()));
			try{
				builderProjectList.setImage(projectDAO.getProjectImagesByProjectId(builderProject.getId()).get(0).getImage());
			}catch(Exception e){
				builderProjectList.setImage("");
			}
			builderProjectLists.add(builderProjectList);
		}
		return builderProjectLists;
		
	}
	
	
	public List<BuilderProjectList> getProjectFilterListByBuilderId(int builderId){
		List<BuilderProjectList> builderProjectLists = new ArrayList<BuilderProjectList>();
		String hql ="from BuilderProject where builder.id = :builder_id AND status=1 order by id desc";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<BuilderProject> builderProjects = query.list();
		for(BuilderProject builderProject : builderProjects){
			BuilderProjectList builderProjectList = new BuilderProjectList();
			builderProjectList.setId(builderProject.getId());
			builderProjectList.setName(builderProject.getName());
			builderProjectList.setCity(builderProject.getCity().getName());
			if(builderProject.getTotalInventory()!=null)
				builderProjectList.setTotalSold(builderProject.getTotalInventory());
			if(builderProject.getInventorySold() != null)
				builderProjectList.setSold(builderProject.getInventorySold());
			ProjectDAO projectDAO = new ProjectDAO();
			builderProjectList.setTotalLeads(projectDAO.getTotalLeadsByProjectId(builderProject.getId()));
			try{
				builderProjectList.setImage(projectDAO.getProjectImagesByProjectId(builderProject.getId()).get(0).getImage());
			}catch(Exception e){
				builderProjectList.setImage("");
			}
			builderProjectLists.add(builderProjectList);
		}
		return builderProjectLists;
		
	}

	/**
	 * Get builder logo by builder id
	 * @author pankaj
	 * @param builderId
	 * @return List<BuilderLogo>
	 */
	public List<BuilderLogo> getBuilderLogoByBuilderId(int builderId){
		String hql = "from BuilderLogo where builder.id = :builder_id";
		List<BuilderLogo> builderLogo = new ArrayList<BuilderLogo>();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		builderLogo = query.list();
		return builderLogo;
	}
	/**
	 * Update builder logo
	 * @author pankaj
	 * @param builderLogos
	 */
	public void updateBuilderLogo(List<BuilderLogo> builderLogos){
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		String hql = "update BuilderLogo set builderUrl=:builder_url where id = :id";
		session.beginTransaction();
		Query query = session.createQuery(hql);
		for(BuilderLogo builderLogo : builderLogos){
			System.out.println("BuilderLogo Id :: "+builderLogo.getId());
			query.setParameter("builder_url", builderLogo.getBuilderUrl());
			query.setParameter("id", builderLogo.getId());
			query.executeUpdate();
		}
		session.getTransaction().commit();
		session.close();
	}
    /**
     * Get all project's flats, buyers and sold flats count by builder id
     * @author pankaj	
     * @param builderId
     * @return List<BarGraphData>
     */
	public List<BarGraphData> getBarGraphByBuilderId(int builderId){
		List<BarGraphData> barGraphDatas = new ArrayList<BarGraphData>();
		String hql = "Select COUNT(DISTINCT B.possessionDate) from BuilderProject B where B.builder.id = :builder_id and B.status=1";
		String projectHql = "from BuilderProject where builder.id =:builder_id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		Session projectSession = hibernateUtil.openSession();
		Query projectQuery = projectSession.createQuery(projectHql);
		projectQuery.setParameter("builder_id", builderId);
		Long builderProjectLists = (Long)query.uniqueResult();
		List<BuilderProject> projectList = projectQuery.list();
		System.err.println("Builder Id :: "+builderId);
		if(projectList != null && builderProjectLists != null){
			try{
				for(int i=0;i< builderProjectLists.intValue();i++){
					BarGraphData barGraphData = new BarGraphData();
					barGraphData.setBuiltYear(projectList.get(i).getPossessionDate());
					barGraphData.setTotalFlats(getTotalFlatsByProjectId(projectList.get(i).getId()));
					barGraphData.setTotalBuyers(getTotalBuyersByProjectId(projectList.get(i).getId()));
					barGraphData.setTotalSold(getTotalsoldFlatsByProjectId(projectList.get(i).getId()));
					barGraphDatas.add(barGraphData);
					
				}
			}catch(IndexOutOfBoundsException e){
				//Return this when no data present in database.
				BarGraphData barGraphData = new BarGraphData();
				barGraphData.setBuiltYear(null);
				barGraphData.setTotalFlats((long)0);
				barGraphData.setTotalBuyers((long)0);
				barGraphData.setTotalSold((long)0);
				barGraphDatas.add(barGraphData);
			}
		}
		return barGraphDatas;
	}

	 /**
     * Get all project's flats, buyers and sold flats count by builder id
     * @author pankaj	
     * @param builderId
     * @return List<BarGraphData>
     */
	public List<BarGraphData> getBarGraphByProjectId(int projectId){
		List<BarGraphData> barGraphDatas = new ArrayList<BarGraphData>();
		String projectHql = "from BuilderProject where id =:id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session projectSession = hibernateUtil.openSession();
		Query projectQuery = projectSession.createQuery(projectHql);
		if(projectId > 0){
			projectQuery.setParameter("id", projectId);
		}
		List<BuilderProject> projectList = projectQuery.list();
		if(projectList != null){
			try{
				for(int i=0;i< projectList.size();i++){
					BarGraphData barGraphData = new BarGraphData();
					barGraphData.setBuiltYear(projectList.get(i).getPossessionDate());
					barGraphData.setTotalFlats(getTotalFlatsByProjectId(projectList.get(i).getId()));
					barGraphData.setTotalBuyers(getTotalBuyersByProjectId(projectList.get(i).getId()));
					barGraphData.setTotalSold(getTotalsoldFlatsByProjectId(projectList.get(i).getId()));
					barGraphDatas.add(barGraphData);
					
				}
			}catch(IndexOutOfBoundsException e){
				//Return this when no data present in database.
				BarGraphData barGraphData = new BarGraphData();
				barGraphData.setBuiltYear(null);
				barGraphData.setTotalFlats((long)0);
				barGraphData.setTotalBuyers((long)0);
				barGraphData.setTotalSold((long)0);
				barGraphDatas.add(barGraphData);
			}
		}
		return barGraphDatas;
	}

	/**
	 * Get all project's flat count by builder id
	 * @author pankaj
	 * @param builderId
	 * @return totalFlats
	 */
	public Long getTotalFlatsByBuilderId(int builderId){
		Long totalFlats = (long)0;
		String hql = "Select COUNT(*) from BuilderFlat where builderFloor.builderBuilding.builderProject.builder.id = :builder_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		totalFlats = (Long) query.uniqueResult();
		if(totalFlats != null){
			return totalFlats;
		}else{
			return (long)0;
		}
	}
	
	public Long getTotalFlatsByProjectId(int projectId){
		Long totalFlats = (long)0;
		String hql = "Select COUNT(*) from BuilderFlat where builderFloor.builderBuilding.builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		totalFlats = (Long) query.uniqueResult();
		if(totalFlats != null){
			return totalFlats;
		}else{
			return (long)0;
		}
	}
	
	/**
	 * Get all owner's count by builder id
	 * @author pankaj 
	 * @param builderId
	 * @return count of buyer
	 */
	public Long getTotalBuyersByBuilderId(int builderId){
		Long totalBuyers = (long)0;
		String hql = "Select COUNt(*) from Buyer where builder.id = :builder_id and is_primary=1 and is_deleted=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		totalBuyers = (Long) query.uniqueResult();
		return totalBuyers;
	}
	/**
	 * Get all owner's count by project id
	 * @author pankaj 
	 * @param projectId
	 * @return buyer's count
	 */
	public Long getTotalBuyersByProjectId(int projectId){
		Long totalBuyers = (long)0;
		String hql = "Select COUNt(*) from Buyer where builderProject.id = :project_id and is_primary=1 and is_deleted=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		totalBuyers = (Long) query.uniqueResult();
		return totalBuyers;
	}
	/**
	 * Get all project's sold flats count by builder id
	 * @author pankaj
	 * @param builderId
	 * @return total sold flats
	 */
	public Long getTotalsoldFlatsByBuilderId(int builderId){
		Long totalSoldFlats = (long)0;
		String hql = "Select COUNT(*) from BuilderFlat where builderFloor.builderBuilding.builderProject.builder.id = :builder_id AND builderFlatStatus.id=2";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		totalSoldFlats = (Long) query.uniqueResult();
		return totalSoldFlats;
	}
	
	/**
	 * Get all project's sold flats count by project id
	 * @author pankaj
	 * @param projectId
	 * @return total sold flats
	 */
	public Long getTotalsoldFlatsByProjectId(int projectId){
		Long totalSoldFlats = (long)0;
		String hql = "Select COUNT(*) from BuilderFlat where builderFloor.builderBuilding.builderProject.id = :project_id AND builderFlatStatus.id=2";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		totalSoldFlats = (Long) query.uniqueResult();
		return totalSoldFlats;
	}
	
	public ResponseMessage saveAllotProjects(List<AllotProject> allotProjectList){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		for(AllotProject allotProject : allotProjectList){
			session.save(allotProject);
		}
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Empolyee Added Successfully.");
		return responseMessage;
		
	}
}