package org.bluepigeon.admin.controller;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.AreaUnitDAO;
import org.bluepigeon.admin.dao.CityNamesImp;
import org.bluepigeon.admin.dao.CountryDAOImp;
import org.bluepigeon.admin.dao.HomeLoanBanksDAO;
import org.bluepigeon.admin.dao.LocalityNamesImp;
import org.bluepigeon.admin.dao.ProjectDAO;
import org.bluepigeon.admin.dao.StateImp;
import org.bluepigeon.admin.data.CityData;
import org.bluepigeon.admin.data.LocalityData;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.data.TaxLabels;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.model.BankLogo;
import org.bluepigeon.admin.model.BuilderLogo;
import org.bluepigeon.admin.model.BuildingAmenityIcon;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.HomeLoanBanks;
import org.bluepigeon.admin.model.Locality;
import org.bluepigeon.admin.model.State;
import org.bluepigeon.admin.service.CityNamesService;
import org.bluepigeon.admin.service.ImageUploader;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

@Path("general")
public class GeneralController {

	@Context ServletContext context;
	ImageUploader imageUploader = new ImageUploader();
	
	@POST
	@Path("/area/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage saveAreaUnit(@FormParam("name") String name, @FormParam("sqft_value") Double sqft_value,@FormParam("status") byte status) {
		Byte is_deleted = 0;
		AreaUnit areaUnit = new AreaUnit();
		areaUnit.setName(name);
		areaUnit.setSqft_value(sqft_value);
		areaUnit.setStatus(status);
		areaUnit.setIsDeleted(is_deleted);
		AreaUnitDAO areaUnitDAOImpl = new AreaUnitDAO();
		return areaUnitDAOImpl.save(areaUnit);
	}
	

	@POST
	@Path("/area/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateAraeUnit(
			@FormParam("id") Short id, 
			@FormParam("name") String name,
			@FormParam("sqft_value") Double sqft_value,
			@FormParam("status") byte status
	) {
		Byte is_deleted = 0;
		AreaUnit areaUnit = new AreaUnit();
		areaUnit.setId(id);
		areaUnit.setName(name);
		areaUnit.setSqft_value(sqft_value);
		areaUnit.setStatus(status);
		areaUnit.setIsDeleted(is_deleted);
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
	public ResponseMessage save(
			@FormParam("name") String name,
			@FormParam("tax1") String taxLabel1,
			@FormParam("tax2") String taxLabel2,
			@FormParam("tax3") String taxLabel3,
			@FormParam("status") byte status,
			@FormParam("sortOrder") int sortOrder) {

		Country country = new Country();
		country.setName(name);
		country.setTaxLabel1(taxLabel1);
		country.setTaxLabel2(taxLabel2);
		country.setTaxLabel3(taxLabel3);
		country.setStatus(status);
		country.setSortOrder(sortOrder);
		CountryDAOImp countryService = new CountryDAOImp();
		return countryService.save(country);
	}

	@POST
	@Path("/country/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateCountry(
			@FormParam("id") int id, 
			@FormParam("name") String name,
			@FormParam("tax1") String taxLabel1,
			@FormParam("tax2") String taxLabel2,
			@FormParam("tax3") String taxLabel3,
			@FormParam("sortOrder") int sortOrder,
			@FormParam("status") byte status) {

		Country country = new Country();
		country.setId(id);
		country.setName(name);
		country.setTaxLabel1(taxLabel1);
		country.setTaxLabel2(taxLabel2);
		country.setTaxLabel3(taxLabel3);
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
		return stateImp.getActiveStateByCountryId(country_id);
	}
	
	@GET
	@Path("/city/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<CityData> cityList(@QueryParam("state_id") int state_id) {
		CityNamesImp cityImp = new CityNamesImp();
		return cityImp.getCityByStateId(state_id);
	}
	
	@POST
	@Path("/city/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addCity(@FormParam("name") String name, @FormParam("state_id") int stateId,
			@FormParam("sortorder") int sortOrder, @FormParam("status") byte status
	) {
		State state = new State();
		state.setId(stateId);
		City city = new City();
		city.setName(name);
		city.setState(state);
		city.setStatus(status);
		CityNamesImp cityNamesImp = new CityNamesImp();
		return cityNamesImp.save(city);
	}
	
	@POST
	@Path("/city/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addCity(@FormParam("id") int id,@FormParam("name") String name, @FormParam("state_id") int stateId,
			@FormParam("sortorder") int sortOrder, @FormParam("status") byte status
	) {
		State state = new State();
		state.setId(stateId);
		City city = new City();
		city.setId(id);
		city.setName(name);
		city.setState(state);
		city.setStatus(status);
		CityNamesImp cityNamesImp = new CityNamesImp();
		return cityNamesImp.update(city);
	}
	
	@GET
	@Path("/locality/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Locality> getLocality(@QueryParam("city_id") int city_id) {
		
		LocalityNamesImp localityNamesImp= new LocalityNamesImp();
		System.out.println("City id :: "+city_id);
		return localityNamesImp.getLocalityByCityId(city_id);
	}
	
	@GET
	@Path("/locality/list/name")
	@Produces(MediaType.APPLICATION_JSON)
	public List<LocalityData> getLocalityNames(@QueryParam("city_id") int city_id) {
		
		ProjectDAO projectDAO = new ProjectDAO();
		return projectDAO.getLocalityNames(city_id);
		//return localityNamesImp.getLocalityByCityId(city_id);
	}
	@POST
	@Path("/locality/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addLocality(@FormParam("name") String name, @FormParam("city_id") int cityId,
			@FormParam("sortorder") byte sortOrder, @FormParam("status") Integer sstatus,
			@FormParam("latitude") String latitude, @FormParam("longitude") String longitude) {
		boolean status = false;
		if(sstatus==1){
			status=true;
		}
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
			@FormParam("status") Integer sstatus, @FormParam("latitude") String latitude,
			@FormParam("longitude") String longitude) {
		boolean status=false;
		if(sstatus==1){
			status=true;
		}
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
		//return null;
	}
	/**************************** Home Loan Banks *************************************/
	@POST
	@Path("/bank/save/")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addHomeLoanBanks(
			@FormDataParam("name") String name, 
			@FormDataParam("location") String location,
			@FormDataParam("email") String email,
			@FormDataParam("contact_name") String contactPerson,
			@FormDataParam("phone") String phone,
			@FormDataParam("status") byte status,
			@FormDataParam("bank_logo[]")List<FormDataBodyPart> bank_logos) {
		ResponseMessage responseMessage = new ResponseMessage();
		HomeLoanBanks homeLoanBanks = new HomeLoanBanks();
		homeLoanBanks.setName(name);
		homeLoanBanks.setLocation(location);
		homeLoanBanks.setEmail(email);
		homeLoanBanks.setContactPerson(contactPerson);
		homeLoanBanks.setPhone(phone);
		homeLoanBanks.setStatus(status);
	
		HomeLoanBanksDAO homeLoanBanksDAO = new HomeLoanBanksDAO();
		responseMessage = homeLoanBanksDAO.save(homeLoanBanks);
		if(responseMessage.getId() > 0){
			homeLoanBanks.setId(responseMessage.getId());
			try {	
				List<BankLogo> bankLogoList = new ArrayList<BankLogo>();
				//for multiple inserting images.
				if (bank_logos.size() > 0) {
					for(int i=0 ;i < bank_logos.size();i++)
					{
						if(bank_logos.get(i).getFormDataContentDisposition().getFileName() != null && !bank_logos.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
							BankLogo bankLogo = new BankLogo();
							String gallery_name = bank_logos.get(i).getFormDataContentDisposition().getFileName();
							long millis = System.currentTimeMillis() % 1000;
							gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
							gallery_name = "images/project/bank/logo/"+gallery_name;
							String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
							//System.out.println("for loop image path: "+uploadGalleryLocation);
							this.imageUploader.writeToFile(bank_logos.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
							bankLogo.setHomeLoanBanks(homeLoanBanks);
							bankLogo.setLogoUrl(gallery_name);
							bankLogoList.add(bankLogo);
						}
					}
					if(bankLogoList.size() > 0) {
						homeLoanBanksDAO.saveBankLogo(bankLogoList);
					}
				}
				responseMessage.setStatus(1);
				responseMessage.setMessage("Bank Details added successfully");
			} catch(Exception e) {
				e.printStackTrace();
				responseMessage.setStatus(0);
				responseMessage.setMessage("Unable to save image");
			}
		}else{
			responseMessage.setStatus(0);
			responseMessage.setMessage("Fail to save bank details");
		}
		return responseMessage;
	}
	
	@POST
	@Path("/bank/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateHomeLoanBanks(
			@FormDataParam("ubank_id") int bankId,
			@FormDataParam("uname") String name,
			@FormDataParam("ulocation") String location,
			@FormDataParam("uemail") String email,
			@FormDataParam("ucontact_name") String contactPerson,
			@FormDataParam("uphone") String phone,
			@FormDataParam("ustatus") byte status,
			@FormDataParam("bank_logo_id[]")List<FormDataBodyPart> logo_ids,
			@FormDataParam("bank_logo[]")List<FormDataBodyPart> bank_logos) {
		ResponseMessage responseMessage = new ResponseMessage();
		HomeLoanBanks homeLoanBanks = new HomeLoanBanks();
		homeLoanBanks.setId(bankId);
		homeLoanBanks.setName(name);
		homeLoanBanks.setLocation(location);
		homeLoanBanks.setStatus(status);
		homeLoanBanks.setEmail(email);
		homeLoanBanks.setContactPerson(contactPerson);
		homeLoanBanks.setPhone(phone);
	
		HomeLoanBanksDAO homeLoanBanksDAO = new HomeLoanBanksDAO();
		homeLoanBanksDAO.update(homeLoanBanks);
		if(bank_logos.size() > 0){
			try {	
				List<BankLogo> updateBankLogos = new ArrayList<BankLogo>();
				List<BankLogo> saveBankLogos = new ArrayList<BankLogo>();
				//for multiple inserting images.
				//if (builder_logo.size() > 0) {
					for(int j=0 ;j < bank_logos.size();j++)
					{
						if(logo_ids != null){
						if(bank_logos.get(j).getFormDataContentDisposition().getFileName() != null && !bank_logos.get(j).getFormDataContentDisposition().getFileName().isEmpty()) {
							if(logo_ids.get(j).getValueAs(Integer.class) != 0 && logo_ids.get(j).getValueAs(Integer.class) != null){
								System.out.println("Inside if condition");
								BankLogo bankLogo = new BankLogo();
								String gallery_name = bank_logos.get(j).getFormDataContentDisposition().getFileName();
								long millis = System.currentTimeMillis() % 1000;
								gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
								gallery_name = "images/project/bank/logo/"+gallery_name;
								String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
								//System.out.println("for loop image path update: "+uploadGalleryLocation);
								this.imageUploader.writeToFile(bank_logos.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
								bankLogo.setId(logo_ids.get(j).getValueAs(Integer.class));
								bankLogo.setLogoUrl(gallery_name);
								bankLogo.setHomeLoanBanks(homeLoanBanks);
								updateBankLogos.add(bankLogo);
							}}}else{
								BankLogo bankLogo = new BankLogo();
								String gallery_name = bank_logos.get(j).getFormDataContentDisposition().getFileName();
								long millis = System.currentTimeMillis() % 1000;
								gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
								gallery_name = "images/project/bank/logo/"+gallery_name;
								String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
								System.out.println("for loop image path add: "+uploadGalleryLocation);
								this.imageUploader.writeToFile(bank_logos.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
								bankLogo.setLogoUrl(gallery_name);
								bankLogo.setHomeLoanBanks(homeLoanBanks);
								saveBankLogos.add(bankLogo);
							}
					}
					if(updateBankLogos.size() > 0) {
						homeLoanBanksDAO.updateBankLogo(updateBankLogos);
					}
					if(saveBankLogos.size() > 0){
						homeLoanBanksDAO.saveBankLogo(saveBankLogos);
					}
				}
			 catch(Exception e) {
				 //System.out.println("Error "+e.getMessage());
				 //e.printStackTrace();
				responseMessage.setStatus(0);
				responseMessage.setMessage("Unable to save image");
			}
			responseMessage.setStatus(1);
			responseMessage.setMessage("Bank Details updated successfully.");
		}else{
			responseMessage.setStatus(0);
			responseMessage.setMessage("Fail to update Bank details");
		}
		return responseMessage;
		
	}
	
	@POST
	@Path("/changeLabel")
	@Produces(MediaType.APPLICATION_JSON)
	public TaxLabels changeTaxLabel(@FormParam("country_id") int countryId) {
		return new CountryDAOImp().getTaxLabels(countryId);
	}
	
	@POST
	@Path("/uchangeLabel")
	@Produces(MediaType.APPLICATION_JSON)
	public TaxLabels updatechangeTaxLabel(@FormParam("country_id") int countryId) {
		return new CountryDAOImp().getTaxLabels(countryId);
	}
	
//	@GET
//	@Path("/project/list/name")
//	@Produces(MediaType.APPLICATION_JSON)
//	public List<ProjectData> getProjectNames(@QueryParam("locality_name") String localityName,@QueryParam("emp_id") int empId,@QueryParam("access_id") int accessId) {
//		
//		ProjectDAO projectDAO = new ProjectDAO();
//		return projectDAO.getProjectNames(localityName,empId,accessId);
//	}
	
	@POST
	@Path("/project/list/name")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectData> getProjectNamesByEmpIds(
			@FormParam("locality_name") String localityName, 
			@FormParam("emp_id") int empId,
			@FormParam("access_id") int accessId){
		ProjectDAO projectDAO = new ProjectDAO();
		return projectDAO.getProjectNames(localityName,empId,accessId);
	}
}
