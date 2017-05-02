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
import org.bluepigeon.admin.model.Locality;
import org.bluepigeon.admin.data.BuilderDetails;
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
				
				Set<BuilderCompanyNames> builderCompanyNames = builderDetails.getBuilderCompanyNames();
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
			Set<BuilderCompanyNames> builderCompanyNames= builderDetails.getBuilderCompanyNames();
			 if(builderCompanyNames.size()>0){
			String deleteBuilderCompanyName = "DELETE from BuilderCompanyNames where builder.id = :builder_id";
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

	public List<Builder> getBuilderList() {
		String hql = "from Builder";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Builder> result = query.list();
		
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
}