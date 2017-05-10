package org.bluepigeon.admin.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.CityNamesImp;
import org.bluepigeon.admin.dao.LocalityNamesImp;
import org.bluepigeon.admin.dao.ProjectDAO;
import org.bluepigeon.admin.dao.StateImp;
import org.bluepigeon.admin.data.BuildingList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderBuilding;
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
	@GET
	@Path("/building/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuildingList> addState(@QueryParam("project_id") int project_id) {
		ProjectDAO projectDAO = new ProjectDAO();
		System.out.println("projectId ::: "+project_id);
		return projectDAO.getBuildingByProjectId(project_id);
	}

}
