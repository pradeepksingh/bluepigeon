package org.bluepigeon.admin.service;

import java.util.List;

import org.bluepigeon.admin.dao.LocalityNamesImp;
import org.bluepigeon.admin.model.Locality;

public class LocalityService  {

	
	public List<Locality> getLocalityName(int city) {
		LocalityNamesImp localityNamesImp = new LocalityNamesImp();
		return localityNamesImp.getLocalityNames(city);
	}

}
