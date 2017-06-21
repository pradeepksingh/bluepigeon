package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuilderLoginValidateImp implements BuilderLoginValidateDAO {

	@Override
	public BuilderEmployee getBuilderByEmail(String email) {
		String hql = "from BuilderEmployee a where a.email =  :email1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		
		query.setString("email1", email);
		BuilderEmployee result = (BuilderEmployee)query.list().get(0);
		session.close();
		System.out.println("Email Id DB :: "+result.getEmail());
		return result;
		
	}

	@Override
	public boolean isValidBuilderEmailId(String email) {
		boolean isValid = false;
		String hql = "from BuilderEmployee a where a.email =  :email";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		
		query.setString("email", email);
		List<BuilderEmployee> result = query.list();
		if(result.size()>0)
			isValid = true;
		session.close();
		return isValid;
	}

	@Override
	public boolean isValidBuilderPassword(String password) {
		boolean isValid = false;
		String hql = "from BuilderEmployee a where a.password =  :password";
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
	public int activateBuilderAccount(BuilderEmployee registration)
	{
		byte status= 1;
		String hql="update BuilderEmployee set password = :password, status = :status where id = :id";
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
}
