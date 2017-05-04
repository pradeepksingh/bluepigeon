package org.bluepigeon.admin.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.util.HibernateUtil;


public class LoginValidationImp implements LoginValidateDAO{

	@Override
	public List<AdminUser> getAdminUserByEmail(String email) {
		String hql = "from AdminUser a where a.email =  :email1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		
		query.setString("email1", email);
		List<AdminUser> result = query.list();
		session.close();
		return result;
		
	}

	@Override
	public boolean isValidEmailId(String email) {
		boolean isValid = false;
		String hql = "from AdminUser a where a.email =  :email";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		
		query.setString("email", email);
		List<AdminUser> result = query.list();
		if(result.size()>0)
			isValid = true;
		session.close();
		return isValid;
	}

	@Override
	public boolean isValidPassword(String password) {
		boolean isValid = false;
		String hql = "from AdminUser a where a.password =  :password";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		
		query.setString("password", password);
		List<AdminUser> result = query.list();
		if(result.size()>0)
			isValid = true;
		session.close();
		return isValid;
	}
	public int activateAccount(AdminUser registration)
	{
		byte status= 1;
		String hql="update AdminUser set password = :password, status = :status where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setString("password", registration.getPassword());
		System.out.println("In db : "+registration.getPassword());
		query.setByte("status", status);
		query.setInteger("id", registration.getId());
		int result = query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		
		return result;
	}
	public int activateBuilderAccount(Builder registration)
	{
		byte status= 1;
		String hql="update Builder set password = :password, status = :status where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setString("password", registration.getPassword());
		System.out.println("In db : "+registration.getPassword());
		query.setByte("status", status);
		query.setInteger("id", registration.getId());
		int result = query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		
		return result;
	}
	public List<AdminUser> getSalesExecutive(){
		String hql = "from AdminUser where adminUserRole.id=2";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<AdminUser> result = query.list();
		session.close();
		return result;
	}
	
	public List<AdminUser> getDataCollector(){
		String hql = "from AdminUser where adminUserRole.id=3";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<AdminUser> result = query.list();
		session.close();
		return result;
	}

	/***************************************builder login *********************************/
	@Override
	public Builder getBuilderByEmail(String email) {
		String hql = "from Builder a where a.email =  :email1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		
		query.setString("email1", email);
		Builder result = (Builder)query.list().get(0);
		session.close();
		System.out.println("Email Id DB :: "+result.getEmail());
		return result;
		
	}

	@Override
	public boolean isValidBuilderEmailId(String email) {
		boolean isValid = false;
		String hql = "from Builder a where a.email =  :email";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		
		query.setString("email", email);
		List<Builder> result = query.list();
		if(result.size()>0)
			isValid = true;
		session.close();
		return isValid;
	}

	@Override
	public boolean isValidBuilderPassword(String password) {
		boolean isValid = false;
		String hql = "from Builder a where a.password =  :password";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		
		query.setString("password", password);
		List<Builder> result = query.list();
		if(result.size()>0)
			isValid = true;
		session.close();
		return isValid;
	}
}
