package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.data.LocalityData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.Locality;
import org.bluepigeon.admin.util.HibernateUtil;

public class LocalityNamesImp {
	
	/**
	 * Save Locality
	 * 
	 * @param locality
	 * @return String
	 */
	public ResponseMessage save(Locality locality){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (locality.getName() == null || locality.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter locality name");
		} else {
			String hql = "from Locality where name = :name and city.id = :city_id";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", locality.getName());
			query.setParameter("city_id", locality.getCity().getId());
			List<Locality> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Locality name already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(locality);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Successfully added location.");
			}
		}
		return response;
	}
	
	public ResponseMessage update(Locality locality){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from Locality where name = :name and city.id = :city_id and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", locality.getName());
		query.setParameter("city_id", locality.getCity().getId());
		query.setParameter("id", locality.getId());
		List<Locality> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("Locality name already exists");
		} else {
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(locality);
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Successfully updated location.");
		}
		return response;
	}

	public List<Locality> getLocalityNames(int cityId)
	{
		String hql = "from Locality where city.id = :city_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("city_id", cityId);
		List<Locality> result = query.list();
		List<Locality> localities = new ArrayList<Locality>();
		for(int i=0; i<result.size(); i++){
			Locality locality = new Locality();
			locality.setId(result.get(i).getId());
			locality.setName(result.get(i).getName());
			locality.setStatus(result.get(i).getStatus());
			locality.setSortOrder(result.get(i).getSortOrder());
			localities.add(locality);
		}
		session.close();
		return localities;
	}
	
	public List<Locality> getLocalityByCity(int cityId)
	{
		String hql = "from Locality where city.id = :city_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("city_id", cityId);
		List<Locality> result = query.list();
		session.close();
		return result;
	}
	
	public List<Locality> getLocalityDetailById(int id){
		String hql = "from Locality where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Locality> result = query.list();
		session.close();
		List<Locality> localities = new ArrayList<Locality>();
		Locality locality = new Locality();
		for(int i=0; i<result.size(); i++){
			City city = new City();
			city.setId(result.get(i).getCity().getId());
			city.setName(result.get(i).getCity().getName());
			locality.setId(result.get(i).getId());
			locality.setName(result.get(i).getName());
			locality.setCity(city);
			locality.setSortOrder(result.get(i).getSortOrder());
			locality.setLastUpdatedBy(result.get(i).getLastUpdatedBy());
			locality.setLastUpdatedOn(result.get(i).getLastUpdatedOn());
			locality.setStatus(result.get(i).getStatus());
			if(result.get(i).getLatitude() != null)
				locality.setLatitude(result.get(i).getLatitude());
			else
				locality.setLatitude("");
			if(result.get(i).getLongitude() != null)
				locality.setLongitude(result.get(i).getLongitude());
			else
				locality.setLongitude("");
			localities.add(locality);
		}
		
		return localities;
	}
	
	public List<Locality> getLocalityById(int id){
		String hql = "from Locality where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Locality> result = query.list();
		session.close();
		return result;
	}
	
	public List<LocalityData> getLocalityName(int cityId)
	{
		String hql = "from Locality where city.id = :city_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("city_id", cityId);
		List<Locality> result = query.list();
		List<LocalityData> localities = new ArrayList<LocalityData>();
		for(int i=0; i<result.size(); i++){
			LocalityData locality = new LocalityData();
			locality.setId(result.get(i).getId());
			locality.setName(result.get(i).getName());
			localities.add(locality);
		}
		session.close();
		return localities;
	}
}
