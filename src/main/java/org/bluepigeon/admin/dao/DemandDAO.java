package org.bluepigeon.admin.dao;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Cancellation;
import org.bluepigeon.admin.model.DemandLetters;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class DemandDAO {
	
	public ResponseMessage save(DemandLetters demandLetters){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.save(demandLetters);
		session.getTransaction().commit();
		session.close();
		responseMessage.setId(demandLetters.getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Demand Letter Added succefully");
		return responseMessage;
	}

	
}
