package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderEmployeeAccessType;
import org.bluepigeon.admin.model.Locality;
import org.bluepigeon.admin.data.BuilderDetails;
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
		int count = 0;
		int objectCount = builderCompanyNames.size();
		if(builderCompanyNames.size()>0){
			try{
				String deleteBuilderCompanyName = "Update from BuilderCompanyNames  set name=:name,email=:email,contact=:contact where builder.id = :builder_id";
				Session newsession1 = hibernateUtil.openSession();
				for(BuilderCompanyNames builderCompanyNames2 : builderCompanyNames){
					newsession1.beginTransaction();
					Query smupdate = newsession1.createQuery(deleteBuilderCompanyName);
					smupdate.setParameter("builder_id", builderCompanyNames2.getBuilder().getId());
					smupdate.setParameter("name", builderCompanyNames2.getName());
					smupdate.setParameter("email", builderCompanyNames2.getEmail());
					smupdate.setParameter("contact", builderCompanyNames2.getContact());
					smupdate.executeUpdate();
					newsession1.getTransaction().commit();
					count++;
				}
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
	public List<Builder> getBuilderList() {
		String hql = "from Builder";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Builder> result = query.list();
		
		session.close();
		return result;
	}

	public List<BuilderEmployeeAccessType> getBuilderAccessList() {
		String hql = "from BuilderEmployeeAccessType";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderEmployeeAccessType> result = query.list();
		session.close();
		return result;
	}
	
	public List<Builder> getBuilderById(int id) {
		String hql = "from Builder where id = :id";
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
		String passwordHql = "from Builder where password = :password";
		String hql = "UPDATE Builder set password = :password, loginStatus=1 "  + 
	             "WHERE id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session passwordSession = hibernateUtil.openSession();
		Session updatePasswordSession = hibernateUtil.openSession();
		Query passwordQuery = passwordSession.createQuery(passwordHql);
		passwordQuery.setParameter("password", oldPassword);
		Builder builder = (Builder) passwordQuery.list().get(0);
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
	public List<EmployeeList> getBuilderEmployeeList(int builder_id) {
		String hql = "from BuilderEmployee where builder.id=:builder_id";
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
}