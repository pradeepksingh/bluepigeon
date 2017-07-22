package org.bluepigeon.admin.dao;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AllotProject;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderEmployeeAccessType;
import org.bluepigeon.admin.model.BuilderFloorAmenity;
import org.bluepigeon.admin.model.BuilderLogo;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.ProjectImageGallery;
import org.bluepigeon.admin.data.BarGraphData;
import org.bluepigeon.admin.data.BuilderDetails;
import org.bluepigeon.admin.data.BuilderProjectList;
import org.bluepigeon.admin.data.EmployeeList;
import org.bluepigeon.admin.data.ProjectList;
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
		responseMessage.setStatus(1);
		responseMessage.setMessage("Builder Added Successfully");
		return responseMessage;
	}
	public ResponseMessage updateBuilder(Builder builder){
		ResponseMessage resp = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(builder);
		newsession.getTransaction().commit();
		newsession.close();
		resp.setStatus(1);
		resp.setMessage("Builder Updated Successfully");
		return resp;
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
				e.printStackTrace();
				
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
		String hql = "";
		if(accessId > 0) {
			hql = "from BuilderEmployeeAccessType where id > :access_id";
		} else {
			hql = "from BuilderEmployeeAccessType";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		if(accessId != 3 || accessId !=6 || accessId != 7){
			Query query = session.createQuery(hql);
			if(accessId > 0) {
				query.setParameter("access_id", accessId);
			}
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
	
	public ResponseMessage updateBuilderEmployeeAccount(BuilderEmployee builderEmployee){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.update(builderEmployee);
		newsession.getTransaction().commit();
		newsession.close();
		response.setStatus(1);
		response.setMessage("Employee Account updated Successfully");
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
	public List<BuilderProjectList> getProjectFilters(int empId,int countryId,int stateId,int cityId, int localityId){
		List<BuilderProjectList> builderProjectLists = new ArrayList<BuilderProjectList>();
		String hqlnew = "from BuilderEmployee where id = "+empId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session sessionnew = hibernateUtil.openSession();
		Query querynew = sessionnew.createQuery(hqlnew);
		List<BuilderEmployee> employees = querynew.list();
		BuilderEmployee builderEmployee = employees.get(0);
		sessionnew.close();
		String hql = "SELECT project.id as id, project.name as name, "
				+"project.completion_status as completionStatus,project.inventory_sold as sold, "
				+"project.total_inventory as totalSold, "
				+"c.name as city, "
				+"count(lead.id) as totalLeads ";
		String where = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2){
			hql = hql + "FROM  builder_project as project inner join allot_project as ap on project.id=ap.project_id "
					+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
					+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id WHERE ";
			where +="ap.emp_id = "+builderEmployee.getId();
		} else {
			hql = hql + "FROM  builder_project as project "
			+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
			+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id WHERE ";
			where +="build.id = "+builderEmployee.getBuilder().getId();
		}
		if(countryId > 0){
			if(where!="")
				where += " AND project.country_id = :country_id";
			else
				where += "project.country_id = :country_id";
		}
		if(stateId > 0){
			if(where !="")
				where += " AND project.state_id = :state_id";
			else
				where += "project.state_id = :state_id";
		}
		if(cityId > 0){
			if(where != "")
				where +=" AND project.city_id = :city_id";
			else
				where +="project.city_id = :city_id";
		}
		if(localityId > 0){
			if(where != "")
				where +=" AND project.area_id = :locality_id";
			else
				where +="project.area_id = :locality_id";
		}
		hql += where + " AND project.status=1 order by project.id desc";
		try {
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuilderProjectList.class));
		if(countryId > 0)
			query.setParameter("country_id", countryId);
		if(stateId > 0)
			query.setParameter("state_id", stateId);
		if(cityId > 0)
			query.setParameter("city_id",cityId);
		if(localityId > 0)
			query.setParameter("locality_id", localityId);
			builderProjectLists = query.list();
		} catch(Exception e) {
			//
		}
		return builderProjectLists;
	}
	
	
	public List<BuilderProjectList> getProjectFilter(int projectId,int empId,int countryId,int stateId,int cityId, int localityId){
		List<BuilderProjectList> builderProjectLists = new ArrayList<BuilderProjectList>();
		String hqlnew = "from BuilderEmployee where id = "+empId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session sessionnew = hibernateUtil.openSession();
		Query querynew = sessionnew.createQuery(hqlnew);
		List<BuilderEmployee> employees = querynew.list();
		BuilderEmployee builderEmployee = employees.get(0);
		sessionnew.close();
		String hql = "SELECT project.id as id, project.name as name, "
				+"project.completion_status as completionStatus,project.inventory_sold as sold, "
				+"project.total_inventory as totalSold,IFNULL('',(select pg.image from project_image_gallery as pg where pg.project_id=project.id limit 1)) as image,"
				+"c.name as city, "
				+"count(lead.id) as totalLeads ";
		String where = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2){
			hql = hql + "FROM  builder_project as project inner join allot_project as ap on project.id=ap.project_id "
					+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
					+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id "
					+ "WHERE ";
			where +="ap.emp_id = "+builderEmployee.getId();
		} else {
			hql = hql + "FROM  builder_project as project "
			+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
			+"left join locality as l ON project.area_id = l.id left join builder_lead as lead ON project.id = lead.project_id "
			+ "WHERE ";
			where +="build.id = "+builderEmployee.getBuilder().getId();
		}
		if(projectId > 0){
			where +=" AND project.id = :project_id";
		}else{
			if(countryId > 0){
				if(where!="")
					where += " AND project.country_id = :country_id";
				else
					where += "project.country_id = :country_id";
			}
			if(stateId > 0){
				if(where !="")
					where += " AND project.state_id = :state_id";
				else
					where += "project.state_id = :state_id";
			}
			if(cityId > 0){
				if(where != "")
					where +=" AND project.city_id = :city_id";
				else
					where +="project.city_id = :city_id";
			}
			if(localityId > 0){
				if(where != "")
					where +=" AND project.area_id = :locality_id";
				else
					where +="project.area_id = :locality_id";
			}
		}
		hql += where + " AND project.status=1 GROUP by project.id order by project.id desc";
		try {
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuilderProjectList.class));
		System.err.println(hql);
		if(projectId > 0){
			
		}
		if(countryId > 0)
			query.setParameter("country_id", countryId);
		if(stateId > 0)
			query.setParameter("state_id", stateId);
		if(cityId > 0)
			query.setParameter("city_id",cityId);
		if(localityId > 0)
			query.setParameter("locality_id", localityId);
			builderProjectLists = query.list();
		} catch(Exception e) {
			//
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
			if(builderProject.getCompletionStatus() != null)
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
			//System.out.println("BuilderLogo Id :: "+builderLogo.getId());
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
	public List<BarGraphData> getBarGraphByBuilderId(BuilderEmployee builderEmployee){
		List<BarGraphData> barGraphDatas = new ArrayList<BarGraphData>();
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2) {
			hql = "SELECT DISTINCT YEAR(b.possession_date) from builder_project as b inner join builder_employee as e on b.id = e.id where b.group_id = :builder_id and b.status=1 and e.id = "+builderEmployee.getId()+" group by YEAR(b.possession_date)";
		} else {
			hql = "SELECT DISTINCT YEAR(b.possession_date) from builder_project as b where b.group_id = :builder_id and b.status=1 group by YEAR(b.possession_date)";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(hql);
		query.setParameter("builder_id", builderEmployee.getBuilder().getId());
		if(query.list() != null){
			int arr[]= new int[query.list().size()];
			System.err.println("Array :: "+arr);
			for(int i=0;i<arr.length;i++){
				//System.err.println("Array value :: "+query.list().get(i));
				try{
					int year =(int) query.list().get(i);
					System.err.println("Year :: "+year);
					BarGraphData barGraphData = new BarGraphData();
					barGraphData.setBuiltYear(year);
					barGraphData.setTotalFlats(getTotalFlatsByYear(year));
					barGraphData.setTotalBuyers(getTotalBuyersByYear(year));
					barGraphData.setTotalSold(getTotalsoldFlatsByYear(year));
					System.err.println("Toatl Buyers :: "+getTotalBuyersByYear(year));
					System.err.println("Total Sold Flats :: "+getTotalsoldFlatsByYear(year));
					System.err.println("Total Flats :: "+getTotalFlatsByYear(year));
				barGraphDatas.add(barGraphData);
				}catch(Exception e){
					
				}
			}
		
		}
		return barGraphDatas;
	}

	public List<BarGraphData> getBarGraphByProjectId(int projectId){
		List<BarGraphData> barGraphDatas = new ArrayList<BarGraphData>();
		String projectHql = "Select DISTINCT YEAR(B.possessionDate) from BuilderProject B where B.id = :id and B.status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session projectSession = hibernateUtil.openSession();
		Query projectQuery = projectSession.createQuery(projectHql);
		if(projectId > 0){
			projectQuery.setParameter("id", projectId);
		}
	//	List<BuilderProject> projectList = projectQuery.list();
		if(projectQuery.list() != null){
			try{
				int arr[]= new int[projectQuery.list().size()]; 
				for(int i=0;i< arr.length;i++){
					BarGraphData barGraphData = new BarGraphData();
					int year =(int) projectQuery.list().get(i);
					barGraphData.setBuiltYear(year);
					barGraphData.setTotalFlats(getTotalFlatsByProjectId(projectId));
					barGraphData.setTotalBuyers(getTotalBuyersByProjectId(projectId));
					barGraphData.setTotalSold(getTotalsoldFlatsByProjectId(projectId));
					barGraphDatas.add(barGraphData);
					
				}
			}catch(Exception e){
				
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
	
	
	/**
	 * Get all project's  flats count by year
	 * @author pankaj
	 * @param projectId
	 * @return total sold flats
	 */
	public int getTotalFlatsByYear(int year){
		int totalSoldFlats =0;
		//String hql = "Select COUNT(*) from BuilderFlat where builderFloor.builderBuilding.builderProject.id = :project_id AND builderFlatStatus.id=2";
		String sql = "SELECT count(a.id) FROM blue_pigeon.builder_flat a join blue_pigeon.builder_floor  c on a.floor_no = c.id left join blue_pigeon.builder_building  d on c.building_id = d.id left join blue_pigeon.builder_project as b on d.project_id =b.id where year(b.possession_date) = :year AND a.status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(sql);
		query.setParameter("year", year);
		BigInteger totalSoldFlat = (BigInteger) query.list().get(0);
		totalSoldFlats = Integer.parseInt(totalSoldFlat.toString());
		return totalSoldFlats;
	}
	/**
	 * Get all project's flats count by project id
	 * @author pankaj
	 * @param projectId
	 * @return total sold flats
	 */
	public int getTotalFlatsByProjectId(int projectId){
		int totalSoldFlats =0;
		//String hql = "Select COUNT(*) from BuilderFlat where builderFloor.builderBuilding.builderProject.id = :project_id AND builderFlatStatus.id=2";
		String sql = "SELECT count(a.id) FROM blue_pigeon.builder_flat a join blue_pigeon.builder_floor  c on a.floor_no = c.id left join blue_pigeon.builder_building  d on c.building_id = d.id left join blue_pigeon.builder_project as b on d.project_id =b.id where  b.id=:id AND a.status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(sql);
		query.setParameter("id", projectId);
		BigInteger totalSoldFlat = (BigInteger) query.list().get(0);
		totalSoldFlats = Integer.parseInt(totalSoldFlat.toString());
		return totalSoldFlats;
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
		//;

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
	public int getTotalBuyersByProjectId(int projectId){
		//Long totalBuyers = (long)0;
		int totalBuyers = 0;
		String sql = "SELECT count(a.id) FROM buyer as a left join builder_project as b on a.project_id =b.id where b.id = :id and b.status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(sql);
		query.setParameter("id", projectId);
		System.err.println("Query Output :: "+query.list());
		BigInteger totalBuyer =(BigInteger) query.list().get(0);
		totalBuyers = Integer.parseInt(totalBuyer.toString());
		return totalBuyers;
	}
	/**
	 * Get all owner's count by year
	 * @author pankaj 
	 * @param projectId
	 * @return buyer's count
	 */
	public int getTotalBuyersByYear(int year){
		int totalBuyers = 0;
		String sql = "SELECT count(a.id) FROM buyer as a left join builder_project as b on a.project_id =b.id where year(b.possession_date) = :year";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(sql);
		query.setParameter("year", year);
		System.err.println("Query Output :: "+query.list());
		BigInteger totalBuyer =(BigInteger) query.list().get(0);
		totalBuyers = Integer.parseInt(totalBuyer.toString());
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
	 * Get all project's sold flats count by year
	 * @author pankaj
	 * @param projectId
	 * @return total sold flats
	 */
	public int getTotalsoldFlatsByYear(int year){
		int totalSoldFlats =0;
		String sql = "SELECT count(a.id) FROM blue_pigeon.builder_flat a join blue_pigeon.builder_floor  c on a.floor_no = c.id left join blue_pigeon.builder_building  d on c.building_id = d.id left join blue_pigeon.builder_project as b on d.project_id =b.id where year(b.possession_date) = :year AND a.status_id=2";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(sql);
		query.setParameter("year", year);
		BigInteger totalSoldFlat = (BigInteger) query.list().get(0);
		totalSoldFlats = Integer.parseInt(totalSoldFlat.toString());
		return totalSoldFlats;
	}
	/**
	 * Get all project's sold flats count by project id
	 * @author pankaj
	 * @param projectId
	 * @return total sold flats
	 */
	public int getTotalsoldFlatsByProjectId(int projectId){
		int totalSoldFlats =0;
		String sql = "SELECT count(a.id) FROM blue_pigeon.builder_flat a join blue_pigeon.builder_floor  c on a.floor_no = c.id left join blue_pigeon.builder_building  d on c.building_id = d.id left join blue_pigeon.builder_project as b on d.project_id =b.id where  b.id=:id AND a.status_id=2";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(sql);
		query.setParameter("id", projectId);
		BigInteger totalSoldFlat = (BigInteger) query.list().get(0);
		totalSoldFlats = Integer.parseInt(totalSoldFlat.toString());
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
	
	public ResponseMessage updateAllotProjects(List<AllotProject> allotProjectList){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		for(AllotProject allotProject : allotProjectList){
			session.update(allotProject);
		}
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Empolyee Updated Successfully.");
		return responseMessage;
		
	}
	
	public void deleteAllotedrojectsByEmpId(int emp_id){
		String hql = "delete from AllotProject where builderEmployee.id = :emp_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("emp_id", emp_id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
	
	public List<AllotProject> getAllotedrojectsByEmpId(int emp_id){
		String hql = "from AllotProject where builderEmployee.id = :emp_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("emp_id", emp_id);
		List<AllotProject> allotProjects = query.list();
		return allotProjects;
	}
}