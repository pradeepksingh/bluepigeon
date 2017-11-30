package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.data.Building;
import org.bluepigeon.admin.data.CompletionList;
import org.bluepigeon.admin.data.CompletionStatus;
import org.bluepigeon.admin.data.DocumentList;
import org.bluepigeon.admin.data.DocumentType;
import org.bluepigeon.admin.data.Flat;
import org.bluepigeon.admin.data.Floor;
import org.bluepigeon.admin.data.Project;
import org.bluepigeon.admin.data.ProjectAPI;
import org.bluepigeon.admin.data.ProjectAddress;
import org.bluepigeon.admin.data.ProjectCount;
import org.bluepigeon.admin.data.Projects;
import org.bluepigeon.admin.data.PropertyDocument;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;

import com.sun.org.apache.regexp.internal.recompile;

public class ProjectAPIDAO {
	public Projects getProjectAddresses(String pancard){
		Projects projects = new Projects();
		int projectId = 0;
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql ="SELECT project.id as id, project.name as projectName, floor.name as floorName, project.locality_name as localityName from builder_project as project "
				+ "join builder_building as building on building.project_id=project.id "
				+ "join builder_floor as floor on floor.building_id=building.id "
				+ "join builder_flat as flat on flat.floor_no = floor.id "
				+ "join buyer as buy on buy.flat_id=flat.id where buy.is_primary=1 and buy.is_deleted=0 and buy.pancard='"+pancard+"'";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectAddress.class));
		List<ProjectAddress> result = query.list();
		projectId = result.get(0).getId();
		ProjectAPI projectAPI = getProjectDetails(projectId);
		projects.setArea(projectAPI.getArea());
		projects.setAreaUnitName(projectAPI.getAreaUnitName());
		projects.setBookingDate(projectAPI.getBookingDate());
		projects.setCompletionStatus(projectAPI.getCompletionStatus());
		projects.setConfigName(projectAPI.getConfigName());
		projects.setFloorName(projectAPI.getFloorName());
		projects.setId(projectAPI.getId());
		if(projectAPI.getImage()!=null){
		projects.setImage(projectAPI.getImage());
		}else{
			projects.setImage("");
		}
		projects.setLocalityName(projectAPI.getLocalityName());
		projects.setTotalCost(projectAPI.getTotalCost());
		Project project = getProjectlevelCount(projectId);
		Building building = getBuildingLevelCount(projectId);
		Floor floor = getFloorLevelCount(projectId);
		Flat flat = getFlatLevelCount(projectId);
		projects.setProject(project);
		projects.setBuilding(building);
		projects.setFloor(floor);
		projects.setFlat(flat);
		projects.setProjectAddresses(result);
		session.close();
		return projects;
	}
	public ProjectAPI getProjectDetails(int id){
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql ="SELECT project.id as id, project.name as projectName, floor.name as floorName, project.locality_name as localityName, ROUND(project.completion_status,2) as CompletionStatus, project.image as image, projectconfig.name as configName, project.project_area as area, area.name as areaUnitName, DATE_FORMAT(bdetails.booking_date,'%D %b %Y') as bookingDate, bdetails.total_cost as totalCost from builder_project as project "
				+ "join builder_building as building on building.project_id=project.id "
				+ "join builder_floor as floor on floor.building_id=building.id "
				+ "join builder_flat as flat on flat.floor_no = floor.id "
				+ "join builder_flat_type as bft on bft.project_id=project.id "
				+ "inner join builder_project_property_configuration as projectconfig on projectconfig.id = bft.config_id "
				+ "join buyer as buy on buy.project_id = project.id join buying_details as bdetails on bdetails.buyer_id=buy.id "
				+ "join area_unit as area on area.id=project.area_unit_id "
				+ "where "
				+ "buy.is_primary=1 and buy.is_deleted=0 and project.id="+id;
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(ProjectAPI.class));
	    ProjectAPI result = (ProjectAPI)query.list().get(0);
	    ProjectAPI projectAPI = result;
	    Project project = getProjectlevelCount(id);
	    Building building = getBuildingLevelCount(id);
	    Floor floor = getFloorLevelCount(id);
	    Flat flat = getFlatLevelCount(id);
	    projectAPI.setProject(project);
	    projectAPI.setBuilding(building);
	    projectAPI.setFloor(floor);
	    projectAPI.setFlat(flat);
	    session.close();
		return projectAPI;
	}
	
	public ProjectCount getProjectlevelDetails(int projectId){
		ProjectCount projectCount = new ProjectCount();
		Project project = getProjectlevelCount(projectId);
		Building building = getBuildingLevelCount(projectId);
		Floor floor  = getFloorLevelCount(projectId);
		Flat flat = getFlatLevelCount(projectId);
		projectCount.setProject(project);
		projectCount.setBuilding(building);
		projectCount.setFlat(flat);
		projectCount.setFloor(floor);
		return projectCount;
	}
	
	public Project getProjectlevelCount(int projectId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql ="select COUNT(building.id) as buildingCount,(select COUNT(amenityinfo.id) from builder_project_amenity_info as amenityinfo where amenityinfo.project_id="+projectId+" ) as amenityCount from builder_building as building join builder_project as project on project.id=building.project_id where project.id="+projectId+" and project.status=1 and building.status=1";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(Project.class));
		List<Project> result = query.list();
		session.close();
		return result.get(0);
	}
	
	public Building getBuildingLevelCount(int projectId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "select COUNT(floor.id) as floorCount, (select count(amenityinfo.id) from builder_project as project join builder_building as building on building.project_id=project.id join building_amenity_info as amenityinfo on amenityinfo.building_id=building.id where project.id="+projectId+") as amenityCount from builder_floor as floor join builder_building as building on building.id = floor.building_id join builder_project as project on project.id = building.project_id where project.id="+projectId+" and project.status=1 and building.status=1 and floor.status=1";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(Building.class));
		List<Building> result = query.list();
		session.close();
		return result.get(0);
	}
	public Floor getFloorLevelCount(int projectId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "select count(flat.id) as flatCount, (select COUNT(amenityinfo.id) from floor_amenity_info as amenityinfo join builder_floor as floor on floor.id = amenityinfo.floor_id join builder_building as building on building.id = floor.building_id join builder_project as project on project.id=building.project_id where project.id="+projectId+") as amenityCount from builder_flat as flat join builder_floor as floor on floor.id=flat.floor_no join builder_building as building on building.id=floor.building_id join builder_project as project on project.id = building.project_id where project.id="+projectId+" and project.status=1 and building.status=1 and floor.status=1 and flat.status=1";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(Floor.class));
		List<Floor> result = query.list();
		session.close();
		return result.get(0);
		
	}
	public Flat getFlatLevelCount(int projectId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "SELECT COUNT(amenityinfo.id) as amenityCount FROM flat_amenity_info as amenityinfo join builder_flat as flat on flat.id=amenityinfo.flat_id join builder_floor as floor on floor.id=flat.floor_no join builder_building as building on building.id= floor.building_id join builder_project as project on project.id=building.project_id where project.id="+projectId+" and project.status=1 and building.status=1 and floor.status=1 and flat.status=1";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(Flat.class));
		List<Flat> result = query.list();
		session.close();
		return result.get(0);
		
		
	}
	public CompletionList getBuildingListByProjcet(int projectId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "SELECT a.completion as percentage, a.image as image, a.title as title, b.id as id, b.name as name FROM building_image_gallery as a join builder_building as b on b.id=a.building_id join builder_project as c on c.id = b.project_id WHERE c.id="+projectId+" and c.status=1 and b.status=1 GROUP by a.id order by a.id DESC";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(CompletionStatus.class));
		List<CompletionStatus> result = query.list();
		CompletionList completionList = new CompletionList();
		completionList.setCompletionStatus(result);
		session.close();
		return completionList;
	}
	
	public CompletionList getFloorListByProject(int projectId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "SELECT a.completion as percentage, a.image as image, a.title as title, b.id as id, b.name as name FROM floor_image_gallery as a join builder_floor as b on b.id=a.floor_id join builder_building as c on c.id=b.building_id join builder_project as d on d.id=c.project_id where d.id="+projectId+" and d.status=1 and b.status=1 and c.status=1 GROUP by a.id order by a.id DESC";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(CompletionStatus.class));
		List<CompletionStatus> result = query.list();
		CompletionList completionList = new CompletionList();
		completionList.setCompletionStatus(result);
		session.close();
		return completionList;
	}
	
	//
	public CompletionList getFlatListByProject(int projectId){
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "SELECT a.completion as percentage, a.image as image, a.title as title, b.id as id, b.flat_no as name FROM flat_image_gallery as a join builder_flat as b on b.id=a.flat_id JOIN builder_floor as c on c.id=b.floor_no JOIN builder_building as d on d.id=c.building_id JOIN builder_project as e on e.id=d.project_id where e.id="+projectId+" and e.status=1 and d.status=1 and c.status=1 and b.status=1 GROUP by a.id ORDER by a.id DESC";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(CompletionStatus.class));
		List<CompletionStatus> result = query.list();
		CompletionList completionList = new CompletionList();
		completionList.setCompletionStatus(result);
		session.close();
		return completionList;
	}
	
	public List<DocumentList> getPropertyDocument(String pancard,int projectId){
		PropertyDocument propertyDocument = new PropertyDocument();
		HibernateUtil hibernateUtil = new HibernateUtil();
		String hql = "SELECT a.id as id, a.name as name, a.doc_url as url, a.doc_type as docType, b.flat_id as flatId, e.flat_no as flatNo FROM buyer_upload_documents as a join buyer as b on b.id=a.buyer_id join builder_project as d on d.id=b.project_id join builder_flat as e on e.id=b.flat_id where d.id="+projectId+" and b.pancard='"+pancard+"' and b.is_primary=1 and b.is_deleted=0 GROUP by a.id order by a.id desc";
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(DocumentList.class));
		System.err.println(hql);
		List<DocumentList> result = query.list();
		session.close();
		return result;
	}
	
}
