package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.data.PayableList;
import org.bluepigeon.admin.data.PayablePOJO;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;

public class PayableListDAO {

	public PayableList getReferEarnProjectId(String pancard,int projectId){
		PayableList payableList = new PayableList();
		String hql = "select DATE_FORMAT(a.booking_date,'%d/%m/%Y') as bookingDate, a.base_rate as baseRate,a.floor_rise_rate as floorRiseRate, a.post as post, a.amenity_facing_rate as amenityFacingRate, a.parking_rate as parkingRate,a.maintenance as maintenance,a.tenure as tenure,a.stamp_duty as stampDuty,a.taxes as taxes, a.vat as vat, a.total_cost as totalCost ,d.flat_no as flatNo, d.id as flatId from buying_details as a join buyer as b on b.id=a.buyer_id join builder_project as c on c.id=b.project_id join builder_flat as d on d.id=b.flat_id where b.pancard='"+pancard+"' and b.is_primary=1 and c.id="+projectId+" AND b.is_deleted=0 GROUP by a.id order by a.id DESC";
		HibernateUtil hibernateUtil = new HibernateUtil();
		Session session = hibernateUtil.getSessionFactory().openSession();
		Query query = session.createSQLQuery(hql).setResultTransformer(Transformers.aliasToBean(PayablePOJO.class));
		List<PayablePOJO> result = query.list();
		payableList.setPayable(result);
		session.close();
		return payableList;
	}
}
