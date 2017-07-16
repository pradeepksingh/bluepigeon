package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderFlatAmenity;
import org.bluepigeon.admin.model.FlatAmenityIcon;
import org.bluepigeon.admin.model.ProjectAmenityIcon;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderFlatAmenityDAO {

	public ResponseMessage save(BuilderFlatAmenity builderFlatAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (builderFlatAmenity.getName() == null || builderFlatAmenity.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter flat amenity name");
		} else {
			String hql = "from BuilderFlatAmenity where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", builderFlatAmenity.getName());
			List<BuilderFlatAmenity> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Flat amenity name already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(builderFlatAmenity);
				newsession.getTransaction().commit();
				newsession.close();
				response.setId(builderFlatAmenity.getId());
				response.setStatus(1);
				response.setMessage("Flat amenity added Successfully");
			}
		}
		return response;
	}
	public ResponseMessage saveFlatAmenityIcon(List<FlatAmenityIcon> flatAmenityIcons){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		for(FlatAmenityIcon flatAmenityIcon : flatAmenityIcons){
			session.save(flatAmenityIcon);
		}
		session.getTransaction().commit();
		session.close();
		
		responseMessage.setStatus(1);
		responseMessage.setMessage("Flat amenity added Successfully");
		return responseMessage;
		
	}
	
	public FlatAmenityIcon getFlatAmenityIconById(int amenityId){
		FlatAmenityIcon flatAmenityIcon = null;
		String hql = "from FlatAmenityIcon where builderFlatAmenity.id = :amenity_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("amenity_id", amenityId);
		flatAmenityIcon = (FlatAmenityIcon) query.uniqueResult();
		return flatAmenityIcon;
	}
	 
	/**
	 * Update falt amenity icon
	 * @author pankaj
	 * @param flatAmenityIcons
	 */
	public void updateFlatAmenityIcon(List<FlatAmenityIcon> flatAmenityIcons){
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		String hql = "update FlatAmenityIcon set iconUrl=:icon_url where id = :id";
		session.beginTransaction();
		Query query = session.createQuery(hql);
		for(FlatAmenityIcon flatAmenityIcon :flatAmenityIcons){
			query.setParameter("icon_url", flatAmenityIcon.getIconUrl());
			query.setParameter("id", flatAmenityIcon.getId());
			query.executeUpdate();
		}
		session.getTransaction().commit();
		session.close();
	}
	
	public ResponseMessage update(BuilderFlatAmenity builderFlatAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderFlatAmenity where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderFlatAmenity.getName());
		query.setParameter("id", builderFlatAmenity.getId());
		List<BuilderFlatAmenity> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Flat amenity name already exists");
		} else {
			String hql1 = "from BuilderFlatAmenity where id = :id";
			Session session1 = hibernateUtil.openSession();
			Query query1 = session1.createQuery(hql1);
			query1.setParameter("id", builderFlatAmenity.getId());
			List<BuilderFlatAmenity> result1 = query1.list();
			session1.close();
			BuilderFlatAmenity newBuilderFlatAmenity = new BuilderFlatAmenity();
			newBuilderFlatAmenity = result1.get(0);
			newBuilderFlatAmenity.setName(builderFlatAmenity.getName());
			newBuilderFlatAmenity.setStatus(builderFlatAmenity.getStatus());
			if(builderFlatAmenity.getIconUrl().length() > 0) {
				newBuilderFlatAmenity.setIconUrl(builderFlatAmenity.getIconUrl());
			}
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(newBuilderFlatAmenity);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Flat amenity updated Successfully");
		}
		return response;
	}

	public ResponseMessage delete(BuilderFlatAmenity builderFlatAmenity) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from BuilderFlatAmenity where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", builderFlatAmenity.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Flat amenity deleted successfuuly");

		return response;
	}

	public List<BuilderFlatAmenity> getBuilderFlatAmenityList() {
		String hql = "from BuilderFlatAmenity";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFlatAmenity> result = query.list();
		
		session.close();
		return result;
	}
	
	public List<BuilderFlatAmenity> getBuilderActiveFlatAmenityList() {
		String hql = "from BuilderFlatAmenity where status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFlatAmenity> result = query.list();
		
		session.close();
		return result;
	}

	public List<BuilderFlatAmenity> getBuilderFlatAmenityById(int id) {
		String hql = "from BuilderFlatAmenity where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderFlatAmenity> result = query.list();
		session.close();
		return result;
	}

}
