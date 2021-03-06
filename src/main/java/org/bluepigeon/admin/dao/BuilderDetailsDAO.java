package org.bluepigeon.admin.dao;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.hibernate.type.DoubleType;
import org.hibernate.type.IntegerType;
import org.hibernate.type.LongType;
import org.hibernate.type.StringType;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AllotLeads;
import org.bluepigeon.admin.model.AllotProject;
import org.bluepigeon.admin.data.BookedBuyerList;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderEmployeeAccessType;
import org.bluepigeon.admin.model.BuilderLead;
import org.bluepigeon.admin.model.BuilderLogo;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.EmployeeRole;
import org.bluepigeon.admin.model.InboxMessage;
import org.bluepigeon.admin.model.InboxMessageReply;
import org.bluepigeon.admin.data.BarGraphData;
import org.bluepigeon.admin.data.BookingFlatList;
import org.bluepigeon.admin.data.BuilderDetails;
import org.bluepigeon.admin.data.BuilderProjectList;
import org.bluepigeon.admin.data.BuildingData;
import org.bluepigeon.admin.data.BuyerList;
import org.bluepigeon.admin.data.ContactUs;
import org.bluepigeon.admin.data.EmployeeList;
import org.bluepigeon.admin.data.InboxMessageData;
import org.bluepigeon.admin.data.NameList;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.data.ProjectWiseData;
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
		String hql = "SELECT project.id as id, project.name as name, project.image as image, "
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
		hql += where + " AND project.status=1 GROUP by project.id order by project.id desc";
		try {
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuilderProjectList.class));
		System.err.println("hql : "+hql);
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
	 * @author pankaj
	 * @param empId
	 * @param countryId
	 * @param stateId
	 * @param cityId
	 * @param localityName
	 * @return
	 */
	
	public List<BuilderProjectList> getProjectFilters(int empId,int countryId,int cityId, String localityName, int projectStatus){
		List<BuilderProjectList> builderProjectLists = new ArrayList<BuilderProjectList>();
		String hqlnew = "from BuilderEmployee where id = "+empId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session sessionnew = hibernateUtil.openSession();
		Query querynew = sessionnew.createQuery(hqlnew);
		List<BuilderEmployee> employees = querynew.list();
		BuilderEmployee builderEmployee = employees.get(0);
		sessionnew.close();
		String hql = "SELECT project.id as id, project.name as name, project.image as image, "
				+"project.completion_status as completionStatus,project.inventory_sold as sold, "
				+"project.total_inventory as totalSold, "
				+"c.name as city, project.locality_name as locality, "
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
//		if(stateId > 0){
//			if(where !="")
//				where += " AND project.state_id = :state_id";
//			else
//				where += "project.state_id = :state_id";
//		}
		if(cityId > 0){
			if(where != "")
				where +=" AND project.city_id = :city_id";
			else
				where +="project.city_id = :city_id";
		}
		if(localityName != null){
			if(where != "")
				where +=" AND project.locality_name like :locality_name";
			else
				where +="project.locality_name like :locality_name";
		}
		if(projectStatus > 0){
			if(projectStatus == 1){
				if(where != ""){
					where +=" AND project.completion_status BETWEEN 0 AND 100 ";
				}
				else{
					where +=" project.completion_status BETWEEN 0 AND 100 ";
				}
			}
			if(projectStatus == 2){
				if(where != ""){
					where +=" AND project.completion_status=100";
				}
				else{
					where +=" project.completion_status=100";
				}
			}
		}
		
		hql += where + " AND project.status=1 GROUP by project.id order by project.id desc";
		try {
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuilderProjectList.class));
		System.err.println("hql : "+hql);
		if(countryId > 0)
			query.setParameter("country_id", countryId);
//		if(stateId > 0)
//			query.setParameter("state_id", stateId);
		if(cityId > 0)
			query.setParameter("city_id",cityId);
		
		if(localityName != null)
			query.setParameter("locality_name", localityName+"%");
			builderProjectLists = query.list();
		} catch(Exception e) {
			//
		}
		return builderProjectLists;
	}
	
	
	public List<BuilderProjectList> getProjectFilter(int empId,int countryId,int cityId, String localityName, int projectStatus){
		List<BuilderProjectList> builderProjectLists = new ArrayList<BuilderProjectList>();
		String hqlnew = "from BuilderEmployee where id = "+empId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session sessionnew = hibernateUtil.openSession();
		Query querynew = sessionnew.createQuery(hqlnew);
		List<BuilderEmployee> employees = querynew.list();
		BuilderEmployee builderEmployee = employees.get(0);
		sessionnew.close();
		//hql written by Pradeep sir
//		String hql = "SELECT project.id as id, project.name as name, "
//				+"project.completion_status as completionStatus,project.inventory_sold as sold, "
//				+"project.total_inventory as totalSold,IFNULL('',(select pg.image from project_image_gallery as pg where pg.project_id=project.id limit 1)) as image,"
//				+"c.name as city, "
//				+"count(lead.id) as totalLeads ";
		//hql written by Pankaj
		String hql = "SELECT project.id as id, project.name as name, project.image as image, "
				+"project.completion_status as completionStatus,project.inventory_sold as sold, "
				+"project.total_inventory as totalSold,"
				+"c.name as city, "
				+"count(lead.id) as totalLeads ";
		String where = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2){
			hql = hql + "FROM  builder_project as project inner join allot_project as ap on project.id=ap.project_id "
					+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
					+" left join builder_lead as lead ON project.id = lead.project_id "
					+ "WHERE ";
			where +="ap.emp_id = "+builderEmployee.getId();
		} else {
			hql = hql + "FROM  builder_project as project "
			+"left join builder as build ON project.group_id = build.id left join city as c ON project.city_id = c.id "
			+" left join builder_lead as lead ON project.id = lead.project_id "
			+ "WHERE ";
			where +="build.id = "+builderEmployee.getBuilder().getId();
		}
		
			if(countryId > 0){
				if(where!="")
					where += " AND project.country_id = :country_id";
				else
					where += "project.country_id = :country_id";
			}
//			if(stateId > 0){
//				if(where !="")
//					where += " AND project.state_id = :state_id";
//				else
//					where += "project.state_id = :state_id";
//			}
			if(cityId > 0){
				if(where != "")
					where +=" AND project.city_id = :city_id";
				else
					where +="project.city_id = :city_id";
			}
			if(localityName != null){
				if(where != "")
					where +=" AND project.locality_name like :locality_name";
				else
					where +="project.locality_name like :locality_name";
			}
			if(projectStatus > 0){
				if(projectStatus == 1){
					if(where != ""){
						where +=" AND project.completion_status BETWEEN 0 AND 100 ";
					}
					else{
						where +=" project.completion_status BETWEEN 0 AND 100 ";
					}
				}
				if(projectStatus == 2){
					if(where != ""){
						where +=" AND project.completion_status=100";
					}
					else{
						where +=" project.completion_status=100";
					}
				}
			}
		
		hql += where + " AND project.status=1 GROUP by project.id order by project.id desc";
		try {
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuilderProjectList.class));
		System.err.println(hql);
		
		if(countryId > 0)
			query.setParameter("country_id", countryId);
//		if(stateId > 0)
//			query.setParameter("state_id", stateId);
		if(cityId > 0)
			query.setParameter("city_id",cityId);
		if(localityName != null)
			query.setParameter("locality_name", localityName);
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
			builderProjectList.setLocality(builderProject.getLocalityName());
			if(builderProject.getTotalInventory()!=null)
				builderProjectList.setTotalSold(builderProject.getTotalInventory());
			if(builderProject.getInventorySold() != null)
				builderProjectList.setSold(builderProject.getInventorySold());
			builderProjectList.setCompletionStatus(builderProject.getCompletionStatus());
			ProjectDAO projectDAO = new ProjectDAO();
			builderProjectList.setTotalLeads(projectDAO.getTotalLeadsByProjectId(builderProject.getId()));
			try{
				builderProjectList.setImage(builderProject.getImage());
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
			builderProjectList.setLocality(builderProject.getLocalityName());
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
			hql = "SELECT DISTINCT YEAR(b.possession_date) from builder_project as b inner join allot_project as ap ON b.id = ap.project_id where b.group_id = :builder_id and b.status=1 and ap.emp_id = "+builderEmployee.getId()+" group by YEAR(b.possession_date)";
		} else {
			hql = "SELECT DISTINCT YEAR(b.possession_date) from builder_project as b where b.group_id = :builder_id and b.status=1 group by YEAR(b.possession_date)";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createSQLQuery(hql);
		System.err.println("HQL :: "+hql);
		query.setParameter("builder_id", builderEmployee.getBuilder().getId());
		if(query.list() != null){
			int arr[]= new int[query.list().size()];
			System.err.println("Array :: "+arr);
			System.err.println("Array Lenght :: "+arr.length);
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
					e.printStackTrace();
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
	
	public List<ProjectWiseData> getEmployeeBarGraphBySource(int empId) {
		String empHql = "From BuilderEmployee where id=:id";
		
		String hql = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session empSession = hibernateUtil.openSession();
		Query empQuery = empSession.createQuery(empHql);
		empQuery.setParameter("id", empId);
		BuilderEmployee builderEmployee=(BuilderEmployee)empQuery.list().get(0);
		if(builderEmployee.getBuilderEmployeeAccessType().getId() ==1){
			hql = "select source.name as name, count(lead.id) as dataCount, SUM(CASE WHEN lead.lead_status=7 THEN 1 ELSE 0 END) as booked from builder_lead as lead inner join builder_project as project on lead.project_id = project.id INNER JOIN source as source on lead.source=source.id where project.status=1 and project.group_id="+builderEmployee.getBuilder().getId()+" GROUP by source.id order by source.name asc";
		}else{
			hql = "select source.name as name, count(lead.id) as dataCount, SUM(CASE WHEN lead.lead_status=7 THEN 1 ELSE 0 END) as booked from builder_lead as lead inner join builder_project as project on lead.project_id = project.id INNER JOIN source as source on lead.source=source.id INNER join allot_project as ap on ap.project_id = lead.project_id  where project.status=1 and ap.emp_id="+builderEmployee.getId()+" GROUP by source.id order by source.name asc";
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		
		List<ProjectWiseData> result = query.list();
		return result;
	}
	
	public List<ProjectWiseData> getEmployeeBarGraphByProject(int empId) {
		String hql = "";
		String empHql = "From BuilderEmployee where id=:id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session empSession = hibernateUtil.openSession();
		Query empQuery = empSession.createQuery(empHql);
		empQuery.setParameter("id", empId);
		BuilderEmployee builderEmployee=(BuilderEmployee)empQuery.list().get(0);
		if(builderEmployee.getBuilderEmployeeAccessType().getId() ==1){
			hql = "select project.name as name, round(project.revenue) as revenue, project.total_inventory as avaliable, project.inventory_sold as sold from builder_project as project left join builder_building as building on building.project_id = project.id left join builder_floor as floor on floor.building_id = building.id left join builder_flat as flat on flat.floor_no = floor.id where project.status=1 and project.group_id="+builderEmployee.getBuilder().getId()+" and flat.status_id=2 GROUP by project.id order by project.id desc";
		}else{
			hql = "select project.name as name, round(project.revenue) as revenue, project.total_inventory as avaliable, project.inventory_sold as sold from builder_project as project INNER join allot_project as ap on ap.project_id = project.id left join builder_building as building on building.project_id = project.id left join builder_floor as floor on floor.building_id = building.id left join builder_flat as flat on flat.floor_no = floor.id where project.status=1 and ap.emp_id="+builderEmployee.getId()+" and flat.status_id=2 GROUP by project.id order by project.id desc";
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.addScalar("avaliable", LongType.INSTANCE)
				.addScalar("sold", LongType.INSTANCE).
				addScalar("revenue", DoubleType.INSTANCE).
				addScalar("name", StringType.INSTANCE)
				.setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		
		List<ProjectWiseData> result = query.list();
		return result;
	}
	
	public List<ProjectWiseData> getEmployeeBarGraphByMonth(int empId) {
		String hql = "";
		String empHql = "From BuilderEmployee where id=:id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session empSession = hibernateUtil.openSession();
		Query empQuery = empSession.createQuery(empHql);
		empQuery.setParameter("id", empId);
		BuilderEmployee builderEmployee=(BuilderEmployee)empQuery.list().get(0);
		if(builderEmployee.getBuilderEmployeeAccessType().getId() ==1){
			hql = "select elt(m.name,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec') as name,m.revenue,m.bookingCount,m.avaliable from(select COUNT(c.id) as bookingCount, project.total_inventory as avaliable, MONTH(a.booking_date) as name,round(sum(a.total_cost)) as revenue FROM buying_details as a join buyer as b on b.id=a.buyer_id join builder_flat as c on c.id=b.flat_id join builder_floor as f on f.id=c.floor_no join builder_building as building on building.id=f.building_id join builder_project as project on project.id=building.project_id left join builder as builder on builder.id=project.group_id where project.group_id="+builderEmployee.getBuilder().getId()+" and b.is_primary=1 and b.is_deleted=0 and c.status_id=2 group by MONTH(a.booking_date)) as m order by FIELD(m.name,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')";
		}else{
			hql = "select elt(m.name,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec') as name,m.revenue,m.bookingCount,m.avaliable from(select COUNT(c.id) as bookingCount, project.total_inventory as avaliable, MONTH(a.booking_date) as name,round(sum(a.total_cost)) as revenue FROM buying_details as a join buyer as b on b.id=a.buyer_id join builder_flat as c on c.id=b.flat_id join builder_floor as f on f.id=c.floor_no join builder_building as building on building.id=f.building_id join builder_project as project on project.id=building.project_id inner join allot_project as e on e.project_id=project.id where e.emp_id="+builderEmployee.getId()+" and b.is_primary=1 and b.is_deleted=0 and c.status_id=2 group by MONTH(a.booking_date)) as m order by FIELD(m.name,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')";
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.addScalar("bookingCount", LongType.INSTANCE).
				addScalar("revenue", DoubleType.INSTANCE).
				addScalar("avaliable",  LongType.INSTANCE).
				addScalar("name", StringType.INSTANCE).
				setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		List<ProjectWiseData> result = query.list();
		return result;
	}
	
	public List<ProjectWiseData> getEmployeeBarGraphBySalesman(int empId) {
		String hql = "";
		String empHql = "From BuilderEmployee where id=:id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session empSession = hibernateUtil.openSession();
		Query empQuery = empSession.createQuery(empHql);
		empQuery.setParameter("id", empId);
		BuilderEmployee builderEmployee=(BuilderEmployee)empQuery.list().get(0);
		if(builderEmployee.getBuilderEmployeeAccessType().getId() ==1){
			hql = "select emp.name as name, sum(bd.total_cost) as revenue, count(flat.id) as sold from builder_employee as emp "
					+ "join buyer as buyer on buyer.emp_id = emp.id "
					+ "inner join buying_details as bd on bd.buyer_id = buyer.id "
					+ "left join builder_project as project on project.id = buyer.project_id "
					+ "left join builder_flat as flat on flat.id=buyer.flat_id "
					+ "where project.status=1 and buyer.is_primary=1 and buyer.is_deleted=0 and "
					+ "buyer.status=0 and buyer.builder_id="+builderEmployee.getBuilder().getId()+" GROUP by emp.id";
		}else{
			hql = "select emp.name as name, sum(bd.total_cost) as revenue, count(flat.id) as sold from builder_employee as emp"
					+ " join buyer as buyer on buyer.emp_id = emp.id "
					+ "inner join buying_details as bd on bd.buyer_id = buyer.id "
					+ "left join builder_project as project on project.id = buyer.project_id "
					+ "left join builder_flat as flat on flat.id=buyer.flat_id "
					+ "where project.status=1 and buyer.is_primary=1 and buyer.is_deleted=0 and flat.status_id=2 and buyer.status=0 and emp.reporting_id="+builderEmployee.getId()+" GROUP by emp.id";
			
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.addScalar("sold", LongType.INSTANCE).
				addScalar("revenue", DoubleType.INSTANCE).
				addScalar("name", StringType.INSTANCE)
				.setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		List<ProjectWiseData> result = query.list();
		return result;
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
	
	public BookingFlatList getFlatFliterByIds(int empId, int projectId, int buildingId, int floorId, int evenOrodd){
		BookingFlatList bookingFlatList = new BookingFlatList();
		String hqlnew = "from BuilderEmployee where id = "+empId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session sessionnew = hibernateUtil.openSession();
		Query querynew = sessionnew.createQuery(hqlnew);
		List<BuilderEmployee> employees = querynew.list();
		BuilderEmployee builderEmployee = employees.get(0);
		sessionnew.close();
		String where ="";
		String hql = "SELECT flat.id as flatId, flat.flat_no as flatNo, flat.image as image, flat_status.id as flatStatus, "
				+ "flat.bedroom as bedroom, flat.bathroom as bathroom, flat.balcony as balcony, flat_type.carpet_area as carpetArea,"
				+ " room.length as length, room.breadth as breadth FROM builder_flat as flat "
				+ "left join builder_floor as floor on floor.id = flat.floor_no "
				+ "left join builder_building as building on building.id = floor.building_id "
				+ "left join builder_flat_type as flat_type on flat_type.id = flat.flat_type_id "
				+ "left join builder_building_flat_type_room as room on room.flat_type_id = flat_type.id "
				+ "left join builder_flat_status as flat_status on flat_status.id = flat.status_id "
				+ "left join builder_project as project on project.id = building.project_id "
				+ "INNER join allot_project as ap on ap.project_id = project.id "
				+ "left join builder_employee as emp on emp.id = ap.emp_id "
				+ "WHERE ";
		
		if(empId > 0){
			where += "emp.id = :emp_id";
		}
		if(projectId > 0){
			if(where != ""){
				where +="AND ap.project_id = :project_id";
			}
			else{
				where +=" ap.project_id = :project_id";
			}
		}
		if(buildingId > 0){
			if(where != ""){
				where += "AND building.id = :building_id ";
			}else{
				where += "building.id = :building_id";
			}
		}
		if(floorId > 0){
			if(where != ""){
				where += " AND floor.id = :floor_id";
			}else{
				where +=" floor.id = :floor_id";
			}
		}
		if(evenOrodd >0){
			//for even floor
			if(evenOrodd % 2 == 0){
				if(where != null){
					where += " AND builderFloor.floorNo % 2 = 0";
				}else{
					where +=" builderFloor.floorNo % 2 = 0";
				}
			}else{
				if(where != null){
					where +=" AND builderFloor.floorNo %2 <> 0";
				}else{
					where +=" builderFloor.floorNo %2 <> 0";
				}
			}
		}
		hql += where+" ORDER BY ap.project_id ASC, building.id ASC, floor.floor_no ASC, flat.flat_no ASC";
		try {
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BookingFlatList.class));
			if(projectId > 0){
				query.setParameter("project_id", projectId);
			}
			if(empId > 0){
				query.setParameter("emp_id", empId);
			}
			if(floorId > 0){
				query.setParameter("floor_id", floorId);
			}
			if(buildingId > 0){
				query.setParameter("building_id", buildingId);
			}
			
		}catch(Exception e){
			
		}
		return bookingFlatList;
	}
	
	
	public List<BookingFlatList> getFlatDetails(BuilderEmployee builderEmployee, int projectId){
		List<BookingFlatList> bookingFlatList = new ArrayList<BookingFlatList>();
		
		int empId = builderEmployee.getId();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String where ="";
		String hql = "SELECT flat.id as flatId, flat.flat_no as flatNo, flat.image as image, flat_status.id as flatStatus, "
				+ "flat.bedroom as bedroom, flat.bathroom as bathroom, flat.balcony as balcony, flat_type.name as flatType, flat_type.carpet_area as carpetArea,"
				+ " room.length as length, room.breadth as breadth, floor.id as floorId,"
				+ "FROM builder_flat as flat "
				+ "left join builder_floor as floor on floor.id = flat.floor_no "
				+ "left join builder_building as building on building.id = floor.building_id "
				+ "left join builder_flat_type as flat_type on flat_type.id = flat.flat_type_id "
				+ "left join builder_building_flat_type_room as room on room.flat_type_id = flat_type.id "
				+ "left join builder_flat_status as flat_status on flat_status.id = flat.status_id "
				+ "left join builder_project as project on project.id = building.project_id "
				+ "INNER join allot_project as ap on ap.project_id = project.id "
				+ "left join builder_employee as emp on emp.id = ap.emp_id "
				+ "WHERE ";
		
		if(empId > 0){
			where += "ap.emp_id = :emp_id ";
		}
		if(projectId > 0){
			if(where != ""){
				where +="AND ap.project_id = :project_id ";
			}
			else{
				where +=" ap.project_id = :project_id ";
			}
		}
		hql += where+"ORDER BY ap.project_id ASC, building.id ASC, floor.floor_no ASC, flat.flat_no ASC";
		try {
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BookingFlatList.class));
			//System.err.println(query.list().size());
			System.err.println(hql);
			System.err.println("flat size :: "+bookingFlatList.size());
			if(projectId > 0){
				query.setParameter("project_id", projectId);
			}
			if(empId > 0){
				query.setParameter("emp_id", empId);
			}
			System.err.println("Hello from booking :: "+empId);
			for(BookingFlatList bookingFlatList2 : bookingFlatList){
				System.err.println("Flat No :: "+bookingFlatList2.getFlatNo());
			}
			System.err.println("Hello from after booking");
		}catch(Exception e){
			
		}
		return bookingFlatList;
	}
	
	/**
	 * Get booked primary buyer list
	 * @param builderEmployee
	 * @return List<BookedBuyerList> 
	 */
	public List<BookedBuyerList> getBookedBuyerList(BuilderEmployee builderEmployee){
		String hql = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		
		if(builderEmployee.getBuilderEmployeeAccessType().getId() >0 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
			hql ="SELECT b.name as buyerName, b.mobile as buyerContact, b.email as buyerEmail, project.name as projectName,project.locality_name as localityName, flat.flat_no as flatNo, building.name as buildingName, city.name as cityName FROM buyer as b inner join builder_project as project on project.id = b.project_id left join builder_building as building on building.id = b.building_id left join builder_flat as flat on flat.id = b.flat_id left join city as city on city.id = project.city_id WHERE b.builder_id="+builderEmployee.getBuilder().getId()+" and b.is_primary=1 and b.is_deleted=0 and project.status=1 group by b.id order by b.id DESC ";
		}else{
			hql= "SELECT b.name as buyerName, b.mobile as buyerContact, b.email as buyerEmail, project.name as projectName,project.locality_name as localityName, flat.flat_no as flatNo, building.name as buildingName, city.name as cityName FROM buyer as b left join builder_project as project on project.id = b.project_id inner join allot_project as ap on ap.project_id = project.id left join builder_building as building on building.id = b.building_id left join builder_flat as flat on flat.id = b.flat_id left join city as city on city.id = project.city_id WHERE ap.emp_id="+builderEmployee.getId()+" and b.is_primary=1 and b.is_deleted=0 and project.status=1 group by b.id order by b.id DESC";
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BookedBuyerList.class));
		
		List<BookedBuyerList> result = query.list();
		return result;
	}
	
	public List<BookedBuyerList> getBookedBuyerList(int empId, int projectId, String keyword){
		List<BookedBuyerList> result = null;
		String hql = "SELECT b.name as buyerName, b.mobile as buyerContact, b.email as buyerEmail, project.name as projectName,project.locality_name as localityName, flat.flat_no as flatNo, building.name as buildingName, city.name as cityName ";
		String where = "";
		String hqlnew = "from BuilderEmployee where id = "+empId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session sessionnew = hibernateUtil.openSession();
		Query querynew = sessionnew.createQuery(hqlnew);
		List<BuilderEmployee> employees = querynew.list();
		BuilderEmployee builderEmployee = employees.get(0);
		sessionnew.close();
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2){
			if(keyword == ""){
				hql += " FROM buyer as b left join builder_project as project on project.id = b.project_id inner join allot_project as ap on ap.project_id = project.id left join builder_building as building on building.id = b.building_id left join builder_flat as flat on flat.id = b.flat_id left join city as city on city.id = project.city_id "
					+ "WHERE ";
					where+= "ap.emp_id="+builderEmployee.getId();
				if(projectId > 0){
					if(where != ""){
						hql = hql+" AND project.id = "+projectId;
					}else{
						hql = hql+" project.id = "+projectId;
					}
				}
			}else{
				hql += " FROM buyer as b left join builder_project as project on project.id = b.project_id inner join allot_project as ap on ap.project_id = project.id left join builder_building as building on building.id = b.building_id left join builder_flat as flat on flat.id = b.flat_id left join city as city on city.id = project.city_id "
					+ "WHERE ";
					where+= " and ap.emp_id="+builderEmployee.getId();
				hql = hql+" (b.name like '%"+keyword+"%' OR b.mobile like '%"+keyword+"%') ";
				if(projectId > 0){
					if(where != ""){
						hql +=" AND project.id ="+projectId;
					}else{
						hql +=" project.id = "+projectId;
					}
				}
			}
		}else{
			if(keyword == ""){
				hql = hql+" FROM buyer as b inner join builder_project as project on project.id = b.project_id left join builder_building as building on building.id = b.building_id left join builder_flat as flat on flat.id = b.flat_id left join city as city on city.id = project.city_id "
						+ "WHERE ";
						where+= "b.builder_id="+builderEmployee.getBuilder().getId();
				if(projectId > 0){
					if(where != ""){
						hql = hql+" AND project.id = "+projectId;
					}else{
						hql += " project.id="+projectId;
					}
				}
			}else{
				hql = hql+" FROM buyer as b inner join builder_project as project on project.id = b.project_id left join builder_building as building on building.id = b.building_id left join builder_flat as flat on flat.id = b.flat_id left join city as city on city.id = project.city_id "
						+ "WHERE ";
						where+= " and b.builder_id="+builderEmployee.getBuilder().getId();
				hql = hql+" (b.name like '%"+keyword+"' OR b.mobile like '%"+keyword+"%')";
				if(projectId > 0){
					if(where != ""){
						hql +=" AND project.id="+projectId;
					}else{
						hql +=" project.id="+projectId;
					}
				}
			}
		}
		
		hql += where + " AND project.status=1 AND b.is_primary=1 AND b.is_deleted=0 GROUP by b.id ORDER BY project.id desc";
		try {
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BookedBuyerList.class));
		System.err.println(hql);
		 result = query.list();
		
		} catch(Exception e) {
			//
		}
		return result;
	}
	
	public ResponseMessage saveInboxMessages(List<InboxMessage> inboxMessageList){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		for(InboxMessage inboxMessage : inboxMessageList)
			session.save(inboxMessage);
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Message saved succefully");
		return responseMessage;
	}
	
	public List<InboxMessageData> getnameOrNumberList(int empId, String keyword){
		List<InboxMessageData> result = null;
		//String hql = "SELECT b.name as name, b.photo as image, im.subject as subject, im.im_date as date  ";
		String hql =" SELECT b.id as id, a.name as name, a.photo as image, b.im_date as date, b.subject as subject";
		String where = "";
		String hqlnew = "from BuilderEmployee where id = "+empId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session sessionnew = hibernateUtil.openSession();
		Query querynew = sessionnew.createQuery(hqlnew);
		List<BuilderEmployee> employees = querynew.list();
		BuilderEmployee builderEmployee = employees.get(0);
		sessionnew.close();
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2){
				if(keyword == ""){
					hql += " from buyer as a join inbox_message as b on b.buyer_id=a.id "
							+ "WHERE ";
							where+= "b.emp_id="+builderEmployee.getId();
				}else{
					hql += " from buyer as a join inbox_message as b on b.buyer_id=a.id "
							+ "WHERE ";
							where+= " and b.emp_id="+builderEmployee.getId();
					hql = hql+"  (a.name like '%"+keyword+"%' OR a.mobile like '%"+keyword+"%')";
					
				}
		}else{
				if(keyword == ""){
					hql = hql+" FROM buyer as a  join inbox_message as b on b.buyer_id=a.id "
							+ "left join builder as build on build.id = a.builder_id  "
							+ "WHERE ";
							where+= " and a.builder_id="+builderEmployee.getBuilder().getId();
				}else{
					hql = hql+" FROM buyer as a join inbox_message as b on b.buyer_id=a.id "
							+ "left join builder as build on build.id = a.builder_id  "
							+ "WHERE ";
							where+= " and a.builder_id="+builderEmployee.getBuilder().getId();
					hql = hql+"  (a.name like '%"+keyword+"' OR a.mobile like '%"+keyword+"%')";
				}
		}
		
		hql += where + " AND a.is_primary=1 and a.is_deleted=0 and a.status=0 GROUP by b.id ORDER by b.id DESC";
		try {
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(InboxMessageData.class));
		System.err.println(hql);
		 result = query.list();
		
		} catch(Exception e) {
			//
		}
		
		return result;
	}
	
	public List<ProjectWiseData> getProjectWiseByEmployee(BuilderEmployee builderEmployee){
		String hql = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
			hql = "select project.name as name, round(project.revenue) as revenue from builder_project as project left join builder_building as building on building.project_id = project.id left join builder_floor as floor on floor.building_id = building.id left join builder_flat as flat on flat.floor_no = floor.id where project.status=1 and project.group_id="+builderEmployee.getBuilder().getId()+" and flat.status_id=2 GROUP by project.id order by project.id desc";
		}else{
			hql = "select project.name as name, round(project.revenue) as revenue from builder_project as project INNER join allot_project as ap on ap.project_id = project.id left join builder_building as building on building.project_id = project.id left join builder_floor as floor on floor.building_id = building.id left join builder_flat as flat on flat.floor_no = floor.id where project.status=1 and ap.emp_id="+builderEmployee.getId()+" and flat.status_id=2 GROUP by project.id order by project.id desc";
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		
		List<ProjectWiseData> result = query.list();
		return result;
	}
	
	public List<ProjectWiseData> getProjectWiseByEmployee(int empid){
		String emphql = "from BuilderEmployee where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session empSession = hibernateUtil.openSession();
		Query empQuery = empSession.createQuery(emphql);
		empQuery.setParameter("id", empid);
		BuilderEmployee builderEmployee = (BuilderEmployee) empQuery.list().get(0);
				
		String hql = "";
		
		if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
			hql = "select project.name as name, project.revenue as revenue from builder_project as project left join builder_building as building on building.project_id = project.id left join builder_floor as floor on floor.building_id = building.id left join builder_flat as flat on flat.floor_no = floor.id where project.status=1 and project.group_id="+builderEmployee.getBuilder().getId()+" and flat.status_id=2 GROUP by project.id order by project.id desc";
		}else{
			hql = "select project.name as name, project.revenue as revenue from builder_project as project INNER join allot_project as ap on ap.project_id = project.id left join builder_building as building on building.project_id = project.id left join builder_floor as floor on floor.building_id = building.id left join builder_flat as flat on flat.floor_no = floor.id where project.status=1 and ap.emp_id="+builderEmployee.getId()+" and flat.status_id=2 GROUP by project.id order by project.id desc";
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		
		List<ProjectWiseData> result = query.list();
		return result;
	}
	
	public ResponseMessage updateLeadStatus(int value,int id){
		ResponseMessage responseMessage =  new ResponseMessage();
		BuilderLead builderLead = getBuilderLead(id);
		builderLead.setLeadStatus(value);
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		try{
			session.beginTransaction();
			session.update(builderLead);
			session.getTransaction().commit();
		}catch(Exception e){
			e.printStackTrace();
		}
		responseMessage.setId(builderLead.getId());
		responseMessage.setData(builderLead.getLeadStatus());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Lead Status updated successfully");
		
		return responseMessage;
 	}
	
	public BuilderLead getBuilderLead(int id){
		String hql = "from BuilderLead where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id",id);
		BuilderLead builderLead = (BuilderLead) query.list().get(0);
		return builderLead;
	}
	
	public List<BuilderEmployee> getBuilderSalesman(BuilderEmployee builderEmployee){
		String hql = "From BuilderEmployee where builder.id = :builder_id and builderEmployeeAccessType.id = 7";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderEmployee.getBuilder().getId());
		List<BuilderEmployee> result = query.list();
		return result;
	}
	
	public void addAllotLead(List<AllotLeads> allotLeads){
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		for(AllotLeads allotLeads2 : allotLeads){
			session.save(allotLeads2);
		}
		session.getTransaction().commit();
		session.close();
	}
	
	public List<BuilderEmployee> getBuilderSaleshead(BuilderEmployee builderEmployee){
		String hql = "From BuilderEmployee where builder.id = :builder_id and builderEmployeeAccessType.id = 5";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderEmployee.getBuilder().getId());
		List<BuilderEmployee> result = query.list();
		return result;
	}
	
	public List<ProjectData> getEmployeeByRoles(BuilderEmployee builderEmployee){
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
	
	public InboxMessageData getInboxMessageData(int id){
		String hql = "select buyer.id as buyerId, buyer.name as name, inbox.id as id, inbox.subject as subject, inbox.emp_id as empId, inbox.message as message, inbox.attachment as attachments "
				+ " from buyer as buyer left join inbox_message as inbox on inbox.buyer_id=buyer.id"
				+ " where inbox.id="+id+" and buyer.is_primary=1 and buyer.is_deleted=0 and buyer.status=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		  Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(InboxMessageData.class));
		List<InboxMessageData> result = query.list();
		session.close();
		
		return result.get(0);
	}
	
	public ResponseMessage saveInboxReply(InboxMessageReply inboxMessageReply){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.save(inboxMessageReply);
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		responseMessage.setMessage("Reply is save Successfully");
		return responseMessage;
		
	}
	
	public List<ProjectWiseData> getBuildingWiseByEmployeeId(BuilderEmployee builderEmployee, int projectId){
		String hql = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
			hql="select a.id as id,a.name as name, round(a.revenue) as revenue, count(c.id) as bookingCount, SUM(d.total_inventory) as avaliable from builder_building as a "
				+ "join builder_floor as b on b.building_id=a.id "
				+ "join builder_flat as c on c.floor_no=b.id "
				+ "join builder_project as d on d.id=a.project_id "
				+ "join builder as e on e.id=d.group_id "
				+ "where e.id="+builderEmployee.getBuilder().getId()+" and c.status_id=2 and d.status=1 and d.id=5 "
				+ "GROUP by a.id order by a.id DESC";
		}else{
			hql = "select a.id as id,a.name as name, round(a.revenue) as revenue, count(c.id) as bookingCount, SUM(d.total_inventory) as avaliable from builder_building as a "
				+ "join builder_floor as b on b.building_id=a.id "
				+ "join builder_flat as c on c.floor_no=b.id "
				+ "join builder_project as d on d.id=a.project_id "
				+ "where "
				+ "c.status_id=2 and d.status=1 and d.id="+projectId
				+ " GROUP by a.id order by a.id DESC";
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.addScalar("avaliable", LongType.INSTANCE)
			    .addScalar("bookingCount", LongType.INSTANCE)
				.addScalar("revenue", DoubleType.INSTANCE)
				.addScalar("name", StringType.INSTANCE)
				.setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		
		List<ProjectWiseData> result = query.list();
		return result;
	}
	
	public List<ProjectWiseData> getEmployeeBarGraphByBuilding(int projectId) {
		String hql = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
			hql = "select a.id as id,a.name as name, round(a.revenue) as revenue, count(c.id) as bookingCount, SUM(d.total_inventory) as avaliable from builder_building as a "
					+ "join builder_floor as b on b.building_id=a.id "
					+ "join builder_flat as c on c.floor_no=b.id "
					+ "join builder_project as d on d.id=a.project_id "
					//+ "inner join allot_project as e on e.project_id=d.id "
					+ "where "
					+ "c.status_id=2 and d.status=1 and d.id="+projectId
					+ " GROUP by a.id order by a.id DESC";
		
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).
				addScalar("avaliable", LongType.INSTANCE)
				.addScalar("bookingCount", LongType.INSTANCE).
				addScalar("revenue", DoubleType.INSTANCE)
				.addScalar("name", StringType.INSTANCE)
				.setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		
		List<ProjectWiseData> result = query.list();
		return result;
	}
	
	public List<EmployeeList> getSalesHeadByBuilderId(int builderId){
		String hql = "select emp.id as id, emp.name as name, emp.mobile as mobileNo, emp.email as email, GROUP_CONCAT(project.name) as projectName from builder_employee as emp join builder_project as project on project.group_id=emp.builder_id inner join allot_project as ap on ap.project_id = project.id where emp.access_type_id=5 and emp.builder_id="+builderId+" GROUP by emp.id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(EmployeeList.class));
		
		List<EmployeeList> result = query.list();
		return result;
	}
	
	public List<BuilderEmployeeAccessType> getBuilderAccessType(){
		String hql = "from BuilderEmployeeAccessType";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderEmployeeAccessType> result = query.list();
		return result;
	}
	
	public ProjectWiseData getTotalRevenueByEmployee(BuilderEmployee builderEmployee){
		String hql = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
			hql = "Select sum(ROUND(a.revenue)) as revenue, sum(a.total_inventory) as avaliable, sum(a.inventory_sold) as sold from builder_project as a join builder as b on b.id=a.group_id where a.group_id="+builderEmployee.getBuilder().getId();
		}else{
			hql = "Select sum(ROUND(a.revenue)) as revenue, sum(a.total_inventory) as avaliable, sum(a.inventory_sold) as sold from builder_project as a inner join allot_project as b on b.project_id=a.id where a.group_id="+builderEmployee.getBuilder().getId()+" and b.emp_id="+builderEmployee.getId();
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).
				addScalar("avaliable", LongType.INSTANCE)
				.addScalar("sold", LongType.INSTANCE).
				addScalar("revenue", DoubleType.INSTANCE).
				setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		List<ProjectWiseData> result = query.list();
		return result.get(0);
	}
	
	public ProjectWiseData getTotalRevenueByEmployee(int empid){
		String emphql = "from BuilderEmployee where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session empSession = hibernateUtil.openSession();
		Query empQuery = empSession.createQuery(emphql);
		empQuery.setParameter("id", empid);
		BuilderEmployee builderEmployee = (BuilderEmployee) empQuery.list().get(0);
				
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
			hql = "Select sum(ROUND(a.revenue)) as revenue, sum(a.total_inventory) as avaliable, sum(a.inventory_sold) as sold from builder_project as a join builder as b on b.id=a.group_id where a.group_id="+builderEmployee.getBuilder().getId();
		}else{
			hql = "Select sum(ROUND(a.revenue)) as revenue, sum(a.total_inventory) as avaliable, sum(a.inventory_sold) as sold from builder_project as a inner join allot_project as b on b.project_id=a.id where a.group_id="+builderEmployee.getBuilder().getId()+" and b.emp_id="+builderEmployee.getId();
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).
				addScalar("avaliable", LongType.INSTANCE)
				.addScalar("sold", LongType.INSTANCE).
				addScalar("revenue", DoubleType.INSTANCE).
				setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		List<ProjectWiseData> result = query.list();
		return result.get(0);
	}
	
	public ResponseMessage saveAllotedProjects(List<AllotProject> allotProjects){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		String hql = "delete from AllotProject where builderEmployee.id = :id";
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", allotProjects.get(0).getBuilderEmployee().getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		
		Session session1 = hibernateUtil.openSession();
		session1.beginTransaction();
		for(AllotProject allotProject:allotProjects) {
			session1.save(allotProject);
		}
		session1.getTransaction().commit();
		session1.close();
		response.setStatus(1);
		response.setMessage("Project Assigned successfully");
		List<ProjectData> projectdata = new ProjectDAO().getAssigProjects(allotProjects.get(0).getBuilderEmployee().getId());
		ArrayList<String> projectNames = new ArrayList<String>();
		System.err.println(projectdata.size());
		for(int a=0;a<projectdata.size();a++){
			projectNames.add(projectdata.get(a).getName());
		}
		String projectnames="";
		if(projectdata != null){
      	  int i=1;
      	  for(ProjectData assignProject : projectdata){
      		  if(i>1){
      	  		System.out.print(" "+assignProject.getName()+" |");
      	  		projectnames +=" "+assignProject.getName()+" | ";
      	  		i--;
      		  }else{
      			  System.out.print(assignProject.getName()+" |");
      			  projectnames +=assignProject.getName()+" |";
      		  }
       	i++;}} 
		 response.setData(projectnames);
		return response;
	}
	
	/**
	 * Return data for CEO's revenue Source wise
	 * @author pankaj
	 * @param projectId
	 * @return List<ProjectWiseData>
	 */
	public List<ProjectWiseData> getEmployeeBarGraphBySourceCEO(int projectId) {
		String hql = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		hql = "select source.name as name, count(lead.id) as dataCount, SUM(CASE WHEN lead.lead_status=7 THEN 1 ELSE 0 END) as booked from builder_lead as lead inner join builder_project as project on lead.project_id = project.id left join builder as builder on builder.id=project.group_id INNER JOIN source as source on lead.source=source.id where project.status=1 and project.id="+projectId+" GROUP by source.id order by source.name asc";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		List<ProjectWiseData> result = query.list();
		session.close();
		return result;
	}
	/**
	 * @author pankaj
	 * @param projectId
	 * @return
	 */
	public List<ProjectWiseData> getEmployeeBarGraphByMonthCEO(int projectId) {
		String hql = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		hql = "select elt(m.name,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec') as name,m.revenue,m.bookingCount,m.avaliable from(select COUNT(c.id) as bookingCount, project.total_inventory as avaliable, MONTH(a.booking_date) as name,round(sum(a.total_cost)) as revenue FROM buying_details as a join buyer as b on b.id=a.buyer_id join builder_flat as c on c.id=b.flat_id join builder_floor as f on f.id=c.floor_no join builder_building as building on building.id=f.building_id join builder_project as project on project.id=building.project_id left join builder as builder on builder.id=project.group_id where project.id="+projectId+" and b.is_primary=1 and b.is_deleted=0 and b.status=0 and c.status_id=2 group by MONTH(a.booking_date)) as m order by FIELD(m.name,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).
				addScalar("avaliable", LongType.INSTANCE)
				.addScalar("bookingCount", LongType.INSTANCE).
				addScalar("revenue", DoubleType.INSTANCE)
				.addScalar("name", StringType.INSTANCE).
				setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		List<ProjectWiseData> result = query.list();
		session.close();
		return result;
	}
	/**
	 * @author pankaj
	 * @param projectId
	 * @return
	 */
	public List<ProjectWiseData> getEmployeeBarGraphBySalesmanCEO(int projectId) {
		String hql = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		hql = "select emp.name as name, sum(bd.total_cost) as revenue, count(flat.id) as sold, project.total_inventory as avaliable from builder_employee as emp join buyer as buyer on buyer.emp_id = emp.id inner join buying_details as bd on bd.buyer_id = buyer.id left join builder_project as project on project.id = buyer.project_id left join builder as builder on builder.id=project.group_id left join builder_flat as flat on flat.id=buyer.flat_id where project.status=1 and buyer.is_primary=1 and buyer.is_deleted=0 and buyer.status=0 and project.id="+projectId+" GROUP by emp.id";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.addScalar("sold", LongType.INSTANCE).
				addScalar("revenue", DoubleType.INSTANCE).
				addScalar("name", StringType.INSTANCE).
				addScalar("avaliable", LongType.INSTANCE)
				.setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		List<ProjectWiseData> result = query.list();
		session.close();
		return result;
	}
	
	public List<ProjectWiseData> getBuildingWiseByEmployeeIdCEO(BuilderEmployee builderEmployee, int projectId){
		String hql = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
			hql="select a.id as id,a.name as name, round(a.revenue) as revenue, count(c.id) as bookingCount, SUM(d.total_inventory) as avaliable from builder_building as a "
				+ "join builder_floor as b on b.building_id=a.id "
				+ "join builder_flat as c on c.floor_no=b.id "
				+ "join builder_project as d on d.id=a.project_id "
				+ "join builder as e on e.id=d.group_id "
				+ "where c.status_id=2 and d.status=1 and d.id="+projectId
				+ " GROUP by a.id order by a.id DESC";
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql)
				.addScalar("avaliable", LongType.INSTANCE)
			    .addScalar("bookingCount", LongType.INSTANCE)
				.addScalar("revenue", DoubleType.INSTANCE)
				.addScalar("name", StringType.INSTANCE)
				.setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
		
		List<ProjectWiseData> result = query.list();
		return result;
	}
	public List<BuildingData> getBuildingData(List<String> projectIds){
		List<BuildingData> buildingDatas = new ArrayList<BuildingData>();
		if(projectIds != null && projectIds.size() > 0){
			String projectIdList = Arrays.toString(projectIds.toArray());
			String strSeparator = "";
			projectIdList = projectIdList.replace("[", strSeparator).replace("]", strSeparator);
			
			String  hql="SELECT  b.id as id, b.name as name FROM builder_building as b WHERE b.project_id IN("+projectIdList+") and b.status=1";
			HibernateUtil hibernateUtil = new HibernateUtil();
			try {
					Session session = hibernateUtil.getSessionFactory().openSession();
					Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuildingData.class));
					System.err.println("hql : "+hql);
					buildingDatas = query.list();
					return buildingDatas;
				} catch(Exception e) {
					//
					return null;
				}
		}else{
			return null;
		}
	}
//	public List<BuyerList> getFlatBuyerList(List<String> buildingIds){
//		List<BuyerList> buildingDatas = new ArrayList<BuyerList>();
//		if(buildingIds != null && buildingIds.size() > 0){
//			String buildingIdList = Arrays.toString(buildingIds.toArray());
//			String strSeparator = "";
//			buildingIdList = buildingIdList.replace("[", strSeparator).replace("]", strSeparator);
//			
//			String  hql="Select a.id as id,a.name as name, b.flat_no as flatNumber from buyer as a join builder_flat as b on b.id = a.flat_id join builder_floor as c on c.id=b.floor_no join builder_building as d on d.id = c.building_id where d.id in ("+buildingIdList+") and a.is_primary=1 and a.is_deleted=0 AND a.status=0";
//			HibernateUtil hibernateUtil = new HibernateUtil();
//			try {
//					Session session = hibernateUtil.getSessionFactory().openSession();
//					Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuyerList.class));
//					System.err.println("hql : "+hql);
//					buildingDatas = query.list();
//					return buildingDatas;
//				} catch(Exception e) {
//					//
//					return null;
//				}
//		}else{
//			return null;
//		}
//	}
	
		public List<BuildingData> getBuildingData(String projectIds){
			List<BuildingData> buildingDatas = new ArrayList<BuildingData>();
				
			String  hql="SELECT  b.id as value, b.name as name FROM builder_building as b WHERE b.project_id IN("+projectIds+") and b.status=1";
			HibernateUtil hibernateUtil = new HibernateUtil();
			try{
				Session session = hibernateUtil.getSessionFactory().openSession();
				Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuildingData.class));
				System.err.println("hql : "+hql);
				buildingDatas = query.list();
				return buildingDatas;
			}catch(Exception e) {
					//
				return null;
			}
		}
		
		public List<BuyerList> getFlatBuyerList(String buildingIds){
			List<BuyerList> buildingDatas = new ArrayList<BuyerList>();
			String  hql="Select a.id as value,CONCAT_WS(' & ',b.flat_no, a.name) as name from buyer as a join builder_flat as b on b.id = a.flat_id join builder_floor as c on c.id=b.floor_no join builder_building as d on d.id = c.building_id where d.id in ("+buildingIds+") and a.is_primary=1 and a.is_deleted=0 AND a.status=0";
			HibernateUtil hibernateUtil = new HibernateUtil();
			try{
				Session session = hibernateUtil.getSessionFactory().openSession();
				Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuyerList.class));
				System.err.println("hql : "+hql);
				buildingDatas = query.list();
				return buildingDatas;
			}catch(Exception e) {
					//
				return null;
			}
		}
		
		public ResponseMessage saveEmpRoles(List<EmployeeRole> empRoleList){
			ResponseMessage responseMessage = new ResponseMessage();
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			session.beginTransaction();
			for(EmployeeRole empRoles : empRoleList){
				session.save(empRoles);
			}
			session.getTransaction().commit();
			session.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Empolyee added Successfully.");
			return responseMessage;
			
		}
		
		public List<ProjectWiseData> getCampaignWiseData(int empId){
			String emphql = "from BuilderEmployee where id = :id";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session empSession = hibernateUtil.openSession();
			Query empQuery = empSession.createQuery(emphql);
			empQuery.setParameter("id", empId);
			BuilderEmployee builderEmployee = (BuilderEmployee) empQuery.list().get(0);
					
			String hql = "";
			if(builderEmployee.getBuilderEmployeeAccessType().getId() ==3){
				hql = "SELECT COUNT(a.id) as bookingCount,b.name as name FROM campaign as a JOIN builder_project as b on b.id = a.project_id inner join allot_project as ap on ap.project_id=b.id where ap.emp_id="+builderEmployee.getId()+" GROUP by b.id";
			}else{
			}
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).
					addScalar("bookingCount", LongType.INSTANCE)
					.addScalar("name", StringType.INSTANCE).
					setResultTransformer(Transformers.aliasToBean(ProjectWiseData.class));
			List<ProjectWiseData> result = query.list();
			return result;
		}
		
		public List<ProjectData> getProjectList(String cityIds, int empId){
			String hql = "";
			String hqlnew = "from BuilderEmployee where id = "+empId;
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session sessionnew = hibernateUtil.openSession();
			Query querynew = sessionnew.createQuery(hqlnew);
			List<BuilderEmployee> employees = querynew.list();
			BuilderEmployee builderEmployee = employees.get(0);
			hql = "SELECT a.id as value, a.name as name FROM builder_project as a inner join allot_project as b on b.project_id=a.id WHERE a.city_id in ("+cityIds+") and a.status=1 and a.group_id="+builderEmployee.getBuilder().getId()+" and b.emp_id="+empId;
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectData.class));
			List<ProjectData> result = query.list();
			session.close();
			return result;
		}
		
		public List<ProjectData> getBuyerOrBuilding(String projectIds,String userType, int empId){
			String hql = "";
			String hqlnew = "from BuilderEmployee where id = "+empId;
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session sessionnew = hibernateUtil.openSession();
			Query querynew = sessionnew.createQuery(hqlnew);
			List<BuilderEmployee> employees = querynew.list();
			BuilderEmployee builderEmployee = employees.get(0);
			int a=0,b=0,c=0;
			if(userType.length() == 5){
				hql="SELECT a.project_id as id, CONCAT(a.id,'',3) as value,a.name as name, 3 as typeId FROM builder_employee as a where  a.access_type_id>2 and a.builder_id ="+builderEmployee.getBuilder().getId()+" UNION select b.project_id as id, CONCAT(b.id,'',2) as value, b.name as name,2 as typeId from builder_lead as b where b.project_id in("+projectIds+") UNION select c.project_id as id, CONCAT(c.id,'',1) as value, c.name as name,1 as typeId from buyer as c where c.is_primary=1 and c.is_deleted=0 and c.project_id in ("+projectIds+");";
			}
			else if(userType.length() == 3){
				try{
					if(userType.contentEquals("1,2")){
						a=1;
						b=2;
						c=0;
					}else if(userType.contentEquals("1,3")){
						a=1;
						b=0;
						c=3;
					}else if(userType.contentEquals("2,3")){
						a=0;
						b=2;
						c=3;
					}
					if(a==1 && b==2 && c == 0){
						hql="Select b.project_id as id,  CONCAT(b.id,'',2) as value, b.name as name,2 as typeId from builder_lead as b where b.project_id in("+projectIds+") UNION select c.project_id as id, CONCAT(c.id,'',1) as value, c.name as name,1 as typeId from buyer as c where c.is_primary=1 and c.is_deleted=0 and c.project_id in ("+projectIds+");";
					}
					else if(a==1 && c==3 && b == 0){
						hql="SELECT a.project_id as id, CONCAT(a.id,'',3) as value,a.name as name, 3 as typeId FROM builder_employee as a where  a.access_type_id>2 and a.builder_id ="+builderEmployee.getBuilder().getId()+" UNION select c.project_id as id, CONCAT(c.id,'',1) as value, c.name as name,1 as typeId from buyer as c where c.is_primary=1 and c.is_deleted=0 and c.project_id in ("+projectIds+");";
					}
					else if(b==2 && c==3 && a==0){
						hql="SELECT a.project_id as id, CONCAT(a.id,'',3) as value,a.name as name, 3 as typeId FROM builder_employee as a where  a.access_type_id>2 and a.builder_id ="+builderEmployee.getBuilder().getId()+" UNION select b.project_id as id, CONCAT(b.id,'',2) as value, b.name as name,2 as typeId from builder_lead as b where b.project_id in("+projectIds+");";
					}
				}catch(Exception e){
					
					e.printStackTrace();
					//return null;
				}
			}
			else if(userType.length() == 1){
				if(userType.equals("1")){
					hql="select a.project_id as id,a.id as value, a.name as name, 4 as typeId from builder_building as a join builder_project as b on b.id = a.project_id inner join allot_project as c on c.project_id=b.id where c.emp_id="+builderEmployee.getId();
				}
				else if(userType.equals("2")){
					hql="select a.project_id as id, CONCAT(b.id,'',2) as value, b.name as name,2 as typeId from builder_lead as b where b.project_id in("+projectIds+");";
				}
				else if(userType.equals("3")){
					hql="SELECT a.project_id as id, CONCAT(a.id,'',3) as value,a.name as name, 3 as typeId FROM builder_employee as a where a.access_type_id>2 and a.builder_id ="+builderEmployee.getBuilder().getId()+";";
				}else{
					
				}
			}
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).
					addScalar("value",IntegerType.INSTANCE).
					addScalar("name", StringType.INSTANCE).
					addScalar("typeId",IntegerType.INSTANCE).
					addScalar("id",IntegerType.INSTANCE).
					setResultTransformer(Transformers.aliasToBean(ProjectData.class));
			List<ProjectData> result = query.list();
			System.err.println(hql);
			session.close();
			sessionnew.close();
			return result;
		}
		
		public List<ProjectData> getBuyerLists(String buildingIds){		
			HibernateUtil hibernateUtil = new HibernateUtil();
			String hql="SELECT a.project_id as id, CONCAT(a.id,'',1) as value,a.name as name, 1 as typeId FROM buyer as a WHERE a.building_id in("+buildingIds+") and a.is_primary=1 and a.is_deleted=0";
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).
					addScalar("value",IntegerType.INSTANCE).
					addScalar("name", StringType.INSTANCE).
					addScalar("typeId",IntegerType.INSTANCE).
					addScalar("id",IntegerType.INSTANCE).
					setResultTransformer(Transformers.aliasToBean(ProjectData.class));
			List<ProjectData> result = query.list();
			System.err.println(hql);
			session.close();
			return result;
		}
		/**
		 * @author pankaj
		 * @param empId
		 * @param countryId
		 * @param stateId
		 * @param cityId
		 * @param localityName
		 * @return
		 */
		
		public List<BuilderProjectList> getProjectFiltersByEmpIds(int empId,int countryId,int cityId, String localityName,int projectId, int projectStatus){
			List<BuilderProjectList> builderProjectLists = new ArrayList<BuilderProjectList>();
			String hqlnew = "from BuilderEmployee where id = "+empId;
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session sessionnew = hibernateUtil.openSession();
			Query querynew = sessionnew.createQuery(hqlnew);
			List<BuilderEmployee> employees = querynew.list();
			BuilderEmployee builderEmployee = employees.get(0);
			sessionnew.close();
			String hql = "SELECT project.id as id, project.name as name, project.image as image, "
					+"project.completion_status as completionStatus,project.inventory_sold as sold, "
					+"project.total_inventory as totalSold, "
					+"c.name as city, project.locality_name as locality, "
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
//			if(stateId > 0){
//				if(where !="")
//					where += " AND project.state_id = :state_id";
//				else
//					where += "project.state_id = :state_id";
//			}
			if(cityId > 0){
				if(where != "")
					where +=" AND project.city_id = :city_id";
				else
					where +="project.city_id = :city_id";
			}
			if(localityName != null){
				if(where != "")
					where +=" AND project.locality_name like :locality_name";
				else
					where +="project.locality_name like :locality_name";
			}
			if(projectId > 0){
				if(where != ""){
					where +=" AND  project.id = :id";
				}else{
					where +=" project.id = :id";
				}
			}
			if(projectStatus > 0){
				if(projectStatus == 1){
					if(where != ""){
						where +=" AND project.completion_status BETWEEN 0 AND 100 ";
					}
					else{
						where +=" project.completion_status BETWEEN 0 AND 100 ";
					}
				}
				if(projectStatus == 2){
					if(where != ""){
						where +=" AND project.completion_status=100";
					}
					else{
						where +=" project.completion_status=100";
					}
				}
			}
			
			hql += where + " AND project.status=1 GROUP by project.id order by project.id desc";
			try {
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuilderProjectList.class));
			System.err.println("hql : "+hql);
			if(countryId > 0)
				query.setParameter("country_id", countryId);
//			if(stateId > 0)
//				query.setParameter("state_id", stateId);
			if(cityId > 0)
				query.setParameter("city_id",cityId);
			
			if(localityName != null)
				query.setParameter("locality_name", localityName+"%");
			if(projectId > 0){
				query.setParameter("id", projectId);
			}
				builderProjectLists = query.list();
			} catch(Exception e) {
				//
			}
			return builderProjectLists;
		}
		
		public void saveNewEmpRole(EmployeeRole empRoleList){
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			session.beginTransaction();
			session.save(empRoleList);
			session.getTransaction().commit();
			session.close();
		}
		
		public List<EmployeeRole> getEmployeeRolesByEmployee(int empId){
			HibernateUtil hibernateUtil = new HibernateUtil();
			String hql = "from EmployeeRole where builderEmployee.id="+empId;
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			List<EmployeeRole> employeeRoles = query.list();
			session.close();
			return employeeRoles;
		}
		public void deleteEmployeeRolesByEmpId(int emp_id){
			String hql = "delete from EmployeeRole where builderEmployee.id = :emp_id";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setParameter("emp_id", emp_id);
			query.executeUpdate();
			session.getTransaction().commit();
			session.close();
		}
		public List<BuilderEmployeeAccessType> getBuilderAccessList() {
			List<BuilderEmployeeAccessType> result = null;
			String hql = "";
			hql = "from BuilderEmployeeAccessType";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			result = query.list();
			session.close();
			
			return result;
		}
		
		public ResponseMessage updateEmpRoles(List<EmployeeRole> empRoleList){
			String hql = "delete from EmployeeRole where builderEmployee.id = :emp_id";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session sessionDelete = hibernateUtil.openSession();
			sessionDelete.beginTransaction();
			Query queryDelate = sessionDelete.createQuery(hql);
			queryDelate.setParameter("emp_id", empRoleList.get(0).getBuilderEmployee().getId());
			queryDelate.executeUpdate();
			sessionDelete.getTransaction().commit();
			sessionDelete.close();
			
			ResponseMessage responseMessage = new ResponseMessage();
			Session session = hibernateUtil.openSession();
			session.beginTransaction();
			for(EmployeeRole empRoles : empRoleList){
				session.save(empRoles);
			}
			session.getTransaction().commit();
			session.close();
			responseMessage.setStatus(1);
			responseMessage.setMessage("Empolyee Updated Successfully.");
			return responseMessage;
			
		}
		
		public ResponseMessage getRegisteredEmailId(String emailId){
			ResponseMessage responseMessage = new ResponseMessage();
			if(emailId != null && emailId.trim().length()>0){
				String hql = "from BuilderEmployee where email = '"+emailId+"'";
				HibernateUtil hibernateUtil = new HibernateUtil();
				Session session = hibernateUtil.openSession();
				Query query = session.createQuery(hql);
				List<BuilderEmployee> result = query.list();
				if(result.size() > 0 && result !=null){
					responseMessage.setStatus(1);
					responseMessage.setMessage("Your will receive your password on your registered mobile number and email id.");
				}else{
					responseMessage.setStatus(0);
					responseMessage.setMessage("Please enter your registered email id.");
				}
			}else{
				responseMessage.setStatus(0);
				responseMessage.setMessage("Registered email id is required.");
			}
			return responseMessage;
		}
		
		public ResponseMessage getRegisteredMobileNumber(String mobileNo){
			ResponseMessage responseMessage = new ResponseMessage();
			if(mobileNo.trim().length() > 0){
				try{
					String hql = "from BuilderEmployee where mobile = '"+mobileNo+"'";
					HibernateUtil hibernateUtil = new HibernateUtil();
					Session session = hibernateUtil.openSession();
					Query query = session.createQuery(hql);
					List<BuilderEmployee> result = query.list();
					if(result.size() > 0 && result !=null){
						responseMessage.setStatus(1);
						responseMessage.setMessage("Your will receive your username on your registered mobile number and email id.");
					}else{
						responseMessage.setStatus(0);
						responseMessage.setMessage("Please enter your registered mobile number.");
					}
					return responseMessage;
				}catch(Exception e){
					responseMessage.setStatus(0);
					responseMessage.setMessage("Please enter numbers only.");
					return responseMessage;
				}
			}else{
				responseMessage.setStatus(0);
				responseMessage.setMessage("Registered mobile number is required.");
				return responseMessage;
			}
			
		}
		
		 //City names for dashboard
		  /**
		   * Get list of city with alloted projects or with builder id from project table
		   * @author pankaj
		   * @param builderEmployee
		   * @return List<NameList>
		   */
		public List<NameList> getProjectCityList(BuilderEmployee builderEmployee){
			String hql = "";
			if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
				hql = "SELECT DISTINCT(city.name) as name, project.city_id as id "
						+ "from builder_project as project "
						+ "left join builder as b on b.id=project.group_id "
						+ "left join city as city on city.id=project.city_id "
						+ "where b.id="+builderEmployee.getBuilder().getId();
			}else{
				hql = "SELECT DISTINCT(city.name) as name,city.id as id from builder_project as project "
						+ "left join city as city on city.id=project.city_id "
						+ "inner join allot_project as ap on ap.project_id=project.id "
						+ "where ap.emp_id="+builderEmployee.getId();						
			}
			hql +=" and project.status=1 group  by project.id order by city.name desc";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameList.class));
			List<NameList> result = query.list();
			session.close();
			return result;
		}
		
		public List<NameList> getProjectLocalityList(BuilderEmployee builderEmployee){
			String hql = "";
			if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
				hql = "SELECT DISTINCT(project.locality_name) as name from builder_project as project "
						+ "left join builder as b on b.id=project.group_id "
						+ "where b.id="+builderEmployee.getBuilder().getId();
			}else{
				hql = "SELECT DISTINCT(project.locality_name) as name from builder_project as project "
						+ "inner join allot_project as ap on ap.project_id=project.id "
						+ "where ap.emp_id="+builderEmployee.getId();
			}
			hql +=" and project.status=1 group by project.id order by project.locality_name desc";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameList.class));
			List<NameList> result = query.list();
			session.close();
			return result;
		}
		
		public List<NameList> getAllotedProjectDetails(BuilderEmployee builderEmployee){
			String hql = "";
			if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
				hql = "SELECT project.name as name, project.id as id "
						+ "from builder_project as project "
						+ "join builder as b on b.id=project.group_id "
						+ "join city as city on city.id=project.city_id "
						+ "where b.id="+builderEmployee.getBuilder().getId()+" "
						+ "and project.status=1";
			}else{
				hql = "SELECT project.name as name,project.id as id from builder_project as project "
						+ "join city as city on city.id=project.city_id "
						+ "inner join allot_project as ap on ap.project_id=project.id "
						+ "where ap.emp_id="+builderEmployee.getId()+" and "
						+ "project.status=1 "
						+ "group by project.id order by city.name desc";
			}
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameList.class));
			List<NameList> result = query.list();
			session.close();
			return result;
		}
		
		
		public List<NameList> getProjectCityList(int empId){
			String empHql = "from BuilderEmployee where id ="+empId;
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session empSession = hibernateUtil.openSession();
			Query empQuery = empSession.createQuery(empHql);
			BuilderEmployee builderEmployee = (BuilderEmployee)empQuery.list().get(0);
			String hql = "";
			if(builderEmployee != null){
				if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
					hql = "SELECT DISTINCT(city.name) as name, project.city_id as id "
							+ "from builder_project as project "
							+ "left join builder as b on b.id=project.group_id "
							+ "left join city as city on city.id=project.city_id "
							+ "where b.id="+builderEmployee.getBuilder().getId();
				}else{
					hql = "SELECT DISTINCT(city.name) as name,city.id as id from builder_project as project "
							+ "left join city as city on city.id=project.city_id "
							+ "inner join allot_project as ap on ap.project_id=project.id "
							+ "where ap.emp_id="+builderEmployee.getId();						
				}
			}
			hql +=" and project.status=1 group  by project.id order by city.name desc";
			
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameList.class));
			List<NameList> result = query.list();
			session.close();
			return result;
		}
		
		public List<NameList> getProjectLocalityList(int cityId,int empId){
			String empHql = "from BuilderEmployee where id ="+empId;
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session empSession = hibernateUtil.openSession();
			Query empQuery = empSession.createQuery(empHql);
			BuilderEmployee builderEmployee = (BuilderEmployee)empQuery.list().get(0);
			String hql = "";
			if(builderEmployee != null){
				if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
					hql = "SELECT DISTINCT(project.locality_name) as name from builder_project as project "
						+ "left join builder as b on b.id=project.group_id "
						+ "where b.id="+builderEmployee.getBuilder().getId();
					if(cityId > 0){
						hql +=" and project.city_id="+cityId;
					}
				}else{
					hql = "SELECT DISTINCT(project.locality_name) as name from builder_project as project "
						+ "inner join allot_project as ap on ap.project_id=project.id "
						+ "where ap.emp_id="+builderEmployee.getId();
					if(cityId > 0){
						hql +=" and project.city_id="+cityId;
					}
				}
			}
			hql +=" and project.status=1 group by project.id order by project.locality_name desc";
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameList.class));
			List<NameList> result = query.list();
			session.close();
			return result;
		}
		
		public List<NameList> getAllotedProjectDetails(int cityId,int empId){
			String empHql = "from BuilderEmployee where id ="+empId;
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session empSession = hibernateUtil.openSession();
			Query empQuery = empSession.createQuery(empHql);
			BuilderEmployee builderEmployee = (BuilderEmployee)empQuery.list().get(0);
			String hql = "";
			if(builderEmployee != null){
				if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
					hql = "SELECT project.name as name, project.id as id from builder_project as project "
						+ "join builder as b on b.id=project.group_id "
						+ "where b.id="+builderEmployee.getBuilder().getId();
					if(cityId > 0){
						hql +=" and project.city_id = "+cityId;
					}
				}else{
					hql = "SELECT project.name as name,project.id as id from builder_project as project "
						+ "inner join allot_project as ap on ap.project_id=project.id "
						+ "where ap.emp_id="+builderEmployee.getId();
					if(cityId > 0){
						hql +=" and project.city_id = "+cityId;
					}
				}
			}
			hql +=" and project.status=1 group by project.id order by project.name desc";
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameList.class));
			List<NameList> result = query.list();
			session.close();
			return result;
		}
		public List<NameList> getAllotedProjectDetails(String localityName,int empId){
			String empHql = "from BuilderEmployee where id ="+empId;
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session empSession = hibernateUtil.openSession();
			Query empQuery = empSession.createQuery(empHql);
			BuilderEmployee builderEmployee = (BuilderEmployee)empQuery.list().get(0);
			String hql = "";
			if(builderEmployee != null){
				if(builderEmployee.getBuilderEmployeeAccessType().getId() >=1 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
					hql = "SELECT project.name as name, project.id as id from builder_project as project "
						+ "join builder as b on b.id=project.group_id "
						+ "where b.id="+builderEmployee.getBuilder().getId();
					if(localityName != ""){
						hql +=" and project.locality_name = '"+localityName+"'";
					}
				}else{
					hql = "SELECT project.name as name,project.id as id from builder_project as project "
						+ "inner join allot_project as ap on ap.project_id=project.id "
						+ "where ap.emp_id="+builderEmployee.getId();
					if(!localityName.isEmpty() || localityName.trim().length() > 0){
						hql +=" and project.locality_name = '"+localityName+"'";
					}
				}
			}
			hql +=" and project.status=1 group by project.id order by project.name desc";
			System.err.println(hql);
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameList.class));
			List<NameList> result = query.list();
			session.close();
			return result;
		}
		
		/**
		 * @author pankaj
		 * @param empId
		 * @param countryId
		 * @param stateId
		 * @param cityId
		 * @param localityName
		 * @return
		 */
		
		public List<BuilderProjectList> getProjectFiltersByEmpIds(int empId,int cityId, String localityName,int projectId, int projectStatus){
			List<BuilderProjectList> builderProjectLists = new ArrayList<BuilderProjectList>();
			String hqlnew = "from BuilderEmployee where id = "+empId;
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session sessionnew = hibernateUtil.openSession();
			Query querynew = sessionnew.createQuery(hqlnew);
			List<BuilderEmployee> employees = querynew.list();
			BuilderEmployee builderEmployee = employees.get(0);
			sessionnew.close();
			String hql = "SELECT project.id as id, project.name as name, project.image as image, "
					+"project.completion_status as completionStatus,project.inventory_sold as sold, "
					+"project.total_inventory as totalSold, "
					+"c.name as city, project.locality_name as locality, "
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
		
			
			if(cityId > 0){
				if(where != "")
					where +=" AND project.city_id = :city_id";
				else
					where +="project.city_id = :city_id";
			}
			if(localityName != null){
				if(where != "")
					where +=" AND project.locality_name like :locality_name";
				else
					where +="project.locality_name like :locality_name";
			}
			if(projectId > 0){
				if(where != ""){
					where +=" AND  project.id = :id";
				}else{
					where +=" project.id = :id";
				}
			}
			if(projectStatus > 0){
				if(projectStatus == 1){
					if(where != ""){
						where +=" AND project.completion_status BETWEEN 0 AND 100 ";
					}
					else{
						where +=" project.completion_status BETWEEN 0 AND 100 ";
					}
				}
				if(projectStatus == 2){
					if(where != ""){
						where +=" AND project.completion_status=100";
					}
					else{
						where +=" project.completion_status=100";
					}
				}
			}
			
			hql += where + " AND project.status=1 GROUP by project.id order by project.id desc";
			try {
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BuilderProjectList.class));
			System.err.println("hql : "+hql);
			
			if(cityId > 0)
				query.setParameter("city_id",cityId);
			
			if(localityName != null)
				query.setParameter("locality_name", localityName+"%");
			if(projectId > 0){
				query.setParameter("id", projectId);
			}
				builderProjectLists = query.list();
			} catch(Exception e) {
				//
				e.printStackTrace();
			}
			return builderProjectLists;
		}
		
		public ContactUs getContactDetails(int id){
			HibernateUtil hibernateUtil = new HibernateUtil();
			String hql = "select  builder.mobile as mobile, builder.email as email, builder_logo.builder_url as image from builder_project as project join builder as builder on builder.id = project.group_id join builder_logo as builder_logo on builder_logo.builder_id=builder.id where project.id="+id+" GROUP by builder.id";
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ContactUs.class));
			List<ContactUs> result = query.list();
			return result.get(0);
		}
}