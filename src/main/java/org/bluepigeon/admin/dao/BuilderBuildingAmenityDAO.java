package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.data.BuildingAmenityList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.model.BuilderBuildingAmenity;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderBuildingAmenityDAO {

	public ResponseMessage save(BuilderBuildingAmenity builderBuildingAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (builderBuildingAmenity.getName() == null || builderBuildingAmenity.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter building amenity name");
		} else {
			String hql = "from BuilderBuildingAmenity where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", builderBuildingAmenity.getName());
			List<BuilderBuildingAmenity> result = query.list();
			session.close();
			if (result.size() > 0) {
				if(result.get(0).getIsDeleted() ==1){
					byte isDeleted=0;
					builderBuildingAmenity.setId(result.get(0).getId());
					builderBuildingAmenity.setIsDeleted(isDeleted);
					Session newsession = hibernateUtil.openSession();
					newsession.beginTransaction();
					newsession.update(builderBuildingAmenity);
					newsession.getTransaction().commit();
					newsession.close();
					response.setStatus(1);
					response.setMessage("Building amenity Added Successfully");
				}else{
					response.setStatus(0);
					response.setMessage("Building amenity name already exists");
				}
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(builderBuildingAmenity);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Building amenity Added Successfully");
			}
		}
		return response;
	}

	public ResponseMessage update(BuilderBuildingAmenity builderBuildingAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderBuildingAmenity where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderBuildingAmenity.getName());
		query.setParameter("id", builderBuildingAmenity.getId());
		// System.out.println("Country status ::"+country.getStatus());
		// query.setParameter("status", country.getStatus());
		System.out.println("id :: "+builderBuildingAmenity.getId()+" Name :: "+builderBuildingAmenity.getName());
		List<BuilderBuildingAmenity> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Building amenity name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(builderBuildingAmenity);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Building amenity Updated Successfully");
		}
		return response;
	}

	public ResponseMessage delete(BuilderBuildingAmenity builderBuildingAmenity) {
	/*	ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderBuildingAmenity where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderBuildingAmenity.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Success");*/
		
		
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from BuilderBuildingAmenity where id = :id";
		Session session = hibernateUtil.openSession();
		System.out.println("Area Unit Id : "+builderBuildingAmenity.getId());
		Query query = session.createQuery(hql);
		query.setParameter("id", builderBuildingAmenity.getId());
		List<BuilderBuildingAmenity> result = query.list();
		session.close();
		if (result.size() > 0) {
			builderBuildingAmenity.setName(result.get(0).getName());
			builderBuildingAmenity.setStatus(result.get(0).getStatus());
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(builderBuildingAmenity);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Building Amenity Deleted Successfully");
		} 
		else{
			response.setStatus(0);
			response.setMessage("Building Amenity Fail to Delete");
		}
		return response;
	
	}

	public List<BuilderBuildingAmenity> getBuilderBuildingAmenityList() {
		String hql = "from BuilderBuildingAmenity where isDeleted=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderBuildingAmenity> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all active building amenity list
	 * @author pankaj
	 * @return List<BuilderBuildingAmenity>
	 */
	public List<BuilderBuildingAmenity> getActiveBuilderBuildingAmenityList() {
		String hql = "from BuilderBuildingAmenity where isDeleted=0 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderBuildingAmenity> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuilderBuildingAmenity> getBuilderActiveBuildingAmenityList() {
		String hql = "from BuilderBuildingAmenity where isDeleted=0 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderBuildingAmenity> result = query.list();
		session.close();
		return result;
	}

	public List<BuilderBuildingAmenity> getBuilderBuildingAmenityById(int id) {
		String hql = "from BuilderBuildingAmenity where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderBuildingAmenity> result = query.list();
		session.close();
		return result;
	}
}
