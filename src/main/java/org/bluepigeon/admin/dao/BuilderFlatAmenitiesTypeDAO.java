//package org.bluepigeon.admin.dao;
//
//import java.util.List;
//
//import org.bluepigeon.admin.exception.ResponseMessage;
//import org.bluepigeon.admin.model.BuilderFlatAmenitiesStagesAndSubStages;
//import org.bluepigeon.admin.model.BuilderFlatAmenitiesType;
//import org.bluepigeon.admin.util.HibernateUtil;
//import org.hibernate.Query;
//import org.hibernate.Session;
//
//public class BuilderFlatAmenitiesTypeDAO {
//	public ResponseMessage save(BuilderFlatAmenitiesType buildingAmeneties) {
//		ResponseMessage response = new ResponseMessage();
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		if (buildingAmeneties.getName() == null || buildingAmeneties.getName().trim().length() == 0) {
//			response.setStatus(0);
//			response.setMessage("Please enter flat amenities type name");
//		} else {
//			String hql = "from BuilderFlatAmenitiesType where name = :name";
//			Session session = hibernateUtil.openSession();
//			Query query = session.createQuery(hql);
//			query.setParameter("name", buildingAmeneties.getName());
//			List<BuilderFlatAmenitiesStagesAndSubStages> result = query.list();
//			session.close();
//			if (result.size() > 0) {
//				response.setStatus(0);
//				response.setMessage("Flat amenities type name already exists");
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
//	public ResponseMessage update(BuilderFlatAmenitiesType buildingAmeneties) {
//		ResponseMessage response = new ResponseMessage();
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		String hql = "from BuilderFlatAmenitiesType where name = :name and id != :id";
//		Session session = hibernateUtil.openSession();
//		Query query = session.createQuery(hql);
//		query.setParameter("name", buildingAmeneties.getName());
//		query.setParameter("id", buildingAmeneties.getId());
//		
//		List<BuilderFlatAmenitiesType> result = query.list();
//		session.close();
//		if (result.size() > 0) {
//			response.setStatus(0);
//			response.setMessage("Flat amenities type already exists");
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
//	public ResponseMessage delete(BuilderFlatAmenitiesType buildingAmeneties) {
//		ResponseMessage response = new ResponseMessage();
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		String hql = "delete from BuilderFlatAmenitiesType where id = :id";
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
//	public List<BuilderFlatAmenitiesType> getBuilderCompany() {
//		String hql = "from BuilderFlatAmenitiesType";
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		Session session = hibernateUtil.openSession();
//		Query query = session.createQuery(hql);
//		List<BuilderFlatAmenitiesType> result = query.list();
//		session.close();
//		return result;
//	}
//
//	public List<BuilderFlatAmenitiesType> getCountryById(int id) {
//		String hql = "from BuilderBuildingStatus where id = :id";
//		HibernateUtil hibernateUtil = new HibernateUtil();
//		Session session = hibernateUtil.openSession();
//		Query query = session.createQuery(hql);
//		query.setParameter("id", id);
//		List<BuilderFlatAmenitiesType> result = query.list();
//		session.close();
//		return result;
//	}
//
//}
