package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.model.BuilderProjectPaymentInfo;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuilderProjectPaymentInfoDAO {

	public List<BuilderProjectPaymentInfo> getBuilderProjectPaymentInfo(int project_id) {
		String hql = "from BuilderProjectPaymentInfo where builderProject.id = :project_id";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("project_id", project_id);
		List<BuilderProjectPaymentInfo> result = query.list();
		session.close();
		return result;
	}
}
