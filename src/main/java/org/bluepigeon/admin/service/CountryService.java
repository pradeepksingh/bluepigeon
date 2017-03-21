package org.bluepigeon.admin.service;

import java.util.List;

import org.bluepigeon.admin.dao.CountryDAOImp;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Country;

public class CountryService {

	public ResponseMessage save(Country country)
	{
		CountryDAOImp countryDAOImp = new CountryDAOImp();
		return countryDAOImp.save(country);
		
	}
	public List<Country> getCountryList()
	{
		CountryDAOImp countryDAOImp = new CountryDAOImp();
		
		return countryDAOImp.getCountryList();
	}
}
