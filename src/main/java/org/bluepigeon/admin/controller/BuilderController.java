package org.bluepigeon.admin.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.CityNamesImp;
import org.bluepigeon.admin.dao.LocalityNamesImp;
import org.bluepigeon.admin.dao.ProjectDAO;
import org.bluepigeon.admin.dao.StateImp;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.Locality;
import org.bluepigeon.admin.model.State;
import org.bluepigeon.admin.service.ImageUploader;

@Path("builder/")
public class BuilderController {

	@Context ServletContext context;
	ImageUploader imageUploader = new ImageUploader();
	@POST
	@Path("/new")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseMessage newProject(
			@FormParam("builder_id") int builder_id, 
			@FormParam("name") String name,
			@FormParam("locality_id") int locality_id
	) {
		
		System.err.println("Hi builder");
		System.err.println("Builder id "+builder_id);
		System.err.println("name "+name);
		System.err.println("locality_id : "+locality_id);
		Byte status = 1;
		Short unit = 1;
		int stateId = 0;
		int cityId = 0;
		int countryId = 0;
		Builder builder = new Builder();
		builder.setId(builder_id);
		Locality locality = new Locality();
		BuilderProject builderProject = new BuilderProject();
		locality.setId(locality_id);
		if(locality_id > 0){
			City city = new City(); 
			Locality localities = new LocalityNamesImp().getCityById(locality_id);
			cityId = localities.getCity().getId();
			city.setId(cityId);
		}
		if(cityId > 0){
			State state = new State();
			List<City> city = new CityNamesImp().getCityById(cityId);
			stateId = city.get(0).getState().getId();
			state.setId(stateId);
			builderProject.setState(state);
		}
		if(stateId > 0){
			Country country = new Country();
			List<State> state_list = new StateImp().getStateById(stateId);
			countryId = state_list.get(0).getCountry().getId();
			country.setId(countryId);
			builderProject.setCountry(country);
		}
		BuilderCompanyNames builderCompanyNames = new BuilderCompanyNames();
		builderProject.setBuilderCompanyNames(builderCompanyNames);
		AreaUnit areaUnit = new AreaUnit();
		areaUnit.setId(unit);
		AdminUser adminUser =new AdminUser();
		builderProject.setAdminUser(adminUser);
		builderProject.setName(name);
		builderProject.setBuilder(builder);
		builderProject.setLocality(locality);
		builderProject.setProjectArea(0.0);
		builderProject.setStatus(status);
		builderProject.setAreaUnit(areaUnit);
		ResponseMessage resp = new ProjectDAO().saveProject(builderProject); 
		return resp;
	}
	
	@POST
	@Path("/project/basic/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateProjectBasicInfo (
			@FormParam("id") int id,
			@FormParam("builder_id") int builder_id, 
			@FormParam("company_id") int company_id,
			@FormParam("name") String name,
			@FormParam("sublocation") String sublocation,
			@FormParam("landmark") String landmark,
			@FormParam("country_id") int country_id,
			@FormParam("state_id") int state_id,
			@FormParam("city_id") int city_id,
			@FormParam("locality_id") int locality_id,
			@FormParam("pincode") String pincode,
			@FormParam("latitude") String latitude,
			@FormParam("longitude") String longitude,
			@FormParam("description") String description,
			@FormParam("highlight") String highlights,
			@FormParam("status") Byte status
	) {
		Short unit = 1;
		Builder builder = new Builder();
		builder.setId(builder_id);
		BuilderCompanyNames builderCompanyNames = new BuilderCompanyNames();
		builderCompanyNames.setId(company_id);
		Country country = new Country();
		country.setId(country_id);
		State state = new State();
		state.setId(state_id);
		City city = new City();
		city.setId(city_id);
		Locality locality = new Locality();
		locality.setId(locality_id);
		AreaUnit areaUnit = new AreaUnit();
		areaUnit.setId(unit);
		BuilderProject builderProject = new BuilderProject();
		builderProject.setId(id);;
		builderProject.setName(name);
		builderProject.setBuilder(builder);
		builderProject.setBuilderCompanyNames(builderCompanyNames);
		builderProject.setAddr1(landmark);
		builderProject.setAddr2(sublocation);
		builderProject.setCountry(country);
		builderProject.setState(state);
		builderProject.setCity(city);
		builderProject.setLocality(locality);
		builderProject.setPincode(pincode);
		builderProject.setLatitude(latitude);
		builderProject.setLongitude(longitude);
		builderProject.setDescription(description);
		builderProject.setHighlights(highlights);
		builderProject.setStatus(status);
		builderProject.setAreaUnit(areaUnit);
		ResponseMessage resp = new ProjectDAO().updateBasicInfo(builderProject); 
		return resp;
	}
	

}
