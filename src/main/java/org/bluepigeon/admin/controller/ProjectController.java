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
import org.bluepigeon.admin.model.BuilderBuildingAmenity;
import org.bluepigeon.admin.model.BuilderBuildingStatus;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFlatAmenity;
import org.bluepigeon.admin.model.BuilderFlatStatus;
import org.bluepigeon.admin.model.BuilderFlatType;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderFloorAmenity;
import org.bluepigeon.admin.model.BuilderFloorStatus;
import org.bluepigeon.admin.model.BuilderLead;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuilderProjectPriceInfo;
import org.bluepigeon.admin.model.BuilderProjectProjectType;
import org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration;
import org.bluepigeon.admin.model.BuildingAmenityInfo;
import org.bluepigeon.admin.model.BuildingImageGallery;
import org.bluepigeon.admin.model.BuildingOfferInfo;
import org.bluepigeon.admin.model.BuildingPanoramicImage;
import org.bluepigeon.admin.model.BuildingPaymentInfo;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.FlatAmenityInfo;
import org.bluepigeon.admin.model.FlatPaymentSchedule;
import org.bluepigeon.admin.model.FlatTypeImage;
import org.bluepigeon.admin.model.FloorAmenityInfo;
import org.bluepigeon.admin.model.FloorLayoutImage;
import org.bluepigeon.admin.model.Locality;
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
			@FormDataParam("admin_id") int admin_id
	) {
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
			@FormDataParam("admin_id") int admin_id
	) {
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
			@FormDataParam("admin_id") int admin_id
	) {
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
			@FormDataParam("admin_id") int admin_id
	) {
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
	
	/* ********* Flat Types ************** */
	
	@POST
	@Path("/building/flattype/add")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuildingFlatType (
			@FormDataParam("building_id") int building_id,
			@FormDataParam("project_id") int project_id,
			@FormDataParam("name") String name, 
			@FormDataParam("floor_area") Double floor_area,
			@FormDataParam("floor_used") int floor_used,
			@FormDataParam("config_id") int config_id,
			@FormDataParam("building_image[]") List<FormDataBodyPart> building_images,
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
		BuilderBuilding builderBuilding = new BuilderBuilding();
		builderBuilding.setId(building_id);
		BuilderFlatType builderFlatType = new BuilderFlatType();
		builderFlatType.setBuilderBuilding(builderBuilding);
		builderFlatType.setStatus(floor_status);
		builderFlatType.setFloorArea(floor_area);
		builderFlatType.setFloorUsed(floor_used);
		builderFlatType.setName(name);
		builderFlatType.setBuilderProjectPropertyConfiguration(builderProjectPropertyConfiguration);
		builderFlatType.setBuilderProject(builderProject);
		builderFlatType.setAdminUser(adminUser);
		msg = projectDAO.addBuildingFlatType(builderFlatType);
		if(msg.getId() > 0) {
			builderFlatType.setId(msg.getId());
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
			@FormDataParam("building_id") int building_id,
			@FormDataParam("project_id") int project_id,
			@FormDataParam("name") String name, 
			@FormDataParam("floor_area") Double floor_area,
			@FormDataParam("floor_used") int floor_used,
			@FormDataParam("config_id") int config_id,
			@FormDataParam("building_image[]") List<FormDataBodyPart> building_images,
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
		BuilderBuilding builderBuilding = new BuilderBuilding();
		builderBuilding.setId(building_id);
		BuilderFlatType builderFlatType = new BuilderFlatType();
		builderFlatType.setId(flat_type_id);
		builderFlatType.setBuilderBuilding(builderBuilding);
		builderFlatType.setStatus(floor_status);
		builderFlatType.setFloorArea(floor_area);
		builderFlatType.setFloorUsed(floor_used);
		builderFlatType.setName(name);
		builderFlatType.setBuilderProjectPropertyConfiguration(builderProjectPropertyConfiguration);
		builderFlatType.setBuilderProject(builderProject);
		builderFlatType.setAdminUser(adminUser);
		msg = projectDAO.updateBuildingFlatType(builderFlatType);
		if(msg.getId() > 0) {
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
			@FormDataParam("admin_id") int admin_id
	) {
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
			@FormDataParam("admin_id") int admin_id
	) {
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
		builderLead.setName(name);
		builderLead.setMobile(mobile);
		builderLead.setEmail(email);
		builderLead.setCity(city);
		builderLead.setArea(area);
		builderLead.setSource(source);
		builderLead.setDiscountOffered(discount_offered);
		builderLead.setStatus(status);
		builderLead.setAddedBy(added_by);
		ResponseMessage resp = new ProjectDAO().addProjectLead(builderLead); 
		return resp;
	}
}
