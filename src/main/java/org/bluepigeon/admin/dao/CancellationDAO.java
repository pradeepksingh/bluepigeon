package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.BookingFlatList;
import org.bluepigeon.admin.data.CancellationList;
import org.bluepigeon.admin.data.EmployeeList;
import org.bluepigeon.admin.data.FlatData;
import org.bluepigeon.admin.data.LeadList;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.data.BookedBuyerList;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.Cancellation;
import org.bluepigeon.admin.model.FlatPricingDetails;
import org.bluepigeon.admin.model.Notification;
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
			String chql = "from Cancellation where builderFlat.id = :flat_id and buyer_id =:buyer_id";
			Session presession = hibernateUtil.openSession();
			Query prequery = presession.createQuery(chql);
			prequery.setParameter("flat_id", cancellation.getBuilderFlat().getId());
			prequery.setParameter("buyer_id", cancellation.getBuyerId());
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
			saveNewNotification(builderEmployee,cancellation);
		if(builderEmployee.getBuilderEmployeeAccessType().getId()==5){
			updateFlatStatus(cancellation.getBuilderFlat().getId());
			updatePrimaryBuyer(cancellation.getBuilderFlat().getId());
			updateProjectInventory(cancellation.getBuilderFlat().getId());
			updateBuildingInventory(cancellation.getBuilderFlat().getId());
			updateProjectRevenue(cancellation.getCharges(),cancellation.getBuilderProject().getId(),cancellation.getBuilderFlat().getId());
			updateBuildingRevenue(cancellation.getCharges(),cancellation.getBuilderProject().getId(),cancellation.getBuilderFlat().getId());
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
			hql ="select project.name as projectName,project.locality_name as localityName, city.name as cityName, building.name as buildingName, flat.flat_no as flatNo,cancel.buyer_name as buyerName, cancel.buyer_contact as buyerContact, cancel.reason as cancelReason, cancel.charges as charges from cancellation as cancel inner join builder_flat as flat on flat.id = cancel.flat_id left join buyer as buy on buy.flat_id = flat.id left join builder_floor as floor on floor.id = flat.floor_no left join builder_building as building on building.id = floor.building_id left join builder_project as project on project.id = building.project_id left join city as city on city.id = project.city_id where buy.builder_id ="+builderEmployee.getBuilder().getId()+" and buy.is_primary=1 and buy.is_deleted=1 and project.status=1  GROUP by cancel.id order by project.id DESC";
		}else{
			hql= "select project.name as projectName,project.locality_name as localityName, city.name as cityName, building.name as buildingName, flat.flat_no as flatNo,cancel.buyer_name as buyerName, cancel.buyer_contact as buyerContact, cancel.reason as cancelReason, cancel.charges as charges from cancellation as cancel inner join builder_flat as flat on flat.id = cancel.flat_id left join buyer as buy on buy.flat_id = flat.id left join builder_floor as floor on floor.id = flat.floor_no left join builder_building as building on building.id = floor.building_id left join builder_project as project on project.id = building.project_id inner join allot_project as ap on ap.project_id = project.id left join city as city on city.id = project.city_id where ap.emp_id ="+builderEmployee.getId()+" and buy.is_primary=1 and buy.is_deleted=1 and project.status=1 GROUP by cancel.id order by project.id DESC";
		}
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BookedBuyerList.class));
		System.err.println(hql);
		List<BookedBuyerList> result = query.list();
		session.close();
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
	
	public List<BookedBuyerList> getCancelledBuyerList(int empId, int projectId, String keyword){
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
			if(keyword==""){
				hql += " from cancellation as cancel inner join builder_flat as flat on flat.id = cancel.flat_id left join buyer as buy on buy.flat_id = flat.id left join builder_floor as floor on floor.id = flat.floor_no left join builder_building as building on building.id = floor.building_id left join builder_project as project on project.id = building.project_id inner join allot_project as ap on ap.project_id = project.id left join city as city on city.id = project.city_id "
					+ "WHERE ";
				where+= "ap.emp_id="+builderEmployee.getId();
				if(projectId > 0){
					if(where != ""){
						where += " AND project.id ="+projectId;
					}else{
						where +=" project.id = "+projectId;
					}
				}
			}else{
				hql += " from cancellation as cancel inner join builder_flat as flat on flat.id = cancel.flat_id left join buyer as buy on buy.flat_id = flat.id left join builder_floor as floor on floor.id = flat.floor_no left join builder_building as building on building.id = floor.building_id left join builder_project as project on project.id = building.project_id inner join allot_project as ap on ap.project_id = project.id left join city as city on city.id = project.city_id "
					+"WHERE ";
				where+= " and ap.emp_id="+builderEmployee.getId();
				hql +=" (cancel.buyer_name like '%"+keyword+"%' OR cancel.buyer_contact like '%"+keyword+"%')";
				if(projectId > 0){
					if(where != ""){
						where +=" AND project.id="+projectId;
					}else{
						where +=" project.id="+projectId;
					}
				}
			}
		}else{
			if(keyword == ""){
				hql = hql+" from cancellation as cancel inner join builder_flat as flat on flat.id = cancel.flat_id left join buyer as buy on buy.flat_id = flat.id left join builder_floor as floor on floor.id = flat.floor_no left join builder_building as building on building.id = floor.building_id left join builder_project as project on project.id = building.project_id left join city as city on city.id = project.city_id "
					+ "WHERE ";
				where+= "buy.builder_id="+builderEmployee.getBuilder().getId();
				if(projectId > 0){
					if(where != ""){
						where +=" AND project.id = "+projectId;
					}else{
						where +=" project.id ="+projectId;
					}
				}
					
			}else{
				hql = hql+" from cancellation as cancel inner join builder_flat as flat on flat.id = cancel.flat_id left join buyer as buy on buy.flat_id = flat.id left join builder_floor as floor on floor.id = flat.floor_no left join builder_building as building on building.id = floor.building_id left join builder_project as project on project.id = building.project_id left join city as city on city.id = project.city_id "
					+ "WHERE ";
				where+= " and buy.builder_id="+builderEmployee.getBuilder().getId();
				hql +=" (cancel.buyer_name like '%"+keyword+"%' OR cancel.buyer_contact like '%"+keyword+"%')";
				if(projectId > 0){
					if(where != ""){
						where +=" AND project.id = "+projectId;
					}else{
							where +=" project.id = "+projectId;
					}
				}
			}
		}
		
		
		hql += where + " AND project.status=1 AND buy.is_primary=1 AND buy.is_deleted=1 GROUP by cancel.id ORDER BY cancel.id desc";
		try {
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(BookedBuyerList.class));
		System.err.println(hql);
		 result = query.list();
		
		} catch(Exception e) {
			//
			e.printStackTrace();
		}
		
		return result;
	}
	public Cancellation getCancellationByFlatId(int flatId){
		String hql = "from Cancellation where builderFlat.id = :flat_id and cancel_status=1 and is_approved = 0";
		Cancellation cancellation = null;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		try{
			cancellation =(Cancellation) query.list().get(0);
			session.close();
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
			session.close();
			return cancellation;
		}catch(Exception e){
			return cancellation;
		}
	}
	
	public ResponseMessage updateCancelStatus(Cancellation cancellation,int empId){
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
		saveApprovedCancellation(cancellation,empId);
		responseMessage.setStatus(1);
		responseMessage.setMessage("Booked Flat is cancelled Successfully");
		return responseMessage;
	}
	
	public List<Cancellation> getCancellationFlatId(int flatId){
		String hql = "from Cancellation where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		try{
			List<Cancellation> cancellation = query.list();
			session.close();
			return cancellation;
		}catch(Exception e){
			return null;
		}
	}
	
	public void saveNewNotification(BuilderEmployee builderEmployee,Cancellation cancellation){
		
		List<Notification> notifications = new ArrayList<Notification>();
		List<EmployeeList> empIds = getAssignedProjectSalesHead(cancellation.getBuilderProject().getId());
		FlatData flatData = getFlatById(cancellation.getBuilderFlat().getId());
		for(EmployeeList employeeList : empIds){
			Notification notification = new Notification();
			notification.setAssignedBy(builderEmployee.getId());
			notification.setAssignedTo(employeeList.getId());
			notification.setBuilderProject(cancellation.getBuilderProject());
			notification.setBuyerId(0);
			notification.setFlatId(cancellation.getBuilderFlat().getId());
			notification.setRead(false);
			notification.setType(1);
			notification.setDescription("Flat No "+flatData.getName()+" cancellation Request");
			notifications.add(notification);
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		for(Notification notification : notifications){
			session.save(notification);
		}
		session.getTransaction().commit();
		session.close();
	}
	
	public  List<EmployeeList> getAssignedProjectSalesHead(int projectId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		List<EmployeeList> result = null;
		String hql = "select emp.id as id from builder_employee as emp "
				+ "join employee_role as er on er.emp_id=emp.id "
				+ "join buyer as buy on buy.emp_id=emp.id "
				+ "join builder_project as project on project.id=buy.project_id "
				+ "inner join allot_project as ap on ap.project_id=project.id "
				+ "where er.role_id=5 and ap.project_id="+projectId+" GROUP by emp.id order by emp.id DESC";
		try {
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(EmployeeList.class));
			System.err.println(hql);
			 result = query.list();
			 session.close();
			} catch(Exception e) {
				//
				e.printStackTrace();
			}
		return result;
	}
	
	public List<Notification> getAssignedToByEmployee(int empId){
		String hql ="From Notification where assignedTo = :emp_id order by id desc";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("emp_id", empId);
		List<Notification> notification = query.list();
		session.close();
		return notification;
	}
	
	public FlatData getFlatById(int flatId){
		String hql = " select flat.id as id, flat.flat_no as name from builder_flat as flat where flat.id="+flatId;
		FlatData flatData = new FlatData();
		HibernateUtil hibernateUtil = new HibernateUtil();
		try {
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(FlatData.class));
			System.err.println(hql);
			flatData = (FlatData)query.list().get(0);
			session.close();
			return flatData;
			} catch(Exception e) {
				//
				e.printStackTrace();
				return null;
			}
	}
	
	public ResponseMessage updateNotificationStatus(int id){
		ResponseMessage responseMessage = new ResponseMessage();
		String hql = "UPDATE Notification set is_read=1 WHERE id = :id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("id",id);
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
		responseMessage.setStatus(1);
		return responseMessage;
	}
	
	public void saveApprovedCancellation(Cancellation cancellation,int empId){
		List<Notification> notifications = new ArrayList<Notification>();
		List<EmployeeList> empIds = getAssignedProjectSalesman(cancellation.getBuilderProject().getId());
		BuilderFlat builderFlat = getFlatDetailId(cancellation.getBuilderFlat().getId());
		for(EmployeeList employeeList : empIds){
			Notification notification = new Notification();
			notification.setAssignedBy(empId);
			notification.setAssignedTo(employeeList.getId());
			notification.setBuilderProject(cancellation.getBuilderProject());
			notification.setBuyerId(0);
			notification.setRead(false);
			notification.setType(1);
			notification.setDescription("Your cancellation request for "+builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName()+", "
					+builderFlat.getBuilderFloor().getBuilderBuilding().getName()+", "+builderFlat.getFlatNo()+" has been approved");
			notifications.add(notification);
		}
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		for(Notification notification : notifications){
			session.save(notification);
		}
		session.getTransaction().commit();
		session.close();
	}
	
	public  List<EmployeeList> getAssignedProjectSalesman(int projectId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		List<EmployeeList> result = null;
		String hql = "select emp.id as id from builder_employee as emp "
				+ "join employee_role as er on er.emp_id=emp.id "
				+ "join buyer as buy on buy.emp_id=emp.id "
				+ "join builder_project as project on project.id=buy.project_id "
				+ "inner join allot_project as ap on ap.project_id=project.id "
				+ "where er.role_id=7 and ap.project_id="+projectId+" GROUP by emp.id order by emp.id DESC";
		try {
			Session session = hibernateUtil.getSessionFactory().openSession();
			Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(EmployeeList.class));
			System.err.println(hql);
			 result = query.list();
			session.close();
			} catch(Exception e) {
				//
				e.printStackTrace();
			}
		return result;
	}
	
	public BuilderFlat getFlatDetailId(int flatId){
		String hql = "From BuilderFlat where id="+flatId;
		FlatData flatData = new FlatData();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		List<BuilderFlat> result = query.list();
		return result.get(0);
	}
	
	public void updateProjectInventory(int flatId){
		String hql = "UPDATE BuilderProject set availbale = :availbale, inventorySold =:soldInventory, totalInventory = :totalInventory where id = :project_id ";
		int available = 0;
		int totalInventory = 0;
		int soldInventory = 0;
		BuilderFlat builderFlat = getFlatDetailId(flatId);
		int projectId = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getId();
		available = getAvaiableFlatCount(projectId);
		soldInventory = getSoldFlatCount(projectId);
		totalInventory = available + soldInventory;
		//Double total_inventory =  totalInventory;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("availbale", available);
		query.setParameter("soldInventory", soldInventory);
		query.setParameter("totalInventory",totalInventory );
		query.setParameter("project_id",projectId );
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
	public int getAvaiableFlatCount(int project_id){
		String hql = "select id from BuilderFlat where builderFloor.builderBuilding.builderProject.id = :project_id and builderFlatStatus =1 AND status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		int available = query.list().size();
		return available;
	}

	public int getSoldFlatCount(int projectId){
		String hql = "Select id from BuilderFlat where builderFloor.builderBuilding.builderProject.id = :project_id and builderFlatStatus =2 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		int available =  query.list().size();
		return available;
	}
	
	 public void updateBuildingInventory(int flatId){
		String hql = "UPDATE BuilderBuilding set inventorySold =:soldInventory, totalInventory = :totalInventory where id = :building_id ";
		double totalInventory = 0.0;
		double soldInventory = 0.0;
		BuilderFlat builderFlat = getBuildingFlatById(flatId);
		int buildingId = builderFlat.getBuilderFloor().getBuilderBuilding().getId();
		totalInventory = getTotalFlatCount(buildingId);
		soldInventory = getBuildingSoldFlatCount(buildingId);
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		session.beginTransaction();
		Query query = session.createQuery(hql);
		query.setParameter("soldInventory", soldInventory);
		query.setParameter("totalInventory",totalInventory );
		query.setParameter("building_id",buildingId );
		query.executeUpdate();
		session.getTransaction().commit();
		session.close();
	}
 
	public int getTotalFlatCount(int buildingId){
		String hql = "select id from BuilderFlat where builderFloor.builderBuilding.id = :building_id  AND status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", buildingId);
		int totalInventory = query.list().size();
		return totalInventory;
	}
	
	public int getBuildingSoldFlatCount(int buildingId){
		String hql = "Select id from BuilderFlat where builderFloor.builderBuilding.id = :building_id and builderFlatStatus =2 and status=1";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("building_id", buildingId);
		int soldInventory =  query.list().size();
		return soldInventory;
	}
	public BuilderFlat getBuildingFlatById(int flatId){
		String hql = "From BuilderFlat where id=:flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("flat_id", flatId);
		List<BuilderFlat> result = query.list();
		return result.get(0);
	}
	
	public void updateProjectRevenue(double charges,int projectId,int flatId){
		String projecthql = "from BuilderProject where id = :id";
		String flatTotal = "from FlatPricingDetails where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session projectSession = hibernateUtil.openSession();
		Query projectQuery = projectSession.createQuery(projecthql);
		projectQuery.setParameter("id", projectId);
		BuilderProject builderProject = (BuilderProject) projectQuery.list().get(0);
		projectSession.close();
		Session flatSession = hibernateUtil.openSession();
		Query flatQuery = flatSession.createQuery(flatTotal);
		//Session updateSession = hibernateUtil.openSession();
		if(builderProject != null){
			flatQuery.setParameter("flat_id",flatId );
			FlatPricingDetails flatPricingDetails = (FlatPricingDetails)flatQuery.list().get(0);
			double flatValue =  flatPricingDetails.getTotalCost()-charges;
			double revenue = builderProject.getRevenue() -flatValue;
			builderProject.setRevenue(revenue);
			Session updateProject = hibernateUtil.openSession();
			updateProject.beginTransaction();
			updateProject.update(builderProject);
			updateProject.getTransaction().commit();
			updateProject.close();
		}
		flatSession.close();
	}

	public void updateBuildingRevenue(double charges,int projectId, int flatId){
		String buildinghql = "from BuilderBuilding where id = :id";
		String flatTotal = "from FlatPricingDetails where builderFlat.id = :flat_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session buildingSession = hibernateUtil.openSession();
		Query buildingQuery = buildingSession.createQuery(buildinghql);
		buildingQuery.setParameter("id", projectId);
		BuilderBuilding builderBuilding = (BuilderBuilding) buildingQuery.list().get(0);
		buildingSession.close();
		Session flatSession = hibernateUtil.openSession();
		Query flatQuery = flatSession.createQuery(flatTotal);
		//Session updateSession = hibernateUtil.openSession();
		if(builderBuilding != null){
			flatQuery.setParameter("flat_id",flatId );
			FlatPricingDetails flatPricingDetails = (FlatPricingDetails)flatQuery.list().get(0);
			double flatValue =  flatPricingDetails.getTotalCost()-charges;
			double revenue = builderBuilding.getRevenue() -flatValue;
			builderBuilding.setRevenue(revenue);
			Session updateBuilding = hibernateUtil.openSession();
			updateBuilding.beginTransaction();
			updateBuilding.update(builderBuilding);
			updateBuilding.getTransaction().commit();
			updateBuilding.close();
		}
		flatSession.close();
	}
}