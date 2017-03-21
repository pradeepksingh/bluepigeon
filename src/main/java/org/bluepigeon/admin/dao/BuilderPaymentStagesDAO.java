package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderPaymentStages;
import org.bluepigeon.admin.util.HibernateUtil;

public class BuilderPaymentStagesDAO {

	public ResponseMessage save(BuilderPaymentStages builderPaymentStages) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (builderPaymentStages.getName() == null || builderPaymentStages.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter flat amenity name");
		} else {
			String hql = "from BuilderPaymentStages where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", builderPaymentStages.getName());
			List<BuilderPaymentStages> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Payment Stages name already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(builderPaymentStages);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Payment Stages added Successfully");
			}
		}
		return response;
	}

	public ResponseMessage update(BuilderPaymentStages builderPaymentStages) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from BuilderPaymentStages where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", builderPaymentStages.getName());
		query.setParameter("id", builderPaymentStages.getId());
		List<BuilderPaymentStages> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Payment Stages name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(builderPaymentStages);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Payment Stages updated Successfully");
		}
		return response;
	}

	public ResponseMessage delete(BuilderPaymentStages builderFlatAmenity) {
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
		response.setMessage("Payment Stages deleted successfuuly");

		return response;
	}

	public List<BuilderPaymentStages> getBuilderPaymentStagesList() {
		String hql = "from BuilderPaymentStages";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderPaymentStages> result = query.list();
		
		session.close();
		return result;
	}

	public List<BuilderPaymentStages> getBuilderPaymentStagesById(int id) {
		String hql = "from BuilderPaymentStages where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<BuilderPaymentStages> result = query.list();
		session.close();
		return result;
	}

}
