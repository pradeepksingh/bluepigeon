package org.bluepigeon.admin.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
  
public class HibernateUtil {
  
    private static final SessionFactory sessionFactory = buildSessionFactory();
  
    
	@SuppressWarnings("deprecation")
	private static SessionFactory buildSessionFactory() {
        try {
            // Create the SessionFactory from hibernate.cfg.xml
            return new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            // Make sure you log the exception, as it might be swallowed
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
  
    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }
  
    public void shutdown() {
        // Close caches and connection pools
        getSessionFactory().close();
    }
    
    public Session openSession(){
    	return getSessionFactory().openSession();
    }
  
}