package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.data.NameDetailList;
import org.bluepigeon.admin.data.NameDetails;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;

public class NameDetailsDAO {
	public List<NameDetailList> getFloorDetials(int buildingId){
		String hql = "select a.title as title,ROUND(a.completion,2) as completion, c.name as name from floor_image_gallery as a join builder_floor as b on b.id=a.floor_id join builder_building as c on c.id = b.building_id where c.id="+buildingId+" and c.status=1 and b.status=1 GROUP by a.id order by a.id desc";
		HibernateUtil hibernateUtil = new HibernateUtil(); 
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameDetailList.class));
		List<NameDetailList> result = query.list();
		session.close();
		return result;
	}
	
	public NameDetails getBuildingDetails(int buildingId){
		NameDetails nameDetails = new NameDetails();
		String hql = "select a.image as image, ROUND(a.completion,2) as percentage from building_image_gallery as a join builder_building as b on b.id=a.building_id where b.id="+buildingId+" GROUP by a.id order by a.id DESC LIMIT 1";
		HibernateUtil hibernateUtil = new HibernateUtil(); 
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameDetails.class));
		try{
			NameDetails result = (NameDetails)query.list().get(0);
			session.close();
			if(result != null ){
				nameDetails.setImage(result.getImage());
				nameDetails.setPercentage(result.getPercentage());
				List<NameDetailList> nameDetailLists =  getFloorDetials(buildingId);
				nameDetails.setList(nameDetailLists);
			}
			return nameDetails;
		}catch(Exception e){
			e.printStackTrace();
			return nameDetails;
		}
	}
	
	public List<NameDetailList> getFlatDetailsByFloorId(int floorId){
		String hql = "select a.title as title,  ROUND(a.completion,2) as completion, c.name as name from flat_image_gallery as a join builder_flat as b on b.id=a.flat_id join builder_floor as c on c.id=b.floor_no where c.id="+floorId+" and c.status=1 and b.status=1 GROUP by a.id ORDER by a.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil(); 
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameDetailList.class));
		List<NameDetailList> result = query.list();
		session.close();
		return result;
	}
	
	public NameDetails getFloorDetails(int floorId){
		NameDetails nameDetails = new NameDetails();
		String hql = "select a.image as image, ROUND(a.completion,2) as percentage from floor_image_gallery as a join builder_floor as b on b.id=a.floor_id where b.id="+floorId+" GROUP by a.id order by a.id DESC LIMIT 1";
		HibernateUtil hibernateUtil = new HibernateUtil(); 
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameDetails.class));
		try{
			NameDetails result = (NameDetails)query.list().get(0);
			session.close();
			if(result != null ){
				nameDetails.setImage(result.getImage());
				nameDetails.setPercentage(result.getPercentage());
				List<NameDetailList> nameDetailLists =  getFlatDetailsByFloorId(floorId);
				nameDetails.setList(nameDetailLists);
			}
			return nameDetails;
		}catch(Exception e){
			e.printStackTrace();
			return nameDetails;
		}
	}
	
	public List<NameDetailList> getFlatDetailsByFlatId(int flatId){
		String hql = "select a.title as title, ROUND(a.completion,2) as completion, b.flat_no as name from flat_image_gallery as a join builder_flat as b on b.id=a.flat_id where b.id="+flatId+" GROUP by a.id order by a.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil(); 
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameDetailList.class));
		List<NameDetailList> result = query.list();
		session.close();
		return result;
	}
	
	public NameDetails getFlatDetails(int flatId){
		NameDetails nameDetails = new NameDetails();
		String hql = "select a.image as image, ROUND(a.completion,2) as percentage from flat_image_gallery as a join builder_flat as b on b.id=a.flat_id where b.id="+flatId+" GROUP by a.id order by a.id DESC LIMIT 1";
		HibernateUtil hibernateUtil = new HibernateUtil(); 
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(NameDetails.class));
		try{
			NameDetails result = (NameDetails)query.list().get(0);
			session.close();
			if(result != null ){
				nameDetails.setImage(result.getImage());
				nameDetails.setPercentage(result.getPercentage());
				List<NameDetailList> nameDetailLists =  getFlatDetailsByFlatId(flatId);
				nameDetails.setList(nameDetailLists);
			}
			return nameDetails;
		}catch(Exception e){
			e.printStackTrace();
			return nameDetails;
		}
	}
}
