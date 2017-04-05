package org.bluepigeon.admin.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.DemandLetters;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class DemandLettersDAO {
		/**
		 * @author pankaj
		 * @param demandLetters
		 * @return response
		 */
		public ResponseMessage saveDemandLettes(DemandLetters demandLetters){
			ResponseMessage responseMessage = new ResponseMessage();
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.save(demandLetters);
			newsession.getTransaction().commit();
			newsession.close();
			responseMessage.setId(demandLetters.getId());
			responseMessage.setStatus(1);
			responseMessage.setMessage("Demand letter Added Successfully.");
			return responseMessage;
		}
		/**
		 * @author pankaj
		 * @param demandLetters
		 * @return response
		 */
		public ResponseMessage updateDemandLetter(DemandLetters demandLetters){
			ResponseMessage response = new ResponseMessage();
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session newsession = hibernateUtil.openSession();
			newsession.beginTransaction();
			newsession.update(demandLetters);
			newsession.getTransaction().commit();
			newsession.close();
			response.setId(demandLetters.getId());
			response.setStatus(1);
			response.setMessage("Demand letter updated Successfully.");
			return response;
		}
		/**
		 * @author pankaj
		 * @param id
		 * @return demandLetter's object
		 */
		public DemandLetters getDemandLetterById(int id){
			String hql = "from DemandLetters where id = :id";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			query.setParameter("id", id);
			List<DemandLetters> result = query.list();
			session.close();
			return result.get(0);
		}
		/**
		 * @author pankaj
		 * @return list
		 */
		public List<DemandLetters> getAllDemandLetters(){
			String hql = "from DemandLetters";
			HibernateUtil hibernateUtil = new HibernateUtil();
			Session session = hibernateUtil.openSession();
			Query query = session.createQuery(hql);
			List<DemandLetters> result = query.list();
			session.close();
			return result;
		}
		
		 public List<BuilderBuilding> getAllBuildingByProjectId(int projectId){
			  String hql = "from BuilderBuilding where builderProject.id = :project_id";
				HibernateUtil hibernateUtil = new HibernateUtil();
				Session session = hibernateUtil.openSession();
				Query query = session.createQuery(hql);
				query.setParameter("project_id", projectId);
				List<BuilderBuilding> result = query.list();
				session.close();
				System.out.println("Return");
				List<BuilderBuilding> builderBuildings = new ArrayList<BuilderBuilding>();
				for(BuilderBuilding builderBuilding : result){
					BuilderBuilding builderBuilding2 = new BuilderBuilding();
					builderBuilding2.setId(builderBuilding.getId());
					builderBuilding2.setName(builderBuilding.getName());
					builderBuildings.add(builderBuilding2);
				}
				return builderBuildings;
		  }
		 
//		 public List<BuilderFlat> getFlatByBuildingId(int buildingId){
//			 String hql = "from BuilderBuilding where id = :id";
//			 HibernateUtil hibernateUtil = new HibernateUtil();
//				Session session = hibernateUtil.openSession();
//				Query query = session.createQuery(hql);
//				query.setParameter("id", buildingId);
//				List<BuilderBuilding> result = query.list();
//				session.close();
//				System.out.println("Return");
//				List<BuilderFloor> builderBuildings = new ArrayList<BuilderFloor>();
//				for(BuilderBuilding builderBuilding : result){
//					BuilderFloor builderBuilding2 = new BuilderFloor();
//					if(builderBuilding.getBuilderFloors().size()>0){
//						Iterator<BuilderFloor> bIterator = builderBuilding.getBuilderFloors().iterator();
//						
//					}
//					builderBuilding2.setId(builderBuilding.getBuilderFloors());
//					builderBuilding2.setName(builderBuilding.getName());
//					builderBuildings.add(builderBuilding2);
//				}
//				return builderBuildings;
//		 }
}
