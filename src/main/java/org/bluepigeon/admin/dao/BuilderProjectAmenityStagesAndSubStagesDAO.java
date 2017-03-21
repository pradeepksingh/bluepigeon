//package org.bluepigeon.admin.dao;
//
//import java.util.List;
//
//import org.bluepigeon.admin.exception.ResponseMessage;
//import org.bluepigeon.admin.model.BuilderPaymentStagesAndSubStages;
//import org.bluepigeon.admin.model.BuilderProjectAmenityStagesAndSubStages;
//import org.bluepigeon.admin.util.HibernateUtil;
//import org.hibernate.Query;
//import org.hibernate.Session;
//
//public class BuilderProjectAmenityStagesAndSubStagesDAO {
//	public ResponseMessage save(BuilderProjectAmenityStagesAndSubStages buildingAmeneties) {
//		ResponseMessage response = new ResponseMessage();
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		if (buildingAmeneties.getName() == null || buildingAmeneties.getName().trim().length() == 0) {
//			response.setStatus(0);
//			response.setMessage("Please enter project amenities stages/sub stages");
//		} else {
//			String hql = "from BuilderProjectAmenityStagesAndSubStages where name = :name";
//			Session session = hibernateUtil.openSession();
//			Query query = session.createQuery(hql);
//			query.setParameter("name", buildingAmeneties.getName());
//			List<BuilderProjectAmenityStagesAndSubStages> result = query.list();
//			session.close();
//			if (result.size() > 0) {
//				response.setStatus(0);
//				response.setMessage("Prject amenities stages/sub stages already exists");
//			} else { 
//				Session newsession = hibernateUtil.openSession();
//				newsession.beginTransaction();
//				newsession.save(buildingAmeneties);
//				newsession.getTransaction().commit();
//				newsession.close();
//				response.setStatus(1);
//				response.setMessage("Success");
//			}
//		}
//		return response;
//	}
//
//	public ResponseMessage update(BuilderProjectAmenityStagesAndSubStages buildingAmeneties) {
//		ResponseMessage response = new ResponseMessage();
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		String hql = "from BuilderProjectAmenityStagesAndSubStages where name = :name and id != :id";
//		Session session = hibernateUtil.openSession();
//		Query query = session.createQuery(hql);
//		query.setParameter("name", buildingAmeneties.getName());
//		query.setParameter("id", buildingAmeneties.getId());
//		
//		List<BuilderProjectAmenityStagesAndSubStages> result = query.list();
//		session.close();
//		if (result.size() > 0) {
//			response.setStatus(0);
//			response.setMessage("Project amenity stage/sub stage already exists");
//		} else {
//			Session newsession = hibernateUtil.openSession();
//			newsession.beginTransaction();
//			newsession.update(buildingAmeneties);
//			newsession.getTransaction().commit();
//			newsession.close();
//			response.setStatus(1);
//			response.setMessage("Success");
//		}
//		return response;
//	}
//
//	public ResponseMessage delete(BuilderPaymentStagesAndSubStages buildingAmeneties) {
//		ResponseMessage response = new ResponseMessage();
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		String hql = "delete from BuilderPaymentStagesAndSubStages where id = :id";
//		Session session = hibernateUtil.openSession();
//		session.beginTransaction();
//		Query query = session.createQuery(hql);
//		query.setParameter("id", buildingAmeneties.getId());
//		query.executeUpdate();
//		session.getTransaction().commit();
//		session.close();
//		response.setStatus(1);
//		response.setMessage("Success");
//
//		return response;
//	}
//
//	public List<BuilderProjectAmenityStagesAndSubStages> getBuilderCompany() {
//		String hql = "from BuilderPaymentStagesAndSubStages";
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		Session session = hibernateUtil.openSession();
//		Query query = session.createQuery(hql);
//		List<BuilderProjectAmenityStagesAndSubStages> result = query.list();
//		session.close();
//		return result;
//	}
//
//	public List<BuilderProjectAmenityStagesAndSubStages> getCountryById(int id) {
//		String hql = "from BuilderPaymentStagesAndSubStages where id = :id";
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		Session session = hibernateUtil.openSession();
//		Query query = session.createQuery(hql);
//		query.setParameter("id", id);
//		List<BuilderProjectAmenityStagesAndSubStages> result = query.list();
//		session.close();
//		return result;
//	}
//
//}
