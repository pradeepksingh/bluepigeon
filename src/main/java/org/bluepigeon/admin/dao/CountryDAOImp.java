package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.bluepigeon.admin.data.BuildingPojo;
import org.bluepigeon.admin.data.TaxLabels;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.State;
import org.bluepigeon.admin.util.HibernateUtil;

public class CountryDAOImp {

	public ResponseMessage save(Country country) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (country.getName() == null || country.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter country name");
		} else {
			String hql = "from Country where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", country.getName());
			List<Country> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Country name already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(country);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Success");
			}
		}
		return response;
	}

	public ResponseMessage update(Country country) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from Country where name = :name and id != :id";
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
	}

	public ResponseMessage delete(Country country) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from Country where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", country.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Success");

		return response;
	}

	public List<Country> getCountryList() {
		String hql = "from Country";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Country> result = query.list();
		session.close();
		return result;
	}
	
	public List<Country> getActiveCountryList() {
		String hql = "from Country where status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<Country> result = query.list();
		session.close();
		return result;
	}

	public List<Country> getCountryById(int id) {
		String hql = "from Country where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Country> result = query.list();
		session.close();
		return result;
	}
	public TaxLabels getTaxLabels(int countryId){
		String hql = "select c.tax_label_1 as taxLabel1, c.tax_label_2 as taxLabel2,c.tax_label_3 as taxLabel3 from country as c where c.id = "+countryId+" and c.status = 1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(TaxLabels.class));
		TaxLabels result = (TaxLabels)query.list().get(0);
		session.close();
		return result;
	}
}
