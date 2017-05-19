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
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.AdminUserDAO;
import org.bluepigeon.admin.dao.BuilderDetailsDAO;
import org.bluepigeon.admin.dao.ProjectDAO;
import org.bluepigeon.admin.data.EmployeeList;
import org.bluepigeon.admin.data.ProjectCityData;
import org.bluepigeon.admin.data.PropertyManagerData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.AdminUserPhotos;
import org.bluepigeon.admin.model.AdminUserRole;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderEmployeeAccessType;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.Locality;
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
		AdminUserDAO propertyManagerDAO = new AdminUserDAO();
		propertyManagerDAO.getAdminUserById(manager_id);
		return propertyManagerDAO.getAdminUserById(manager_id);
	}
	
	@GET
	@Path("/projectarea/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectCityData> getProjectList(@QueryParam("project") int project) {
		ProjectDAO projectDAO = new ProjectDAO();
		return projectDAO.getCityareabyproject(project);
		
		
	}
	
	@POST
	@Path("/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage saveBPEmployees(
			@FormDataParam("name") String name,
			@FormDataParam("phone") String contact,
			@FormDataParam("email") String email,
			@FormDataParam("password") String password,
			@FormDataParam("current_address") String currentAddress,
			@FormDataParam("permanent_address") String permanentAddress,
			@FormDataParam("city_id") int cityId,
			@FormDataParam("access_id") int accessId,
			@FormDataParam("admin_id") Long adminId,
			@FormDataParam("manager_image[]") List<FormDataBodyPart> managerImage){
		
		AdminUser propertyManager = new AdminUser();
		
		if(adminId > 0){
			propertyManager.setCreatedBy(adminId);
		}
		propertyManager.setName(name);
		propertyManager.setMobile(contact);
		propertyManager.setEmail(email);
		propertyManager.setPassword(password);
		propertyManager.setCurrentAddress(currentAddress);
		propertyManager.setCreatedDate(new java.util.Date());
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
		ResponseMessage msg = new AdminUserDAO().save(propertyManager);
		if(msg.getId() > 0) {
			propertyManager.setId(msg.getId());
		//add gallery images
		try {	
			List<AdminUserPhotos> buildingImageGalleries = new ArrayList<AdminUserPhotos>();
			//for multiple inserting images.
			if (managerImage.size() > 0) {
				for(int i=0 ;i < managerImage.size();i++)
				{
					if(managerImage.get(i).getFormDataContentDisposition().getFileName() != null && !managerImage.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						AdminUserPhotos buildingImageGallery = new AdminUserPhotos();
						String gallery_name = managerImage.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/building/images/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						System.out.println("for loop image path: "+uploadGalleryLocation);
						this.imageUploader.writeToFile(managerImage.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						buildingImageGallery.setPhotoUrl(gallery_name);
						buildingImageGallery.setAdminUser(propertyManager);
						buildingImageGalleries.add(buildingImageGallery);
					}
				}
				if(buildingImageGalleries.size() > 0) {
					new AdminUserDAO().saveManagerPhoto(buildingImageGalleries);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to update Manager Photo");
			}
		}
		return msg;
	}
	
	@POST
	@Path("/save1")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage saveEmployees(
			@FormDataParam("name") String name,
			@FormDataParam("contact") String mobile,
			@FormDataParam("email") String email,
			@FormDataParam("address") String currentAddress,
			@FormDataParam("address1") String permanentAddress,
			@FormDataParam("designation") String designation,
			@FormDataParam("access") int accessId,
			@FormDataParam("empid") String employeeId,
			@FormDataParam("project") int projectId,
			@FormDataParam("area") int areaId,
			@FormDataParam("city") int cityId,
			@FormDataParam("builder_id") int builderId){
		
		BuilderEmployeeAccessType employeeAccessType = new BuilderEmployeeAccessType();
		
		Builder builder = new Builder();
		BuilderEmployee builderEmployee = new BuilderEmployee();
		Locality locality = new Locality();
		boolean status = false;
		
		if(builderId > 0){
			builder.setId(builderId);
			builderEmployee.setBuilder(builder); 
		}
		
		if(cityId > 0){
			City city = new City();
			city.setId(cityId);
			builderEmployee.setCity(city); 
		}
		if(accessId > 0){
			
			employeeAccessType.setId(accessId);
			builderEmployee.setBuilderEmployeeAccessType(employeeAccessType);
		}
		if(areaId > 0){
			locality.setId(areaId);
			builderEmployee.setLocality(locality);
		}
		if(projectId > 0){
			BuilderProject builderProject = new BuilderProject();
			builderProject.setId(projectId);
			builderEmployee.setBuilderProject(builderProject);
		}
		builderEmployee.setName(name);
		builderEmployee.setEmail(email);
		builderEmployee.setMobile(mobile);
		builderEmployee.setCurrentAddress(currentAddress);
		builderEmployee.setPermanentAddress(permanentAddress);
		builderEmployee.setDesignation(designation);
		builderEmployee.setEmployeeId(employeeId);
		builderEmployee.setStatus(status);
		
	return new BuilderDetailsDAO().saveEmployee(builderEmployee);
	}

	@POST
	@Path("/emp/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<EmployeeList> getBuildingList(@PathParam("city_id") int city_id, 
			@PathParam("project_id") int project_id
	) {
		List<EmployeeList> project_list = new BuilderDetailsDAO().getEmployeeListFilter(city_id, project_id);
		return project_list;
	}
	
	
	@GET
	@Path("/project/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectCityData> addCity(@QueryParam("project") int project) {
		ProjectDAO projectDAO = new ProjectDAO();
		return projectDAO.getCityareabyproject(project);
		
		
	}
	
}
