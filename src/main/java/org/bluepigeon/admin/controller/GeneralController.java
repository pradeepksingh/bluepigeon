package org.bluepigeon.admin.controller;

import java.util.List;

import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.AreaUnitDAO;
import org.bluepigeon.admin.dao.CityNamesImp;
import org.bluepigeon.admin.dao.CountryDAOImp;
import org.bluepigeon.admin.dao.HomeLoanBanksDAO;
import org.bluepigeon.admin.dao.LocalityNamesImp;
import org.bluepigeon.admin.dao.StateImp;
import org.bluepigeon.admin.data.CityData;
import org.bluepigeon.admin.data.LocalityData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.HomeLoanBanks;
import org.bluepigeon.admin.model.Locality;
import org.bluepigeon.admin.model.State;
import org.bluepigeon.admin.service.CityNamesService;

@Path("general")
public class GeneralController {

	@POST
	@Path("/area/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage saveAreaUnit(@FormParam("name") String name, @FormParam("status") byte status) {

		AreaUnit areaUnit = new AreaUnit();
		areaUnit.setName(name);
		areaUnit.setStatus(status);
		AreaUnitDAO areaUnitDAOImpl = new AreaUnitDAO();
		return areaUnitDAOImpl.save(areaUnit);
	}

	@POST
	@Path("/area/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateAraeUnit(@FormParam("id") Short id, @FormParam("name") String name,
			@FormParam("status") byte status) {

		AreaUnit areaUnit = new AreaUnit();
		areaUnit.setId(id);
		areaUnit.setName(name);
		areaUnit.setStatus(status);

		AreaUnitDAO areaUnitDAOImpl = new AreaUnitDAO();
		return areaUnitDAOImpl.update(areaUnit);
	}

	@DELETE
	@Path("/area/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteAreaUnit(@FormParam("id") Short id) {

		byte isDeleted = 1;
		AreaUnit areaUnit = new AreaUnit();
		areaUnit.setId(id);
		areaUnit.setIsDeleted(isDeleted);
		AreaUnitDAO areaUnitDAOImpl = new AreaUnitDAO();
		return areaUnitDAOImpl.delete(areaUnit);
	}

	@POST
	@Path("/country/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage save(@FormParam("name") String name, @FormParam("status") byte status,
			@FormParam("sortOrder") int sortOrder) {

		Country country = new Country();
		country.setName(name);
		country.setStatus(status);
		country.setSortOrder(sortOrder);
		CountryDAOImp countryService = new CountryDAOImp();
		return countryService.save(country);
	}

	@POST
	@Path("/country/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateCountry(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("sortOrder") int sortOrder, @FormParam("status") byte status) {

		Country country = new Country();
		country.setId(id);
		country.setName(name);
		country.setSortOrder(sortOrder);
		country.setStatus(status);

		CountryDAOImp countryService = new CountryDAOImp();
		return countryService.update(country);
	}

	@DELETE
	@Path("/country/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteCountry(@FormParam("id") int id) {

		Country country = new Country();
		country.setId(id);

		CountryDAOImp countryService = new CountryDAOImp();
		return countryService.delete(country);
	}

	@POST
	@Path("/state/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addState(@FormParam("name") String name, @FormParam("country_id") int countryId,
			@FormParam("status") byte status, @FormParam("sortOrder") int sortOrder) {

		Country country = new Country();
		country.setId(countryId);
		State state = new State();
		state.setName(name);
		state.setCountry(country);
		state.setSortOrder(sortOrder);
		state.setStatus(status);
		StateImp stateImp = new StateImp();
		return stateImp.save(state);
	}

	@POST
	@Path("/state/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateState(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("country_id") int countryId, @FormParam("sortOrder") int sortOrder,
			@FormParam("status") byte status) {
		Country country = new Country();
		country.setId(countryId);
		State state = new State();
		state.setId(id);
		state.setName(name);
		state.setCountry(country);
		state.setSortOrder(sortOrder);
		state.setStatus(status);
		StateImp stateImp = new StateImp();
		return stateImp.update(state);
	}

	@GET
	@Path("/state/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<State> addState(@QueryParam("country_id") int country_id) {
		StateImp stateImp = new StateImp();
		return stateImp.getStateByCountryId(country_id);
	}
	
	@GET
	@Path("/city/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<CityData> cityList(@QueryParam("state_id") int state_id) {
		CityNamesImp cityImp = new CityNamesImp();
		return cityImp.getCityByStateId(state_id);
	}

	@POST
	@Path("/locality/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addLocality(@FormParam("name") String name, @FormParam("city_id") int cityId,
			@FormParam("sortorder") byte sortOrder, @FormParam("status") Integer status,
			@FormParam("latitude") String latitude, @FormParam("longitude") String longitude) {
		City city = new City();
		city.setId(cityId);
		Locality locality = new Locality();
		locality.setName(name);
		locality.setCity(city);
		locality.setSortOrder(sortOrder);
		locality.setStatus(status);
		locality.setLongitude(longitude);
		locality.setLatitude(latitude);
		LocalityNamesImp localityNamesImp = new LocalityNamesImp();
		return localityNamesImp.save(locality);
	}

	@POST
	@Path("/locality/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateLocality(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("city_id") int cityId, @FormParam("sortorder") byte sortOrder,
			@FormParam("status") Integer status, @FormParam("latitude") String latitude,
			@FormParam("longitude") String longitude) {
		City city = new City();
		city.setId(cityId);
		Locality locality = new Locality();
		locality.setId(id);
		locality.setName(name);
		locality.setCity(city);
		locality.setSortOrder(sortOrder);
		locality.setStatus(status);
		locality.setLongitude(longitude);
		locality.setLatitude(latitude);
		LocalityNamesImp localityNamesImp = new LocalityNamesImp();
		return localityNamesImp.update(locality);
	}

	@GET
	@Path("/cities")
	@Produces(MediaType.APPLICATION_JSON)
	public List<City> getAllCity() {
		CityNamesService cityNamesService = new CityNamesService();
		System.out.print("Test : ,," + cityNamesService.getAllCityNames());
		return cityNamesService.getAllCityNames();
	}

	@GET
	@Path("/city/{state_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<CityData> getCityByState(@PathParam("state_id") int tehsil_id) {

		return new CityNamesImp().getCityByStateId(tehsil_id);
	}

	@GET
	@Path("/locality/{city_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<LocalityData> getLocalityByCity(@PathParam("city_id") int city_id) {
		return new LocalityNamesImp().getLocalityName(city_id);
	}
	
}
