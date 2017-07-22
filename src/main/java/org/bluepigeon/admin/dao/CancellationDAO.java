package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.CancellationList;
import org.bluepigeon.admin.data.LeadList;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.Cancellation;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;

public class CancellationDAO {
	
	public ResponseMessage save(Cancellation cancellation, BuilderEmployee builderEmployee){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		session.save(cancellation);
		session.getTransaction().commit();
		session.close();
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 7)
			updateBuyerStatus(cancellation.getBuilderFlat().getId());
		if(builderEmployee.getBuilderEmployeeAccessType().getId() == 1 ||
		   builderEmployee.getBuilderEmployeeAccessType().getId() ==2 ||
		   builderEmployee.getBuilderEmployeeAccessType().getId()==4||
		   builderEmployee.getBuilderEmployeeAccessType().getId()==5||
		   builderEmployee.getBuilderEmployeeAccessType().getId()==6){
			updateFlatStatus(cancellation.getBuilderFlat().getId());
			updatePrimaryBuyer(cancellation.getBuilderFlat().getId());
		}
		responseMessage.setId(cancellation.getId());
		responseMessage.setStatus(1);
		return responseMessage;
	}
	public void updateBuyerStatus(int flatId){
		String hql = "UPDATE Buyer set status=1 where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		
				
	}
	public void updateFlatStatus(int flatId){
		System.out.println("FlatId :: "+flatId);
		String hql = "UPDATE BuilderFlat set builderFlatStatus.id = 1 WHERE id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id",flatId);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
	public void updatePrimaryBuyer(int flatId){
		String hql ="UPDATE Buyer set is_deleted=1 where builderFlat.id = :flat_id ";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		
	}
	public Buyer getPrimaryBuyerByFlatId(int flatId){
		String hql = "from Buyer where builderFlat.id = :flat_id and is_primary=1";
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
		b2.setIsPrimary(buyer.getIsPrimary());
		session.close();
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
			//bList.setCount(i);
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
			//bList.setCount(i);
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
	
	public List<CancellationList> getCancellationByBuilderEmployee(BuilderEmployee builderEmployee){
		
		String hql = "";
		if(builderEmployee.getBuilderEmployeeAccessType().getId() <= 2) {
			hql = "SELECT cancel.buyer_name as buyerName, cancel.cancel_status as status, cancel.is_approved as isApproved,  project.name as projectName, building.name as buildingName, flat.flat_no as flatNo "
				+"FROM  cancellation as cancel left join builder_project as project ON cancel.project_id = project.id left join builder_building as building"
				+ "ON cancel.building_id = building.id left join builder_flat as flat ON cancel.flat_id = flat.id"
				+"left join builder as build ON project.group_id = build.id "
				+"WHERE build.id = "+builderEmployee.getBuilder().getId()+" group by cancel.id";
		} else {
			hql = "SELECT cancel.buyer_name as buyerName, cancel.cancel_status as status,cancel.is_approved as isApproved, project.name as projectName, building.name as buildingName, flat.flat_no as flatNo "
					+"FROM  cancellation as cancel left join builder_project as project ON cancel.project_id = project.id inner join allot_project ap ON project.id = ap.project_id "
					+ "left join builder_building as building"
				+ "ON cancel.building_id = building.id left join builder_flat as flat ON cancel.flat_id = flat.id"
					+"left join builder as build ON project.group_id = build.id "
					+"WHERE ap.emp_id = "+builderEmployee.getId()+" group by cancel.id";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(CancellationList.class));
		System.err.println(hql);
		List<CancellationList> result = query.list();
		session.close();
		return result;
	}
}