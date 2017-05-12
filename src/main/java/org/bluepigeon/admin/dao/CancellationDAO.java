package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.Cancellation;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class CancellationDAO {
	
	public ResponseMessage save(Cancellation cancellation){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.save(cancellation);
		session.getTransaction().commit();
		session.close();
		updateFlatStatus(cancellation.getBuilderFlat().getId());
		responseMessage.setId(cancellation.getId());
		responseMessage.setStatus(1);
		return responseMessage;
	}

	public void updateFlatStatus(int flatId){
		System.out.println("FlatId :: "+flatId);
		String hql = "UPDATE BuilderFlat set builderFlatStatus.id = 1 WHERE id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setInteger("id",flatId);
		query.executeUpdate();
		session.getTransaction().commit();
		//tx.commit();
		session.close();
	}
	
	public Buyer getPrimaryBuyerByFlatId(int flatId){
		String hql = "from Buyer where builderFlat.id = :flat_id";
		Buyer buyer = new Buyer();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		List<Buyer> buyer_list = query.list();
		for(Buyer buyer2 : buyer_list){
			if(buyer2.getIsPrimary()){
				buyer = buyer2;
				break;
			}
		}
		Buyer b2 = new Buyer();
		b2.setName(buyer.getName());
		b2.setPancard(buyer.getPancard());
		b2.setMobile(buyer.getMobile());
		
		return b2;
	}
}
