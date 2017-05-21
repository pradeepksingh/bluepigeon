package org.bluepigeon.admin.controller;

import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.BuilderCompanyDAO;
import org.bluepigeon.admin.dao.BuilderDetailsDAO;
import org.bluepigeon.admin.dao.BuyerDAO;
import org.bluepigeon.admin.dao.CityNamesImp;
import org.bluepigeon.admin.dao.LocalityNamesImp;
import org.bluepigeon.admin.dao.ProjectDAO;
import org.bluepigeon.admin.dao.StateImp;
import org.bluepigeon.admin.data.BuildingList;
import org.bluepigeon.admin.data.FloorData;
import org.bluepigeon.admin.data.LocalityData;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.data.ProjectDetail;
import org.bluepigeon.admin.data.ProjectList;
import org.bluepigeon.admin.data.ProjectOffer;
import org.bluepigeon.admin.data.ProjectPaymentSchedule;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderBuildingAmenity;
import org.bluepigeon.admin.model.BuilderBuildingAmenityStages;
import org.bluepigeon.admin.model.BuilderBuildingAmenitySubstages;
import org.bluepigeon.admin.model.BuilderBuildingFlatType;
import org.bluepigeon.admin.model.BuilderBuildingFlatTypeRoom;
import org.bluepigeon.admin.model.BuilderBuildingStatus;
import org.bluepigeon.admin.model.BuilderCompany;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFlatAmenity;
import org.bluepigeon.admin.model.BuilderFlatAmenityStages;
import org.bluepigeon.admin.model.BuilderFlatAmenitySubstages;
import org.bluepigeon.admin.model.BuilderFlatStatus;
import org.bluepigeon.admin.model.BuilderFlatType;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderFloorAmenity;
import org.bluepigeon.admin.model.BuilderFloorAmenityStages;
import org.bluepigeon.admin.model.BuilderFloorAmenitySubstages;
import org.bluepigeon.admin.model.BuilderFloorStatus;
import org.bluepigeon.admin.model.BuilderLead;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuilderProjectPriceInfo;
import org.bluepigeon.admin.model.BuilderProjectProjectType;
import org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration;
import org.bluepigeon.admin.model.BuildingAmenityInfo;
import org.bluepigeon.admin.model.BuildingAmenityWeightage;
import org.bluepigeon.admin.model.BuildingImageGallery;
import org.bluepigeon.admin.model.BuildingOfferInfo;
import org.bluepigeon.admin.model.BuildingPanoramicImage;
import org.bluepigeon.admin.model.BuildingPaymentInfo;
import org.bluepigeon.admin.model.BuilderPropertyType;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.FlatAmenityInfo;
import org.bluepigeon.admin.model.FlatAmenityWeightage;
import org.bluepigeon.admin.model.FlatImageGallery;
import org.bluepigeon.admin.model.FlatPanoramicImage;
import org.bluepigeon.admin.model.FlatPaymentSchedule;
import org.bluepigeon.admin.model.FlatTypeImage;
import org.bluepigeon.admin.model.FloorAmenityInfo;
import org.bluepigeon.admin.model.FloorAmenityWeightage;
import org.bluepigeon.admin.model.FloorImageGallery;
import org.bluepigeon.admin.model.FloorLayoutImage;
import org.bluepigeon.admin.model.FloorPanoramicImage;
import org.bluepigeon.admin.model.Locality;
import org.bluepigeon.admin.model.ProjectAmenityWeightage;
import org.bluepigeon.admin.model.ProjectImageGallery;
import org.bluepigeon.admin.model.ProjectPanoramicImage;
import org.bluepigeon.admin.model.State;
import org.bluepigeon.admin.service.ImageUploader;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.glassfish.jersey.server.ResourceConfig;
@Path("project")
public class ProjectController extends ResourceConfig {
	@Context ServletContext context;
	ImageUploader imageUploader = new ImageUploader();
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
		builderProjectPriceInfo.setAreaUnit(areaUnit);
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
	
	@GET
	@Path("/image/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteProjectImage(@PathParam("id") int imgae_id) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteProjectImage(imgae_id);
		return msg;
	}
	
	@GET
	@Path("/elevationimage/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteProjectElevationImage(@PathParam("id") int imgae_id) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteProjectElevationImage(imgae_id);
		return msg;
	}
	
	@POST
	@Path("/status/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuildingInfo (
			@FormDataParam("project_id") int project_id,
			@FormDataParam("substagewt_id[]") List<FormDataBodyPart> substagewt_id,
			@FormDataParam("project_image[]") List<FormDataBodyPart> project_images,
			@FormDataParam("elevation_image[]") List<FormDataBodyPart> elevation_images,
			@FormDataParam("admin_id") int admin_id
	) {
		Boolean bstatus = true;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderProject builderProject = new BuilderProject();
		builderProject.setId(project_id);
		List<ProjectAmenityWeightage> projectAmenityWeightages = new ArrayList<ProjectAmenityWeightage>();
		for(int i=0 ;i < substagewt_id.size();i++) {
			ProjectAmenityWeightage baw = new ProjectAmenityWeightage();
			baw.setId(substagewt_id.get(i).getValueAs(Integer.class));
			baw.setStatus(bstatus);
			projectAmenityWeightages.add(baw);
		}
		if(projectAmenityWeightages.size() > 0) {
			msg = projectDAO.updateProjectAmenityWeightage(projectAmenityWeightages, project_id);
		}
		
		try {	
			List<ProjectImageGallery> projectImageGalleries = new ArrayList<ProjectImageGallery>();
			//for multiple inserting images.
			if (project_images.size() > 0) {
				for(int i=0 ;i < project_images.size();i++)
				{
					if(project_images.get(i).getFormDataContentDisposition().getFileName() != null && !project_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						ProjectImageGallery projectImageGallery = new ProjectImageGallery();
						String gallery_name = project_images.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/images/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						//System.out.println("for loop image path: "+uploadGalleryLocation);
						this.imageUploader.writeToFile(project_images.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						projectImageGallery.setImage(gallery_name);
						projectImageGallery.setTitle("New Image");
						projectImageGallery.setBuilderProject(builderProject);
						projectImageGalleries.add(projectImageGallery);
					}
				}
				if(projectImageGalleries.size() > 0) {
					projectDAO.addProjectImageGallery(projectImageGalleries);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to save image");
		}
		//add elevation images
		try {	
			List<ProjectPanoramicImage> projectPanoramicImages = new ArrayList<ProjectPanoramicImage>();
			//for multiple inserting images.
			if (elevation_images.size() > 0) {
				for(int i=0 ;i < elevation_images.size();i++)
				{
					if(elevation_images.get(i).getFormDataContentDisposition().getFileName() != null && !elevation_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						System.out.println("Image:"+elevation_images.get(i).getFormDataContentDisposition().getFileName());
						ProjectPanoramicImage projectPanoramicImage = new ProjectPanoramicImage();
						String elv_name = elevation_images.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						elv_name = Long.toString(millis) + elv_name.replaceAll(" ", "_").toLowerCase();
						elv_name = "images/project/elevation/"+elv_name;
						String uploadElevationLocation = this.context.getInitParameter("building_elevation_url")+elv_name;
						//System.out.println("for loop image path: "+uploadElevationLocation);
						this.imageUploader.writeToFile(elevation_images.get(i).getValueAs(InputStream.class), uploadElevationLocation);
						projectPanoramicImage.setPanoImage(elv_name);
						projectPanoramicImage.setTitle("New Image");
						projectPanoramicImage.setBuilderProject(builderProject);
						projectPanoramicImages.add(projectPanoramicImage);
					}
				}
				if(projectPanoramicImages.size() > 0) {
					projectDAO.addProjectPanoImage(projectPanoramicImages);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to save image");
		}
		
		msg.setMessage("Updated successfully.");
		msg.setStatus(1);
		return msg;
	}
	
	/* *************** Project buildings ************** */
	
	@POST
	@Path("/building/add")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuildingInfo (
			@FormDataParam("project_id") int project_id,
			@FormDataParam("name") String name, 
			@FormDataParam("total_floor") int total_floor,
			@FormDataParam("building_image[]") List<FormDataBodyPart> building_images,
			@FormDataParam("elevation_image[]") List<FormDataBodyPart> elevation_images,
			@FormDataParam("launch_date") String launch_date,
			@FormDataParam("possession_date") String possession_date,
			@FormDataParam("status") Integer status,
			@FormDataParam("amenity_type[]") List<FormDataBodyPart> amenity_type,
			@FormDataParam("schedule[]") List<FormDataBodyPart> schedule,
			@FormDataParam("payable[]") List<FormDataBodyPart> payable,
			@FormDataParam("amount[]") List<FormDataBodyPart> amount,
			@FormDataParam("offer_title[]") List<FormDataBodyPart> offer_title,
			@FormDataParam("discount[]") List<FormDataBodyPart> discount,
			@FormDataParam("discount_amount[]") List<FormDataBodyPart> discount_amount,
			@FormDataParam("description[]") List<FormDataBodyPart> description,
			@FormDataParam("offer_type[]") List<FormDataBodyPart> offer_type,
			@FormDataParam("offer_status[]") List<FormDataBodyPart> offer_status,
			@FormDataParam("admin_id") int admin_id,
			@FormDataParam("amenity_wt") String amenity_wts
	) {
		String [] amenityWeightages = amenity_wts.split(",");
		List<BuildingAmenityWeightage> baws = new ArrayList<BuildingAmenityWeightage>();
		SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
		Date launchDate = null,possessionDate = null;
		try {
			launchDate = format.parse(launch_date);
			possessionDate = format.parse(possession_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		byte bstatus = 1;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderProject builderProject = new BuilderProject();
		builderProject.setId(project_id);
		BuilderBuildingStatus builderBuildingStatus = new BuilderBuildingStatus();
		builderBuildingStatus.setId(status);
		AdminUser adminUser = new AdminUser();
		adminUser.setId(admin_id);
		BuilderBuilding builderBuilding = new BuilderBuilding();
		builderBuilding.setBuilderProject(builderProject);
		builderBuilding.setName(name);
		builderBuilding.setTotalFloor(total_floor);
		builderBuilding.setLaunchDate(launchDate);
		builderBuilding.setPossessionDate(possessionDate);
		builderBuilding.setAdminUser(adminUser);
		builderBuilding.setBuilderBuildingStatus(builderBuildingStatus);
		builderBuilding.setStatus(bstatus);
		builderBuilding.setInventorySold(0.0);
		builderBuilding.setRevenue(0.0);
		builderBuilding.setTotalInventory(0.0);
		msg = projectDAO.addBuilding(builderBuilding);
		if(msg.getId() > 0) {
			builderBuilding.setId(msg.getId());
			//add gallery images
			try {	
				List<BuildingImageGallery> buildingImageGalleries = new ArrayList<BuildingImageGallery>();
				//for multiple inserting images.
				if (building_images.size() > 0) {
					for(int i=0 ;i < building_images.size();i++)
					{
						if(building_images.get(i).getFormDataContentDisposition().getFileName() != null && !building_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
							BuildingImageGallery buildingImageGallery = new BuildingImageGallery();
							String gallery_name = building_images.get(i).getFormDataContentDisposition().getFileName();
							long millis = System.currentTimeMillis() % 1000;
							gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
							gallery_name = "images/project/building/images/"+gallery_name;
							String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
							//System.out.println("for loop image path: "+uploadGalleryLocation);
							this.imageUploader.writeToFile(building_images.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
							buildingImageGallery.setImage(gallery_name);
							buildingImageGallery.setTitle("New Image");
							buildingImageGallery.setBuilderBuilding(builderBuilding);
							buildingImageGalleries.add(buildingImageGallery);
						}
					}
					if(buildingImageGalleries.size() > 0) {
						projectDAO.addBuildingImageGallery(buildingImageGalleries);
					}
				}
			} catch(Exception e) {
				msg.setStatus(0);
				msg.setMessage("Unable to save image");
			}
			//add elevation images
			try {	
				List<BuildingPanoramicImage> buildingPanoramicImages = new ArrayList<BuildingPanoramicImage>();
				//for multiple inserting images.
				if (elevation_images.size() > 0) {
					for(int i=0 ;i < elevation_images.size();i++)
					{
						if(elevation_images.get(i).getFormDataContentDisposition().getFileName() != null && !elevation_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
							System.out.println("Image:"+elevation_images.get(i).getFormDataContentDisposition().getFileName());
							BuildingPanoramicImage buildingPanoramicImage = new BuildingPanoramicImage();
							String elv_name = elevation_images.get(i).getFormDataContentDisposition().getFileName();
							long millis = System.currentTimeMillis() % 1000;
							elv_name = Long.toString(millis) + elv_name.replaceAll(" ", "_").toLowerCase();
							elv_name = "images/project/building/elevation/"+elv_name;
							String uploadElevationLocation = this.context.getInitParameter("building_elevation_url")+elv_name;
							//System.out.println("for loop image path: "+uploadElevationLocation);
							this.imageUploader.writeToFile(elevation_images.get(i).getValueAs(InputStream.class), uploadElevationLocation);
							buildingPanoramicImage.setPanoImage(elv_name);
							buildingPanoramicImage.setTitle("New Image");
							buildingPanoramicImage.setBuilderBuilding(builderBuilding);
							buildingPanoramicImages.add(buildingPanoramicImage);
						}
					}
					if(buildingPanoramicImages.size() > 0) {
						projectDAO.addBuildingPanoImage(buildingPanoramicImages);
					}
				}
			} catch(Exception e) {
				msg.setStatus(0);
				msg.setMessage("Unable to save image");
			}
			if (amenity_type.size() > 0) {
				List<BuildingAmenityInfo> buildingAmenityInfos = new ArrayList<BuildingAmenityInfo>();
				int i = 0;
				for(FormDataBodyPart amenity : amenity_type)
				{
					if(amenity.getValueAs(Integer.class) != null && amenity.getValueAs(Integer.class) != 0) {
						Byte milestone_status = 0;
						BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
						builderBuildingAmenity.setId(amenity.getValueAs(Integer.class));
						BuildingAmenityInfo amenityInfo = new BuildingAmenityInfo();
						amenityInfo.setBuilderBuildingAmenity(builderBuildingAmenity);
						amenityInfo.setBuilderBuilding(builderBuilding);
						buildingAmenityInfos.add(amenityInfo);
					}
					i++;
				}
				if(buildingAmenityInfos.size() > 0) {
					projectDAO.addBuildingAmenityInfo(buildingAmenityInfos);
				}
			}
			if(amenity_wts != "") {
				for(String aw :amenityWeightages) {
					BuildingAmenityWeightage baw = new BuildingAmenityWeightage();
					String [] amenityWeightage = aw.split("#");
					Integer amenity_id = Integer.parseInt(amenityWeightage[0]);
					Double amenity_weightage = Double.parseDouble(amenityWeightage[1]);
					Integer stage_id = Integer.parseInt(amenityWeightage[2]);
					Double stage_weightage = Double.parseDouble(amenityWeightage[3]);
					Integer substage_id = Integer.parseInt(amenityWeightage[4]);
					Double substage_weightage = Double.parseDouble(amenityWeightage[5]);
					Boolean wstatus = Boolean.parseBoolean(amenityWeightage[6]);
					BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
					builderBuildingAmenity.setId(amenity_id);
					BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();
					builderBuildingAmenityStages.setId(stage_id);
					BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages = new BuilderBuildingAmenitySubstages();
					builderBuildingAmenitySubstages.setId(substage_id);
					baw.setBuilderBuildingAmenity(builderBuildingAmenity);
					baw.setAmenityWeightage(amenity_weightage);
					baw.setBuilderBuildingAmenityStages(builderBuildingAmenityStages);
					baw.setStageWeightage(stage_weightage);
					baw.setBuilderBuildingAmenitySubstages(builderBuildingAmenitySubstages);
					baw.setSubstageWeightage(substage_weightage);
					baw.setStatus(wstatus);
					baw.setBuilderBuilding(builderBuilding);
					baws.add(baw);
				}
				projectDAO.addBuildingAmenityWeightage(baws);
			}
			if (schedule.size() > 0) {
				List<BuildingPaymentInfo> buildingPaymentInfos = new ArrayList<BuildingPaymentInfo>();
				int i = 0;
				for(FormDataBodyPart milestone : schedule)
				{
					if(milestone.getValueAs(String.class).toString() != null && !milestone.getValueAs(String.class).toString().isEmpty()) {
						Byte milestone_status = 0;
						BuildingPaymentInfo buildingPaymentInfo = new BuildingPaymentInfo();
						buildingPaymentInfo.setMilestone(milestone.getValueAs(String.class).toString());
						buildingPaymentInfo.setPayable(payable.get(i).getValueAs(Double.class));
						buildingPaymentInfo.setAmount(amount.get(i).getValueAs(Double.class));
						buildingPaymentInfo.setStatus(milestone_status);
						buildingPaymentInfo.setBuilderBuilding(builderBuilding);
						buildingPaymentInfos.add(buildingPaymentInfo);
					}
					i++;
				}
				if(buildingPaymentInfos.size() > 0) {
					projectDAO.addBuildingPaymentInfo(buildingPaymentInfos);
				}
			}
			
			if (offer_title.size() > 0) {
				List<BuildingOfferInfo> buildingOfferInfos = new ArrayList<BuildingOfferInfo>();
				int i = 0;
				for(FormDataBodyPart title : offer_title)
				{
					if(title.getValueAs(String.class).toString() != null && !title.getValueAs(String.class).toString().isEmpty()) {
						BuildingOfferInfo buildingOfferInfo = new BuildingOfferInfo();
						buildingOfferInfo.setTitle(title.getValueAs(String.class).toString());
						buildingOfferInfo.setAmount(discount_amount.get(i).getValueAs(Double.class));
						buildingOfferInfo.setDiscount(discount.get(i).getValueAs(Double.class));
						buildingOfferInfo.setDescription(description.get(i).getValueAs(String.class).toString());
						buildingOfferInfo.setType(offer_type.get(i).getValueAs(Byte.class));
						buildingOfferInfo.setStatus(offer_status.get(i).getValueAs(Byte.class));
						buildingOfferInfo.setBuilderBuilding(builderBuilding);
						buildingOfferInfos.add(buildingOfferInfo);
					}
					i++;
				}
				if(buildingOfferInfos.size() > 0) {
					projectDAO.addBuildingOfferInfo(buildingOfferInfos);
				}
			}
		} else {
			msg.setMessage("Failed to add building.");
			msg.setStatus(0);
		}
		return msg;
	}
	
	@POST
	@Path("/building/info/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuildingInfo (
			@FormDataParam("project_id") int project_id,
			@FormDataParam("building_id") int building_id,
			@FormDataParam("name") String name, 
			@FormDataParam("total_floor") int total_floor,
			@FormDataParam("launch_date") String launch_date,
			@FormDataParam("possession_date") String possession_date,
			@FormDataParam("status") Integer status,
			@FormDataParam("amenity_type[]") List<FormDataBodyPart> amenity_type,
			@FormDataParam("admin_id") int admin_id,
			@FormDataParam("amenity_wt") String amenity_wts
	) {
		String [] amenityWeightages = amenity_wts.split(",");
		List<BuildingAmenityWeightage> baws = new ArrayList<BuildingAmenityWeightage>();
		SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
		Date launchDate = null,possessionDate = null;
		try {
			launchDate = format.parse(launch_date);
			possessionDate = format.parse(possession_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		byte bstatus = 1;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderProject builderProject = new BuilderProject();
		builderProject.setId(project_id);
		BuilderBuildingStatus builderBuildingStatus = new BuilderBuildingStatus();
		builderBuildingStatus.setId(status);
		AdminUser adminUser = new AdminUser();
		adminUser.setId(admin_id);
		BuilderBuilding builderBuilding = new ProjectDAO().getBuilderProjectBuildingById(building_id).get(0);
		builderBuilding.setId(building_id);
		builderBuilding.setName(name);
		builderBuilding.setTotalFloor(total_floor);
		builderBuilding.setLaunchDate(launchDate);
		builderBuilding.setPossessionDate(possessionDate);
		builderBuilding.setAdminUser(adminUser);
		builderBuilding.setBuilderBuildingStatus(builderBuildingStatus);
		builderBuilding.setStatus(bstatus);
		msg = projectDAO.updateBuilding(builderBuilding);
		if(msg.getId() > 0) {
			if (amenity_type.size() > 0) {
				List<BuildingAmenityInfo> buildingAmenityInfos = new ArrayList<BuildingAmenityInfo>();
				int i = 0;
				for(FormDataBodyPart amenity : amenity_type)
				{
					if(amenity.getValueAs(Integer.class) != null && amenity.getValueAs(Integer.class) != 0) {
						Byte milestone_status = 0;
						BuildingAmenityInfo amenityInfo = new BuildingAmenityInfo();
						BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
						builderBuildingAmenity.setId(amenity.getValueAs(Integer.class));
						amenityInfo.setBuilderBuildingAmenity(builderBuildingAmenity);
						amenityInfo.setBuilderBuilding(builderBuilding);
						buildingAmenityInfos.add(amenityInfo);
					}
					i++;
				}
				if(buildingAmenityInfos.size() > 0) {
					projectDAO.deleteBuildingAmenityInfo(building_id);
					projectDAO.addBuildingAmenityInfo(buildingAmenityInfos);
				}
			}
			if(amenity_wts != "") {
				for(String aw :amenityWeightages) {
					BuildingAmenityWeightage baw = new BuildingAmenityWeightage();
					String [] amenityWeightage = aw.split("#");
					Integer amenity_id = Integer.parseInt(amenityWeightage[0]);
					Double amenity_weightage = Double.parseDouble(amenityWeightage[1]);
					Integer stage_id = Integer.parseInt(amenityWeightage[2]);
					Double stage_weightage = Double.parseDouble(amenityWeightage[3]);
					Integer substage_id = Integer.parseInt(amenityWeightage[4]);
					Double substage_weightage = Double.parseDouble(amenityWeightage[5]);
					Boolean wstatus = Boolean.parseBoolean(amenityWeightage[6]);
					BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
					builderBuildingAmenity.setId(amenity_id);
					BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();
					builderBuildingAmenityStages.setId(stage_id);
					BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages = new BuilderBuildingAmenitySubstages();
					builderBuildingAmenitySubstages.setId(substage_id);
					baw.setBuilderBuildingAmenity(builderBuildingAmenity);
					baw.setAmenityWeightage(amenity_weightage);
					baw.setBuilderBuildingAmenityStages(builderBuildingAmenityStages);
					baw.setStageWeightage(stage_weightage);
					baw.setBuilderBuildingAmenitySubstages(builderBuildingAmenitySubstages);
					baw.setSubstageWeightage(substage_weightage);
					baw.setStatus(wstatus);
					baw.setBuilderBuilding(builderBuilding);
					baws.add(baw);
				}
				projectDAO.deleteBuildingAmenityWeightage(building_id);
				projectDAO.addBuildingAmenityWeightage(baws);
			}
		} else {
			msg.setMessage("Failed to update building info.");
			msg.setStatus(0);
		}
		return msg;
	}
	
	@POST
	@Path("/building/images/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuildingImages (
			@FormDataParam("building_id") int building_id,
			@FormDataParam("building_image[]") List<FormDataBodyPart> building_images,
			@FormDataParam("elevation_image[]") List<FormDataBodyPart> elevation_images
	) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderBuilding builderBuilding = new BuilderBuilding();
		builderBuilding.setId(building_id);
		//add gallery images
		try {	
			List<BuildingImageGallery> buildingImageGalleries = new ArrayList<BuildingImageGallery>();
			//for multiple inserting images.
			if (building_images.size() > 0) {
				for(int i=0 ;i < building_images.size();i++)
				{
					if(building_images.get(i).getFormDataContentDisposition().getFileName() != null && !building_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						BuildingImageGallery buildingImageGallery = new BuildingImageGallery();
						String gallery_name = building_images.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/building/images/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						//System.out.println("for loop image path: "+uploadGalleryLocation);
						this.imageUploader.writeToFile(building_images.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						buildingImageGallery.setImage(gallery_name);
						buildingImageGallery.setTitle("New Image");
						buildingImageGallery.setBuilderBuilding(builderBuilding);
						buildingImageGalleries.add(buildingImageGallery);
					}
				}
				if(buildingImageGalleries.size() > 0) {
					projectDAO.addBuildingImageGallery(buildingImageGalleries);
				}
			}
			msg.setStatus(1);
			msg.setMessage("Builing images updated successfully.");
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to save images");
		}
		//add elevation images
		try {	
			List<BuildingPanoramicImage> buildingPanoramicImages = new ArrayList<BuildingPanoramicImage>();
			//for multiple inserting images.
			if (elevation_images.size() > 0) {
				for(int i=0 ;i < elevation_images.size();i++)
				{
					if(elevation_images.get(i).getFormDataContentDisposition().getFileName() != null && !elevation_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						System.out.println("Image:"+elevation_images.get(i).getFormDataContentDisposition().getFileName());
						BuildingPanoramicImage buildingPanoramicImage = new BuildingPanoramicImage();
						String elv_name = elevation_images.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						elv_name = Long.toString(millis) + elv_name.replaceAll(" ", "_").toLowerCase();
						elv_name = "images/project/building/elevation/"+elv_name;
						String uploadElevationLocation = this.context.getInitParameter("building_elevation_url")+elv_name;
						//System.out.println("for loop image path: "+uploadElevationLocation);
						this.imageUploader.writeToFile(elevation_images.get(i).getValueAs(InputStream.class), uploadElevationLocation);
						buildingPanoramicImage.setPanoImage(elv_name);
						buildingPanoramicImage.setTitle("New Image");
						buildingPanoramicImage.setBuilderBuilding(builderBuilding);
						buildingPanoramicImages.add(buildingPanoramicImage);
					}
				}
				if(buildingPanoramicImages.size() > 0) {
					projectDAO.addBuildingPanoImage(buildingPanoramicImages);
				}
			}
			msg.setStatus(1);
			msg.setMessage("Builing images updated successfully.");
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to save images");
		}
		return msg;
	}
	
	@POST
	@Path("/building/payment/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuildingInfo (
			@FormDataParam("building_id") int building_id,
			@FormDataParam("payment_id[]") List<FormDataBodyPart> payment_id,
			@FormDataParam("schedule[]") List<FormDataBodyPart> schedule,
			@FormDataParam("payable[]") List<FormDataBodyPart> payable,
			@FormDataParam("amount[]") List<FormDataBodyPart> amount
	) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderBuilding builderBuilding = new BuilderBuilding();
		builderBuilding.setId(building_id);
		if (schedule.size() > 0) {
			List<BuildingPaymentInfo> buildingPaymentInfos = new ArrayList<BuildingPaymentInfo>();
			List<BuildingPaymentInfo> newBuildingPaymentInfos = new ArrayList<BuildingPaymentInfo>();
			int i = 0;
			for(FormDataBodyPart milestone : schedule)
			{
				if(milestone.getValueAs(String.class).toString() != null && !milestone.getValueAs(String.class).toString().isEmpty()) {
					if(payment_id.get(i).getValueAs(Integer.class) != 0 && payment_id.get(i).getValueAs(Integer.class) != null) {
						Byte milestone_status = 0;
						BuildingPaymentInfo buildingPaymentInfo = new BuildingPaymentInfo();
						buildingPaymentInfo.setId(payment_id.get(i).getValueAs(Integer.class));
						buildingPaymentInfo.setMilestone(milestone.getValueAs(String.class).toString());
						buildingPaymentInfo.setPayable(payable.get(i).getValueAs(Double.class));
						buildingPaymentInfo.setAmount(amount.get(i).getValueAs(Double.class));
						buildingPaymentInfo.setStatus(milestone_status);
						buildingPaymentInfo.setBuilderBuilding(builderBuilding);
						buildingPaymentInfos.add(buildingPaymentInfo);
					} else {
						Byte milestone_status = 0;
						BuildingPaymentInfo buildingPaymentInfo = new BuildingPaymentInfo();
						buildingPaymentInfo.setMilestone(milestone.getValueAs(String.class).toString());
						buildingPaymentInfo.setPayable(payable.get(i).getValueAs(Double.class));
						buildingPaymentInfo.setAmount(amount.get(i).getValueAs(Double.class));
						buildingPaymentInfo.setStatus(milestone_status);
						buildingPaymentInfo.setBuilderBuilding(builderBuilding);
						newBuildingPaymentInfos.add(buildingPaymentInfo);
					}
				}
				i++;
			}
			if(buildingPaymentInfos.size() > 0) {
				projectDAO.updateBuildingPaymentInfo(buildingPaymentInfos);
			}
			if(newBuildingPaymentInfos.size() > 0) {
				projectDAO.addBuildingPaymentInfo(newBuildingPaymentInfos);
			}
			msg.setStatus(1);
			msg.setMessage("Builing payment updated successfully.");
		} else {
			msg.setMessage("Failed to add building.");
			msg.setStatus(0);
		}
		return msg;
	}
	
	@POST
	@Path("/building/offer/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuildingInfo (
			@FormDataParam("building_id") int building_id,
			@FormDataParam("offer_id[]") List<FormDataBodyPart> offer_id,
			@FormDataParam("offer_title[]") List<FormDataBodyPart> offer_title,
			@FormDataParam("discount[]") List<FormDataBodyPart> discount,
			@FormDataParam("discount_amount[]") List<FormDataBodyPart> discount_amount,
			@FormDataParam("description[]") List<FormDataBodyPart> description,
			@FormDataParam("offer_type[]") List<FormDataBodyPart> offer_type,
			@FormDataParam("offer_status[]") List<FormDataBodyPart> offer_status
	) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderBuilding builderBuilding = new BuilderBuilding();
		builderBuilding.setId(building_id);
		if (offer_title.size() > 0) {
			List<BuildingOfferInfo> newBuildingOfferInfos = new ArrayList<BuildingOfferInfo>();
			List<BuildingOfferInfo> buildingOfferInfos = new ArrayList<BuildingOfferInfo>();
			int i = 0;
			for(FormDataBodyPart title : offer_title)
			{
				if(title.getValueAs(String.class).toString() != null && !title.getValueAs(String.class).toString().isEmpty()) {
					if(offer_id.get(i).getValueAs(Integer.class) != 0 && offer_id.get(i).getValueAs(Integer.class) != null) {
						BuildingOfferInfo buildingOfferInfo = new BuildingOfferInfo();
						buildingOfferInfo.setId(offer_id.get(i).getValueAs(Integer.class));
						buildingOfferInfo.setTitle(title.getValueAs(String.class).toString());
						buildingOfferInfo.setAmount(discount_amount.get(i).getValueAs(Double.class));
						buildingOfferInfo.setDiscount(discount.get(i).getValueAs(Double.class));
						buildingOfferInfo.setDescription(description.get(i).getValueAs(String.class).toString());
						buildingOfferInfo.setType(offer_type.get(i).getValueAs(Byte.class));
						buildingOfferInfo.setStatus(offer_status.get(i).getValueAs(Byte.class));
						buildingOfferInfo.setBuilderBuilding(builderBuilding);
						buildingOfferInfos.add(buildingOfferInfo);
					} else {
						BuildingOfferInfo buildingOfferInfo = new BuildingOfferInfo();
						buildingOfferInfo.setTitle(title.getValueAs(String.class).toString());
						buildingOfferInfo.setAmount(discount_amount.get(i).getValueAs(Double.class));
						buildingOfferInfo.setDiscount(discount.get(i).getValueAs(Double.class));
						buildingOfferInfo.setDescription(description.get(i).getValueAs(String.class).toString());
						buildingOfferInfo.setType(offer_type.get(i).getValueAs(Byte.class));
						buildingOfferInfo.setStatus(offer_status.get(i).getValueAs(Byte.class));
						buildingOfferInfo.setBuilderBuilding(builderBuilding);
						newBuildingOfferInfos.add(buildingOfferInfo);
					}
				}
				i++;
			}
			if(buildingOfferInfos.size() > 0) {
				projectDAO.updateBuildingOfferInfo(buildingOfferInfos);
			}
			if(newBuildingOfferInfos.size() > 0) {
				projectDAO.addBuildingOfferInfo(newBuildingOfferInfos);
			}
			msg.setStatus(1);
			msg.setMessage("Builing offer updated successfully.");
		} else {
			msg.setMessage("Failed to update building offers.");
			msg.setStatus(0);
		}
		return msg;
	}
	
	@GET
	@Path("/building/image/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuildingImage(@PathParam("id") int imgae_id) {
		System.out.println("Image ID : "+imgae_id);
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteBuildingImage(imgae_id);
		return msg;
	}
	
	@GET
	@Path("/building/elevationimage/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuildingElevationImage(@PathParam("id") int imgae_id) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteBuildingElevationImage(imgae_id);
		return msg;
	}
	
	@GET
	@Path("/building/payment/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuildingPaymentInfo(@PathParam("id") int id) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteBuildingPaymentInfo(id);
		return msg;
	}
	
	@GET
	@Path("/building/offer/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuildingOfferInfo(@PathParam("id") int id) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteBuildingOfferInfo(id);
		return msg;
	}
	
	@GET
	@Path("/offer/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteProjectOfferInfo(@PathParam("id") int id) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteProjectOfferInfo(id);
		return msg;
	}
	
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
	
	@POST
	@Path("/building/status/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuildingStatus (
			@FormDataParam("building_id") int building_id,
			@FormDataParam("substagewt_id[]") List<FormDataBodyPart> substagewt_id,
			@FormDataParam("building_image[]") List<FormDataBodyPart> building_images,
			@FormDataParam("elevation_image[]") List<FormDataBodyPart> elevation_images,
			@FormDataParam("admin_id") int admin_id
	) {
		Boolean bstatus = true;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderBuilding builderBuilding = new BuilderBuilding();
		builderBuilding.setId(building_id);
		List<BuildingAmenityWeightage> buildingAmenityWeightages = new ArrayList<BuildingAmenityWeightage>();
		for(int i=0 ;i < substagewt_id.size();i++) {
			BuildingAmenityWeightage baw = new BuildingAmenityWeightage();
			baw.setId(substagewt_id.get(i).getValueAs(Integer.class));
			baw.setStatus(bstatus);
			buildingAmenityWeightages.add(baw);
		}
		if(buildingAmenityWeightages.size() > 0) {
			msg = projectDAO.updateBuildingAmenityWeightage(buildingAmenityWeightages, building_id);
		}
		
		try {	
			List<BuildingImageGallery> buildingImageGalleries = new ArrayList<BuildingImageGallery>();
			//for multiple inserting images.
			if (building_images.size() > 0) {
				for(int i=0 ;i < building_images.size();i++)
				{
					if(building_images.get(i).getFormDataContentDisposition().getFileName() != null && !building_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						BuildingImageGallery buildingImageGallery = new BuildingImageGallery();
						String gallery_name = building_images.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/building/images/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						//System.out.println("for loop image path: "+uploadGalleryLocation);
						this.imageUploader.writeToFile(building_images.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						buildingImageGallery.setImage(gallery_name);
						buildingImageGallery.setTitle("New Image");
						buildingImageGallery.setBuilderBuilding(builderBuilding);
						buildingImageGalleries.add(buildingImageGallery);
					}
				}
				if(buildingImageGalleries.size() > 0) {
					projectDAO.addBuildingImageGallery(buildingImageGalleries);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to save image");
		}
		//add elevation images
		try {	
			List<BuildingPanoramicImage> buildingPanoramicImages = new ArrayList<BuildingPanoramicImage>();
			//for multiple inserting images.
			if (elevation_images.size() > 0) {
				for(int i=0 ;i < elevation_images.size();i++)
				{
					if(elevation_images.get(i).getFormDataContentDisposition().getFileName() != null && !elevation_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						System.out.println("Image:"+elevation_images.get(i).getFormDataContentDisposition().getFileName());
						BuildingPanoramicImage buildingPanoramicImage = new BuildingPanoramicImage();
						String elv_name = elevation_images.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						elv_name = Long.toString(millis) + elv_name.replaceAll(" ", "_").toLowerCase();
						elv_name = "images/project/building/elevation/"+elv_name;
						String uploadElevationLocation = this.context.getInitParameter("building_elevation_url")+elv_name;
						//System.out.println("for loop image path: "+uploadElevationLocation);
						this.imageUploader.writeToFile(elevation_images.get(i).getValueAs(InputStream.class), uploadElevationLocation);
						buildingPanoramicImage.setPanoImage(elv_name);
						buildingPanoramicImage.setTitle("New Image");
						buildingPanoramicImage.setBuilderBuilding(builderBuilding);
						buildingPanoramicImages.add(buildingPanoramicImage);
					}
				}
				if(buildingPanoramicImages.size() > 0) {
					projectDAO.addBuildingPanoImage(buildingPanoramicImages);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to save image");
		}
		
		msg.setMessage("Updated successfully.");
		msg.setStatus(1);
		return msg;
	}
	
	
	/* *************** Building Floors ************** */
	
	@POST
	@Path("/building/floor/add")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuildingFloor (
			@FormDataParam("building_id") int building_id,
			@FormDataParam("name") String name, 
			@FormDataParam("floor_no") int floor_no,
			@FormDataParam("total_flats") int total_flats,
			@FormDataParam("status") Integer status,
			@FormDataParam("amenity_type[]") List<FormDataBodyPart> amenity_type,
			@FormDataParam("building_image[]") List<FormDataBodyPart> building_images,
			@FormDataParam("admin_id") int admin_id,
			@FormDataParam("amenity_wt") String amenity_wts
	) {
		String [] amenityWeightages = amenity_wts.split(",");
		List<FloorAmenityWeightage> baws = new ArrayList<FloorAmenityWeightage>();
		byte floor_status = 1;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderFloorStatus builderFloorStatus = new BuilderFloorStatus();
		builderFloorStatus.setId(status);
		AdminUser adminUser = new AdminUser();
		adminUser.setId(admin_id);
		BuilderBuilding builderBuilding = new BuilderBuilding();
		builderBuilding.setId(building_id);
		BuilderFloor builderFloor = new BuilderFloor();
		builderFloor.setBuilderBuilding(builderBuilding);
		builderFloor.setBuilderFloorStatus(builderFloorStatus);
		builderFloor.setFloorNo(floor_no);
		builderFloor.setName(name);
		builderFloor.setTotalFlats(total_flats);
		builderFloor.setStatus(floor_status);
		msg = projectDAO.addBuildingFloor(builderFloor);
		if(msg.getId() > 0) {
			builderFloor.setId(msg.getId());
			//add gallery images
			try {	
				List<FloorLayoutImage> floorLayoutImages = new ArrayList<FloorLayoutImage>();
				//for multiple inserting images.
				if (building_images.size() > 0) {
					for(int i=0 ;i < building_images.size();i++)
					{
						if(building_images.get(i).getFormDataContentDisposition().getFileName() != null && !building_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
							FloorLayoutImage floorLayoutImage = new FloorLayoutImage();
							String gallery_name = building_images.get(i).getFormDataContentDisposition().getFileName();
							long millis = System.currentTimeMillis() % 1000;
							gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
							gallery_name = "images/project/floor/"+gallery_name;
							String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
							//System.out.println("for loop image path: "+uploadGalleryLocation);
							this.imageUploader.writeToFile(building_images.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
							floorLayoutImage.setLayout(gallery_name);
							floorLayoutImage.setTitle("New Plan");
							floorLayoutImage.setBuilderFloor(builderFloor);
							floorLayoutImages.add(floorLayoutImage);
						}
					}
					if(floorLayoutImages.size() > 0) {
						projectDAO.addBuildingFloorPlan(floorLayoutImages);
					}
				}
			} catch(Exception e) {
				msg.setStatus(0);
				msg.setMessage("Unable to save image");
			}
			if (amenity_type.size() > 0) {
				List<FloorAmenityInfo> floorAmenityInfos = new ArrayList<FloorAmenityInfo>();
				int i = 0;
				for(FormDataBodyPart amenity : amenity_type)
				{
					if(amenity.getValueAs(Integer.class) != null && amenity.getValueAs(Integer.class) != 0) {
						Byte milestone_status = 0;
						BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
						builderFloorAmenity.setId(amenity.getValueAs(Integer.class));
						FloorAmenityInfo amenityInfo = new FloorAmenityInfo();
						amenityInfo.setBuilderFloorAmenity(builderFloorAmenity);
						amenityInfo.setBuilderFloor(builderFloor);
						floorAmenityInfos.add(amenityInfo);
					}
					i++;
				}
				if(floorAmenityInfos.size() > 0) {
					projectDAO.addBuildingFloorAmenityInfo(floorAmenityInfos);
				}
			}
			if(amenity_wts != "") {
				for(String aw :amenityWeightages) {
					FloorAmenityWeightage baw = new FloorAmenityWeightage();
					String [] amenityWeightage = aw.split("#");
					Integer amenity_id = Integer.parseInt(amenityWeightage[0]);
					Double amenity_weightage = Double.parseDouble(amenityWeightage[1]);
					Integer stage_id = Integer.parseInt(amenityWeightage[2]);
					Double stage_weightage = Double.parseDouble(amenityWeightage[3]);
					Integer substage_id = Integer.parseInt(amenityWeightage[4]);
					Double substage_weightage = Double.parseDouble(amenityWeightage[5]);
					Boolean wstatus = Boolean.parseBoolean(amenityWeightage[6]);
					BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
					builderFloorAmenity.setId(amenity_id);
					BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
					builderFloorAmenityStages.setId(stage_id);
					BuilderFloorAmenitySubstages builderFloorAmenitySubstages = new BuilderFloorAmenitySubstages();
					builderFloorAmenitySubstages.setId(substage_id);
					baw.setBuilderFloorAmenity(builderFloorAmenity);
					baw.setAmenityWeightage(amenity_weightage);
					baw.setBuilderFloorAmenityStages(builderFloorAmenityStages);
					baw.setStageWeightage(stage_weightage);
					baw.setBuilderFloorAmenitySubstages(builderFloorAmenitySubstages);
					baw.setSubstageWeightage(substage_weightage);
					baw.setStatus(wstatus);
					baw.setBuilderFloor(builderFloor);
					baws.add(baw);
				}
				projectDAO.addFloorAmenityWeightage(baws);
			}
		} else {
			msg.setMessage("Failed to add floor.");
			msg.setStatus(0);
		}
		return msg;
	}
	
	@POST
	@Path("/building/floor/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuildingFloor (
			@FormDataParam("building_id") int building_id,
			@FormDataParam("floor_id") int floor_id,
			@FormDataParam("name") String name, 
			@FormDataParam("floor_no") int floor_no,
			@FormDataParam("total_flats") int total_flats,
			@FormDataParam("status") Integer status,
			@FormDataParam("amenity_type[]") List<FormDataBodyPart> amenity_type,
			@FormDataParam("building_image[]") List<FormDataBodyPart> building_images,
			@FormDataParam("admin_id") int admin_id,
			@FormDataParam("amenity_wt") String amenity_wts
	) {
		String [] amenityWeightages = amenity_wts.split(",");
		List<FloorAmenityWeightage> baws = new ArrayList<FloorAmenityWeightage>();
		byte floor_status = 1;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderFloorStatus builderFloorStatus = new BuilderFloorStatus();
		builderFloorStatus.setId(status);
		AdminUser adminUser = new AdminUser();
		adminUser.setId(admin_id);
		BuilderBuilding builderBuilding = new BuilderBuilding();
		builderBuilding.setId(building_id);
		BuilderFloor builderFloor = new BuilderFloor();
		builderFloor.setId(floor_id);
		builderFloor.setBuilderBuilding(builderBuilding);
		builderFloor.setBuilderFloorStatus(builderFloorStatus);
		builderFloor.setFloorNo(floor_no);
		builderFloor.setName(name);
		builderFloor.setTotalFlats(total_flats);
		builderFloor.setStatus(floor_status);
		msg = projectDAO.updateBuildingFloor(builderFloor);
		if(msg.getId() > 0) {
			//add gallery images
			try {	
				List<FloorLayoutImage> floorLayoutImages = new ArrayList<FloorLayoutImage>();
				//for multiple inserting images.
				if (building_images.size() > 0) {
					for(int i=0 ;i < building_images.size();i++)
					{
						if(building_images.get(i).getFormDataContentDisposition().getFileName() != null && !building_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
							FloorLayoutImage floorLayoutImage = new FloorLayoutImage();
							String gallery_name = building_images.get(i).getFormDataContentDisposition().getFileName();
							long millis = System.currentTimeMillis() % 1000;
							gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
							gallery_name = "images/project/floor/"+gallery_name;
							String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
							//System.out.println("for loop image path: "+uploadGalleryLocation);
							this.imageUploader.writeToFile(building_images.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
							floorLayoutImage.setLayout(gallery_name);
							floorLayoutImage.setTitle("New Plan");
							floorLayoutImage.setBuilderFloor(builderFloor);
							floorLayoutImages.add(floorLayoutImage);
						}
					}
					if(floorLayoutImages.size() > 0) {
						projectDAO.addBuildingFloorPlan(floorLayoutImages);
					}
				}
			} catch(Exception e) {
				msg.setStatus(0);
				msg.setMessage("Unable to save floor plan");
			}
			if (amenity_type.size() > 0) {
				List<FloorAmenityInfo> floorAmenityInfos = new ArrayList<FloorAmenityInfo>();
				int i = 0;
				for(FormDataBodyPart amenity : amenity_type)
				{
					if(amenity.getValueAs(Integer.class) != null && amenity.getValueAs(Integer.class) != 0) {
						Byte milestone_status = 0;
						BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
						builderFloorAmenity.setId(amenity.getValueAs(Integer.class));
						FloorAmenityInfo amenityInfo = new FloorAmenityInfo();
						amenityInfo.setBuilderFloorAmenity(builderFloorAmenity);
						amenityInfo.setBuilderFloor(builderFloor);
						floorAmenityInfos.add(amenityInfo);
					}
					i++;
				}
				if(floorAmenityInfos.size() > 0) {
					projectDAO.deleteFloorAmenityInfo(floor_id);
					projectDAO.addBuildingFloorAmenityInfo(floorAmenityInfos);
				}
			}
			if(amenity_wts != "") {
				for(String aw :amenityWeightages) {
					FloorAmenityWeightage baw = new FloorAmenityWeightage();
					String [] amenityWeightage = aw.split("#");
					Integer amenity_id = Integer.parseInt(amenityWeightage[0]);
					Double amenity_weightage = Double.parseDouble(amenityWeightage[1]);
					Integer stage_id = Integer.parseInt(amenityWeightage[2]);
					Double stage_weightage = Double.parseDouble(amenityWeightage[3]);
					Integer substage_id = Integer.parseInt(amenityWeightage[4]);
					Double substage_weightage = Double.parseDouble(amenityWeightage[5]);
					Boolean wstatus = Boolean.parseBoolean(amenityWeightage[6]);
					BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
					builderFloorAmenity.setId(amenity_id);
					BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
					builderFloorAmenityStages.setId(stage_id);
					BuilderFloorAmenitySubstages builderFloorAmenitySubstages = new BuilderFloorAmenitySubstages();
					builderFloorAmenitySubstages.setId(substage_id);
					baw.setBuilderFloorAmenity(builderFloorAmenity);
					baw.setAmenityWeightage(amenity_weightage);
					baw.setBuilderFloorAmenityStages(builderFloorAmenityStages);
					baw.setStageWeightage(stage_weightage);
					baw.setBuilderFloorAmenitySubstages(builderFloorAmenitySubstages);
					baw.setSubstageWeightage(substage_weightage);
					baw.setStatus(wstatus);
					baw.setBuilderFloor(builderFloor);
					baws.add(baw);
				}
				projectDAO.deleteFloorAmenityWeightage(floor_id);
				projectDAO.addFloorAmenityWeightage(baws);
			}
		} else {
			msg.setMessage("Failed to update floor.");
			msg.setStatus(0);
		}
		return msg;
	}
	
	@GET
	@Path("/building/floor/plan/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteFloorPlan(@PathParam("id") int imgae_id) {
		System.out.println("Image ID : "+imgae_id);
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteFloorPlan(imgae_id);
		return msg;
	}
	
	@GET
	@Path("/building/floor/names/{building_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<FloorData> getBuilderFloorById(@PathParam("building_id") int building_id) {
		ProjectDAO projectDAO = new ProjectDAO();
		return projectDAO.getBuildingFloorNamesByBuildingId(building_id);
	}
	
	@POST
	@Path("/building/floor/status/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateFloorStatus (
			@FormDataParam("floor_id") int floor_id,
			@FormDataParam("substagewt_id[]") List<FormDataBodyPart> substagewt_id,
			@FormDataParam("floor_image[]") List<FormDataBodyPart> building_images,
			@FormDataParam("elevation_image[]") List<FormDataBodyPart> elevation_images,
			@FormDataParam("admin_id") int admin_id
	) {
		Boolean bstatus = true;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderFloor builderFloor = new BuilderFloor();
		builderFloor.setId(floor_id);
		List<FloorAmenityWeightage> floorAmenityWeightages = new ArrayList<FloorAmenityWeightage>();
		for(int i=0 ;i < substagewt_id.size();i++) {
			FloorAmenityWeightage baw = new FloorAmenityWeightage();
			baw.setId(substagewt_id.get(i).getValueAs(Integer.class));
			baw.setStatus(bstatus);
			floorAmenityWeightages.add(baw);
		}
		if(floorAmenityWeightages.size() > 0) {
			msg = projectDAO.updateFloorAmenityWeightage(floorAmenityWeightages, floor_id);
		}
		
		try {	
			List<FloorImageGallery> floorImageGalleries = new ArrayList<FloorImageGallery>();
			//for multiple inserting images.
			if (building_images.size() > 0) {
				for(int i=0 ;i < building_images.size();i++)
				{
					if(building_images.get(i).getFormDataContentDisposition().getFileName() != null && !building_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						FloorImageGallery floorImageGallery = new FloorImageGallery();
						String gallery_name = building_images.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/floor/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						//System.out.println("for loop image path: "+uploadGalleryLocation);
						this.imageUploader.writeToFile(building_images.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						floorImageGallery.setImage(gallery_name);
						floorImageGallery.setBuilderFloor(builderFloor);
						floorImageGalleries.add(floorImageGallery);
					}
				}
				if(floorImageGalleries.size() > 0) {
					projectDAO.addFloorImageGallery(floorImageGalleries);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to save image");
		}
		//add elevation images
		try {	
			List<FloorPanoramicImage> floorPanoramicImages = new ArrayList<FloorPanoramicImage>();
			//for multiple inserting images.
			if (elevation_images.size() > 0) {
				for(int i=0 ;i < elevation_images.size();i++)
				{
					if(elevation_images.get(i).getFormDataContentDisposition().getFileName() != null && !elevation_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						System.out.println("Image:"+elevation_images.get(i).getFormDataContentDisposition().getFileName());
						FloorPanoramicImage floorPanoramicImage = new FloorPanoramicImage();
						String elv_name = elevation_images.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						elv_name = Long.toString(millis) + elv_name.replaceAll(" ", "_").toLowerCase();
						elv_name = "images/project/floor/"+elv_name;
						String uploadElevationLocation = this.context.getInitParameter("building_elevation_url")+elv_name;
						//System.out.println("for loop image path: "+uploadElevationLocation);
						this.imageUploader.writeToFile(elevation_images.get(i).getValueAs(InputStream.class), uploadElevationLocation);
						floorPanoramicImage.setPanoImage(elv_name);
						floorPanoramicImage.setBuilderFloor(builderFloor);
						floorPanoramicImages.add(floorPanoramicImage);
					}
				}
				if(floorPanoramicImages.size() > 0) {
					projectDAO.addFloorPanoImage(floorPanoramicImages);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to save image");
		}
		
		msg.setMessage("Updated successfully.");
		msg.setStatus(1);
		return msg;
	}
	
	@GET
	@Path("/building/floor/image/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteFloorImageGallery(@PathParam("id") int imgae_id) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteFloorImageGallery(imgae_id);
		return msg;
	}
	
	@GET
	@Path("/building/floor/elevationimage/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteFloorPanoImage(@PathParam("id") int imgae_id) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteFloorPanoImage(imgae_id);
		return msg;
	}
	
	/* ********* Flat Types ************** */
	
	@POST
	@Path("/building/flattype/add")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuildingFlatType (
			@FormDataParam("project_id") int project_id,
			@FormDataParam("name") String name, 
			@FormDataParam("super_builtup_area") Double super_builtup_area,
			@FormDataParam("builtup_area") Double builtup_area,
			@FormDataParam("carpet_area") Double carpet_area,
			@FormDataParam("bedroom") byte bedroom,
			@FormDataParam("bathroom") byte bathroom,
			@FormDataParam("balcony") byte balcony,
			@FormDataParam("drybalcony") byte drybalcony,
			@FormDataParam("config_id") int config_id,
			@FormDataParam("building_image[]") List<FormDataBodyPart> building_images,
			@FormDataParam("building_id[]") List<FormDataBodyPart> buildings,
			@FormDataParam("room_name[]") List<FormDataBodyPart> room_name,
			@FormDataParam("length[]") List<FormDataBodyPart> length,
			@FormDataParam("breadth[]") List<FormDataBodyPart> breadth,
			@FormDataParam("length_unit[]") List<FormDataBodyPart> length_unit,
			@FormDataParam("admin_id") int admin_id
	) {
		byte floor_status = 1;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderProject builderProject = new BuilderProject();
		builderProject.setId(project_id);
		AdminUser adminUser = new AdminUser();
		adminUser.setId(admin_id);
		BuilderProjectPropertyConfiguration builderProjectPropertyConfiguration = new BuilderProjectPropertyConfiguration();
		builderProjectPropertyConfiguration.setId(config_id);
		BuilderFlatType builderFlatType = new BuilderFlatType();
		builderFlatType.setStatus(floor_status);
		builderFlatType.setSuperBuiltupArea(super_builtup_area);
		builderFlatType.setBuiltupArea(builtup_area);
		builderFlatType.setCarpetArea(carpet_area);
		builderFlatType.setBedroom(bedroom);
		builderFlatType.setBathroom(bathroom);
		builderFlatType.setBalcony(balcony);
		builderFlatType.setDrybalcony(drybalcony);
		builderFlatType.setName(name);
		builderFlatType.setBuilderProjectPropertyConfiguration(builderProjectPropertyConfiguration);
		builderFlatType.setBuilderProject(builderProject);
		builderFlatType.setAdminUser(adminUser);
		msg = projectDAO.addBuildingFlatType(builderFlatType);
		if(msg.getId() > 0) {
			builderFlatType.setId(msg.getId());
			//add building flat types
			if (buildings.size() > 0) {
				List<BuilderBuildingFlatType> builderBuildingFlatTypes = new ArrayList<BuilderBuildingFlatType>();
				for(FormDataBodyPart building : buildings)
				{
					if(building.getValueAs(Integer.class) != null && building.getValueAs(Integer.class) != 0) {
						BuilderBuilding builderBuilding = new BuilderBuilding();
						builderBuilding.setId(building.getValueAs(Integer.class));
						BuilderBuildingFlatType builderBuildingFlatType = new BuilderBuildingFlatType();
						builderBuildingFlatType.setBuilderBuilding(builderBuilding);
						builderBuildingFlatType.setBuilderFlatType(builderFlatType);
						builderBuildingFlatTypes.add(builderBuildingFlatType);
					}
				}
				if(builderBuildingFlatTypes.size() > 0) {
					projectDAO.addBuilderBuildingFlatType(builderBuildingFlatTypes);
				}
			}
			
			//add builder building flat type rooms
			if (room_name.size() > 0) {
				List<BuilderBuildingFlatTypeRoom> builderBuildingFlatTypeRooms = new ArrayList<BuilderBuildingFlatTypeRoom>();
				int i = 0;
				for(FormDataBodyPart room : room_name)
				{
					if(room.getValueAs(String.class).toString() != null && !room.getValueAs(String.class).isEmpty()) {
						BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom = new BuilderBuildingFlatTypeRoom();
						builderBuildingFlatTypeRoom.setBuilderFlatType(builderFlatType);
						builderBuildingFlatTypeRoom.setRoomName(room.getValueAs(String.class).toString());
						builderBuildingFlatTypeRoom.setLength(length.get(i).getValueAs(Double.class));
						builderBuildingFlatTypeRoom.setBreadth(breadth.get(i).getValueAs(Double.class));
						builderBuildingFlatTypeRoom.setLengthUnit(length_unit.get(i).getValueAs(Byte.class));
						builderBuildingFlatTypeRooms.add(builderBuildingFlatTypeRoom);
					}
					i++;
				}
				if(builderBuildingFlatTypeRooms.size() > 0) {
					projectDAO.addBuilderBuildingFlatTypeRoom(builderBuildingFlatTypeRooms);
				}
			}
			//add gallery images
			try {	
				List<FlatTypeImage> flatTypeImages = new ArrayList<FlatTypeImage>();
				//for multiple inserting images.
				if (building_images.size() > 0) {
					for(int i=0 ;i < building_images.size();i++)
					{
						if(building_images.get(i).getFormDataContentDisposition().getFileName() != null && !building_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
							FlatTypeImage flatTypeImage = new FlatTypeImage();
							String gallery_name = building_images.get(i).getFormDataContentDisposition().getFileName();
							long millis = System.currentTimeMillis() % 1000;
							gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
							gallery_name = "images/project/flattype/"+gallery_name;
							String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
							//System.out.println("for loop image path: "+uploadGalleryLocation);
							this.imageUploader.writeToFile(building_images.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
							flatTypeImage.setImage(gallery_name);
							flatTypeImage.setTitle("New Image");
							flatTypeImage.setBuilderFlatType(builderFlatType);
							flatTypeImages.add(flatTypeImage);
						}
					}
					if(flatTypeImages.size() > 0) {
						projectDAO.addFlatTypeImages(flatTypeImages);
					}
				}
			} catch(Exception e) {
				msg.setStatus(0);
				msg.setMessage("Unable to save image");
			}
		} else {
			msg.setMessage("Failed to add flat type.");
			msg.setStatus(0);
		}
		return msg;
	}
	
	@POST
	@Path("/building/flattype/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuildingFlatType (
			@FormDataParam("flat_type_id") int flat_type_id,
			@FormDataParam("project_id") int project_id,
			@FormDataParam("name") String name, 
			@FormDataParam("super_builtup_area") Double super_builtup_area,
			@FormDataParam("builtup_area") Double builtup_area,
			@FormDataParam("carpet_area") Double carpet_area,
			@FormDataParam("bedroom") byte bedroom,
			@FormDataParam("bathroom") byte bathroom,
			@FormDataParam("balcony") byte balcony,
			@FormDataParam("drybalcony") byte drybalcony,
			@FormDataParam("config_id") int config_id,
			@FormDataParam("building_image[]") List<FormDataBodyPart> building_images,
			@FormDataParam("building_id[]") List<FormDataBodyPart> buildings,
			@FormDataParam("room_name[]") List<FormDataBodyPart> room_name,
			@FormDataParam("length[]") List<FormDataBodyPart> length,
			@FormDataParam("breadth[]") List<FormDataBodyPart> breadth,
			@FormDataParam("length_unit[]") List<FormDataBodyPart> length_unit,
			@FormDataParam("admin_id") int admin_id
	) {
		byte floor_status = 1;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderProject builderProject = new BuilderProject();
		builderProject.setId(project_id);
		AdminUser adminUser = new AdminUser();
		adminUser.setId(admin_id);
		BuilderProjectPropertyConfiguration builderProjectPropertyConfiguration = new BuilderProjectPropertyConfiguration();
		builderProjectPropertyConfiguration.setId(config_id);
		BuilderFlatType builderFlatType = new BuilderFlatType();
		builderFlatType.setId(flat_type_id);
		builderFlatType.setStatus(floor_status);
		builderFlatType.setSuperBuiltupArea(super_builtup_area);
		builderFlatType.setBuiltupArea(builtup_area);
		builderFlatType.setCarpetArea(carpet_area);
		builderFlatType.setBedroom(bedroom);
		builderFlatType.setBathroom(bathroom);
		builderFlatType.setBalcony(balcony);
		builderFlatType.setDrybalcony(drybalcony);
		builderFlatType.setName(name);
		builderFlatType.setBuilderProjectPropertyConfiguration(builderProjectPropertyConfiguration);
		builderFlatType.setBuilderProject(builderProject);
		builderFlatType.setAdminUser(adminUser);
		msg = projectDAO.updateBuildingFlatType(builderFlatType);
		if(msg.getId() > 0) {
			//add building flat types
			if (buildings.size() > 0) {
				List<BuilderBuildingFlatType> builderBuildingFlatTypes = new ArrayList<BuilderBuildingFlatType>();
				for(FormDataBodyPart building : buildings)
				{
					if(building.getValueAs(Integer.class) != null && building.getValueAs(Integer.class) != 0) {
						BuilderBuilding builderBuilding = new BuilderBuilding();
						builderBuilding.setId(building.getValueAs(Integer.class));
						BuilderBuildingFlatType builderBuildingFlatType = new BuilderBuildingFlatType();
						builderBuildingFlatType.setBuilderBuilding(builderBuilding);
						builderBuildingFlatType.setBuilderFlatType(builderFlatType);
						builderBuildingFlatTypes.add(builderBuildingFlatType);
					}
				}
				if(builderBuildingFlatTypes.size() > 0) {
					projectDAO.deleteBuilderBuildingFlatType(flat_type_id);
					projectDAO.addBuilderBuildingFlatType(builderBuildingFlatTypes);
				}
			}
			
			//add builder building flat type rooms
			if (room_name.size() > 0) {
				List<BuilderBuildingFlatTypeRoom> builderBuildingFlatTypeRooms = new ArrayList<BuilderBuildingFlatTypeRoom>();
				int i = 0;
				for(FormDataBodyPart room : room_name)
				{
					if(room.getValueAs(String.class).toString() != null && !room.getValueAs(String.class).isEmpty()) {
						BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom = new BuilderBuildingFlatTypeRoom();
						builderBuildingFlatTypeRoom.setBuilderFlatType(builderFlatType);
						builderBuildingFlatTypeRoom.setRoomName(room.getValueAs(String.class).toString());
						builderBuildingFlatTypeRoom.setLength(length.get(i).getValueAs(Double.class));
						builderBuildingFlatTypeRoom.setBreadth(breadth.get(i).getValueAs(Double.class));
						builderBuildingFlatTypeRoom.setLengthUnit(length_unit.get(i).getValueAs(Byte.class));
						builderBuildingFlatTypeRooms.add(builderBuildingFlatTypeRoom);
					}
					i++;
				}
				if(builderBuildingFlatTypeRooms.size() > 0) {
					projectDAO.deleteBuilderBuildingFlatTypeRoom(flat_type_id);
					projectDAO.addBuilderBuildingFlatTypeRoom(builderBuildingFlatTypeRooms);
				}
			}
			//add gallery images
			try {	
				List<FlatTypeImage> flatTypeImages = new ArrayList<FlatTypeImage>();
				//for multiple inserting images.
				if (building_images.size() > 0) {
					for(int i=0 ;i < building_images.size();i++)
					{
						if(building_images.get(i).getFormDataContentDisposition().getFileName() != null && !building_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
							FlatTypeImage flatTypeImage = new FlatTypeImage();
							String gallery_name = building_images.get(i).getFormDataContentDisposition().getFileName();
							long millis = System.currentTimeMillis() % 1000;
							gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
							gallery_name = "images/project/flattype/"+gallery_name;
							String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
							//System.out.println("for loop image path: "+uploadGalleryLocation);
							this.imageUploader.writeToFile(building_images.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
							flatTypeImage.setImage(gallery_name);
							flatTypeImage.setTitle("New Image");
							flatTypeImage.setBuilderFlatType(builderFlatType);
							flatTypeImages.add(flatTypeImage);
						}
					}
					if(flatTypeImages.size() > 0) {
						projectDAO.addFlatTypeImages(flatTypeImages);
					}
				}
			} catch(Exception e) {
				msg.setStatus(0);
				msg.setMessage("Unable to update image");
			}
		} else {
			msg.setMessage("Failed to update flat type.");
			msg.setStatus(0);
		}
		return msg;
	}
	
	@GET
	@Path("/building/flattype/image/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteFlatTypeImage(@PathParam("id") int imgae_id) {
		System.out.println("Image ID : "+imgae_id);
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteFlatTypeImage(imgae_id);
		return msg;
	}
	
	@GET
	@Path("/building/flattype/names/{building_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<FloorData> getBuilderFlatTypeNamesByBuildingId(@PathParam("building_id") int building_id) {
		ProjectDAO projectDAO = new ProjectDAO();
		return projectDAO.getBuildingFlatTypeNamesByBuildingId(building_id);
	}
	
	
	/* ********* Building Flats ************** */
	
	@POST
	@Path("/building/floor/flat/add")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuildingFloorFlat (
			@FormDataParam("floor_id") int floor_id,
			@FormDataParam("flat_type_id") int flat_type_id,
			@FormDataParam("flat_no") String flat_no, 
			@FormDataParam("bedroom") Integer bedroom,
			@FormDataParam("bathroom") Integer bathroom,
			@FormDataParam("balcony") Integer balcony,
			@FormDataParam("status") Integer status,
			@FormDataParam("possession_date") String possession_date,
			@FormDataParam("amenity_type[]") List<FormDataBodyPart> amenity_type,
			@FormDataParam("schedule[]") List<FormDataBodyPart> schedule,
			@FormDataParam("payable[]") List<FormDataBodyPart> payable,
			@FormDataParam("amount[]") List<FormDataBodyPart> amount,
			@FormDataParam("admin_id") int admin_id,
			@FormDataParam("amenity_wt") String amenity_wts
	) {
		String [] amenityWeightages = amenity_wts.split(",");
		List<FlatAmenityWeightage> baws = new ArrayList<FlatAmenityWeightage>();
		SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
		Date possessionDate = null;
		try {
			possessionDate = format.parse(possession_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		byte floor_status = 1;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderFloor builderFloor = new BuilderFloor();
		builderFloor.setId(floor_id);
		AdminUser adminUser = new AdminUser();
		adminUser.setId(admin_id);
		BuilderFlatStatus builderFlatStatus = new BuilderFlatStatus();
		builderFlatStatus.setId(status);
		BuilderFlatType builderFlatType = new BuilderFlatType();
		builderFlatType.setId(flat_type_id);
		BuilderFlat builderFlat = new BuilderFlat();
		builderFlat.setBuilderFloor(builderFloor);
		builderFlat.setBuilderFlatStatus(builderFlatStatus);
		builderFlat.setBuilderFlatType(builderFlatType);
		builderFlat.setFlatNo(flat_no);
		builderFlat.setBedroom(bedroom);
		builderFlat.setBathroom(bathroom);
		builderFlat.setBalcony(balcony);
		builderFlat.setInventorySold(0.0);
		builderFlat.setTotalInventory(0.0);
		builderFlat.setRevenue(0.0);
		builderFlat.setPossessionDate(possessionDate);
		builderFlat.setAdminUser(adminUser);
		builderFlat.setStatus(floor_status);
		msg = projectDAO.addBuildingFlat(builderFlat);
		if(msg.getId() > 0) {
			builderFlat.setId(msg.getId());
			//add gallery images
			if (amenity_type.size() > 0) {
				List<FlatAmenityInfo> flatAmenityInfos = new ArrayList<FlatAmenityInfo>();
				int i = 0;
				for(FormDataBodyPart amenity : amenity_type)
				{
					if(amenity.getValueAs(Integer.class) != null && amenity.getValueAs(Integer.class) != 0) {
						Byte milestone_status = 0;
						BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
						builderFlatAmenity.setId(amenity.getValueAs(Integer.class));
						FlatAmenityInfo amenityInfo = new FlatAmenityInfo();
						amenityInfo.setBuilderFlatAmenity(builderFlatAmenity);
						amenityInfo.setBuilderFlat(builderFlat);
						flatAmenityInfos.add(amenityInfo);
					}
					i++;
				}
				if(flatAmenityInfos.size() > 0) {
					projectDAO.addFlatAmenityInfo(flatAmenityInfos);
				}
			}
			if(amenity_wts != "") {
				for(String aw :amenityWeightages) {
					FlatAmenityWeightage baw = new FlatAmenityWeightage();
					String [] amenityWeightage = aw.split("#");
					Integer amenity_id = Integer.parseInt(amenityWeightage[0]);
					Double amenity_weightage = Double.parseDouble(amenityWeightage[1]);
					Integer stage_id = Integer.parseInt(amenityWeightage[2]);
					Double stage_weightage = Double.parseDouble(amenityWeightage[3]);
					Integer substage_id = Integer.parseInt(amenityWeightage[4]);
					Double substage_weightage = Double.parseDouble(amenityWeightage[5]);
					Boolean wstatus = Boolean.parseBoolean(amenityWeightage[6]);
					BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
					builderFlatAmenity.setId(amenity_id);
					BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
					builderFlatAmenityStages.setId(stage_id);
					BuilderFlatAmenitySubstages builderFlatAmenitySubstages = new BuilderFlatAmenitySubstages();
					builderFlatAmenitySubstages.setId(substage_id);
					baw.setBuilderFlatAmenity(builderFlatAmenity);
					baw.setAmenityWeightage(amenity_weightage);
					baw.setBuilderFlatAmenityStages(builderFlatAmenityStages);
					baw.setStageWeightage(stage_weightage);
					baw.setBuilderFlatAmenitySubstages(builderFlatAmenitySubstages);
					baw.setSubstageWeightage(substage_weightage);
					baw.setStatus(wstatus);
					baw.setBuilderFlat(builderFlat);
					baws.add(baw);
				}
				projectDAO.addFlatAmenityWeightage(baws);
			}
			if (schedule.size() > 0) {
				List<FlatPaymentSchedule> flatPaymentSchedules = new ArrayList<FlatPaymentSchedule>();
				int i = 0;
				for(FormDataBodyPart milestone : schedule)
				{
					if(milestone.getValueAs(String.class).toString() != null && !milestone.getValueAs(String.class).toString().isEmpty()) {
						Byte milestone_status = 0;
						FlatPaymentSchedule flatPaymentSchedule = new FlatPaymentSchedule();
						flatPaymentSchedule.setMilestone(milestone.getValueAs(String.class).toString());
						flatPaymentSchedule.setPayable(payable.get(i).getValueAs(Double.class));
						flatPaymentSchedule.setAmount(amount.get(i).getValueAs(Double.class));
						flatPaymentSchedule.setStatus(milestone_status);
						flatPaymentSchedule.setBuilderFlat(builderFlat);
						flatPaymentSchedules.add(flatPaymentSchedule);
					}
					i++;
				}
				if(flatPaymentSchedules.size() > 0) {
					projectDAO.addFlatPaymentInfo(flatPaymentSchedules);
				}
			}
		} else {
			msg.setMessage("Failed to add flat.");
			msg.setStatus(0);
		}
		return msg;
	}
	
	@POST
	@Path("/building/floor/flat/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuildingFloorFlat (
			@FormDataParam("flat_id") int flat_id,
			@FormDataParam("floor_id") int floor_id,
			@FormDataParam("flat_type_id") int flat_type_id,
			@FormDataParam("flat_no") String flat_no, 
			@FormDataParam("bedroom") Integer bedroom,
			@FormDataParam("bathroom") Integer bathroom,
			@FormDataParam("balcony") Integer balcony,
			@FormDataParam("status") Integer status,
			@FormDataParam("possession_date") String possession_date,
			@FormDataParam("amenity_type[]") List<FormDataBodyPart> amenity_type,
			@FormDataParam("payment_id[]") List<FormDataBodyPart> payment_id,
			@FormDataParam("schedule[]") List<FormDataBodyPart> schedule,
			@FormDataParam("payable[]") List<FormDataBodyPart> payable,
			@FormDataParam("amount[]") List<FormDataBodyPart> amount,
			@FormDataParam("admin_id") int admin_id,
			@FormDataParam("amenity_wt") String amenity_wts
	) {
		String [] amenityWeightages = amenity_wts.split(",");
		List<FlatAmenityWeightage> baws = new ArrayList<FlatAmenityWeightage>();
		SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
		Date possessionDate = null;
		try {
			possessionDate = format.parse(possession_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		byte floor_status = 1;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderFloor builderFloor = new BuilderFloor();
		builderFloor.setId(floor_id);
		AdminUser adminUser = new AdminUser();
		adminUser.setId(admin_id);
		BuilderFlatStatus builderFlatStatus = new BuilderFlatStatus();
		builderFlatStatus.setId(status);
		BuilderFlatType builderFlatType = new BuilderFlatType();
		builderFlatType.setId(flat_type_id);
		BuilderFlat builderFlat = projectDAO.getBuildingFlatById(flat_id).get(0);
		builderFlat.setBuilderFloor(builderFloor);
		builderFlat.setBuilderFlatStatus(builderFlatStatus);
		builderFlat.setBuilderFlatType(builderFlatType);
		builderFlat.setFlatNo(flat_no);
		builderFlat.setBedroom(bedroom);
		builderFlat.setBathroom(bathroom);
		builderFlat.setBalcony(balcony);
		builderFlat.setPossessionDate(possessionDate);
		builderFlat.setAdminUser(adminUser);
		msg = projectDAO.updateBuildingFlat(builderFlat);
		if(msg.getId() > 0) {
			//add gallery images
			if (amenity_type.size() > 0) {
				List<FlatAmenityInfo> flatAmenityInfos = new ArrayList<FlatAmenityInfo>();
				int i = 0;
				for(FormDataBodyPart amenity : amenity_type)
				{
					if(amenity.getValueAs(Integer.class) != null && amenity.getValueAs(Integer.class) != 0) {
						Byte milestone_status = 0;
						BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
						builderFlatAmenity.setId(amenity.getValueAs(Integer.class));
						FlatAmenityInfo amenityInfo = new FlatAmenityInfo();
						amenityInfo.setBuilderFlatAmenity(builderFlatAmenity);
						amenityInfo.setBuilderFlat(builderFlat);
						flatAmenityInfos.add(amenityInfo);
					}
					i++;
				}
				if(flatAmenityInfos.size() > 0) {
					projectDAO.deleteFlatAmenityInfo(flat_id);
					projectDAO.addFlatAmenityInfo(flatAmenityInfos);
				}
			}
			if(amenity_wts != "") {
				for(String aw :amenityWeightages) {
					FlatAmenityWeightage baw = new FlatAmenityWeightage();
					String [] amenityWeightage = aw.split("#");
					Integer amenity_id = Integer.parseInt(amenityWeightage[0]);
					Double amenity_weightage = Double.parseDouble(amenityWeightage[1]);
					Integer stage_id = Integer.parseInt(amenityWeightage[2]);
					Double stage_weightage = Double.parseDouble(amenityWeightage[3]);
					Integer substage_id = Integer.parseInt(amenityWeightage[4]);
					Double substage_weightage = Double.parseDouble(amenityWeightage[5]);
					Boolean wstatus = Boolean.parseBoolean(amenityWeightage[6]);
					BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
					builderFlatAmenity.setId(amenity_id);
					BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
					builderFlatAmenityStages.setId(stage_id);
					BuilderFlatAmenitySubstages builderFlatAmenitySubstages = new BuilderFlatAmenitySubstages();
					builderFlatAmenitySubstages.setId(substage_id);
					baw.setBuilderFlatAmenity(builderFlatAmenity);
					baw.setAmenityWeightage(amenity_weightage);
					baw.setBuilderFlatAmenityStages(builderFlatAmenityStages);
					baw.setStageWeightage(stage_weightage);
					baw.setBuilderFlatAmenitySubstages(builderFlatAmenitySubstages);
					baw.setSubstageWeightage(substage_weightage);
					baw.setStatus(wstatus);
					baw.setBuilderFlat(builderFlat);
					baws.add(baw);
				}
				projectDAO.deleteFlatAmenityWeightage(flat_id);
				projectDAO.addFlatAmenityWeightage(baws);
			}
			try{
				if (schedule.size() > 0) {
					List<FlatPaymentSchedule> flatPaymentSchedules = new ArrayList<FlatPaymentSchedule>();
					List<FlatPaymentSchedule> newFlatPaymentSchedules = new ArrayList<FlatPaymentSchedule>();
					int i = 0;
					for(FormDataBodyPart milestone : schedule)
					{
						if(milestone.getValueAs(String.class).toString() != null && !milestone.getValueAs(String.class).toString().isEmpty()) {
							if(payment_id.get(i).getValueAs(Integer.class) != 0 && payment_id.get(i).getValueAs(Integer.class) != null) {
								Byte milestone_status = 0;
								FlatPaymentSchedule flatPaymentSchedule = new FlatPaymentSchedule();
								flatPaymentSchedule.setId(payment_id.get(i).getValueAs(Integer.class));
								flatPaymentSchedule.setMilestone(milestone.getValueAs(String.class).toString());
								flatPaymentSchedule.setPayable(payable.get(i).getValueAs(Double.class));
								flatPaymentSchedule.setAmount(amount.get(i).getValueAs(Double.class));
								flatPaymentSchedule.setStatus(milestone_status);
								flatPaymentSchedule.setBuilderFlat(builderFlat);
								flatPaymentSchedules.add(flatPaymentSchedule);
							} else {
								Byte milestone_status = 0;
								FlatPaymentSchedule flatPaymentSchedule = new FlatPaymentSchedule();
								flatPaymentSchedule.setMilestone(milestone.getValueAs(String.class).toString());
								flatPaymentSchedule.setPayable(payable.get(i).getValueAs(Double.class));
								flatPaymentSchedule.setAmount(amount.get(i).getValueAs(Double.class));
								flatPaymentSchedule.setStatus(milestone_status);
								flatPaymentSchedule.setBuilderFlat(builderFlat);
								newFlatPaymentSchedules.add(flatPaymentSchedule);
							}
						}
						i++;
					}
					if(flatPaymentSchedules.size() > 0) {
						projectDAO.updateFlatPaymentInfo(flatPaymentSchedules);
						projectDAO.addFlatPaymentInfo(newFlatPaymentSchedules);
					}
				}
			} catch(Exception e) {
				
			}
		} else {
			msg.setMessage("Failed to update flat.");
			msg.setStatus(0);
		}
		return msg;
	}
	
	@GET
	@Path("/building/floor/flat/payment/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteFlatPaymentInfo(@PathParam("id") int id) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteFlatPaymentInfo(id);
		return msg;
	}
	
	@POST
	@Path("/building/floor/flat/status/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateFlatStatus (
			@FormDataParam("flat_id") int flat_id,
			@FormDataParam("substagewt_id[]") List<FormDataBodyPart> substagewt_id,
			@FormDataParam("flat_image[]") List<FormDataBodyPart> building_images,
			@FormDataParam("elevation_image[]") List<FormDataBodyPart> elevation_images,
			@FormDataParam("admin_id") int admin_id
	) {
		Boolean bstatus = true;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderFlat builderFlat = new BuilderFlat();
		builderFlat.setId(flat_id);
		List<FlatAmenityWeightage> flatAmenityWeightages = new ArrayList<FlatAmenityWeightage>();
		for(int i=0 ;i < substagewt_id.size();i++) {
			FlatAmenityWeightage baw = new FlatAmenityWeightage();
			baw.setId(substagewt_id.get(i).getValueAs(Integer.class));
			baw.setStatus(bstatus);
			flatAmenityWeightages.add(baw);
		}
		if(flatAmenityWeightages.size() > 0) {
			msg = projectDAO.updateFlatAmenityWeightage(flatAmenityWeightages, flat_id);
		}
		
		try {	
			List<FlatImageGallery> flatImageGalleries = new ArrayList<FlatImageGallery>();
			//for multiple inserting images.
			if (building_images.size() > 0) {
				for(int i=0 ;i < building_images.size();i++)
				{
					if(building_images.get(i).getFormDataContentDisposition().getFileName() != null && !building_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						FlatImageGallery flatImageGallery = new FlatImageGallery();
						String gallery_name = building_images.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/flat/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						//System.out.println("for loop image path: "+uploadGalleryLocation);
						this.imageUploader.writeToFile(building_images.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						flatImageGallery.setImage(gallery_name);
						flatImageGallery.setBuilderFlat(builderFlat);
						flatImageGalleries.add(flatImageGallery);
					}
				}
				if(flatImageGalleries.size() > 0) {
					projectDAO.addFlatImageGallery(flatImageGalleries);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to save image");
		}
		//add elevation images
		try {	
			List<FlatPanoramicImage> flatPanoramicImages = new ArrayList<FlatPanoramicImage>();
			//for multiple inserting images.
			if (elevation_images.size() > 0) {
				for(int i=0 ;i < elevation_images.size();i++)
				{
					if(elevation_images.get(i).getFormDataContentDisposition().getFileName() != null && !elevation_images.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						System.out.println("Image:"+elevation_images.get(i).getFormDataContentDisposition().getFileName());
						FlatPanoramicImage flatPanoramicImage = new FlatPanoramicImage();
						String elv_name = elevation_images.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						elv_name = Long.toString(millis) + elv_name.replaceAll(" ", "_").toLowerCase();
						elv_name = "images/project/flat/"+elv_name;
						String uploadElevationLocation = this.context.getInitParameter("building_elevation_url")+elv_name;
						//System.out.println("for loop image path: "+uploadElevationLocation);
						this.imageUploader.writeToFile(elevation_images.get(i).getValueAs(InputStream.class), uploadElevationLocation);
						flatPanoramicImage.setPanoImage(elv_name);
						flatPanoramicImage.setBuilderFlat(builderFlat);
						flatPanoramicImages.add(flatPanoramicImage);
					}
				}
				if(flatPanoramicImages.size() > 0) {
					projectDAO.addFlatPanoImage(flatPanoramicImages);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to save image");
		}
		
		msg.setMessage("Updated successfully.");
		msg.setStatus(1);
		return msg;
	}
	
	@GET
	@Path("/building/floor/flat/image/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteFlatImageGallery(@PathParam("id") int imgae_id) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteFlatImageGallery(imgae_id);
		return msg;
	}
	
	@GET
	@Path("/building/floor/flat/elevationimage/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteFlatPanoImage(@PathParam("id") int imgae_id) {
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		msg = projectDAO.deleteFlatPanoImage(imgae_id);
		return msg;
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
	
	@POST
	@Path("/new")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage newProject(
			@FormParam("builder_id") int builder_id, 
			@FormParam("name") String name,
			@FormParam("locality_id") int locality_id
	) {
		
		ResponseMessage resp = new ResponseMessage();
		AdminUser adminUser = new AdminUser();
		adminUser.setId(1);
		Short areaunit = 1;
		Byte status = 0;
		AreaUnit areaUnit = new AreaUnit();
		areaUnit.setId(areaunit);
		Locality locality = new Locality();
		locality.setId(locality_id);
		Locality newLocality = new LocalityNamesImp().getLocality(locality_id);
		City city = newLocality.getCity();
		State state = newLocality.getCity().getState();
		Country country = newLocality.getCity().getState().getCountry();
		Builder builder = new Builder();
		builder.setId(builder_id);
		BuilderCompanyNames builderCompanyNames = new BuilderDetailsDAO().getAllBuilderCompanyNameByBuilderId(builder_id).get(0);
		
		BuilderProject builderProject = new BuilderProject();
		builderProject.setAddr1("");
		builderProject.setAddr2("");
		builderProject.setAdminUser(adminUser);
		builderProject.setAreaUnit(areaUnit);
		builderProject.setBuilder(builder);
		builderProject.setBuilderCompanyNames(builderCompanyNames);
		builderProject.setCity(city);
		builderProject.setCountry(country);
		builderProject.setDescription("");
		builderProject.setHighlights("");
		builderProject.setInventorySold(0.0);
		builderProject.setLatitude("");
		builderProject.setLaunchDate(null);
		builderProject.setLocality(locality);
		builderProject.setLongitude("");
		builderProject.setName(name);
		builderProject.setPincode("");
		builderProject.setPossessionDate(null);
		builderProject.setProjectArea(0.0);
		builderProject.setRevenue(0.0);
		builderProject.setState(state);
		builderProject.setTotalInventory(0.0);
		builderProject.setStatus(status);
		resp = new ProjectDAO().saveProject(builderProject); 
		return resp;
	}
	
	@GET
	@Path("/locality")
	@Produces(MediaType.APPLICATION_JSON)
	public List<LocalityData> getLocalityList(@QueryParam("city_id") int cityId) {
		return new LocalityNamesImp().getLocalityName(cityId);
	}
	
	@GET
	@Path("/list/city")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectData> getProjectList(@QueryParam("city_id") int cityId) {
		return new ProjectDAO().getProjectsByCityId(cityId);
	}
	
	@POST
	@Path("/building")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuildingList> getBuildingList(@FormParam("city_id") int city_id, 
			@FormParam("locality_id") int locality_id,
			@FormParam("project_id") int project_id
	) {
		List<BuildingList> project_list = new ProjectDAO().getBuildingListFilter(city_id, locality_id, project_id);
		return project_list;
	}
	
	@GET
	@Path("/buyer/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuyerById(@PathParam("id") int id) {
		ResponseMessage msg = new ResponseMessage();
		BuyerDAO buyerDAO = new BuyerDAO();
		msg = buyerDAO.deleteBuyerById(id);
		return msg;
	}
	
}
