package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.data.PriceInfoData;
import org.bluepigeon.admin.data.ProjectPriceInfoData;
import org.bluepigeon.admin.model.BuilderFlatType;
import org.bluepigeon.admin.model.BuilderProjectPriceInfo;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

import com.google.gson.Gson;

public class BuilderProjectPriceInfoDAO {

	public BuilderProjectPriceInfo getBuilderProjectPriceInfo(int project_id) {
		String hql = "from BuilderProjectPriceInfo where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<BuilderProjectPriceInfo> result = query.list();
		session.close();
		return result.get(0);
	}
	public PriceInfoData getBuilderProjectPriceInfos(int project_id) {
		PriceInfoData priceInfoData = null; 
		String hql = "from BuilderProjectPriceInfo where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<BuilderProjectPriceInfo> result = query.list();
		
		if(result.get(0) != null){
			priceInfoData = new PriceInfoData();
			priceInfoData.setId(result.get(0).getId());
			priceInfoData.setAmenityRate(result.get(0).getAmenityRate());
			//priceInfoData.setAreaUnits(result.get(0).getAreaUnit());
			priceInfoData.setBaseRate(result.get(0).getBasePrice());
			priceInfoData.setMaintainance(result.get(0).getMaintenance());
			priceInfoData.setParking(result.get(0).getParking());
			priceInfoData.setPost(result.get(0).getPost());
			priceInfoData.setRiseRate(result.get(0).getRiseRate());
			priceInfoData.setTenure(result.get(0).getTenure());
			priceInfoData.setFee(result.get(0).getFee());
			priceInfoData.setStampDuty(result.get(0).getStampDuty());
			priceInfoData.setTax(result.get(0).getTax());
			priceInfoData.setVat(result.get(0).getVat());
		}
		session.close();
		return priceInfoData;
	}
	
	public ProjectPriceInfoData getProjectPriceInfoByProjectId(int projectId){
		int numberOfFloors = 0;
		Double a = 0.0,b = 0.0,c = 0.0,d = 0.0,e = 0.0,f = 0.0,g = 0.0,totalSalePrice = 0.0;
		String hql = "from BuilderProjectPriceInfo where builderProject.id = :project_id";
		String superBuildUpArea = "from BuilderFlatType where builderProject.id = :project_id";
		ProjectPriceInfoData projectPriceInfoData = new ProjectPriceInfoData();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", projectId);
		BuilderProjectPriceInfo builderProjectPriceInfo = (BuilderProjectPriceInfo) query.list().get(0);
		Session innerSession = hibernateUtil.openSession();
		Query innerQuery = innerSession.createQuery(superBuildUpArea);
		innerQuery.setParameter("project_id", projectId);
		BuilderFlatType builderFlatType = (BuilderFlatType) innerQuery.list().get(0);
		if(builderProjectPriceInfo != null && builderFlatType != null){
			projectPriceInfoData.setId(builderProjectPriceInfo.getId());
			projectPriceInfoData.setAmenityRate(builderProjectPriceInfo.getAmenityRate());
			projectPriceInfoData.setBasePrice(builderProjectPriceInfo.getBasePrice());
			projectPriceInfoData.setMaintenance(builderProjectPriceInfo.getMaintenance());
			projectPriceInfoData.setParking(builderProjectPriceInfo.getParking());
			projectPriceInfoData.setPost(builderProjectPriceInfo.getPost());
			projectPriceInfoData.setRiseRate(builderProjectPriceInfo.getRiseRate());
			projectPriceInfoData.setStampDuty(builderProjectPriceInfo.getStampDuty());
			projectPriceInfoData.setTax(builderProjectPriceInfo.getTax());
			projectPriceInfoData.setTenure(builderProjectPriceInfo.getTenure());
			projectPriceInfoData.setVat(builderProjectPriceInfo.getVat());
			a = projectPriceInfoData.getBasePrice()*builderFlatType.getSuperBuiltupArea()*builderProjectPriceInfo.getAreaUnit().getSqft_value();
			if(numberOfFloors > projectPriceInfoData.getPost())
				b = projectPriceInfoData.getRiseRate()*builderFlatType.getSuperBuiltupArea()*builderProjectPriceInfo.getAreaUnit().getSqft_value();
			if(projectPriceInfoData.getMaintenance() > 0)
				c = projectPriceInfoData.getMaintenance();
			if(projectPriceInfoData.getAmenityRate() > 0)
				d =	 projectPriceInfoData.getAmenityRate();
			if(projectPriceInfoData.getParking() > 0)
				e = projectPriceInfoData.getParking();
			f = a+b+d;
			g= f*projectPriceInfoData.getStampDuty()/100+f * projectPriceInfoData.getTax()/100+f * projectPriceInfoData.getVat()/100;
			totalSalePrice = f+c+e+g;
			projectPriceInfoData.setTotalSaleValue(totalSalePrice);
		}
		session.close();
		innerSession.close();
		return projectPriceInfoData;
	}
	
	public Double getProjectPriceInfoByBuilderId(int builderId){
		int numberOfFloors = 0;
		Double A = 0.0,B = 0.0,C = 0.0,D = 0.0,E = 0.0,F = 0.0,G = 0.0,totalSalePrice = 0.0;
		String hql = "from BuilderProjectPriceInfo where builderProject.builder.id = :builder_id";
		String superBuildUpArea = "from BuilderFlatType where builderProject.builder.id = :builder_id";
		ProjectPriceInfoData projectPriceInfoData = new ProjectPriceInfoData();
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Session innerSession = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("builder_id", builderId);
		Query innerQuery = innerSession.createQuery(superBuildUpArea);
		try{
			BuilderProjectPriceInfo builderProjectPriceInfo = (BuilderProjectPriceInfo) query.list().get(0);
			innerQuery.setParameter("builder_id", builderId);
			BuilderFlatType builderFlatType = (BuilderFlatType) innerQuery.list().get(0);
			if(builderProjectPriceInfo != null && builderFlatType != null){
				projectPriceInfoData.setId(builderProjectPriceInfo.getId());
				projectPriceInfoData.setAmenityRate(builderProjectPriceInfo.getAmenityRate());
				projectPriceInfoData.setBasePrice(builderProjectPriceInfo.getBasePrice());
				projectPriceInfoData.setMaintenance(builderProjectPriceInfo.getMaintenance());
				projectPriceInfoData.setParking(builderProjectPriceInfo.getParking());
				projectPriceInfoData.setPost(builderProjectPriceInfo.getPost());
				projectPriceInfoData.setRiseRate(builderProjectPriceInfo.getRiseRate());
				projectPriceInfoData.setStampDuty(builderProjectPriceInfo.getStampDuty());
				projectPriceInfoData.setTax(builderProjectPriceInfo.getTax());
				projectPriceInfoData.setTenure(builderProjectPriceInfo.getTenure());
				projectPriceInfoData.setVat(builderProjectPriceInfo.getVat());
				A = projectPriceInfoData.getBasePrice()*builderFlatType.getSuperBuiltupArea()*builderProjectPriceInfo.getAreaUnit().getSqft_value();
				if(numberOfFloors > projectPriceInfoData.getPost())
					B = projectPriceInfoData.getRiseRate()*builderFlatType.getSuperBuiltupArea()*builderProjectPriceInfo.getAreaUnit().getSqft_value();
				if(projectPriceInfoData.getMaintenance() > 0)
					C = projectPriceInfoData.getMaintenance();
				if(projectPriceInfoData.getAmenityRate() > 0)
					D =	 projectPriceInfoData.getAmenityRate();
				if(projectPriceInfoData.getParking() > 0)
					E = projectPriceInfoData.getParking();
				F = A+B+D;
				G= F*projectPriceInfoData.getStampDuty()/100+F * projectPriceInfoData.getTax()/100+F * projectPriceInfoData.getVat()/100;
				totalSalePrice = F+C+E+G;
				projectPriceInfoData.setTotalSaleValue(totalSalePrice);
			}
		}catch(IndexOutOfBoundsException e){
			e.printStackTrace();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		session.close();
		innerSession.close();
		return totalSalePrice;
	}
	public BuilderFlatType getBuilderFlatTypeByProjectId(int projectId){
		String superBuildUpArea = "from BuilderFlatType where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(superBuildUpArea);
		query.setParameter("project_id", projectId);
		BuilderFlatType builderFlatType = (BuilderFlatType)query.list().get(0);
		return builderFlatType;
	}
}
