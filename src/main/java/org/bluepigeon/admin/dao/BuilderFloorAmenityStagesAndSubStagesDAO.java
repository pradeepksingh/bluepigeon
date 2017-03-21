//package org.bluepigeon.admin.dao;
//
//import java.util.List;
//
//import org.bluepigeon.admin.exception.ResponseMessage;
//import org.bluepigeon.admin.model.BuilderFlatStatus;
//import org.bluepigeon.admin.model.BuilderFloorAmenitiesType;
//import org.bluepigeon.admin.model.BuilderFloorAmenityStagesAndSubStages;
//import org.bluepigeon.admin.util.HibernateUtil;
//import org.hibernate.Query;
//import org.hibernate.Session;
//
//public class BuilderFloorAmenityStagesAndSubStagesDAO {
//	public ResponseMessage save(BuilderFloorAmenityStagesAndSubStages buildingAmeneties) {
//		ResponseMessage response = new ResponseMessage();
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		if (buildingAmeneties.getName() == null || buildingAmeneties.getName().trim().length() == 0) {
//			response.setStatus(0);
//			response.setMessage("Please enter floor amenitity stages/sub stages");
//		} else {
//			String hql = "from BuilderFloorAmenityStagesAndSubStages where name = :name";
//			Session session = hibernateUtil.openSession();
//			Query query = session.createQuery(hql);
//			query.setParameter("name", buildingAmeneties.getName());
//			List<BuilderFloorAmenityStagesAndSubStages> result = query.list();
//			session.close();
//			if (result.size() > 0) {
//				response.setStatus(0);
//				response.setMessage("Floor amenitity stages/substages already exists");
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
//	public ResponseMessage update(BuilderFloorAmenityStagesAndSubStages buildingAmeneties) {
//		ResponseMessage response = new ResponseMessage();
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		String hql = "from BuilderFloorAmenityStagesAndSubStages where name = :name and id != :id";
//		Session session = hibernateUtil.openSession();
//		Query query = session.createQuery(hql);
//		query.setParameter("name", buildingAmeneties.getName());
//		query.setParameter("id", buildingAmeneties.getId());
//		
//		List<BuilderFloorAmenityStagesAndSubStages> result = query.list();
//		session.close();
//		if (result.size() > 0) {
//			response.setStatus(0);
//			response.setMessage("floor amenitity stges/sub stages already exists");
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
//	public ResponseMessage delete(BuilderFloorAmenityStagesAndSubStages buildingAmeneties) {
//		ResponseMessage response = new ResponseMessage();
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		String hql = "delete from BuilderFloorAmenityStagesAndSubStages where id = :id";
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
//	public List<BuilderFloorAmenityStagesAndSubStages> getBuilderCompany() {
//		String hql = "from BuilderFloorAmenityStagesAndSubStages";
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		Session session = hibernateUtil.openSession();
//		Query query = session.createQuery(hql);
//		List<BuilderFloorAmenityStagesAndSubStages> result = query.list();
//		session.close();
//		return result;
//	}
//
//	public List<BuilderFloorAmenityStagesAndSubStages> getCountryById(int id) {
//		String hql = "from BuilderFloorAmenityStagesAndSubStages where id = :id";
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		Session session = hibernateUtil.openSession();
//		Query query = session.createQuery(hql);
//		query.setParameter("id", id);
//		List<BuilderFloorAmenityStagesAndSubStages> result = query.list();
//		session.close();
//		return result;
//	}
//
//}
