package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.data.ScheduleList;
import org.bluepigeon.admin.data.SchedulePOJO;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;

public class ScheduleAPIDAO {
	public ScheduleList getScheduleDetails(String pancard,int projectId){
		ScheduleList scheduleList = new ScheduleList();
		String hql = "select a.id as id, a.milestone as milestone, a.net_payable as netPayable, a.amount as amount, a.is_paid as isPaid, DATE_FORMAT(a.paied_date,'%d/%m/%Y') as paieddate, d.flat_no as flatNo from buyer_payment as a join buyer as b on b.id=a.buyer_id join builder_project as c on c.id=b.project_id join builder_flat as d on d.id=b.flat_id where b.pancard='"+pancard+"' and b.is_primary=1 and b.is_deleted=0 and c.id="+projectId;
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(SchedulePOJO.class));
		List<SchedulePOJO> result = query.list();
		scheduleList.setSchedule(result);
		session.close();
		return scheduleList;
	}
}
