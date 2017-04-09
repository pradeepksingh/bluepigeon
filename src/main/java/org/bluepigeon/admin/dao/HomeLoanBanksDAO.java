package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.HomeLoanBanks;

import org.bluepigeon.admin.util.HibernateUtil;

public class HomeLoanBanksDAO {

	
	public ResponseMessage save(HomeLoanBanks homeLoanBanks) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (homeLoanBanks.getName() == null || homeLoanBanks.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter bank name");
		} else {
			String hql = "from HomeLoanBanks where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", homeLoanBanks.getName());
			List<HomeLoanBanks> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Home Loan Bank name already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(homeLoanBanks);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Home loan bank added Successfully");
			}
		}
		return response;
	}

	public ResponseMessage update(HomeLoanBanks homeLoanBanks) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from HomeLoanBanks where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", homeLoanBanks.getName());
		query.setParameter("id", homeLoanBanks.getId());
		List<HomeLoanBanks> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Home loan bank name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(homeLoanBanks);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Home loan bank Updated Successfully");
		}
		return response;
	}

/*	public ResponseMessage update(HomeLoanBanks country) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from HomeLoanBanks where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", country.getName());
		query.setParameter("id", country.getId());
		// System.out.println("Country status ::"+country.getStatus());
		// query.setParameter("status", country.getStatus());
		List<Country> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Country name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(country);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Success");
		}
		return response;
	}*/
	
	public ResponseMessage delete(HomeLoanBanks homeLoanBanks) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from HomeLoanBanks where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", homeLoanBanks.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Success");

		return response;
	}

	public List<HomeLoanBanks> getHomeLoanBanksList() {
		String hql = "from HomeLoanBanks";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<HomeLoanBanks> result = query.list();
		session.close();
		return result;
	}

	public List<HomeLoanBanks> getHomeLoanBanksById(int id) {
		String hql = "from HomeLoanBanks where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<HomeLoanBanks> result = query.list();
		session.close();
		return result;
	}
}
