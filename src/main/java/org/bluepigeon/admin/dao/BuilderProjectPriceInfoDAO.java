package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.data.ProjectPriceInfoData;
import org.bluepigeon.admin.model.BuilderFlatType;
import org.bluepigeon.admin.model.BuilderProjectPriceInfo;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

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
	
	public ProjectPriceInfoData getProjectPriceInfoByProjectId(int projectId){
		int numberOfFloors = 0;
		Double A = 0.0,B = 0.0,C = 0.0,D = 0.0,E = 0.0,F = 0.0,G = 0.0,totalSalePrice = 0.0;
		String hql = "from BuilderProjectPriceInfo where builderProject.id = :project_id";
		String superBuildUpArea = " from BuilderFlatType where builderProject.id = :project_id";
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
		session.close();
		innerSession.close();
		return projectPriceInfoData;
	}
}
