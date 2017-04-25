package org.bluepigeon.admin.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.PropertyManagerDAO;
import org.bluepigeon.admin.data.BuildingData;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.service.ImageUploader;

@Path("employee")
public class EmployeeController {
	@Context ServletContext context;
	ImageUploader imageUploader = new ImageUploader();
	@GET
	@Path("/list/{manager_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public AdminUser getManagerListNames(@PathParam("manager_id") int manager_id) {
		PropertyManagerDAO propertyManagerDAO = new PropertyManagerDAO();
		propertyManagerDAO.getAdminUserById(manager_id);
		return propertyManagerDAO.getAdminUserById(manager_id);
	}
}
