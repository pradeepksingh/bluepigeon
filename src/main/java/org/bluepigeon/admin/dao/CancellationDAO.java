package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.CancellationList;
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
	public List<CancellationList> getCancellationByBuilderId(int builderId){
		String hql = "from Cancellation where builderProject.builder.id = :builder_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		List<Cancellation> cancellation_list = query.list();
		List<CancellationList> cancellationList = new ArrayList<CancellationList>();
		int i=1;
		for(Cancellation cancellation : cancellation_list){
			CancellationList bList = new CancellationList();
			bList.setCount(i);
			bList.setProjectName(cancellation.getBuilderProject().getName());
			bList.setBuyerName(cancellation.getBuyerName());
			bList.setBuildingName(cancellation.getBuilderBuilding().getName());
			bList.setFlatNo(cancellation.getBuilderFlat().getFlatNo());
			cancellationList.add(bList);
			i++;
		}
		session.close();
		return cancellationList;
	}
	
	public List<CancellationList> getCancellationListFilter(int project_id, int building_id, int flat_id) {
		String hql = "from Cancellation where ";
		String where = "";
		
		if(project_id > 0) {
			where = where + "builderProject.id = :project_id ";
		}
		if(building_id > 0) {
			if(where != "") {
				where = where + "AND builderBuilding.id = :building_id ";
			} else {
				where = where + "builderBuilding.id = :building_id ";
			}
		}
		if(flat_id > 0) {
			if(where != "") {
				where = where + "AND builderFlat.id = :flat_id ";
			} else {
				where = where + "builderFlat.id = :flat_id ";
			}
		}
		hql = hql + where;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		if(project_id > 0) {
			query.setParameter("project_id", project_id);
		}
		if(building_id > 0) {
			query.setParameter("building_id", building_id);
		}
		if(flat_id > 0) {
			query.setParameter("flat_id", flat_id);
		}
		List<Cancellation> result = query.list();
		List<CancellationList> cancellationList = new ArrayList<CancellationList>();
		int i=1;
		for(Cancellation cancellation : result) {
			CancellationList bList = new CancellationList();
			bList.setCount(i);
			bList.setProjectName(cancellation.getBuilderProject().getName());
			bList.setBuyerName(cancellation.getBuyerName());
			bList.setBuildingName(cancellation.getBuilderBuilding().getName());
			bList.setFlatNo(cancellation.getBuilderFlat().getFlatNo());
			cancellationList.add(bList);
			i++;
		}
		session.close();
		return cancellationList;
	}
}
