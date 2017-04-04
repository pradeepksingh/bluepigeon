package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Tax;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class TaxDAO {
	public ResponseMessage save(Tax tax) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (tax.getPincode() == null || tax.getPincode().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter pincode");
		} else {
			String hql = "from Tax where pincode = :pincode";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("pincode", tax.getPincode());
			List<Tax> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Pincode already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(tax);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Pincode Added Successfully");
			}
		}
		return response;
	}

	public ResponseMessage update(Tax tax) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from Tax where pincode = :pincode and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("pincode", tax.getPincode());
		query.setParameter("id", tax.getId());
		// System.out.println("Country status ::"+country.getStatus());
		// query.setParameter("status", country.getStatus());
		List<Tax> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Pincode already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(tax);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Updated Successfully");
		}
		return response;
	}

//	public ResponseMessage delete(Tax tax) {
//		ResponseMessage response = new ResponseMessage();
//		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
//		String hql = "delete from Tax where id = :id";
//		Session session = hibernateUtil.openSession();
//		session.beginTransaction();
//		Query query = session.createQuery(hql);
//		query.setParameter("id", country.getId());
//		query.executeUpdate();
//		session.getTransaction().commit();
//		session.close();
//		response.setStatus(1);
//		response.setMessage("Success");
//
//		return response;
//	}

	public List<Tax> getTaxList() {
		String hql = "from Tax";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Tax> result = query.list();
		session.close();
		return result;
	}

	public List<Tax> getTaxById(int id) {
		String hql = "from Tax where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Tax> result = query.list();
		session.close();
		return result;
	}

}
