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
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.BuilderBuildingAmenityDAO;
import org.bluepigeon.admin.dao.BuilderBuildingAmenityStagesDAO;
import org.bluepigeon.admin.dao.BuilderBuildingAmenitySubstagesDAO;
import org.bluepigeon.admin.dao.BuilderBuildingStatusDAO;
import org.bluepigeon.admin.dao.BuilderCompanyDAO;
import org.bluepigeon.admin.dao.BuilderDetailsDAO;
import org.bluepigeon.admin.dao.BuilderFlatAmenityDAO;
import org.bluepigeon.admin.dao.BuilderFlatAmenityStagesDAO;
import org.bluepigeon.admin.dao.BuilderFlatAmenitySubstagesDAO;
import org.bluepigeon.admin.dao.BuilderFlatStatusDAO;
import org.bluepigeon.admin.dao.BuilderFloorAmenityDAO;
import org.bluepigeon.admin.dao.BuilderFloorAmenityStagesDAO;
import org.bluepigeon.admin.dao.BuilderFloorAmenitySubstagesDAO;
import org.bluepigeon.admin.dao.BuilderGroupDAO;
import org.bluepigeon.admin.dao.BuilderOverallProjectStagesAndSubStagesDAO;
import org.bluepigeon.admin.dao.BuilderPaymentStagesDAO;
import org.bluepigeon.admin.dao.BuilderPaymentSubstagesDAO;
import org.bluepigeon.admin.dao.BuilderProjectAmenityDAO;
import org.bluepigeon.admin.dao.BuilderProjectAmenityStagesDAO;
import org.bluepigeon.admin.dao.BuilderProjectAmenitySubstagesDAO;
import org.bluepigeon.admin.dao.BuilderProjectApprovalTypeDAO;
import org.bluepigeon.admin.dao.BuilderProjectLevelDAO;
import org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationDAO;
import org.bluepigeon.admin.dao.BuilderProjectStatusDAO;
import org.bluepigeon.admin.dao.BuilderProjectTypeDAO;
import org.bluepigeon.admin.dao.BuilderPropertyTypeDAO;
import org.bluepigeon.admin.dao.BuilderSellerTypeDAO;
import org.bluepigeon.admin.dao.BuilderTaxTypeDAO;
import org.bluepigeon.admin.dao.BuildingStageDAO;
import org.bluepigeon.admin.dao.BuildingSubstagesDAO;
import org.bluepigeon.admin.dao.DemandLettersDAO;
import org.bluepigeon.admin.dao.FlatStageDAO;
import org.bluepigeon.admin.dao.FlatSubstagesDAO;
import org.bluepigeon.admin.dao.FloorStageDAO;
import org.bluepigeon.admin.dao.FloorSubstagesDAO;
import org.bluepigeon.admin.dao.ProjectDetailsDAO;
import org.bluepigeon.admin.dao.ProjectLeadDAO;
import org.bluepigeon.admin.dao.ProjectStageDAO;
import org.bluepigeon.admin.dao.ProjectSubstagesDAO;
import org.bluepigeon.admin.dao.TaxDAO;
import org.bluepigeon.admin.data.BuilderDetails;
import org.bluepigeon.admin.data.BuildingAmenityList;
import org.bluepigeon.admin.data.ProjectDetails;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderBuildingAmenity;
import org.bluepigeon.admin.model.BuilderBuildingAmenityStages;
import org.bluepigeon.admin.model.BuilderBuildingAmenitySubstages;
import org.bluepigeon.admin.model.BuilderBuildingStatus;
import org.bluepigeon.admin.model.BuilderCompany;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderEmployeeAccessType;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFlatAmenity;
import org.bluepigeon.admin.model.BuilderFlatAmenityStages;
import org.bluepigeon.admin.model.BuilderFlatAmenitySubstages;
import org.bluepigeon.admin.model.BuilderFlatStatus;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderFloorAmenity;
import org.bluepigeon.admin.model.BuilderFloorAmenityStages;
import org.bluepigeon.admin.model.BuilderFloorAmenitySubstages;
import org.bluepigeon.admin.model.BuilderGroup;
import org.bluepigeon.admin.model.BuilderLogo;
import org.bluepigeon.admin.model.BuilderOverallProjectStagesAndSubStages;
import org.bluepigeon.admin.model.BuilderPaymentStages;
import org.bluepigeon.admin.model.BuilderPaymentSubstages;
import org.bluepigeon.admin.model.BuilderProjectAmenity;
import org.bluepigeon.admin.model.BuilderProjectAmenityStages;
import org.bluepigeon.admin.model.BuilderProjectAmenitySubstages;
import org.bluepigeon.admin.model.BuilderProjectApprovalType;
import org.bluepigeon.admin.model.BuilderProjectLevel;
import org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration;
import org.bluepigeon.admin.model.BuilderProjectStatus;
import org.bluepigeon.admin.model.BuilderProjectType;
import org.bluepigeon.admin.model.BuilderPropertyType;
import org.bluepigeon.admin.model.BuilderSellerType;
import org.bluepigeon.admin.model.BuilderTaxType;
import org.bluepigeon.admin.model.BuildingAmenityIcon;
import org.bluepigeon.admin.model.BuildingStage;
import org.bluepigeon.admin.model.BuildingSubstage;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.FlatAmenityIcon;
import org.bluepigeon.admin.model.FlatStage;
import org.bluepigeon.admin.model.FlatSubstage;
import org.bluepigeon.admin.model.FloorAmenityIcon;
import org.bluepigeon.admin.model.FloorStage;
import org.bluepigeon.admin.model.FloorSubstage;
import org.bluepigeon.admin.model.Locality;
import org.bluepigeon.admin.model.ProjectAmenityIcon;
import org.bluepigeon.admin.model.ProjectImageGallery;
import org.bluepigeon.admin.model.ProjectStage;
import org.bluepigeon.admin.model.ProjectSubstage;
import org.bluepigeon.admin.model.Tax;
import org.bluepigeon.admin.service.ImageUploader;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

import com.amazonaws.Response;
import com.fasterxml.jackson.databind.deser.BuilderBasedDeserializer;

@Path("create")
public class CreateProjectController {
	@Context ServletContext context;
	ImageUploader imageUploader = new ImageUploader();
//	@POST
//	@Path("/builder/new/save")
//	@Produces(MediaType.APPLICATION_JSON)
//	@Consumes(MediaType.APPLICATION_JSON)
//	public ResponseMessage addBuilder(BuilderDetails builderDetails) {
//		
//		 BuilderDetailsDAO builderDetalsDAO = new BuilderDetailsDAO();
//		  return  builderDetalsDAO.save(builderDetails);
//	
//	}

	@POST
	@Path("/builder/new/add")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuilder(
			@FormDataParam("bname") String name,
			@FormDataParam("status") byte status,
			@FormDataParam("hoffice") String headOffice,
			@FormDataParam("hphno") String phone,
			@FormDataParam("hemail") String uhemail,
			@FormDataParam("password") String password,
			@FormDataParam("abuilder") String aboutBuilder,
			@FormDataParam("cname[]") List<FormDataBodyPart> cname,
			@FormDataParam("ccontact[]") List<FormDataBodyPart> ccontact,
			@FormDataParam("cemail[]") List<FormDataBodyPart> cemail,
			@FormDataParam("builder_logo[]") List<FormDataBodyPart> builder_logo
			
			) {
	  ResponseMessage responseMessage = new ResponseMessage();
	  Builder builder = new Builder();
	  builder.setName(name);
	  builder.setStatus(status);
	  builder.setAboutBuilder(aboutBuilder);
	  builder.setEmail(uhemail);
	  builder.setLoginStatus(0);
	  builder.setHeadOffice(headOffice);
	  builder.setMobile(phone);
	  builder.setPassword(password);
	  BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
	  responseMessage = builderDetailsDAO.saveBuilder(builder);
	  if(responseMessage.getId() > 0){
		  builder.setId(responseMessage.getId());
		  byte loginStatus = 0;
		  boolean empStatus = false;
		  if(status == 1)
			  empStatus = true;
		  City city = new City();
		  city.setId(1);
		  Locality locality = new Locality();
		  locality.setId(3);
		  BuilderEmployeeAccessType builderEmployeeAccessType = new BuilderEmployeeAccessType();
		  builderEmployeeAccessType.setId(1);
		  
		  BuilderEmployee builderEmployee = new BuilderEmployee();
		  builderEmployee.setBuilder(builder);
		  builderEmployee.setBuilderEmployeeAccessType(builderEmployeeAccessType);
		  builderEmployee.setCity(city);
		  builderEmployee.setLocality(locality);
		  builderEmployee.setName(name);
		  builderEmployee.setLoginStatus(loginStatus);
		  builderEmployee.setStatus(empStatus);
		  builderEmployee.setEmail(uhemail);
		  builderEmployee.setPassword(password);
		  builderEmployee.setCurrentAddress("");
		  builderEmployee.setPermanentAddress("");
		  builderEmployee.setEmployeeId("");
		  builderEmployee.setMobile(phone);
		  BuilderDetailsDAO builderDetailsDAO2 = new BuilderDetailsDAO();
		  builderDetailsDAO2.saveEmployee(builderEmployee);
		  
		  if(cname.size()>0){
			  int i=0;
			  List<BuilderCompanyNames> builderCompanyNames = new ArrayList<BuilderCompanyNames>();
			  for(FormDataBodyPart company_name : cname){
				  BuilderCompanyNames builderCompanyNames2 = new BuilderCompanyNames();
				  builderCompanyNames2.setBuilder(builder);
				  if(company_name.getValueAs(String.class).toString() != null && !company_name.getValueAs(String.class).toString().isEmpty()) {
					  builderCompanyNames2.setName(cname.get(i).getValueAs(String.class).toString());
				  }
				  if(ccontact.get(i).getValueAs(String.class).toString() != null && !ccontact.get(i).getValueAs(String.class).toString().isEmpty()){
					  builderCompanyNames2.setContact(ccontact.get(i).getValueAs(String.class).toString());
				  }
				  if(cemail.get(i).getValueAs(String.class).toString() != null && !cemail.get(i).getValueAs(String.class).toString().isEmpty()){
					  builderCompanyNames2.setEmail(cemail.get(i).getValueAs(String.class).toString());
				  }
				  builderCompanyNames.add(builderCompanyNames2);
			  }
			  if(builderCompanyNames.size() > 0){
				   new BuilderDetailsDAO().saveBuilderCompany(builderCompanyNames);
			  }
		  }
		  if(builder_logo != null){
			  try {	
					List<BuilderLogo> builderLogos = new ArrayList<BuilderLogo>();
					//for multiple inserting images.
					if (builder_logo.size() > 0) {
						for(int i=0 ;i < builder_logo.size();i++)
						{
							if(builder_logo.get(i).getFormDataContentDisposition().getFileName() != null && !builder_logo.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
								BuilderLogo builderLogo = new BuilderLogo();
								String gallery_name = builder_logo.get(i).getFormDataContentDisposition().getFileName();
								long millis = System.currentTimeMillis() % 1000;
								gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
								gallery_name = "images/project/builder/"+gallery_name;
								String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
								//System.out.println("for loop image path: "+uploadGalleryLocation);
								this.imageUploader.writeToFile(builder_logo.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
								builderLogo.setBuilder(builder);
								builderLogo.setBuilderUrl(gallery_name);
								builderLogos.add(builderLogo);
							}
						}
						if(builderLogos.size() > 0) {
							builderDetailsDAO2.saveBuilderLogo(builderLogos);
						}
						responseMessage.setStatus(1);
						responseMessage.setMessage("Builder added successfully");
					}
				} catch(Exception e) {
					e.printStackTrace();
					responseMessage.setStatus(0);
					responseMessage.setMessage("Unable to save image");
				}
		  }
	  }else{
		  responseMessage.setStatus(0);
		  responseMessage.setMessage("Fail to add new Builder");
	  }
	  
	  return responseMessage;
	}
	
	
	@POST
	@Path("/builder/new/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuilder(
			@FormDataParam("ubuilder_id") int id,
			@FormDataParam("ubname") String name,
			@FormDataParam("ustatus") byte status,
			@FormDataParam("uhoffice") String headOffice,
			@FormDataParam("uhphno") String phone,
			@FormDataParam("uhemail") String uhemail,
			@FormDataParam("uabuilder") String aboutBuilder,
			@FormDataParam("company_id[]") List<FormDataBodyPart> cid,
			@FormDataParam("uname[]") List<FormDataBodyPart> cname,
			@FormDataParam("ucontact[]") List<FormDataBodyPart> ucontact,
			@FormDataParam("uemail[]") List<FormDataBodyPart> cemail,
			@FormDataParam("builder_logo[]") List<FormDataBodyPart> builder_logo,
			@FormDataParam("builder_logo_id[]")  List<FormDataBodyPart> builder_logo_id
			) {
			Builder builder = new Builder();
			BuilderDetailsDAO builderDetalsDAO = new BuilderDetailsDAO();
			ResponseMessage msg = new ResponseMessage();
			if(id>0){
				
				builder.setId(id);
				builder.setName(name);
				builder.setStatus(status);
				builder.setEmail(uhemail);
				builder.setMobile(phone);
				String passworddao = new BuilderDetailsDAO().getActiveBuilderById(id).get(0).getPassword();
				builder.setPassword(passworddao);
				int loginStatus = new BuilderDetailsDAO().getActiveBuilderById(id).get(0).getLoginStatus();
				builder.setLoginStatus(loginStatus);
				builder.setAboutBuilder(aboutBuilder);
				builder.setHeadOffice(headOffice);
				builderDetalsDAO.updateBuilder(builder);
			}
			if(cname.size()>0){
				List<BuilderCompanyNames> updatebuilderCompanyNames = new ArrayList<BuilderCompanyNames>();
				List<BuilderCompanyNames> saveBuilderCompanyNames = new ArrayList<BuilderCompanyNames>();
				int i=0;
				for(FormDataBodyPart names : cname)
				{
					if(cid.get(i).getValueAs(Integer.class) != 0 && cid.get(i).getValueAs(Integer.class) != null){
						BuilderCompanyNames builderCompanyNames2 = new BuilderCompanyNames();
						builderCompanyNames2.setBuilder(builder);
						builderCompanyNames2.setId(cid.get(i).getValueAs(Integer.class));
	 					if(names.getValueAs(String.class) != null || names.getValueAs(String.class).trim().length() > 0){
							builderCompanyNames2.setName(names.getValueAs(String.class).toString());
						}
	 					if(ucontact.get(i).getValueAs(String.class) != null || ucontact.get(i).getValueAs(String.class).trim().length() >0){
	 						builderCompanyNames2.setContact(ucontact.get(i).getValueAs(String.class).toString());
	 					}
	 					if(cemail.get(i).getValueAs(String.class) != null || cemail.get(i).getValueAs(String.class).trim().length() > 0){
	 						builderCompanyNames2.setEmail(cemail.get(i).getValueAs(String.class).toString());
	 					}
	 					updatebuilderCompanyNames.add(builderCompanyNames2);
					}else{
						BuilderCompanyNames builderCompanyNames2 = new BuilderCompanyNames();
						builderCompanyNames2.setBuilder(builder);
	 					if(names.getValueAs(String.class) != null || names.getValueAs(String.class).trim().length() > 0){
							builderCompanyNames2.setName(names.getValueAs(String.class).toString());
						}
	 					if(ucontact.get(i).getValueAs(String.class) != null || ucontact.get(i).getValueAs(String.class).trim().length() >0){
	 						builderCompanyNames2.setContact(ucontact.get(i).getValueAs(String.class).toString());
	 					}
	 					if(cemail.get(i).getValueAs(String.class) != null || cemail.get(i).getValueAs(String.class).trim().length() > 0){
	 						builderCompanyNames2.setEmail(cemail.get(i).getValueAs(String.class).toString());
	 					}
	 					saveBuilderCompanyNames.add(builderCompanyNames2);
					}
					i++;
				}
				if(updatebuilderCompanyNames.size()>0)
				{
					builderDetalsDAO.updateBuilderCompanyName(updatebuilderCompanyNames);
				}
				if(saveBuilderCompanyNames.size() > 0){
					builderDetalsDAO.saveBuilderCompany(saveBuilderCompanyNames);
				}
			}
			System.out.println("BuilderLog Size :: "+builder_logo.size());
			
			if(builder_logo != null){
				if(builder_logo.size() > 0){
				try {	
					System.out.println("Inside Builder logo");
					List<BuilderLogo> builderLogos = new ArrayList<BuilderLogo>();
					List<BuilderLogo> saveBuilderLogos = new ArrayList<BuilderLogo>();
					//for multiple inserting images.
					//if (builder_logo.size() > 0) {
						for(int j=0 ;j < builder_logo.size();j++)
						{
							System.out.println("Inside For loop");
							if(builder_logo_id != null){
							if(builder_logo.get(j).getFormDataContentDisposition().getFileName() != null && !builder_logo.get(j).getFormDataContentDisposition().getFileName().isEmpty()) {
								if(builder_logo_id.get(j).getValueAs(Integer.class) != 0 && builder_logo_id.get(j).getValueAs(Integer.class) != null){
									System.out.println("Inside if condition");
									BuilderLogo builderLogo = new BuilderLogo();
									String gallery_name = builder_logo.get(j).getFormDataContentDisposition().getFileName();
									long millis = System.currentTimeMillis() % 1000;
									gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
									gallery_name = "images/project/builder/"+gallery_name;
									String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
									System.out.println("for loop image path update: "+uploadGalleryLocation);
									this.imageUploader.writeToFile(builder_logo.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
									builderLogo.setId(builder_logo_id.get(j).getValueAs(Integer.class));
									builderLogo.setBuilderUrl(gallery_name);
									builderLogo.setBuilder(builder);
									builderLogos.add(builderLogo);
								}}else{
									System.out.println("Inside else condition..");
									BuilderLogo builderLogo = new BuilderLogo();
									String gallery_name = builder_logo.get(j).getFormDataContentDisposition().getFileName();
									long millis = System.currentTimeMillis() % 1000;
									gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
									gallery_name = "images/project/builder/"+gallery_name;
									String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
									System.out.println("for loop image path add: "+uploadGalleryLocation);
									this.imageUploader.writeToFile(builder_logo.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
									builderLogo.setBuilderUrl(gallery_name);
									builderLogo.setBuilder(builder);
									saveBuilderLogos.add(builderLogo);
								}
								System.out.println("Out side else condition..");
							}
							System.out.println("Out side main if condition");
						}
						if(builderLogos.size() > 0) {
							builderDetalsDAO.updateBuilderLogo(builderLogos);
						}
						if(saveBuilderLogos.size() > 0){
							builderDetalsDAO.saveBuilderLogo(saveBuilderLogos);
						}
					}
				 catch(Exception e) {
					 System.out.println("Error "+e.getMessage());
					 e.printStackTrace();
					msg.setStatus(0);
					msg.setMessage("Unable to save image");
				}
				
				msg.setStatus(1);
				msg.setMessage("Builder updated successfully.");
			}else {
				msg.setMessage("Failed to add builder.");
				msg.setStatus(0);
			}
			}
		 
		return msg;
	}
	
	@POST
	@Path("/project/new/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseMessage addProject(ProjectDetails projectDetails) {
		ProjectDetailsDAO projectDetailsDAO = new ProjectDetailsDAO();
		  return  projectDetailsDAO.save(projectDetails);
	
	}

	@POST
	@Path("/project/new/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateProject(ProjectDetails builderDetails) {
		ProjectDetailsDAO builderDetalsDAO = new ProjectDetailsDAO();
		  return  builderDetalsDAO.update(builderDetails);
	}

	@DELETE
	@Path("/builder/new/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilder(@FormParam("amenityid") int amenityid) {
		byte isDeleted = 1;
		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
		builderBuildingAmenity.setId(amenityid);
		builderBuildingAmenity.setIsDeleted(isDeleted);
		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
		return builderBuildingAmenityDAO.delete(builderBuildingAmenity);
	}

	
	@POST
	@Path("/builder/building/amenity/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuilderBuildingAmenity(
			@FormDataParam("name") String name,
			@FormDataParam("status") byte status,
			@FormDataParam("building_amenity_icon[]") List<FormDataBodyPart> amenity_icons) {
		ResponseMessage responseMessage = new ResponseMessage();
		byte isDeleted = 0;
		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
        builderBuildingAmenity.setIsDeleted(isDeleted);
		builderBuildingAmenity.setName(name);
		builderBuildingAmenity.setStatus(status);
		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
		responseMessage = builderBuildingAmenityDAO.save(builderBuildingAmenity);
		if(amenity_icons != null){
			if(responseMessage.getId() > 0){
				builderBuildingAmenity.setId(responseMessage.getId());
				  try {	
						List<BuildingAmenityIcon> buildingAmenityIconList = new ArrayList<BuildingAmenityIcon>();
						//for multiple inserting images.
						if (amenity_icons.size() > 0) {
							for(int i=0 ;i < amenity_icons.size();i++)
							{
								if(amenity_icons.get(i).getFormDataContentDisposition().getFileName() != null && !amenity_icons.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
									BuildingAmenityIcon buildingAmenityIcon = new BuildingAmenityIcon();
									String gallery_name = amenity_icons.get(i).getFormDataContentDisposition().getFileName();
									long millis = System.currentTimeMillis() % 1000;
									gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
									gallery_name = "images/project/building/amenityicon/"+gallery_name;
									String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
									//System.out.println("for loop image path: "+uploadGalleryLocation);
									this.imageUploader.writeToFile(amenity_icons.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
									buildingAmenityIcon.setBuilderBuildingAmenity(builderBuildingAmenity);
									buildingAmenityIcon.setIconUrl(gallery_name);
									buildingAmenityIconList.add(buildingAmenityIcon);
								}
							}
							if(buildingAmenityIconList.size() > 0) {
								builderBuildingAmenityDAO.saveBuildingAmenityIcon(buildingAmenityIconList);
							}
						}
						responseMessage.setStatus(1);
						responseMessage.setMessage("Building Amenity added successfully");
					} catch(Exception e) {
						e.printStackTrace();
						responseMessage.setStatus(0);
						responseMessage.setMessage("Unable to save image");
					}
			}else{
				responseMessage.setStatus(0);
				responseMessage.setMessage("Fail to save Building Amenity");
			} 
		}
		return responseMessage;
	}
	
	
	
//	@POST
//	@Path("/builder/building/amenity/save")
//	@Produces(MediaType.APPLICATION_JSON)
//	public ResponseMessage addBuilderBuildingAmenity(@FormParam("name") String name, @FormParam("status") byte status) {
//		byte isDeleted = 0;
//		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
//        builderBuildingAmenity.setIsDeleted(isDeleted);
//		builderBuildingAmenity.setName(name);
//		builderBuildingAmenity.setStatus(status);
//		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
//		return builderBuildingAmenityDAO.save(builderBuildingAmenity);
//	}

	
	
	@POST
	@Path("/builder/building/amenity/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuilderBuildingAmenity(
			@FormDataParam("uamenity_id") int id,
			@FormDataParam("uname") String name,
			@FormDataParam("ustatus") byte status,
			@FormDataParam("building_amenity_id[]") List<FormDataBodyPart> amenity_ids,
			@FormDataParam("building_amenity_icon[]") List<FormDataBodyPart> amenity_icons) {
		
		ResponseMessage responseMessage = new ResponseMessage();
		byte isDeleted = 0;
		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
		builderBuildingAmenity.setId(id);
		builderBuildingAmenity.setName(name);
		builderBuildingAmenity.setStatus(status);
		builderBuildingAmenity.setIsDeleted(isDeleted);

		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
		 builderBuildingAmenityDAO.update(builderBuildingAmenity);
		 if(amenity_icons != null){
			 if(amenity_icons.size() > 0){
					try {	
						System.out.println("Inside Builder logo");
						List<BuildingAmenityIcon> updateBuildingAmenityIcon = new ArrayList<BuildingAmenityIcon>();
						List<BuildingAmenityIcon> saveBuildingAmenityIcon = new ArrayList<BuildingAmenityIcon>();
						//for multiple inserting images.
						//if (builder_logo.size() > 0) {
							for(int j=0 ;j < amenity_icons.size();j++)
							{
								System.out.println("Inside For loop");
								if(amenity_ids != null){
								if(amenity_icons.get(j).getFormDataContentDisposition().getFileName() != null && !amenity_icons.get(j).getFormDataContentDisposition().getFileName().isEmpty()) {
									if(amenity_ids.get(j).getValueAs(Integer.class) != 0 && amenity_ids.get(j).getValueAs(Integer.class) != null){
										BuildingAmenityIcon buildingAmenityIcon = new BuildingAmenityIcon();
										String gallery_name = amenity_icons.get(j).getFormDataContentDisposition().getFileName();
										long millis = System.currentTimeMillis() % 1000;
										gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
										gallery_name = "images/project/building/amenityicon/"+gallery_name;
										String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
										System.out.println("for loop image path update: "+uploadGalleryLocation);
										this.imageUploader.writeToFile(amenity_icons.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
										buildingAmenityIcon.setId(amenity_ids.get(j).getValueAs(Integer.class));
										buildingAmenityIcon.setIconUrl(gallery_name);
										buildingAmenityIcon.setBuilderBuildingAmenity(builderBuildingAmenity);
										updateBuildingAmenityIcon.add(buildingAmenityIcon);
									}}}else{
										System.out.println("Inside else condition..");
										BuildingAmenityIcon buildingAmenityIcon = new BuildingAmenityIcon();
										String gallery_name = amenity_icons.get(j).getFormDataContentDisposition().getFileName();
										long millis = System.currentTimeMillis() % 1000;
										gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
										gallery_name = "images/project/building/amenityicon/"+gallery_name;
										String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
										System.out.println("for loop image path add: "+uploadGalleryLocation);
										this.imageUploader.writeToFile(amenity_icons.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
										buildingAmenityIcon.setIconUrl(gallery_name);
										buildingAmenityIcon.setBuilderBuildingAmenity(builderBuildingAmenity);
										saveBuildingAmenityIcon.add(buildingAmenityIcon);
									}
							}
							if(updateBuildingAmenityIcon.size() > 0) {
								builderBuildingAmenityDAO.updateBuildingAmenityIcon(updateBuildingAmenityIcon);
							}
							if(saveBuildingAmenityIcon.size() > 0){
								builderBuildingAmenityDAO.saveBuildingAmenityIcon(saveBuildingAmenityIcon);
							}
							responseMessage.setStatus(1);
							responseMessage.setMessage("Building Amenity updated successfully.");
						}
					 catch(Exception e) {
						 e.printStackTrace();
						 responseMessage.setStatus(0);
						 responseMessage.setMessage("Unable to save image");
					}
			 }else{
				 responseMessage.setStatus(0);
				 responseMessage.setMessage("Fail to update Building Amenity");
			 }
		 }
		 return responseMessage;
	}
	
	
	
//	@POST
//	@Path("/builder/building/amenity/update")
//	@Produces(MediaType.APPLICATION_JSON)
//	public ResponseMessage updateBuilderBuildingAmenity(@FormParam("id") int id, @FormParam("name") String name,
//			@FormParam("status") byte status) {
//		byte isDeleted = 0;
//		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
//		builderBuildingAmenity.setId(id);
//		builderBuildingAmenity.setName(name);
//		builderBuildingAmenity.setStatus(status);
//		builderBuildingAmenity.setIsDeleted(isDeleted);
//
//		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
//		return builderBuildingAmenityDAO.update(builderBuildingAmenity);
//	}

	@DELETE
	@Path("/builder/building/amenity/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderBuildingAmenity(@FormParam("amenityid") int amenityid) {
		byte isDeleted = 1;
		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
		builderBuildingAmenity.setId(amenityid);
		builderBuildingAmenity.setIsDeleted(isDeleted);
		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
		return builderBuildingAmenityDAO.delete(builderBuildingAmenity);
	}

//	@GET
//	@Path("/builder/building/amenity/list")
//	@Produces(MediaType.APPLICATION_JSON)
//	public List<BuilderBuildingAmenity> getBuilderBuildingAmenity(@QueryParam("amenity_id") int amenity_id) {
//		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
//		return builderBuildingAmenityDAO.getBuilderBuildingAmenityById(amenity_id);
//	}

	@GET
	@Path("/builder/building/amenity/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuildingAmenityList> getBuilderBuildingAmenity(@QueryParam("amenity_id") int amenity_id) {
		BuilderBuildingAmenityStagesDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityStagesDAO();
		return builderBuildingAmenityDAO.getBuildingAmenityById(amenity_id);
	}
	
	@POST
	@Path("/builder/building/amenity/stages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderBuildingAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
		builderBuildingAmenity.setId(amenityId);

		BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();

		builderBuildingAmenityStages.setName(name);
		builderBuildingAmenityStages.setStatus(status);
		builderBuildingAmenityStages.setBuilderBuildingAmenity(builderBuildingAmenity);
		BuilderBuildingAmenityStagesDAO builderBuildingAmenityStagesDAO = new BuilderBuildingAmenityStagesDAO();
		return builderBuildingAmenityStagesDAO.save(builderBuildingAmenityStages);
	}

	@POST
	@Path("/builder/building/amenity/stages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderBuildingAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
		builderBuildingAmenity.setId(amenityId);

		BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();
		builderBuildingAmenityStages.setId(id);
		builderBuildingAmenityStages.setName(name);
		builderBuildingAmenityStages.setStatus(status);
		builderBuildingAmenityStages.setBuilderBuildingAmenity(builderBuildingAmenity);
		BuilderBuildingAmenityStagesDAO builderBuildingAmenityStagesDAO = new BuilderBuildingAmenityStagesDAO();
		return builderBuildingAmenityStagesDAO.update(builderBuildingAmenityStages);
	}

	@DELETE
	@Path("/builder/building/amenity/stages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderBuildingAmenityStages(@FormParam("amenity_substage_id") int amenityid) {
		byte isDeleted = 1;
		BuilderBuildingAmenityStages builderBuildingAmenity = new BuilderBuildingAmenityStages();
		builderBuildingAmenity.setId(amenityid);
		builderBuildingAmenity.setIsDeleted(isDeleted);
		BuilderBuildingAmenityStagesDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityStagesDAO();
		return builderBuildingAmenityDAO.delete(builderBuildingAmenity);
	}

	@GET
	@Path("/builder/building/amenity/stages/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderBuildingAmenityStages> getBuilderBuildingAmenityStages(
			@QueryParam("amenity_id") int amenity_id) {
		BuilderBuildingAmenityStagesDAO builderBuildingAmenityStagesDAO = new BuilderBuildingAmenityStagesDAO();
		return builderBuildingAmenityStagesDAO.getStateByAmenityId(amenity_id);
	}

	@POST
	@Path("/builder/building/amenity/substages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderBuildingAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();
		builderBuildingAmenityStages.setId(stageId);

		BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages = new BuilderBuildingAmenitySubstages();

		builderBuildingAmenitySubstages.setName(name);
		builderBuildingAmenitySubstages.setStatus(status);
		builderBuildingAmenitySubstages.setBuilderBuildingAmenityStages(builderBuildingAmenityStages);
		BuilderBuildingAmenitySubstagesDAO builderBuildingAmenitySubstagesDAO = new BuilderBuildingAmenitySubstagesDAO();
		return builderBuildingAmenitySubstagesDAO.save(builderBuildingAmenitySubstages);
	}

	@POST
	@Path("/builder/building/amenity/substages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderBuildingAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();
		builderBuildingAmenityStages.setId(stageId);

		BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages = new BuilderBuildingAmenitySubstages();
		builderBuildingAmenitySubstages.setId(id);
		builderBuildingAmenitySubstages.setName(name);
		builderBuildingAmenitySubstages.setStatus(status);
		builderBuildingAmenitySubstages.setBuilderBuildingAmenityStages(builderBuildingAmenityStages);
		BuilderBuildingAmenitySubstagesDAO builderBuildingAmenitySubstagesDAO = new BuilderBuildingAmenitySubstagesDAO();
		return builderBuildingAmenitySubstagesDAO.update(builderBuildingAmenitySubstages);
	}

	@DELETE
	@Path("/builder/building/amenity/substages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderBuildingAmenitySubstages(@FormParam("substage_id") int substageid) {

		BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages = new BuilderBuildingAmenitySubstages();
		builderBuildingAmenitySubstages.setId(substageid);
		BuilderBuildingAmenitySubstagesDAO builderBuildingAmenitySubstagesDAO = new BuilderBuildingAmenitySubstagesDAO();
		return builderBuildingAmenitySubstagesDAO.delete(builderBuildingAmenitySubstages);
	}

	@POST
	@Path("/builder/project/amenity/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuilderProjectAmenity(
			@FormDataParam("name") String name,
			@FormDataParam("status") byte status,
			@FormDataParam("project_amenity_icon[]")List<FormDataBodyPart> amenity_icons) {
		ResponseMessage responseMessage = new ResponseMessage();
		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();

		builderProjectAmenity.setName(name);
		builderProjectAmenity.setStatus(status);
		BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
		
		responseMessage=builderProjectAmenityDAO.save(builderProjectAmenity);
		if(amenity_icons != null){
			if(responseMessage.getId()>0){
				builderProjectAmenity.setId(responseMessage.getId());
					  try {	
							List<ProjectAmenityIcon> projectAmenityIconList = new ArrayList<ProjectAmenityIcon>();
							//for multiple inserting images.
							if (amenity_icons.size() > 0) {
								for(int i=0 ;i < amenity_icons.size();i++)
								{
									if(amenity_icons.get(i).getFormDataContentDisposition().getFileName() != null && !amenity_icons.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
										ProjectAmenityIcon projectAmenityIcon = new ProjectAmenityIcon();
										String gallery_name = amenity_icons.get(i).getFormDataContentDisposition().getFileName();
										long millis = System.currentTimeMillis() % 1000;
										gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
										gallery_name = "images/project/projectamenityicon/"+gallery_name;
										String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
										System.out.println("for loop image path: "+uploadGalleryLocation);
										this.imageUploader.writeToFile(amenity_icons.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
										projectAmenityIcon.setBuilderProjectAmenity(builderProjectAmenity);
										projectAmenityIcon.setIconUrl(gallery_name);
										projectAmenityIconList.add(projectAmenityIcon);
									}
								}
								if(projectAmenityIconList.size() > 0) {
									builderProjectAmenityDAO.saveProjectAmenityIcon(projectAmenityIconList);
									responseMessage.setStatus(1);
									responseMessage.setMessage("save image");
								}
							}
							responseMessage.setStatus(1);
							responseMessage.setMessage("Project Amenity added successfully");
						} catch(Exception e) {
							e.printStackTrace();
							responseMessage.setStatus(0);
							responseMessage.setMessage("Unable to save image");
						}
			}else{
				responseMessage.setStatus(0);
				responseMessage.setMessage("Unable to save Project Amenity");
			}
		}
		return responseMessage;
	}

//	public ResponseMessage addBuilderProjectAmenity(@FormParam("name") String name, @FormParam("status") byte status) {
//		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();
//
//		builderProjectAmenity.setName(name);
//		builderProjectAmenity.setStatus(status);
//		BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
//		return builderProjectAmenityDAO.save(builderProjectAmenity);
//	}

	@POST
	@Path("/builder/project/amenity/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuilderProjectAmenity(
			@FormDataParam("uamenity_id") int amenity_id,
			@FormDataParam("uname") String name,
			@FormDataParam("ustatus") byte status,
			@FormDataParam("project_amenity_id[]") List<FormDataBodyPart> amenity_ids,
			@FormDataParam("project_amenity_icon[]") List<FormDataBodyPart> amenity_icons
			){
		ResponseMessage responseMessage = new ResponseMessage();
		BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();
		builderProjectAmenity.setId(amenity_id);
		builderProjectAmenity.setName(name);
		builderProjectAmenity.setStatus(status);
		responseMessage = builderProjectAmenityDAO.update(builderProjectAmenity);
		if(amenity_icons != null){
		if(amenity_icons.size() > 0){
			try {	
				System.out.println("Inside Builder logo");
				List<ProjectAmenityIcon> updateProjectAmenityIcon = new ArrayList<ProjectAmenityIcon>();
				List<ProjectAmenityIcon> saveProjectAmenityIcon = new ArrayList<ProjectAmenityIcon>();
				//for multiple inserting images.
				//if (builder_logo.size() > 0) {
					for(int j=0 ;j < amenity_icons.size();j++)
					{
						System.out.println("Inside For loop");
						if(amenity_ids != null){
						if(amenity_icons.get(j).getFormDataContentDisposition().getFileName() != null && !amenity_icons.get(j).getFormDataContentDisposition().getFileName().isEmpty()) {
							if(amenity_ids.get(j).getValueAs(Integer.class) != 0 && amenity_ids.get(j).getValueAs(Integer.class) != null){
								ProjectAmenityIcon projectAmenityIcon = new ProjectAmenityIcon();
								String gallery_name = amenity_icons.get(j).getFormDataContentDisposition().getFileName();
								long millis = System.currentTimeMillis() % 1000;
								gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
								gallery_name = "images/project/projectamenityicon/"+gallery_name;
								String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
								System.out.println("for loop image path update: "+uploadGalleryLocation);
								this.imageUploader.writeToFile(amenity_icons.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
								projectAmenityIcon.setId(amenity_ids.get(j).getValueAs(Integer.class));
								projectAmenityIcon.setIconUrl(gallery_name);
								projectAmenityIcon.setBuilderProjectAmenity(builderProjectAmenity);
								updateProjectAmenityIcon.add(projectAmenityIcon);
							}}}else{
								ProjectAmenityIcon projectAmenityIcon = new ProjectAmenityIcon();
								String gallery_name = amenity_icons.get(j).getFormDataContentDisposition().getFileName();
								long millis = System.currentTimeMillis() % 1000;
								gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
								gallery_name = "images/project/projectamenityicon/"+gallery_name;
								String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
								System.out.println("for loop image path add: "+uploadGalleryLocation);
								this.imageUploader.writeToFile(amenity_icons.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
								projectAmenityIcon.setIconUrl(gallery_name);
								projectAmenityIcon.setBuilderProjectAmenity(builderProjectAmenity);
								saveProjectAmenityIcon.add(projectAmenityIcon);
							}
						}
					
					if(updateProjectAmenityIcon.size() > 0) {
						builderProjectAmenityDAO.updateProjectAmenityIcon(updateProjectAmenityIcon);
					}
					if(saveProjectAmenityIcon.size() > 0){
						builderProjectAmenityDAO.saveProjectAmenityIcon(saveProjectAmenityIcon);
					}
					responseMessage.setStatus(1);
					responseMessage.setMessage("Project Amenity updated successfully.");
				}
			 catch(Exception e) {
				 responseMessage.setStatus(0);
				 responseMessage.setMessage("Unable to save image");
			}
		}
			
		}else{
			responseMessage.setStatus(1);
			responseMessage.setMessage("Project Amenity updated successfully without icon.");
		}
		return responseMessage;
		
	}
	
//	public ResponseMessage updateBuilderProjectAmenity(@FormParam("id") int id, @FormParam("name") String name,
//			@FormParam("status") byte status) {
//
//		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();
//		builderProjectAmenity.setId(id);
//		builderProjectAmenity.setName(name);
//		builderProjectAmenity.setStatus(status);
	//	BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
		//return builderProjectAmenityDAO.update(builderProjectAmenity);
//	}

	@DELETE
	@Path("/builder/project/amenity/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectAmenity(@FormParam("amenityid") int amenityid) {

		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();
		builderProjectAmenity.setId(amenityid);

		BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
		return builderProjectAmenityDAO.delete(builderProjectAmenity);
	}

	@GET
	@Path("/builder/project/amenity/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderProjectAmenity> getBuilderProjectAmenity(@QueryParam("amenity_id") int amenity_id) {
		BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
		return builderProjectAmenityDAO.getBuilderProjectAmenityById(amenity_id);
	}

	@POST
	@Path("/builder/project/amenity/stages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();
		builderProjectAmenity.setId(amenityId);

		BuilderProjectAmenityStages builderProjectAmenityStages = new BuilderProjectAmenityStages();

		builderProjectAmenityStages.setName(name);
		builderProjectAmenityStages.setStatus(status);
		builderProjectAmenityStages.setBuilderProjectAmenity(builderProjectAmenity);
		BuilderProjectAmenityStagesDAO builderProjectAmenityStagesDAO = new BuilderProjectAmenityStagesDAO();
		return builderProjectAmenityStagesDAO.save(builderProjectAmenityStages);
	}

	@POST
	@Path("/builder/project/amenity/stages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();
		builderProjectAmenity.setId(amenityId);

		BuilderProjectAmenityStages builderProjectAmenityStages = new BuilderProjectAmenityStages();
		builderProjectAmenityStages.setId(id);
		builderProjectAmenityStages.setName(name);
		builderProjectAmenityStages.setStatus(status);
		builderProjectAmenityStages.setBuilderProjectAmenity(builderProjectAmenity);
		BuilderProjectAmenityStagesDAO builderProjectAmenityStagesDAO = new BuilderProjectAmenityStagesDAO();
		return builderProjectAmenityStagesDAO.update(builderProjectAmenityStages);
	}

	@DELETE
	@Path("/builder/project/amenity/stages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectAmenityStages(@FormParam("amenity_substage_id") int amenityid) {

		BuilderProjectAmenityStages builderProjectAmenityStages = new BuilderProjectAmenityStages();
		builderProjectAmenityStages.setId(amenityid);
		BuilderProjectAmenityStagesDAO builderProjectAmenityDAO = new BuilderProjectAmenityStagesDAO();
		return builderProjectAmenityDAO.delete(builderProjectAmenityStages);
	}

	@GET
	@Path("/builder/project/amenity/stages/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderProjectAmenityStages> getBuilderProjectAmenityStages(@QueryParam("amenity_id") int amenity_id) {
		BuilderProjectAmenityStagesDAO builderProjectAmenityStagesDAO = new BuilderProjectAmenityStagesDAO();
		return builderProjectAmenityStagesDAO.getStateByAmenityId(amenity_id);
	}

	@POST
	@Path("/builder/project/amenity/substages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderProjectAmenityStages builderProjectAmenityStages = new BuilderProjectAmenityStages();
		builderProjectAmenityStages.setId(stageId);

		BuilderProjectAmenitySubstages builderProjectAmenitySubstages = new BuilderProjectAmenitySubstages();

		builderProjectAmenitySubstages.setName(name);
		builderProjectAmenitySubstages.setStatus(status);
		builderProjectAmenitySubstages.setBuilderProjectAmenityStages(builderProjectAmenityStages);
		BuilderProjectAmenitySubstagesDAO builderProjectAmenitySubstagesDAO = new BuilderProjectAmenitySubstagesDAO();
		return builderProjectAmenitySubstagesDAO.save(builderProjectAmenitySubstages);
	}

	@POST
	@Path("/builder/project/amenity/substages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderProjectAmenityStages builderProjectAmenityStages = new BuilderProjectAmenityStages();
		builderProjectAmenityStages.setId(stageId);

		BuilderProjectAmenitySubstages builderProjectAmenitySubstages = new BuilderProjectAmenitySubstages();
		builderProjectAmenitySubstages.setId(id);
		builderProjectAmenitySubstages.setName(name);
		builderProjectAmenitySubstages.setStatus(status);
		builderProjectAmenitySubstages.setBuilderProjectAmenityStages(builderProjectAmenityStages);
		BuilderProjectAmenitySubstagesDAO builderProjectAmenitySubstagesDAO = new BuilderProjectAmenitySubstagesDAO();
		return builderProjectAmenitySubstagesDAO.update(builderProjectAmenitySubstages);
	}

	@DELETE
	@Path("/builder/project/amenity/substages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectAmenitySubstages(@FormParam("substage_id") int substageid) {

		BuilderProjectAmenitySubstages builderProjectAmenitySubstages = new BuilderProjectAmenitySubstages();
		builderProjectAmenitySubstages.setId(substageid);
		BuilderProjectAmenitySubstagesDAO builderProjectAmenitySubstagesDAO = new BuilderProjectAmenitySubstagesDAO();
		return builderProjectAmenitySubstagesDAO.delete(builderProjectAmenitySubstages);
	}

	
	
	@POST
	@Path("/builder/floor/amenity/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuilderFloorAmenity(
			@FormDataParam("name") String name, 
			@FormDataParam("status") byte status,
			@FormDataParam("floor_amenity_icon[]") List<FormDataBodyPart> amenity_icons) {
		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
		ResponseMessage responseMessage = new ResponseMessage();
		builderFloorAmenity.setName(name);
		builderFloorAmenity.setStatus(status);
		BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
		responseMessage = builderFloorAmenityDAO.save(builderFloorAmenity);
		if(amenity_icons != null){
			if(responseMessage.getId()>0){
					builderFloorAmenity.setId(responseMessage.getId());
					  try {	
							List<FloorAmenityIcon> floorAmenityIconList = new ArrayList<FloorAmenityIcon>();
							//for multiple inserting images.
							if (amenity_icons.size() > 0) {
								for(int i=0 ;i < amenity_icons.size();i++)
								{
									if(amenity_icons.get(i).getFormDataContentDisposition().getFileName() != null && !amenity_icons.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
										FloorAmenityIcon floorAmenityIcon = new FloorAmenityIcon();
										String gallery_name = amenity_icons.get(i).getFormDataContentDisposition().getFileName();
										long millis = System.currentTimeMillis() % 1000;
										gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
										gallery_name = "images/project/floor/amenityicon/"+gallery_name;
										String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
										//System.out.println("for loop image path: "+uploadGalleryLocation);
										this.imageUploader.writeToFile(amenity_icons.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
										floorAmenityIcon.setBuilderFloorAmenity(builderFloorAmenity);
										floorAmenityIcon.setIconUrl(gallery_name);
										floorAmenityIconList.add(floorAmenityIcon);
									}
								}
								if(floorAmenityIconList.size() > 0) {
									builderFloorAmenityDAO.saveFloorAmenityIcon(floorAmenityIconList);
								}
							}
							responseMessage.setStatus(1);
							responseMessage.setMessage("Floor Amenity added successfully");
						} catch(Exception e) {
							//e.printStackTrace();
							responseMessage.setStatus(0);
							responseMessage.setMessage("Unable to save image");
						}	
			}else{
				responseMessage.setStatus(0);
				responseMessage.setMessage("Fail to save Floor Amenity");
			}
		}
		return responseMessage;
	}

	@POST
	@Path("/builder/floor/amenity/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuilderFloorAmenity(
			@FormDataParam("uamenity_id") int id, 
			@FormDataParam("uname") String name,
			@FormDataParam("ustatus") byte status,
			@FormDataParam("floor_amenity_id[]")List<FormDataBodyPart> amenity_ids,
			@FormDataParam("floor_amenity_icon[]")List<FormDataBodyPart> amenity_icons) {
		ResponseMessage responseMessage = new ResponseMessage();
		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
		builderFloorAmenity.setId(id);
		builderFloorAmenity.setName(name);
		builderFloorAmenity.setStatus(status);
		BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
		responseMessage = builderFloorAmenityDAO.update(builderFloorAmenity);
		if(amenity_icons != null){
			 if(amenity_icons.size() > 0){
					try {	
						List<FloorAmenityIcon> updateFloorAmenityIcon = new ArrayList<FloorAmenityIcon>();
						List<FloorAmenityIcon> saveFloorAmenityIcon = new ArrayList<FloorAmenityIcon>();
						//for multiple inserting images.
						//if (builder_logo.size() > 0) {
							for(int j=0 ;j < amenity_icons.size();j++)
							{
								System.out.println("Inside For loop");
								if(amenity_ids != null){
								if(amenity_icons.get(j).getFormDataContentDisposition().getFileName() != null && !amenity_icons.get(j).getFormDataContentDisposition().getFileName().isEmpty()) {
									if(amenity_ids.get(j).getValueAs(Integer.class) != 0 && amenity_ids.get(j).getValueAs(Integer.class) != null){
										FloorAmenityIcon floorAmenityIcon = new FloorAmenityIcon();
										String gallery_name = amenity_icons.get(j).getFormDataContentDisposition().getFileName();
										long millis = System.currentTimeMillis() % 1000;
										gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
										gallery_name = "images/project/floor/amenityicon/"+gallery_name;
										String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
										System.out.println("for loop image path update: "+uploadGalleryLocation);
										this.imageUploader.writeToFile(amenity_icons.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
										floorAmenityIcon.setId(amenity_ids.get(j).getValueAs(Integer.class));
										floorAmenityIcon.setIconUrl(gallery_name);
										floorAmenityIcon.setBuilderFloorAmenity(builderFloorAmenity);
										updateFloorAmenityIcon.add(floorAmenityIcon);
									}}}else{
										System.out.println("Inside else condition..");
										FloorAmenityIcon floorAmenityIcon = new FloorAmenityIcon();
										String gallery_name = amenity_icons.get(j).getFormDataContentDisposition().getFileName();
										long millis = System.currentTimeMillis() % 1000;
										gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
										gallery_name = "images/project/floor/amenityicon/"+gallery_name;
										String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
										System.out.println("for loop image path add: "+uploadGalleryLocation);
										this.imageUploader.writeToFile(amenity_icons.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
										floorAmenityIcon.setIconUrl(gallery_name);
										floorAmenityIcon.setBuilderFloorAmenity(builderFloorAmenity);
										saveFloorAmenityIcon.add(floorAmenityIcon);
									}
							}
							if(updateFloorAmenityIcon.size() > 0) {
								builderFloorAmenityDAO.updateFloorAmenityIcon(updateFloorAmenityIcon);
							}
							if(saveFloorAmenityIcon.size() > 0){
								builderFloorAmenityDAO.saveFloorAmenityIcon(saveFloorAmenityIcon);
							}
//							responseMessage.setStatus(1);
//							responseMessage.setMessage("Floor Amenity updated successfully.");
						}
					 catch(Exception e) {
						 e.printStackTrace();
						 responseMessage.setStatus(0);
						 responseMessage.setMessage("Unable to save image");
					}
			 }else{
				 responseMessage.setStatus(0);
				 responseMessage.setMessage("Fail to update Floor Amenity");
			 }
		}
		 return responseMessage;
	}
	
//	@POST
//	@Path("/builder/floor/amenity/save")
//	@Produces(MediaType.APPLICATION_JSON)
//	public ResponseMessage addBuilderFloorAmenity(@FormParam("name") String name, @FormParam("status") byte status) {
//		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
//
//		builderFloorAmenity.setName(name);
//		builderFloorAmenity.setStatus(status);
//		BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
//		return builderFloorAmenityDAO.save(builderFloorAmenity);
//	}
//
//	@POST
//	@Path("/builder/floor/amenity/update")
//	@Produces(MediaType.APPLICATION_JSON)
//	public ResponseMessage updateBuilderFloorAmenity(@FormParam("id") int id, @FormParam("name") String name,
//			@FormParam("status") byte status) {
//
//		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
//		builderFloorAmenity.setId(id);
//		builderFloorAmenity.setName(name);
//		builderFloorAmenity.setStatus(status);
//		BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
//		return builderFloorAmenityDAO.update(builderFloorAmenity);
//	}

	@DELETE
	@Path("/builder/floor/amenity/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFloorAmenity(@FormParam("amenityid") int amenityid) {

		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
		builderFloorAmenity.setId(amenityid);

		BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
		return builderFloorAmenityDAO.delete(builderFloorAmenity);
	}

	@GET
	@Path("/builder/floor/amenity/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderFloorAmenity> getBuilderFloorAmenity(@QueryParam("amenity_id") int amenity_id) {
		BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
		return builderFloorAmenityDAO.getBuilderFloorAmenityById(amenity_id);
	}

	@POST
	@Path("/builder/floor/amenity/stages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFloorAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
		builderFloorAmenity.setId(amenityId);

		BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();

		builderFloorAmenityStages.setName(name);
		builderFloorAmenityStages.setStatus(status);
		builderFloorAmenityStages.setBuilderFloorAmenity(builderFloorAmenity);
		BuilderFloorAmenityStagesDAO builderFloorAmenityStagesDAO = new BuilderFloorAmenityStagesDAO();
		return builderFloorAmenityStagesDAO.save(builderFloorAmenityStages);
	}

	@POST
	@Path("/builder/floor/amenity/stages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFloorAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
		builderFloorAmenity.setId(amenityId);

		BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
		builderFloorAmenityStages.setId(id);
		builderFloorAmenityStages.setName(name);
		builderFloorAmenityStages.setStatus(status);
		builderFloorAmenityStages.setBuilderFloorAmenity(builderFloorAmenity);
		BuilderFloorAmenityStagesDAO builderFloorAmenityStagesDAO = new BuilderFloorAmenityStagesDAO();
		return builderFloorAmenityStagesDAO.update(builderFloorAmenityStages);
	}

	@DELETE
	@Path("/builder/floor/amenity/stages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFloorAmenityStages(@FormParam("amenity_substage_id") int amenityid) {

		BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
		builderFloorAmenityStages.setId(amenityid);
		BuilderFloorAmenityStagesDAO builderFloorAmenityDAO = new BuilderFloorAmenityStagesDAO();
		return builderFloorAmenityDAO.delete(builderFloorAmenityStages);
	}

	@GET
	@Path("/builder/floor/amenity/stages/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderFloorAmenityStages> getBuilderFloorAmenityStages(@QueryParam("amenity_id") int amenity_id) {
		BuilderFloorAmenityStagesDAO builderFloorAmenityStagesDAO = new BuilderFloorAmenityStagesDAO();
		return builderFloorAmenityStagesDAO.getStateByAmenityId(amenity_id);
	}

	@POST
	@Path("/builder/floor/amenity/substages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFloorAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
		builderFloorAmenityStages.setId(stageId);

		BuilderFloorAmenitySubstages builderFloorAmenitySubstages = new BuilderFloorAmenitySubstages();

		builderFloorAmenitySubstages.setName(name);
		builderFloorAmenitySubstages.setStatus(status);
		builderFloorAmenitySubstages.setBuilderFloorAmenityStages(builderFloorAmenityStages);
		BuilderFloorAmenitySubstagesDAO builderFloorAmenitySubstagesDAO = new BuilderFloorAmenitySubstagesDAO();
		return builderFloorAmenitySubstagesDAO.save(builderFloorAmenitySubstages);
	}

	@POST
	@Path("/builder/floor/amenity/substages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFloorAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
		builderFloorAmenityStages.setId(stageId);

		BuilderFloorAmenitySubstages builderFloorAmenitySubstages = new BuilderFloorAmenitySubstages();
		builderFloorAmenitySubstages.setId(id);
		builderFloorAmenitySubstages.setName(name);
		builderFloorAmenitySubstages.setStatus(status);
		builderFloorAmenitySubstages.setBuilderFloorAmenityStages(builderFloorAmenityStages);
		BuilderFloorAmenitySubstagesDAO builderProjectAmenitySubstagesDAO = new BuilderFloorAmenitySubstagesDAO();
		return builderProjectAmenitySubstagesDAO.update(builderFloorAmenitySubstages);
	}

	@DELETE
	@Path("/builder/floor/amenity/substages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFloorAmenitySubstages(@FormParam("substage_id") int substageid) {

		BuilderFloorAmenitySubstages builderFloorAmenitySubstages = new BuilderFloorAmenitySubstages();
		builderFloorAmenitySubstages.setId(substageid);
		BuilderFloorAmenitySubstagesDAO builderFloorAmenitySubstagesDAO = new BuilderFloorAmenitySubstagesDAO();
		return builderFloorAmenitySubstagesDAO.delete(builderFloorAmenitySubstages);
	}
	// ================================================================================================================================

	@POST
	@Path("/builder/flat/amenity/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuilderFlatAmenity(
			@FormDataParam("name") String name, 
			@FormDataParam("status") byte status,
			@FormDataParam("flat_amenity_icon[]") List<FormDataBodyPart> amenity_icons) {
		BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
		ResponseMessage responseMessage = new ResponseMessage();
		builderFlatAmenity.setName(name);
		builderFlatAmenity.setStatus(status);
		BuilderFlatAmenityDAO builderFlatAmenityDAO = new BuilderFlatAmenityDAO();
		responseMessage=builderFlatAmenityDAO.save(builderFlatAmenity);
		 if(amenity_icons != null){
			if(responseMessage.getId()>0){
				builderFlatAmenity.setId(responseMessage.getId());
					  try {	
							List<FlatAmenityIcon> flatAmenityIconList = new ArrayList<FlatAmenityIcon>();
							//for multiple inserting images.
							if (amenity_icons.size() > 0) {
								for(int i=0 ;i < amenity_icons.size();i++)
								{
									if(amenity_icons.get(i).getFormDataContentDisposition().getFileName() != null && !amenity_icons.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
										FlatAmenityIcon flatAmenityIcon = new FlatAmenityIcon();
										String gallery_name = amenity_icons.get(i).getFormDataContentDisposition().getFileName();
										long millis = System.currentTimeMillis() % 1000;
										gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
										gallery_name = "images/project/flat/amenityicon/"+gallery_name;
										String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
										//System.out.println("for loop image path: "+uploadGalleryLocation);
										this.imageUploader.writeToFile(amenity_icons.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
										flatAmenityIcon.setBuilderFlatAmenity(builderFlatAmenity);
										flatAmenityIcon.setIconUrl(gallery_name);
										flatAmenityIconList.add(flatAmenityIcon);
									}
								}
								if(flatAmenityIconList.size() > 0) {
									builderFlatAmenityDAO.saveFlatAmenityIcon(flatAmenityIconList);
								}
							}
//							responseMessage.setStatus(1);
//							responseMessage.setMessage("Flat Amenity added successfully");
						} catch(Exception e) {
							e.printStackTrace();
							responseMessage.setStatus(0);
							responseMessage.setMessage("Unable to save image");
						}
			}else{
				responseMessage.setStatus(0);
				responseMessage.setMessage("Unable to save Project Amenity");
			}
		 }
			return responseMessage;
	}
	
//	@POST
//	@Path("/builder/flat/amenity/save")
//	@Produces(MediaType.APPLICATION_JSON)
//	public ResponseMessage addBuilderFlatAmenity(@FormParam("name") String name, @FormParam("status") byte status) {
//		BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
//
//		builderFlatAmenity.setName(name);
//		builderFlatAmenity.setStatus(status);
//		BuilderFlatAmenityDAO builderFloorAmenityDAO = new BuilderFlatAmenityDAO();
//		return builderFloorAmenityDAO.save(builderFlatAmenity);
//	}

	@POST
	@Path("/builder/flat/amenity/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuilderFlatAmenity(
			@FormDataParam("uamenity_id") int id, 
			@FormDataParam("uname") String name,
			@FormDataParam("ustatus") byte status,
			@FormDataParam("flat_amenity_id[]")List<FormDataBodyPart> amenity_ids,
			@FormDataParam("flat_amenity_icon[]") List<FormDataBodyPart> amenity_icons
			) {
		ResponseMessage responseMessage = new ResponseMessage();
		BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
		builderFlatAmenity.setId(id);
		builderFlatAmenity.setName(name);
		builderFlatAmenity.setStatus(status);
		BuilderFlatAmenityDAO builderFlatAmenityDAO = new BuilderFlatAmenityDAO();
		responseMessage = builderFlatAmenityDAO.update(builderFlatAmenity);
		if(amenity_icons != null){
			if(amenity_icons.size() > 0){
				try {	
					List<FlatAmenityIcon> updateFlatAmenityIcon = new ArrayList<FlatAmenityIcon>();
					List<FlatAmenityIcon> saveFlatAmenityIcon = new ArrayList<FlatAmenityIcon>();
					//for multiple inserting images.
					//if (builder_logo.size() > 0) {
						for(int j=0 ;j < amenity_icons.size();j++)
						{
							if(amenity_ids != null){
							if(amenity_icons.get(j).getFormDataContentDisposition().getFileName() != null && !amenity_icons.get(j).getFormDataContentDisposition().getFileName().isEmpty()) {
								if(amenity_ids.get(j).getValueAs(Integer.class) != 0 && amenity_ids.get(j).getValueAs(Integer.class) != null){
									FlatAmenityIcon flatAmenityIcon = new FlatAmenityIcon();
									String gallery_name = amenity_icons.get(j).getFormDataContentDisposition().getFileName();
									long millis = System.currentTimeMillis() % 1000;
									gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
									gallery_name = "images/project/flat/amenityicon/"+gallery_name;
									String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
									//System.out.println("for loop image path update: "+uploadGalleryLocation);
									this.imageUploader.writeToFile(amenity_icons.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
									flatAmenityIcon.setId(amenity_ids.get(j).getValueAs(Integer.class));
									flatAmenityIcon.setIconUrl(gallery_name);
									flatAmenityIcon.setBuilderFlatAmenity(builderFlatAmenity);
									updateFlatAmenityIcon.add(flatAmenityIcon);
								}}}else{
									FlatAmenityIcon flatAmenityIcon = new FlatAmenityIcon();
									String gallery_name = amenity_icons.get(j).getFormDataContentDisposition().getFileName();
									long millis = System.currentTimeMillis() % 1000;
									gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
									gallery_name = "images/project/flat/amenityicon/"+gallery_name;
									String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
									//System.out.println("for loop image path add: "+uploadGalleryLocation);
									this.imageUploader.writeToFile(amenity_icons.get(j).getValueAs(InputStream.class), uploadGalleryLocation);
									flatAmenityIcon.setIconUrl(gallery_name);
									flatAmenityIcon.setBuilderFlatAmenity(builderFlatAmenity);
									saveFlatAmenityIcon.add(flatAmenityIcon);
								}
							}
						if(updateFlatAmenityIcon.size() > 0) {
							builderFlatAmenityDAO.updateFlatAmenityIcon(updateFlatAmenityIcon);
						}
						if(saveFlatAmenityIcon.size() > 0){
							builderFlatAmenityDAO.saveFlatAmenityIcon(saveFlatAmenityIcon);
						}
//						responseMessage.setStatus(1);
//						responseMessage.setMessage("Flat Amenity updated successfully.");
					}
				 catch(Exception e) {
					 responseMessage.setStatus(0);
					 responseMessage.setMessage("Unable to save image");
				}
			
			}
		}
		return responseMessage;
	}

	@DELETE
	@Path("/builder/flat/amenity/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFlatAmenity(@FormParam("amenityid") int amenityid) {

		BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
		builderFlatAmenity.setId(amenityid);

		BuilderFlatAmenityDAO builderFlatAmenityDAO = new BuilderFlatAmenityDAO();
		return builderFlatAmenityDAO.delete(builderFlatAmenity);
	}

	@GET
	@Path("/builder/flat/amenity/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderFlatAmenity> getBuilderFlatAmenity(@QueryParam("amenity_id") int amenity_id) {
		BuilderFlatAmenityDAO builderFlatAmenityDAO = new BuilderFlatAmenityDAO();
		return builderFlatAmenityDAO.getBuilderFlatAmenityById(amenity_id);
	}

	@POST
	@Path("/builder/flat/amenity/stages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFlatAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
		builderFlatAmenity.setId(amenityId);

		BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();

		builderFlatAmenityStages.setName(name);
		builderFlatAmenityStages.setStatus(status);
		builderFlatAmenityStages.setBuilderFlatAmenity(builderFlatAmenity);
		BuilderFlatAmenityStagesDAO builderFlatAmenityStagesDAO = new BuilderFlatAmenityStagesDAO();
		return builderFlatAmenityStagesDAO.save(builderFlatAmenityStages);
	}

	@POST
	@Path("/builder/flat/amenity/stages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFlatAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
		builderFlatAmenity.setId(amenityId);

		BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
		builderFlatAmenityStages.setId(id);
		builderFlatAmenityStages.setName(name);
		builderFlatAmenityStages.setStatus(status);
		builderFlatAmenityStages.setBuilderFlatAmenity(builderFlatAmenity);
		BuilderFlatAmenityStagesDAO builderFlatAmenityStagesDAO = new BuilderFlatAmenityStagesDAO();
		return builderFlatAmenityStagesDAO.update(builderFlatAmenityStages);
	}

	@DELETE
	@Path("/builder/flat/amenity/stages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFlatAmenityStages(@FormParam("amenity_substage_id") int amenityid) {

		BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
		builderFlatAmenityStages.setId(amenityid);
		BuilderFlatAmenityStagesDAO builderFlatAmenityDAO = new BuilderFlatAmenityStagesDAO();
		return builderFlatAmenityDAO.delete(builderFlatAmenityStages);
	}

	@GET
	@Path("/builder/flat/amenity/stages/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderFlatAmenityStages> getBuilderFlatAmenityStages(@QueryParam("amenity_id") int amenity_id) {
		BuilderFlatAmenityStagesDAO builderFlatAmenityStagesDAO = new BuilderFlatAmenityStagesDAO();
		return builderFlatAmenityStagesDAO.getStateByAmenityId(amenity_id);
	}

	@POST
	@Path("/builder/flat/amenity/substages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFlatAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
		builderFlatAmenityStages.setId(stageId);

		BuilderFlatAmenitySubstages builderFlatAmenitySubstages = new BuilderFlatAmenitySubstages();

		builderFlatAmenitySubstages.setName(name);
		builderFlatAmenitySubstages.setStatus(status);
		builderFlatAmenitySubstages.setBuilderFlatAmenityStages(builderFlatAmenityStages);
		BuilderFlatAmenitySubstagesDAO builderFlatAmenitySubstagesDAO = new BuilderFlatAmenitySubstagesDAO();
		return builderFlatAmenitySubstagesDAO.save(builderFlatAmenitySubstages);
	}

	@POST
	@Path("/builder/flat/amenity/substages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFlatAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
		builderFlatAmenityStages.setId(stageId);

		BuilderFlatAmenitySubstages builderFlatAmenitySubstages = new BuilderFlatAmenitySubstages();
		builderFlatAmenitySubstages.setId(id);
		builderFlatAmenitySubstages.setName(name);
		builderFlatAmenitySubstages.setStatus(status);
		builderFlatAmenitySubstages.setBuilderFlatAmenityStages(builderFlatAmenityStages);
		BuilderFlatAmenitySubstagesDAO builderProjectAmenitySubstagesDAO = new BuilderFlatAmenitySubstagesDAO();
		return builderProjectAmenitySubstagesDAO.update(builderFlatAmenitySubstages);
	}

	@DELETE
	@Path("/builder/flat/amenity/substages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFlatAmenitySubstages(@FormParam("substage_id") int substageid) {

		BuilderFlatAmenitySubstages builderFlatAmenitySubstages = new BuilderFlatAmenitySubstages();
		builderFlatAmenitySubstages.setId(substageid);
		BuilderFlatAmenitySubstagesDAO builderFlatAmenitySubstagesDAO = new BuilderFlatAmenitySubstagesDAO();
		return builderFlatAmenitySubstagesDAO.delete(builderFlatAmenitySubstages);
	}

	@POST
	@Path("/building/status/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBulidingStatus(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderBuildingStatus buildingAmenetiesType = new BuilderBuildingStatus();
	
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderBuildingStatusDAO stateImp = new BuilderBuildingStatusDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/building/status/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuildingStatus(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
		
		BuilderBuildingStatus state = new BuilderBuildingStatus();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderBuildingStatusDAO stateImp = new BuilderBuildingStatusDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/building/status/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuildingStatus(@FormParam("id") int id) {

		BuilderBuildingStatus country = new BuilderBuildingStatus();
		country.setId(id);

		BuilderBuildingStatusDAO countryService = new BuilderBuildingStatusDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/company/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderCompany(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderCompany buildingAmenetiesType = new BuilderCompany();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderCompanyDAO stateImp = new BuilderCompanyDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/company/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderCompany(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("stock") String sstatus) {
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		BuilderCompany state = new BuilderCompany();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderCompanyDAO stateImp = new BuilderCompanyDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/company/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderCompany(@FormParam("id") int id) {

		BuilderCompany country = new BuilderCompany();
		country.setId(id);

		BuilderCompanyDAO countryService = new BuilderCompanyDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/flat/status/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFlatStatus(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderFlatStatus buildingAmenetiesType = new BuilderFlatStatus();
		
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderFlatStatusDAO stateImp = new BuilderFlatStatusDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/flat/status/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFlatStatus(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
	
		BuilderFlatStatus state = new BuilderFlatStatus();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderFlatStatusDAO stateImp = new BuilderFlatStatusDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/flat/status/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFlatStatus(@FormParam("id") int id) {

		BuilderFlatStatus country = new BuilderFlatStatus();
		country.setId(id);

		BuilderFlatStatusDAO countryService = new BuilderFlatStatusDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/group/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderGroup(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderGroup buildingAmenetiesType = new BuilderGroup();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderGroupDAO stateImp = new BuilderGroupDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/group/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderGroup(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("stock") String sstatus) {
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		BuilderGroup state = new BuilderGroup();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderGroupDAO stateImp = new BuilderGroupDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/group/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderGroup(@FormParam("id") int id) {

		BuilderGroup country = new BuilderGroup();
		country.setId(id);

		BuilderGroupDAO countryService = new BuilderGroupDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/project/satges/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderOverallProjectStagesAndSubStages(@FormParam("name") String name,
			@FormParam("status") byte status) {
		BuilderOverallProjectStagesAndSubStages buildingAmenetiesType = new BuilderOverallProjectStagesAndSubStages();
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderOverallProjectStagesAndSubStagesDAO stateImp = new BuilderOverallProjectStagesAndSubStagesDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/satges/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderOverallProjectStagesAndSubStages(@FormParam("id") int id,
			@FormParam("name") String name, @FormParam("status") byte status) {
		
		BuilderOverallProjectStagesAndSubStages state = new BuilderOverallProjectStagesAndSubStages();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderOverallProjectStagesAndSubStagesDAO stateImp = new BuilderOverallProjectStagesAndSubStagesDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/satges/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderOverallProjectStagesAndSubStages(@FormParam("id") int id) {

		BuilderOverallProjectStagesAndSubStages country = new BuilderOverallProjectStagesAndSubStages();
		country.setId(id);

		BuilderOverallProjectStagesAndSubStagesDAO countryService = new BuilderOverallProjectStagesAndSubStagesDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/payment/satges/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderPaymentStages(@FormParam("name") String name,
			@FormParam("status") byte status) {
		BuilderPaymentStages builderPaymentStages = new BuilderPaymentStages();
		
		builderPaymentStages.setName(name);
		builderPaymentStages.setStatus(status);
		BuilderPaymentStagesDAO builderPaymentStagesDAO = new BuilderPaymentStagesDAO();
		return builderPaymentStagesDAO.save(builderPaymentStages);
	}

	@POST
	@Path("/builder/payment/satges/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderPaymentStages(@FormParam("id") int id,
			@FormParam("name") String name, @FormParam("status") byte status) {
		
		BuilderPaymentStages builderPaymentStages = new BuilderPaymentStages();
		builderPaymentStages.setId(id);
		builderPaymentStages.setName(name);
		builderPaymentStages.setStatus(status);
		BuilderPaymentStagesDAO builderPaymentStagesDAO = new BuilderPaymentStagesDAO();
		return builderPaymentStagesDAO.update(builderPaymentStages);
	}

	@DELETE
	@Path("/builder/payment/satges/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderPaymentStages(@FormParam("id") int id) {

		BuilderPaymentStages builderPaymentStages = new BuilderPaymentStages();
		builderPaymentStages.setId(id);

		BuilderPaymentStagesDAO builderPaymentStagesDAO = new BuilderPaymentStagesDAO();
		return builderPaymentStagesDAO.delete(builderPaymentStages);
	}
	
	@GET
	@Path("/builder/payment/stage/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderPaymentStages> getBuilderPaymentList(@QueryParam("payment_id") int payment_id) {
		BuilderPaymentStagesDAO builderPaymentStagesDAO = new BuilderPaymentStagesDAO();
		return builderPaymentStagesDAO.getBuilderPaymentStagesById(payment_id);
	}
	
	@POST
	@Path("/builder/payment/substages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderPaymentSbubstages(@FormParam("payment_id") int paymentId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderPaymentStages builderPaymentStages = new BuilderPaymentStages();
		builderPaymentStages.setId(paymentId);

		BuilderPaymentSubstages builderPaymentSubstages = new BuilderPaymentSubstages();

		builderPaymentSubstages.setName(name);
		builderPaymentSubstages.setStatus(status);
		builderPaymentSubstages.setBuilderPaymentStages(builderPaymentStages);
		BuilderPaymentSubstagesDAO builderPaymentSubstagesDAO = new BuilderPaymentSubstagesDAO();
		return builderPaymentSubstagesDAO.save(builderPaymentSubstages);
	}

	@POST
	@Path("/builder/payment/substages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderPaymentSubstages(@FormParam("payment_id") int paymentId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderPaymentStages builderPaymentStages = new BuilderPaymentStages();
		builderPaymentStages.setId(paymentId);

		BuilderPaymentSubstages builderPaymentSubstages = new BuilderPaymentSubstages();
		builderPaymentSubstages.setId(id);
		builderPaymentSubstages.setName(name);
		builderPaymentSubstages.setStatus(status);
		builderPaymentSubstages.setBuilderPaymentStages(builderPaymentStages);
		BuilderPaymentSubstagesDAO builderPaymentSubstagesDAO = new BuilderPaymentSubstagesDAO();
		return builderPaymentSubstagesDAO.update(builderPaymentSubstages);
	}

//	@DELETE
//	@Path("/builder/payment/substages/delete")
//	@Produces(MediaType.APPLICATION_JSON)
//	public ResponseMessage deleteBuilderPaymentSubstages(@FormParam("substage_id") int substageid) {
//
//		BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages = new BuilderBuildingAmenitySubstages();
//		builderBuildingAmenitySubstages.setId(substageid);
//		BuilderBuildingAmenitySubstagesDAO builderBuildingAmenitySubstagesDAO = new BuilderBuildingAmenitySubstagesDAO();
//		return builderBuildingAmenitySubstagesDAO.delete(builderBuildingAmenitySubstages);
//	}

	@POST
	@Path("/builder/project/approval/type/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectApprovalType(@FormParam("name") String name,
			@FormParam("status") byte status) {
		BuilderProjectApprovalType buildingAmenetiesType = new BuilderProjectApprovalType();

		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderProjectApprovalTypeDAO stateImp = new BuilderProjectApprovalTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/approval/type/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectApprovalType(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
		
		BuilderProjectApprovalType state = new BuilderProjectApprovalType();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderProjectApprovalTypeDAO stateImp = new BuilderProjectApprovalTypeDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/approval/type/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectApprovalType(@FormParam("id") int id) {

		BuilderProjectApprovalType country = new BuilderProjectApprovalType();
		country.setId(id);

		BuilderProjectApprovalTypeDAO countryService = new BuilderProjectApprovalTypeDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/project/level/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectLevel(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderProjectLevel buildingAmenetiesType = new BuilderProjectLevel();
		
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderProjectLevelDAO stateImp = new BuilderProjectLevelDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/level/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectLevel(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
		
		BuilderProjectLevel state = new BuilderProjectLevel();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderProjectLevelDAO stateImp = new BuilderProjectLevelDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/level/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectLevel(@FormParam("id") int id) {

		BuilderProjectLevel country = new BuilderProjectLevel();
		country.setId(id);

		BuilderProjectLevelDAO countryService = new BuilderProjectLevelDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/project/propertyconfig/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectPropertyConfiguration(@FormParam("name") String name,
			@FormParam("status") byte status) {
		BuilderProjectPropertyConfiguration buildingAmenetiesType = new BuilderProjectPropertyConfiguration();
		
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderProjectPropertyConfigurationDAO stateImp = new BuilderProjectPropertyConfigurationDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/propertyconfig/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectPropertyConfiguration(@FormParam("id") int id,
			@FormParam("name") String name, @FormParam("status") byte status) {
		
		BuilderProjectPropertyConfiguration state = new BuilderProjectPropertyConfiguration();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderProjectPropertyConfigurationDAO stateImp = new BuilderProjectPropertyConfigurationDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/propertyconfig/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectPropertyConfiguration(@FormParam("id") int id) {

		BuilderProjectPropertyConfiguration country = new BuilderProjectPropertyConfiguration();
		country.setId(id);

		BuilderProjectPropertyConfigurationDAO countryService = new BuilderProjectPropertyConfigurationDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/project/status/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectStatus(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderProjectStatus buildingAmenetiesType = new BuilderProjectStatus();
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderProjectStatusDAO stateImp = new BuilderProjectStatusDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/status/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectStatus(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
		
		BuilderProjectStatus state = new BuilderProjectStatus();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderProjectStatusDAO stateImp = new BuilderProjectStatusDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/status/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectStatus(@FormParam("id") int id) {

		BuilderProjectStatus country = new BuilderProjectStatus();
		country.setId(id);

		BuilderProjectStatusDAO countryService = new BuilderProjectStatusDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/project/type/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectType(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderProjectType buildingAmenetiesType = new BuilderProjectType();
		
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderProjectTypeDAO stateImp = new BuilderProjectTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/type/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectType(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
		
		BuilderProjectType state = new BuilderProjectType();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderProjectTypeDAO stateImp = new BuilderProjectTypeDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/type/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectType(@FormParam("id") int id) {

		BuilderProjectType country = new BuilderProjectType();
		country.setId(id);

		BuilderProjectTypeDAO countryService = new BuilderProjectTypeDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/property/type/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderPropertyType(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderPropertyType buildingAmenetiesType = new BuilderPropertyType();
		
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderPropertyTypeDAO stateImp = new BuilderPropertyTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/property/type/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderPropertyType(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
		
		BuilderPropertyType state = new BuilderPropertyType();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderPropertyTypeDAO stateImp = new BuilderPropertyTypeDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/property/type/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderPropertyType(@FormParam("id") int id) {

		BuilderPropertyType country = new BuilderPropertyType();
		country.setId(id);

		BuilderPropertyTypeDAO countryService = new BuilderPropertyTypeDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/seller/type/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderSellerType(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderSellerType buildingAmenetiesType = new BuilderSellerType();
		
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderSellerTypeDAO stateImp = new BuilderSellerTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/seller/type/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderSellerType(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
		
		BuilderSellerType state = new BuilderSellerType();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderSellerTypeDAO stateImp = new BuilderSellerTypeDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/seller/type/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderSellerType(@FormParam("id") int id) {

		BuilderSellerType country = new BuilderSellerType();
		country.setId(id);

		BuilderSellerTypeDAO countryService = new BuilderSellerTypeDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/tax/type/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderTaxType(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderTaxType buildingAmenetiesType = new BuilderTaxType();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderTaxTypeDAO stateImp = new BuilderTaxTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/tax/type/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderTaxType(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("stock") String sstatus) {
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		BuilderTaxType state = new BuilderTaxType();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderTaxTypeDAO stateImp = new BuilderTaxTypeDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/tax/type/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderTaxType(@FormParam("id") int id) {

		BuilderTaxType country = new BuilderTaxType();
		country.setId(id);

		BuilderTaxTypeDAO countryService = new BuilderTaxTypeDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilder(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderTaxType buildingAmenetiesType = new BuilderTaxType();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderTaxTypeDAO stateImp = new BuilderTaxTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@GET
	@Path("/project/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderCompanyNames> getCompanyName(@QueryParam("builder_id") int builder_id) {
		BuilderDetailsDAO builderBuildingAmenityDAO = new BuilderDetailsDAO();
		return builderBuildingAmenityDAO.getBuilderCompanyNameList(builder_id);
	}
	@GET
	@Path("/building/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderBuilding> getBuildingList(@QueryParam("project_id") int project_id) {
		ProjectLeadDAO projectLeadDAO = new ProjectLeadDAO();
		System.out.println("ProjectLeadDAO::");
		return projectLeadDAO.getBuildingByProjectId(project_id);
	}
//	@GET
//	@Path("/building/buyer/list")
//	@Produces(MediaType.APPLICATION_JSON)
//	public List<BuilderBuilding> getAllBuildingList(@QueryParam("project_id") int project_id) {
//		DemandLettersDAO projectLeadDAO = new DemandLettersDAO();
//		System.out.println("ProjectLeadDAO::");
//		return projectLeadDAO.getAllBuildingByProjectId(project_id);
//	}
	@POST
	@Path("/tax/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addTax(@FormParam("pincode") String pincode,@FormParam("tax") double tax,@FormParam("sduty") double stampDuty,@FormParam("vat") double vat) {
		TaxDAO taxDAO = new TaxDAO();
		 Tax tax2 = new Tax();
		 tax2.setPincode(pincode);
		 tax2.setStampDuty(stampDuty);
		 tax2.setTax(tax);
		 tax2.setVat(vat);
		 return  taxDAO.save(tax2);
	
	}

	@POST
	@Path("/tax/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateTax(@FormParam("id") int id,@FormParam("pincode") String pincode,@FormParam("tax") double tax,@FormParam("sduty") double stampDuty,@FormParam("vat") double vat) {
		
		TaxDAO taxDAO = new TaxDAO();
		 Tax tax2 = new Tax();
		 tax2.setId(id);
		 tax2.setPincode(pincode);
		 tax2.setStampDuty(stampDuty);
		 tax2.setTax(tax);
		 tax2.setVat(vat);
		 return taxDAO.update(tax2);
	}
	
	@POST
	@Path("/project/stage/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addProjectStage(@FormParam("name") String name, @FormParam("status") byte status) {
		ProjectStage projectStage  = new ProjectStage();
		byte isDeleted = 0;
		projectStage.setName(name);
		projectStage.setStatus(status);
		projectStage.setIsDeleted(isDeleted);
		ProjectStageDAO projectStageDAO = new ProjectStageDAO();
		return projectStageDAO.save(projectStage);
	}
	@POST
	@Path("/project/stage/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateProjectStage(@FormParam("id") int id,@FormParam("name") String name, @FormParam("status") byte status) {
		ProjectStage projectStage  = new ProjectStage();
		byte isDeleted = 0;
		projectStage.setId(id);
		projectStage.setName(name);
		projectStage.setStatus(status);
		projectStage.setIsDeleted(isDeleted);
		ProjectStageDAO projectStageDAO = new ProjectStageDAO();
		return projectStageDAO.update(projectStage);
	}
	
	@GET
	@Path("/project/stage/")
	@Produces(MediaType.APPLICATION_JSON)
	public ProjectStage getProjectStage(@QueryParam("stage_id") int stage_id) {
		ProjectStageDAO builderFloorAmenityDAO = new ProjectStageDAO();
		return builderFloorAmenityDAO.getProjectStageById(stage_id);
	}
	
	@POST
	@Path("/building/stage/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuildingStage(@FormParam("name") String name, @FormParam("status") byte status) {
		BuildingStage buildingStage  = new BuildingStage();
		byte isDeleted = 0;
		buildingStage.setName(name);
		buildingStage.setStatus(status);
		buildingStage.setIsDeleted(isDeleted);
		BuildingStageDAO buildingStageDAO = new BuildingStageDAO();
		return buildingStageDAO.save(buildingStage);
	}
	@POST
	@Path("/building/stage/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuildingStage(@FormParam("id") int id,@FormParam("name") String name, @FormParam("status") byte status) {
		BuildingStage buildingStage  = new BuildingStage();
		byte isDeleted = 0;
		buildingStage.setId(id);
		buildingStage.setName(name);
		buildingStage.setStatus(status);
		buildingStage.setIsDeleted(isDeleted);
		BuildingStageDAO buildingStageDAO = new BuildingStageDAO();
		return buildingStageDAO.update(buildingStage);
	}
	
	@GET
	@Path("/building/stage/")
	@Produces(MediaType.APPLICATION_JSON)
	public BuildingStage getBuildingStage(@QueryParam("stage_id") int stage_id) {
		BuildingStageDAO buildingStageDAO = new BuildingStageDAO();
		return buildingStageDAO.getBuildingStageById(stage_id);
	}

	@POST
	@Path("/floor/stage/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addFloorStage(@FormParam("name") String name, @FormParam("status") byte status) {
		FloorStage floorStage  = new FloorStage();
		byte isDeleted = 0;
		floorStage.setName(name);
		floorStage.setStatus(status);
		floorStage.setIsDeleted(isDeleted);
		FloorStageDAO buildingStageDAO = new FloorStageDAO();
		return buildingStageDAO.save(floorStage);
	}
	@POST
	@Path("/floor/stage/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateFloorStage(@FormParam("id") int id,@FormParam("name") String name, @FormParam("status") byte status) {
		FloorStage floorStage  = new FloorStage();
		byte isDeleted = 0;
		floorStage.setId(id);
		floorStage.setName(name);
		floorStage.setStatus(status);
		floorStage.setIsDeleted(isDeleted);
		FloorStageDAO floorStageDAO = new FloorStageDAO();
		return floorStageDAO.update(floorStage);
	}
	
	@GET
	@Path("/floor/stage/")
	@Produces(MediaType.APPLICATION_JSON)
	public FloorStage getFloorStage(@QueryParam("stage_id") int stage_id) {
		FloorStageDAO floorStageDAO = new FloorStageDAO();
		return floorStageDAO.getFloorStageById(stage_id);
	}
	
	@POST
	@Path("/flat/stage/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addFlatStage(@FormParam("name") String name, @FormParam("status") byte status) {
		FlatStage flatStage  = new FlatStage();
		byte isDeleted = 0;
		flatStage.setName(name);
		flatStage.setStatus(status);
		flatStage.setIsDeleted(isDeleted);
		FlatStageDAO flatStageDAO = new FlatStageDAO();
		return flatStageDAO.save(flatStage);
	}
	@POST
	@Path("/flat/stage/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateFlatStage(@FormParam("id") int id,@FormParam("name") String name, @FormParam("status") byte status) {
		FlatStage flatStage  = new FlatStage();
		byte isDeleted = 0;
		flatStage.setId(id);
		flatStage.setName(name);
		flatStage.setStatus(status);
		flatStage.setIsDeleted(isDeleted);
		FlatStageDAO floorStageDAO = new FlatStageDAO();
		return floorStageDAO.update(flatStage);
	}
	
	@GET
	@Path("/flat/stage/")
	@Produces(MediaType.APPLICATION_JSON)
	public FlatStage getFlatStage(@QueryParam("stage_id") int stage_id) {
		FlatStageDAO flatStageDAO = new FlatStageDAO();
		return flatStageDAO.getFlatStageById(stage_id);
	}

	@POST
	@Path("/project/substage/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addProjectSubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {
		ProjectStage projectStage = new ProjectStage();
		byte isDeleted = 0;
		projectStage.setId(stageId);
		ProjectSubstage projectSubstage = new ProjectSubstage();
		projectSubstage.setIsDeleted(isDeleted);
		projectSubstage.setName(name);
		projectSubstage.setStatus(status);
		projectSubstage.setProjectStage(projectStage);;
		ProjectSubstagesDAO projectSubstagesDAO = new ProjectSubstagesDAO();
		return projectSubstagesDAO.save(projectSubstage);
	}

	@POST
	@Path("/project/substage/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateProjectSubtages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {
		ProjectStage projectStage = new ProjectStage();
		byte isDeleted = 0;
		projectStage.setId(stageId);
		ProjectSubstage projectSubstage = new ProjectSubstage();
		projectSubstage.setId(id);
		projectSubstage.setName(name);
		projectSubstage.setStatus(status);
		projectSubstage.setIsDeleted(isDeleted);
		projectSubstage.setProjectStage(projectStage);
		ProjectSubstagesDAO projectSubstagesDAO = new ProjectSubstagesDAO();
		return projectSubstagesDAO.update(projectSubstage);
	}

	
	@POST
	@Path("/building/substage/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuildingSubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {
		BuildingStage buildingStage = new BuildingStage();
		byte isDeleted = 0;
		buildingStage.setId(stageId);
		BuildingSubstage buildingSubstage = new BuildingSubstage();
		buildingSubstage.setName(name);
		buildingSubstage.setStatus(status);
		buildingSubstage.setIsDeleted(isDeleted);
		buildingSubstage.setBuildingStage(buildingStage);;
		BuildingSubstagesDAO buildingSubstagesDAO = new BuildingSubstagesDAO();
		return buildingSubstagesDAO.save(buildingSubstage);
	}

	@POST
	@Path("/building/substage/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuildingSubtages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {
		BuildingStage buildingStage = new BuildingStage();
		byte isDeleted = 0;
		buildingStage.setId(stageId);
		BuildingSubstage buildingSubstage = new BuildingSubstage();
		buildingSubstage.setId(id);
		buildingSubstage.setName(name);
		buildingSubstage.setStatus(status);
		buildingSubstage.setIsDeleted(isDeleted);
		buildingSubstage.setBuildingStage(buildingStage);
		BuildingSubstagesDAO buildingSubstagesDAO = new BuildingSubstagesDAO();
		return buildingSubstagesDAO.update(buildingSubstage);
	}
	
	@POST
	@Path("/floor/substage/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addFloorSubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {
		FloorStage floorStage = new FloorStage();
		byte isDeleted = 0;
		floorStage.setId(stageId);
		FloorSubstage floorSubstage = new FloorSubstage();
		floorSubstage.setName(name);
		floorSubstage.setStatus(status);
		floorSubstage.setIsDeleted(isDeleted);
		floorSubstage.setFloorStage(floorStage);;
		FloorSubstagesDAO floorSubstagesDAO = new FloorSubstagesDAO();
		return floorSubstagesDAO.save(floorSubstage);
	}

	@POST
	@Path("/floor/substage/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateFloorSubtages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {
		FloorStage floorStage = new FloorStage();
		byte isDeleted = 0;
		floorStage.setId(stageId);
		FloorSubstage floorSubstage = new FloorSubstage();
		floorSubstage.setId(id);
		floorSubstage.setName(name);
		floorSubstage.setStatus(status);
		floorSubstage.setIsDeleted(isDeleted);
		floorSubstage.setFloorStage(floorStage);
		FloorSubstagesDAO projectSubstagesDAO = new FloorSubstagesDAO();
		return projectSubstagesDAO.update(floorSubstage);
	}
	
	
	@POST
	@Path("/flat/substage/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addFlatSubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {
		FlatStage flatStage = new FlatStage();
		byte isDeleted = 0;
		flatStage.setId(stageId);
		FlatSubstage flatSubstage = new FlatSubstage();
		flatSubstage.setName(name);
		flatSubstage.setStatus(status);
		flatSubstage.setIsDeleted(isDeleted);
		flatSubstage.setFlatStage(flatStage);;
		FlatSubstagesDAO flatSubstagesDAO = new FlatSubstagesDAO();
		return flatSubstagesDAO.save(flatSubstage);
	}

	@POST
	@Path("/flat/substage/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateFlatSubtages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {
		FlatStage flatStage = new FlatStage();
		byte isDeleted = 0;
		flatStage.setId(stageId);
		FlatSubstage flatSubstage = new FlatSubstage();
		flatSubstage.setId(id);
		flatSubstage.setName(name);
		flatSubstage.setStatus(status);
		flatSubstage.setIsDeleted(isDeleted);
		flatSubstage.setFlatStage(flatStage);
		FlatSubstagesDAO flatSubstagesDAO = new FlatSubstagesDAO();
		return flatSubstagesDAO.update(flatSubstage);
	}
	
}
