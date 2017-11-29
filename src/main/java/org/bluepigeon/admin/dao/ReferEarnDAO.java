package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.data.ProjectList;
import org.bluepigeon.admin.data.Refer;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;

public class ReferEarnDAO {
	public List<Refer> getReferEarnProjectId(String pancard,int projectId){
		String hql = "SELECT camp.id as id,camp.title as title, camp.image as image FROM campaign as camp join builder_project as project on project.id=camp.project_id inner join campaign_buyer as cb on cb.campaign_id=camp.id join buyer as buy on buy.id=cb.buyer_id where project.id="+projectId+" and buy.pancard='"+pancard+"' and buy.is_primary=1 and buy.is_deleted=0 group by camp.id order by camp.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(Refer.class));
		System.err.println(hql);
		query.setMaxResults(4);
		List<Refer> result = query.list();
		session.close();
		return result;
	}
}
