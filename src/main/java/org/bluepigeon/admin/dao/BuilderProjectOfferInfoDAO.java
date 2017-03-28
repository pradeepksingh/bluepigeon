package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.model.BuilderProjectOfferInfo;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuilderProjectOfferInfoDAO {

	public List<BuilderProjectOfferInfo> getBuilderProjectOfferInfo(int project_id) {
		String hql = "from BuilderProjectOfferInfo where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<BuilderProjectOfferInfo> result = query.list();
		session.close();
		return result;
	}
}
