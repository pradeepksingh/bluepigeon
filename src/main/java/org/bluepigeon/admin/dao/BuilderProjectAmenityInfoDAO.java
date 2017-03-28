package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.model.BuilderProjectAmenityInfo;
import org.bluepigeon.admin.model.BuilderProjectAmenitySubstages;
import org.bluepigeon.admin.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

public class BuilderProjectAmenityInfoDAO {

	public List<BuilderProjectAmenityInfo> getBuilderProjectAmenityInfo(int project_id)
    {
        String hql = "from BuilderProjectAmenityInfo where builderProject.id = :id";
        HibernateUtil hibernateUtil = new HibernateUtil();
        Session session = hibernateUtil.openSession();
        Query query = session.createQuery(hql);
        query.setParameter("id", project_id);
        List<BuilderProjectAmenityInfo> result = query.list();
        session.close();
        return result;
    }
}
