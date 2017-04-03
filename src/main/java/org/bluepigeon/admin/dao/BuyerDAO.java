package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.BuyerDocuments;
import org.bluepigeon.admin.model.BuyerOffer;
import org.bluepigeon.admin.model.BuyerPayment;
import org.bluepigeon.admin.model.BuyerUploadDocuments;
import org.bluepigeon.admin.model.BuyingDetails;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuyerDAO {
	
	public ResponseMessage saveBuyer(Buyer buyer){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if (buyer.getName() == null || buyer.getName().trim().length() == 0) {
			response.setStatus(0);
			response.setMessage("Please enter tax type");
		} else {
			String hql = "from Buyer where name = :name";
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("name", buyer.getName());
			List<Buyer> result = query.list();
			session.close();
			if (result.size() > 0) {
				response.setStatus(0);
				response.setMessage("Buyer name already exists");
			} else {
				Session newsession = hibernateUtil.openSession();
				newsession.beginTransaction();
				newsession.save(buyer);
				newsession.getTransaction().commit();
				newsession.close();
				response.setStatus(1);
				response.setMessage("Success");
			}
		}
		return response;
	}
	
	public ResponseMessage saveBuyerDocuments(List<BuyerDocuments> buyerDocuments){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(buyerDocuments.size()>0){
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			for(int i=0;i<buyerDocuments.size();i++){
				newsession.save(buyerDocuments.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Success");
		}
		return response;
	}
	public ResponseMessage saveBuyingDetails(BuyingDetails buyingDetails){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session newsession = hibernateUtil.openSession();
		newsession.beginTransaction();
		newsession.save(buyingDetails);
		newsession.getTransaction().commit();
		newsession.close();
		response.setStatus(1);
		response.setMessage("Success");
		return response;
	}
	
	public ResponseMessage saveBuyerOffers(List<BuyerOffer> buyerOffer){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(buyerOffer.size()>0){
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			for(int i=0;i<buyerOffer.size();i++){
				newsession.save(buyerOffer.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Success");
		}
		return response;
	}
	public ResponseMessage saveBuyerPayment(List<BuyerPayment> buyerPayments){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(buyerPayments.size()>0){
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			for(int i=0;i<buyerPayments.size();i++){
				newsession.save(buyerPayments.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Success");
		}
		return response;
		
	}
	
	public ResponseMessage saveBuyerUploadDouments(List<BuyerUploadDocuments> buyerUploadDocuments){
		ResponseMessage response = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(buyerUploadDocuments.size()>0){
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			for(int i=0;i<buyerUploadDocuments.size();i++){
				newsession.save(buyerUploadDocuments.get(i));
			}
			newsession.getTransaction().commit();
			newsession.close();
			response.setStatus(1);
			response.setMessage("Success");
		}
		return response;
		}

	public List<Buyer> getBuyerById(int id){
		String hql = "from Buyer where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Buyer> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuyerDocuments> getBuyerDocumentsByBuyerId(int buyerId){
		String hql = "from BuyerDocuments where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyerDocuments> result = query.list();
		session.close();
		return result;
	}
	
	public BuyingDetails getBuyingDetailsByBuyerId(int buyerId){
		String hql = "from BuyingDetails where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyingDetails> result = query.list();
		session.close();
		return result.get(0);
	}
	
	public List<BuyerOffer> getBuyerOffersByBuyerId(int buyerId){
		String hql = "from BuyerOffer where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyerOffer> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuyerPayment> getBuyerPaymentsByBuyerId(int buyerId){
		String hql = "from BuyerPayment where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyerPayment> result = query.list();
		session.close();
		return result;
	}
	
	public List<BuyerUploadDocuments> getBuyerUploadDocumentsByBuyerId(int buyerId){
		String hql = "from BuyerUploadDocuments where buyer.id = :buyer_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("buyer_id", buyerId);
		List<BuyerUploadDocuments> result = query.list();
		session.close();
		return result;
	}
}
