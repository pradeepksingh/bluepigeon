package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.bluepigeon.admin.data.CityData;
import org.bluepigeon.admin.data.NameList;//to get list of cities;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.util.HibernateUtil;

public class CityNamesImp {
	/**
	 * Save City
	 * 
	 * @param city
	 * @return String
	 */
	public ResponseMessage save(City city){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (city.getName() == null || city.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter city name");
		} else {
			String hql = "from City where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", city.getName());
			List<City> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("City name already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(city);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("City Added Successfully");
			}
		}
		return response;
	}
	
	public ResponseMessage update(City city){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "from City where name = :name and state.id = :stateId and id != :id";
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("name", city.getName());
		query.setParameter("id", city.getId());
		query.setParameter("stateId", city.getState().getId());
		List<City> result = query.list();
		session.close();
		if (result.size() > 0) {
			response.setStatus(0);
			response.setMessage("City name already exists");
		} else {
	        Session newsession = hibernateUtil.openSession();
	        newsession.beginTransaction();
	        newsession.update(city);
	        newsession.getTransaction().commit();
	        newsession.close();
	        response.setStatus(1);
			response.setMessage("City Updated Successfuuly");
		}
        return response;
	}
	
	/**
	 * Get All Cities
	 * @author pradeep
	 * @return List<City>
	 */
	public List<City> getCityNames()
	{
		String hql = "from City";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<City> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all active city
	 * @author pankaj
	 * @return list<City>
	 */
	public List<City> getCityActiveNames()
	{
		String hql = "from City where status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<City> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get cities by tehsil ID
	 * @author pradeep
	 * @param int tehsilId
	 * @return List<City>
	 */
	public List<City> getCityNamesByStateId(int stateId)
	{
		String hql = "from City where state.id = :stateId";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("stateId", stateId);
		List<City> result = query.list();
		session.close();
		return result;
	}
	
	public List<City> getActiveCityNamesByStateId(int stateId)
	{
		String hql = "from City where state.id = :stateId and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("stateId", stateId);
		List<City> result = query.list();
		session.close();
		return result;
	}
	
	public List<City> getCityById(int id)
	{
		String hql = "from City where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<City> result = query.list();
		session.close();
		return result;
	}
	
	public List<NameList> getCityList()
	{
		String hql = "SELECT c.id as id, c.name as name FROM City c";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql).setResultTransformer(Transformers.aliasToBean(NameList.class));
		List<NameList> result = query.list();
		session.close();
		return result;
	}
	public List<CityData> getCityByStateId(int stateId){
		String hql = "from City where state.id = :state_id and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("state_id", stateId);
		List<City> result = query.list();
		session.close();
		List<CityData> cityDataList = new ArrayList<CityData>();
		if(result.size()>0){
			for(int i=0;i<result.size();i++){
				CityData cityData = new CityData();
				cityData.setId(result.get(i).getId());
				cityData.setName(result.get(i).getName());
				cityDataList.add(cityData);
			}
		}
		return cityDataList;
	}
}
