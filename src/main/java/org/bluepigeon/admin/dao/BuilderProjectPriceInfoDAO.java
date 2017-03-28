package org.bluepigeon.admin.dao;

import java.util.List;

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
}
