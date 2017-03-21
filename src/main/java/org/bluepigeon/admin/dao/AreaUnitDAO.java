package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AreaUnit;

import org.bluepigeon.admin.util.HibernateUtil;

public class AreaUnitDAO {

	
	public ResponseMessage save(AreaUnit areaUnit) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (areaUnit.getName() == null || areaUnit.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter area unit");
		} else {
			String hql = "from AreaUnit where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", areaUnit.getName());
			List<AreaUnit> result = query.list();
			session.close();
			if (result.size() > 0) {
				if(result.get(0).getIsDeleted() ==1){
					byte isDeleted=0;
					areaUnit.setId(result.get(0).getId());
					areaUnit.setIsDeleted(isDeleted);
					Session newsession = hibernateUtil.openSession();
					newsession.beginTransaction();
					newsession.update(areaUnit);
					newsession.getTransaction().commit();
					newsession.close();
					response.setStatus(1);
					response.setMessage("Area Unit Added Successfully");
				}else{
				response.setStatus(0);
				response.setMessage("Area Unit name already exists");
				}
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(areaUnit);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Area Unit added Successfully");
			}
		}
		return response;
	}

	public ResponseMessage update(AreaUnit areaUnit) {
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from AreaUnit where name = :name and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", areaUnit.getName());
		query.setParameter("id", areaUnit.getId());
		// System.out.println("Country status ::"+country.getStatus());
		// query.setParameter("status", country.getStatus());
		List<AreaUnit> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Area unit name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(areaUnit);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Area Unit Updated Successfully");
		}
		return response;
	}

	public ResponseMessage delete(AreaUnit areaUnit) {
		/*ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "delete from AreaUnit where id = :id";
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id", areaUnit.getId());
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		response.setStatus(1);
		response.setMessage("Success");*/
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new org.bluepigeon.admin.util.HibernateUtil();
		String hql = "from AreaUnit where id = :id";
		Session session = hibernateUtil.openSession();
		System.out.println("Area Unit Id : "+areaUnit.getId());
		Query query = session.createQuery(hql);
		query.setParameter("id", areaUnit.getId());
		List<AreaUnit> result = query.list();
		session.close();
		if (result.size() > 0) {
			areaUnit.setName(result.get(0).getName());
			areaUnit.setStatus(result.get(0).getStatus());
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(areaUnit);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Area Unit Deleted Successfully");
		} 
		else{
			response.setStatus(0);
			response.setMessage("Area Unit Fail to Delete");
		}
		return response;
	}

	public List<AreaUnit> getAreaUnitList() {
		String hql = "from AreaUnit where isDeleted=0";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<AreaUnit> result = query.list();
		
		session.close();
		return result;
	}

	public List<AreaUnit> getAreaUnitById(int id) {
		String hql = "from AreaUnit where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<AreaUnit> result = query.list();
		session.close();
		return result;
	}
}
