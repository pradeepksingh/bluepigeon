package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderLead;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration;
import org.bluepigeon.admin.model.BuilderSellerType;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class ProjectLeadDAO {

	  public  List<BuilderProject> getProjectById(int projectId) {
		  String hql = "from BuilderProject where id = :id";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("id", projectId);
			List<BuilderProject> result = query.list();
			session.close();
			return result;
	  }
	  public List<BuilderBuilding> getBuildingByProjectId(int projectId){
		  String hql = "from BuilderBuilding where project.id = :project_id";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("project_id", projectId);
			List<BuilderBuilding> result = query.list();
			session.close();
			System.out.println("Return");
			return result;
	  }
	  public List<BuilderFloor> getBuilderFloorByBuildingId(int buildingId){
		  String hql = "from BuilderFloor where builderBuilding.id = :building_id";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("builder_id", buildingId);
			List<BuilderFloor> result = query.list();
			session.close();
			return result;
	  }
	  public List<BuilderFlat> getBuilderFlatTypeByFloorId(int floorId){
		  String hql = "from BuilderFlat where builderFloor.id = :floor_id";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("floor_id", floorId);
			List<BuilderFlat> result = query.list();
			session.close();
			return result;
		  
	  }
	  public List<City> getAllCity(){
		  String hql = "from City";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			List<City> result = query.list();
			session.close();
			return result;
	  }
	  public List<AdminUser> getAmdinUser(){
		  String hql = "from AdminUser";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			List<AdminUser> result = query.list();
			session.close();
			return result;
	  }
	  public List<BuilderProjectPropertyConfiguration> getAllPropertyConfiguration(){
		  String hql = "from BuilderProjectPropertyConfiguration";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			List<BuilderProjectPropertyConfiguration> result = query.list();
			session.close();
			return result;
	  }
	  public List<BuilderSellerType> getSellerTypeList(){
		  String hql = "from BuilderSellerType";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			List<BuilderSellerType> result = query.list();
			session.close();
			return result;
	  }
	  public  List<BuilderProject> getProjectList() {
		  String hql = "from BuilderProject";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			List<BuilderProject> result = query.list();
			session.close();
			return result;
	  }
	  public List<BuilderLead> getProjectLeadList(){
		  String hql = "from BuilderLead";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			List<BuilderLead> result = query.list();
			session.close();
			return result;
	  }
}
