package org.bluepigeon.admin.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.BuilderDetailsDAO;
import org.bluepigeon.admin.dao.ProjectDAO;
import org.bluepigeon.admin.data.ProjectDetail;
import org.bluepigeon.admin.data.ProjectList;
import org.bluepigeon.admin.data.ProjectOffer;
import org.bluepigeon.admin.data.ProjectPaymentSchedule;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderLead;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuilderProjectPriceInfo;
import org.bluepigeon.admin.model.BuilderProjectProjectType;
import org.bluepigeon.admin.model.BuilderPropertyType;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.Locality;
import org.bluepigeon.admin.model.State;
@Path("project")
public class ProjectController {
	@GET
	@Path("/list/{builder_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderCompanyNames> getCompanyName(@PathParam("builder_id") int builder_id) {
		BuilderDetailsDAO builderBuildingAmenityDAO = new BuilderDetailsDAO();
		return builderBuildingAmenityDAO.getBuilderCompanyNameList(builder_id);
	}
	
	@POST
	@Path("/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectList> getBuilderProjects(
			@FormParam("builder_id") int builder_id, 
			@FormParam("company_id") int company_id,
			@FormParam("project_name") String project_name,
			@FormParam("country_id") int country_id,
			@FormParam("state_id") int state_id,
			@FormParam("city_id") int city_id
	) {
		List<ProjectList> project_list = new ProjectDAO().getBuilderProjects(builder_id,company_id,project_name,country_id,state_id,city_id);
		return project_list;
	}
	
	@POST
	@Path("/add")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addProject(
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
			@FormParam("admin_id") int admin_id
	) {
		Byte status = 1;
		Short unit = 1;
		AdminUser adminUser = new AdminUser();
		adminUser.setId(admin_id);
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
		builderProject.setProjectArea(0.0);
		builderProject.setStatus(status);
		builderProject.setAreaUnit(areaUnit);
		builderProject.setAdminUser(adminUser);
		ResponseMessage resp = new ProjectDAO().saveProject(builderProject); 
		return resp;
	}
	
	@POST
	@Path("/basic/update")
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
	
	@POST
	@Path("/detail/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseMessage updateProjectDetails(ProjectDetail projectDetail) {
		ResponseMessage resp = new ProjectDAO().updateDetailInfo(projectDetail); 
		return resp;
	}
	
	@POST
	@Path("/price/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateProjectPriceInfo (
			@FormParam("id") int id,
			@FormParam("project_id") int project_id,
			@FormParam("base_rate") Double basePrice, 
			@FormParam("rise_rate") Double riseRate,
			@FormParam("parking") Double parking,
			@FormParam("post") int post,
			@FormParam("maintenance") Double maintenance,
			@FormParam("tenure") Integer tenure,
			@FormParam("amenity_rate") Double amenityRate,
			@FormParam("stamp_duty") Double stampDuty,
			@FormParam("tax") Double tax,
			@FormParam("vat") Double vat,
			@FormParam("tech_fee") Double fee,
			@FormParam("base_unit") Short base_unit
	) {
		BuilderProject builderProject = new BuilderProject();
		builderProject.setId(project_id);
		AreaUnit areaUnit = new AreaUnit();
		areaUnit.setId(base_unit);
		
		BuilderProjectPriceInfo builderProjectPriceInfo = new BuilderProjectPriceInfo();
		builderProjectPriceInfo.setId(id);
		builderProjectPriceInfo.setBuilderProject(builderProject);
		builderProjectPriceInfo.setBasePrice(basePrice);
		builderProjectPriceInfo.setRiseRate(riseRate);
		builderProjectPriceInfo.setParking(parking);
		builderProjectPriceInfo.setPost(post);
		builderProjectPriceInfo.setMaintenance(maintenance);
		builderProjectPriceInfo.setTenure(tenure);
		builderProjectPriceInfo.setAmenityRate(amenityRate);
		builderProjectPriceInfo.setStampDuty(stampDuty);
		builderProjectPriceInfo.setTax(tax);
		builderProjectPriceInfo.setVat(vat);
		builderProjectPriceInfo.setFee(fee);
		builderProject.setAreaUnit(areaUnit);
		ResponseMessage resp = new ProjectDAO().updatePriceInfo(builderProjectPriceInfo); 
		return resp;
	}
	
	@POST
	@Path("/payment/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseMessage updateProjectPayment(ProjectPaymentSchedule projectPaymentSchedule) {
		ResponseMessage resp = new ProjectDAO().updatePaymentInfo(projectPaymentSchedule); 
		return resp;
	}
	
	@POST
	@Path("/offer/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseMessage updateProjectOffer(ProjectOffer projectOffer) {
		ResponseMessage resp = new ProjectDAO().updateOfferInfo(projectOffer); 
		return resp;
	}
	
	/* *************** Project buildings ************** */
	
	@GET
	@Path("/building/names/{project_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderBuilding> getProjectBuildingNames(@PathParam("project_id") int project_id) {
		ProjectDAO projectDAO = new ProjectDAO();
		List<BuilderBuilding> buildings = projectDAO.getBuilderProjectBuildings(project_id);
		List<BuilderBuilding> newbuildings = new ArrayList<BuilderBuilding>();
		for(BuilderBuilding builderBuilding :buildings) {
			BuilderBuilding building = new BuilderBuilding();
			building.setId(builderBuilding.getId());
			building.setName(builderBuilding.getName());
			newbuildings.add(building);
		}
		return newbuildings;
	}
	
	@GET
	@Path("/building/flat/names/{building_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderFlat> getProjectBuildingFlatNames(@PathParam("building_id") int building_id) {
		ProjectDAO projectDAO = new ProjectDAO();
		List<BuilderFlat> flats = projectDAO.getBuilderProjectBuildingFlats(building_id);
		List<BuilderFlat> newflats = new ArrayList<BuilderFlat>();
		for(BuilderFlat builderFlat :flats) {
			BuilderFlat flat = new BuilderFlat();
			flat.setId(builderFlat.getId());
			flat.setFlatNo(builderFlat.getFlatNo());
			newflats.add(flat);
		}
		return newflats;
	}
	
	
	/* ********* Project Leads ************** */
	
	@POST
	@Path("/lead/add")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addProjectLead (
			@FormParam("project_id") int project_id,
			@FormParam("building_id") int building_id, 
			@FormParam("flat_id") int flat_id,
			@FormParam("name") String name,
			@FormParam("mobile") String mobile,
			@FormParam("email") String email,
			@FormParam("city") String city,
			@FormParam("area") String area,
			@FormParam("source") int source,
			@FormParam("discount_offered") String discount_offered,
			@FormParam("interest") int interest,
			@FormParam("type_id") int type_id,
			@FormParam("status") int status,
			@FormParam("added_by") int added_by
	) {
		BuilderProject builderProject = new BuilderProject();
		builderProject.setId(project_id);
		
		BuilderLead builderLead = new BuilderLead();
		builderLead.setBuilderProject(builderProject);
		if(building_id > 0) {
			BuilderBuilding builderBuilding = new BuilderBuilding();
			builderBuilding.setId(building_id);
			builderLead.setBuilderBuilding(builderBuilding);
		}
		if(flat_id > 0) {
			BuilderFlat builderFlat = new BuilderFlat();
			builderFlat.setId(flat_id);
			builderLead.setBuilderFlat(builderFlat);
		}
		if(type_id>0){
			BuilderPropertyType builderPropertyType = new BuilderPropertyType();
			builderPropertyType.setId(type_id);
			builderLead.setBuilderPropertyType(builderPropertyType);
		}
		
		builderLead.setName(name);
		builderLead.setMobile(mobile);
		builderLead.setEmail(email);
		builderLead.setArea(area);
		builderLead.setSource(source);
		builderLead.setCity(city);
		builderLead.setDiscountOffered(discount_offered);
		builderLead.setIntrestedIn(interest);
		builderLead.setStatus(status);
		builderLead.setAddedBy(added_by);
		ResponseMessage resp = new ProjectDAO().addProjectLead(builderLead); 
		return resp;
	}
	
	@POST
	@Path("/lead/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateProjectLead (
			@FormParam("lead_id") int lead_id,
			@FormParam("project_id") int project_id,
			@FormParam("building_id") int building_id, 
			@FormParam("flat_id") int flat_id,
			@FormParam("name") String name,
			@FormParam("mobile") String mobile,
			@FormParam("email") String email,
			@FormParam("city") String city,
			@FormParam("area") String area,
			@FormParam("source") int source,
			@FormParam("discount_offered") String discount_offered,
			@FormParam("interest") int interest,
			@FormParam("type_id") int type_id,
			@FormParam("status") int status,
			@FormParam("added_by") int added_by
	) {
		BuilderProject builderProject = new BuilderProject();
		builderProject.setId(project_id);
		
		BuilderLead builderLead = new BuilderLead();
		builderLead.setBuilderProject(builderProject);
		if(building_id > 0) {
			BuilderBuilding builderBuilding = new BuilderBuilding();
			builderBuilding.setId(building_id);
			builderLead.setBuilderBuilding(builderBuilding);
		}
		if(flat_id > 0) {
			BuilderFlat builderFlat = new BuilderFlat();
			builderFlat.setId(flat_id);
			builderLead.setBuilderFlat(builderFlat);
		}
		if(type_id>0){
			BuilderPropertyType builderPropertyType = new BuilderPropertyType();
			builderPropertyType.setId(type_id);
			builderLead.setBuilderPropertyType(builderPropertyType);
		}
		
		builderLead.setId(lead_id);
		builderLead.setName(name);
		builderLead.setMobile(mobile);
		builderLead.setEmail(email);
		builderLead.setArea(area);
		builderLead.setCity(city);
		builderLead.setSource(source);
		builderLead.setDiscountOffered(discount_offered);
		builderLead.setIntrestedIn(interest);
		builderLead.setStatus(status);
		builderLead.setAddedBy(added_by);
		ResponseMessage resp = new ProjectDAO().updateProjectLead(builderLead);
		return resp;
	}
}
