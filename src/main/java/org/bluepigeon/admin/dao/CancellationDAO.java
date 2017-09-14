package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.BookingFlatList;
import org.bluepigeon.admin.data.CancellationList;
import org.bluepigeon.admin.data.LeadList;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.data.BookedBuyerList;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.Cancellation;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;

public class CancellationDAO {
	
	public ResponseMessage save(Cancellation cancellation, BuilderEmployee builderEmployee){
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(cancellation.getReason() == null || cancellation.getReason().trim().length() ==0){
			responseMessage.setStatus(0);
			responseMessage.setMessage("Please enter reason of cancel");
		}if(cancellation.getCharges() == null || cancellation.getCharges() == 0){
			responseMessage.setStatus(0);
			responseMessage.setMessage("Please enter cancellation amount");
		}else{
			String chql = "from Cancellation where builderFlat.id = :flat_id";
			Session presession = hibernateUtil.openSession();
			Query prequery = presession.createQuery(chql);
			prequery.setParameter("flat_id", cancellation.getBuilderFlat().getId());
			List<Cancellation> result = prequery.list();
			presession.close();
			if (result.size() > 0) {
				responseMessage.setStatus(0);
				responseMessage.setMessage("Cancel request is already send");
			}else{
		
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
		}
		}
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
		String hql ="UPDATE Buyer set isDeleted=1, status=1 where builderFlat.id = :flat_id ";
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
			hql = "SELECT cancel.buyer_name as buyerName, cancel.cancel_status as status, cancel.is_approved as isApproved,  project.name as projectName, building.name as buildingName, flat.id as flatId, flat.flat_no as flatNo "
				+"FROM  cancellation as cancel left join builder_project as project ON cancel.project_id = project.id left join builder_building as building"
				+ " ON cancel.building_id = building.id left join builder_flat as flat ON cancel.flat_id = flat.id "
				+" left join builder as build ON project.group_id = build.id "
				+"WHERE build.id = "+builderEmployee.getBuilder().getId()+" group by cancel.id";
		} else {
			hql = "SELECT cancel.buyer_name as buyerName, cancel.cancel_status as status,cancel.is_approved as isApproved, project.name as projectName, building.name as buildingName, flat.id as flatId, flat.flat_no as flatNo "
					+"FROM  cancellation as cancel left join builder_project as project ON cancel.project_id = project.id inner join allot_project ap ON project.id = ap.project_id "
					+ "left join builder_building as building "
				+ " ON cancel.building_id = building.id left join builder_flat as flat ON cancel.flat_id = flat.id "
					+" left join builder as build ON project.group_id = build.id "
					+"WHERE ap.emp_id = "+builderEmployee.getId()+" group by cancel.id";
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(CancellationList.class));
		//System.err.println(hql);
		List<CancellationList> result = query.list();
		session.close();
		return result;
	}
	
	public ResponseMessage deletePrimaryBuyerByFlatId(int flatId){
		ResponseMessage responseMessage = new ResponseMessage();
		updateBuyerStatus(flatId);
		updateCancelStatus(flatId);
		updateFlatStatus(flatId);
		responseMessage.setStatus(1);
		responseMessage.setMessage("Buyer is Deleted Successfully");
		return responseMessage;
	}
	public void updateCancelStatus(int flatId){
		System.out.println("FlatId :: "+flatId);
		String hql = "UPDATE Cancellation set cancel_status = 2, is_approved = 1 WHERE builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id",flatId);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
	
	public ResponseMessage cancelApproval(int flatId){
		String hql = "UPDATE Cancellation set cancel_status = 0 where builderFlat.id = :flat_id";
		ResponseMessage responseMessage = new ResponseMessage();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		return responseMessage;
	}
	/**
	 * Get all cancellation list on page load
	 * @param builderEmployee
	 * @return List<BookedBuyerList>
	 */
	public List<BookedBuyerList> getCancelledBuyerList(BuilderEmployee builderEmployee){
		String hql = "";
		HibernateUtil hibernateUtil = new HibernateUtil();
		if(builderEmployee.getBuilderEmployeeAccessType().getId() >0 && builderEmployee.getBuilderEmployeeAccessType().getId() <=2){
			hql ="select project.name as projectName,project.locality_name as localityName, city.name as cityName, building.name as buildingName, flat.flat_no as flatNo,cancel.buyer_name as buyerName, cancel.buyer_contact as buyerContact, cancel.reason as cancelReason, cancel.charges as charges from cancellation as cancel inner join builder_flat as flat on flat.id = cancel.flat_id left join buyer as buy on buy.flat_id = flat.id left join builder_floor as floor on floor.id = flat.floor_no left join builder_building as building on building.id = floor.building_id left join builder_project as project on project.id = building.project_id left join city as city on city.id = project.city_id where buy.builder_id ="+builderEmployee.getBuilder().getId()+" and buy.is_primary=1 and buy.is_deleted=1 and project.status=1 GROUP by cancel.id order by project.id DESC";
		}else{
			hql= "select project.name as projectName,project.locality_name as localityName, city.name as cityName, building.name as buildingName, flat.flat_no as flatNo,cancel.buyer_name as buyerName, cancel.buyer_contact as buyerContact, cancel.reason as cancelReason, cancel.charges as charges from cancellation as cancel inner join builder_flat as flat on flat.id = cancel.flat_id left join buyer as buy on buy.flat_id = flat.id left join builder_floor as floor on floor.id = flat.floor_no left join builder_building as building on building.id = floor.building_id left join builder_project as project on project.id = building.project_id inner join allot_project as ap on ap.project_id = project.id left join city as city on city.id = project.city_id where ap.emp_id ="+builderEmployee.getId()+" and buy.is_primary=1 and buy.is_deleted=1 and project.status=1 GROUP by cancel.id order by project.id DESC";
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BookedBuyerList.class));
		
		List<BookedBuyerList> result = query.list();
		return result;
	}
	/**
	 * Filter cancel buyer's list by project name with buyer's contact number or project name with buyer name
	 * @param empId
	 * @param projectId
	 * @param name
	 * @param contactNumber
	 * @return List<BookedBuyerList>
	 */
	
	public List<BookedBuyerList> getCancelledBuyerList(int empId, int projectId, String name, int contactNumber){
		List<BookedBuyerList> result = null;
		String hql = "select project.name as projectName,project.locality_name as localityName, city.name as cityName, building.name as buildingName, flat.flat_no as flatNo,cancel.buyer_name as buyerName, cancel.buyer_contact as buyerContact, cancel.reason as cancelReason, cancel.charges as charges ";
		String where = "";
		String hqlnew = "from BuilderEmployee where id = "+empId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session sessionnew = hibernateUtil.openSession();
		Query querynew = sessionnew.createQuery(hqlnew);
		List<BuilderEmployee> employees = querynew.list();
		BuilderEmployee builderEmployee = employees.get(0);
		sessionnew.close();
		if(builderEmployee.getBuilderEmployeeAccessType().getId() > 2){
			hql += " from cancellation as cancel inner join builder_flat as flat on flat.id = cancel.flat_id left join buyer as buy on buy.flat_id = flat.id left join builder_floor as floor on floor.id = flat.floor_no left join builder_building as building on building.id = floor.building_id left join builder_project as project on project.id = building.project_id inner join allot_project as ap on ap.project_id = project.id left join city as city on city.id = project.city_id "
					+ "WHERE ";
					where+= "ap.emp_id="+builderEmployee.getId();
		}else{
			hql = hql+" from cancellation as cancel inner join builder_flat as flat on flat.id = cancel.flat_id left join buyer as buy on buy.flat_id = flat.id left join builder_floor as floor on floor.id = flat.floor_no left join builder_building as building on building.id = floor.building_id left join builder_project as project on project.id = building.project_id left join city as city on city.id = project.city_id "
					+ "WHERE ";
					where+= "buy.builder_id="+builderEmployee.getBuilder().getId();
		}
		if(projectId > 0){
			if(where != ""){
				where += " AND project.id = :project_id";
			}else{
				where +=" project.id = :project_id";
			}
		}
		if(name != ""){
			if(where != ""){
				where += " AND cancel.buyer_name LIKE :name";
			}else{
				where +=" cancel.buyer_name LIKE :name";
			}
		}
		if(contactNumber > 0){
			if(where != ""){
				where += " AND cancel.buyer_contact LIKE :contact_number";
			}else{
				where +=" cancel.buyer_contact LIKE :contact_number";
			}
		}
		hql += where + " AND project.status=1 AND buy.is_primary=1 AND buy.is_deleted=1 GROUP by cancel.id ORDER BY project.id desc";
		try {
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BookedBuyerList.class));
		System.err.println(hql);
		if(projectId > 0){
			query.setParameter("project_id", projectId);
		}
		if(name != ""){
			query.setParameter("name", "%"+name+"%");
		}
		if(contactNumber > 0){
			query.setParameter("contact_number", "%"+contactNumber+"%");
		}
		
		 result = query.list();
		
		} catch(Exception e) {
			//
		}
		
		return result;
	}
	
	public Cancellation getCancellationByFlatId(int flatId){
		String hql = "from Cancellation where builderFlat.id = :flat_id";
		Cancellation cancellation = null;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		try{
			cancellation =(Cancellation) query.list().get(0);
			return cancellation;
		}catch(Exception e){
			return cancellation;
		}
	}
	
	public Cancellation getCancellationById(int id){
		String hql = "from Cancellation where id = :id";
		Cancellation cancellation = null;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		try{
			cancellation =(Cancellation) query.list().get(0);
			return cancellation;
		}catch(Exception e){
			return cancellation;
		}
	}
	
	public ResponseMessage updateCancelStatus(Cancellation cancellation){
		ResponseMessage responseMessage = new ResponseMessage();
		String hql = "UPDATE Cancellation set charges=:cancel_amount where id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Cancellation cancellation2 = null;
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("cancel_amount", cancellation.getCharges());
		query.setParameter("id",cancellation.getId() );
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		cancellation2 = getCancellationById(cancellation.getId());
		updateBuyerStatus(cancellation2.getBuilderFlat().getId());
		updateCancelStatus(cancellation2.getBuilderFlat().getId());
		updateFlatStatus(cancellation2.getBuilderFlat().getId());
		responseMessage.setStatus(1);
		responseMessage.setMessage("Buyer is Deleted Successfully");
		return responseMessage;
	}
}