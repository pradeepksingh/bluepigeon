package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.PropertyManagerList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.AdminUserRole;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.PropertyManager;
import org.bluepigeon.admin.model.PropertyManagerPhotos;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class PropertyManagerDAO {

	/**
	 * Save Property Manager
	 * @author pankaj
	 * @param propertyManager
	 * @return message
	 */
	public ResponseMessage save(PropertyManager propertyManager){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(propertyManager);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setId(propertyManager.getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Property Manager Added Successfully.");
		return responseMessage;
	}
	/**
	 * Save manager photo
	 * @author pankaj
	 * @param propertyManagerPhotos
	 * @return
	 */
	public ResponseMessage saveManagerPhoto(PropertyManagerPhotos propertyManagerPhotos){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(propertyManagerPhotos);
		newsession.getTransaction().commit();
		newsession.close();
		responseMessage.setId(propertyManagerPhotos.getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Property Manager Photo Added Successfully.");
		return responseMessage;
	}
	/**
	 * Get all User names
	 * @author pankaj
	 * @return list of name
	 */
	public List<AdminUser> getAminUserList(){
		String hql = "from AdminUser";
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		Query query=newsession.createQuery(hql);
		List<AdminUser> result = query.list();
		newsession.close();
		return result;
	}
	/**
	 * Get Admin user by id
	 * @author pankaj
	 * @param id
	 * @return admin user object
	 */
	public AdminUser getAdminUserById(int id){
		String hql = "from AdminUser where id=:id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		AdminUser adminUser = (AdminUser)query.list().get(0);
		session.close();
		return adminUser;
	}
	/**
	 * Get All city name
	 * @author pankaj
	 * @return list of city names
	 */
	public List<City> getCityList(){
		String hql = "from City";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<City> cityList= query.list();
		session.close();
		return cityList;
	}
	/**
	 * Get all role names
	 * @author pankaj
	 * @return list of access role name
	 */
	public List<AdminUserRole> getAdminUserRoles(){
		String hql = "from AdminUserRole";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<AdminUserRole> result = query.list();
		session.close();
		return result;
	}
	/**
	 * Get all bp employee role 
	 * @return list of property
	 */
	public List<PropertyManagerList> getProperyManagers(){
		String hql = "from PropertyManager";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<PropertyManager> result = query.list();
		List<PropertyManagerList> managerList = new ArrayList<PropertyManagerList>();
		for(PropertyManager propertyManager : result){
			PropertyManagerList propertyManagerList = new PropertyManagerList();
			propertyManagerList.setId(propertyManager.getId());
			propertyManagerList.setName(propertyManager.getAdminUser().getName());
			propertyManagerList.setContact(propertyManager.getAdminUser().getMobile());
			propertyManagerList.setEmail(propertyManager.getAdminUser().getEmail());
			propertyManagerList.setRoleName(propertyManager.getAdminUserRole().getRoleName());
			managerList.add(propertyManagerList);
		}
		session.close();
		return managerList;
	}
}
