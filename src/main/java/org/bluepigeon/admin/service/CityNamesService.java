package org.bluepigeon.admin.service;

import java.util.List;

import org.bluepigeon.admin.dao.CityNamesImp;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.City;

public class CityNamesService  {

	public ResponseMessage addCity(City city)
	{
		CityNamesImp cityNamesImp = new CityNamesImp();
		
		return cityNamesImp.save(city);
	}
	
	public ResponseMessage updateCity(City city)
	{
		CityNamesImp cityNamesImp = new CityNamesImp();
		
		return cityNamesImp.update(city);
	}
	
	public List<City> getAllCityNames() {
		CityNamesImp cityNamesImp = new CityNamesImp();
		return cityNamesImp.getCityNames();
	}
	
	public List<City> getAllCityNamesByStateId(int stateId) {
		CityNamesImp cityNamesImp = new CityNamesImp();
		return cityNamesImp.getCityNamesByStateId(stateId);
	}
	
	public List<City> getCityDetailById(int id) {
		CityNamesImp cityNamesImp = new CityNamesImp();
		return cityNamesImp.getCityById(id);
	}

}
