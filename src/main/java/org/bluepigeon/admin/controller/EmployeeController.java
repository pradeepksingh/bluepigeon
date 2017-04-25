package org.bluepigeon.admin.controller;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.PropertyManagerDAO;
import org.bluepigeon.admin.data.PropertyManagerData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.AdminUserRole;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.PropertyManager;
import org.bluepigeon.admin.model.PropertyManagerPhotos;
import org.bluepigeon.admin.service.ImageUploader;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

@Path("employee")
public class EmployeeController {
	@Context ServletContext context;
	ImageUploader imageUploader = new ImageUploader();
	@GET
	@Path("/list/{manager_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public PropertyManagerData getManagerListNames(@PathParam("manager_id") int manager_id) {
		PropertyManagerDAO propertyManagerDAO = new PropertyManagerDAO();
		propertyManagerDAO.getAdminUserById(manager_id);
		return propertyManagerDAO.getAdminUserById(manager_id);
	}
	
	@POST
	@Path("/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage saveBPEmployees(@FormDataParam("manager_id") int adminUserId,
			@FormDataParam("contact") int contact,
			@FormDataParam("email") int email,
			@FormDataParam("current_address") String currentAddress,
			@FormDataParam("permanent_address") String permanentAddress,
			@FormDataParam("city_id") int cityId,
			@FormDataParam("access_id") int accessId,
			@FormDataParam("admin_id") int adminId,
			@FormDataParam("manager_image[]") List<FormDataBodyPart> managerImage){
		
		PropertyManager propertyManager = new PropertyManager();
		if(adminUserId > 0){
			AdminUser adminUser = new AdminUser();
			adminUser.setId(adminUserId);
			propertyManager.setAdminUserByAdminUserId(adminUser);
		}
		if(adminId > 0){
			AdminUser adminUser = new AdminUser();
			adminUser.setId(adminId);
			propertyManager.setAdminUserByAddedBy(adminUser);
		}
		propertyManager.setCurrentAddress(currentAddress);
		propertyManager.setPermanentAddress(permanentAddress);
		if(cityId > 0){
			City city = new City();
			city.setId(cityId);
			propertyManager.setCity(city);
		}
		if(accessId > 0){
			AdminUserRole adminUserRole = new AdminUserRole();
			adminUserRole.setId(accessId);
			propertyManager.setAdminUserRole(adminUserRole);
		}
		ResponseMessage msg = new PropertyManagerDAO().save(propertyManager);
		if(msg.getId() > 0) {
			propertyManager.setId(msg.getId());
		//add gallery images
		try {	
			List<PropertyManagerPhotos> buildingImageGalleries = new ArrayList<PropertyManagerPhotos>();
			//for multiple inserting images.
			if (managerImage.size() > 0) {
				for(int i=0 ;i < managerImage.size();i++)
				{
					if(managerImage.get(i).getFormDataContentDisposition().getFileName() != null && !managerImage.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						PropertyManagerPhotos buildingImageGallery = new PropertyManagerPhotos();
						String gallery_name = managerImage.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/building/images/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						System.out.println("for loop image path: "+uploadGalleryLocation);
						this.imageUploader.writeToFile(managerImage.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						buildingImageGallery.setPhotoUrl(gallery_name);
						buildingImageGallery.setPropertyManager(propertyManager);
						buildingImageGalleries.add(buildingImageGallery);
					}
				}
				if(buildingImageGalleries.size() > 0) {
					new PropertyManagerDAO().saveManagerPhoto(buildingImageGalleries);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to update Manager Photo");
			}
		}
		return msg;
	}
}
