package org.bluepigeon.admin.controller;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.glassfish.jersey.media.multipart.FormDataParam;

@Path("projectupdates")
public class ProjectUpdateController {

	@POST
	@Path("/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage saveProjectUpdates(
			@FormDataParam("admin_id") int empId,
			@FormDataParam("builder_id") int builderId,
			@FormDataParam("project_id") int projectId,
			@FormDataParam("building_id") int buildingId,
			@FormDataParam("floor_id") int floorId,
			@FormDataParam("flat_id") int flatId,
			@FormDataParam("status_id") int statusId,
			@FormDataParam("title") String title,
			@FormDataParam("description") String description
			){
		
		return null;
	}
	
	
}
