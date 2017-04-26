package org.bluepigeon.admin.controller;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.BuyerProjectUpdateDAO;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuyerProjectUpdate;
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
		  BuyerProjectUpdate buyerProjectUpdate = new BuyerProjectUpdate();
		  if(empId > 0){
			  AdminUser adminUser = new AdminUser();
			  adminUser.setId(empId);
			  buyerProjectUpdate.setAdminUser(adminUser);
		  }
		  if(builderId > 0){
			  Builder builder = new Builder();
			  builder.setId(builderId);
			  buyerProjectUpdate.setBuilder(builder);
		  }
		  if(projectId > 0){
			  BuilderProject builderProject = new BuilderProject();
			  builderProject.setId(projectId);
			  buyerProjectUpdate.setBuilderProject(builderProject);
		  }
		
		 BuilderBuilding builderBuilding = new BuilderBuilding();
		 builderBuilding.setId(buildingId);
		 buyerProjectUpdate.setBuilderBuilding(builderBuilding);
		 
		 BuilderFloor builderFloor = new BuilderFloor();
		 builderFloor.setId(floorId);
		 buyerProjectUpdate.setBuilderFloor(builderFloor);
		 
		 BuilderFlat builderFlat = new BuilderFlat();
		 builderFlat.setId(flatId);
		 buyerProjectUpdate.setBuilderFlat(builderFlat);
		 buyerProjectUpdate.setTitle(title);
		 buyerProjectUpdate.setDescription(description);
		 return new BuyerProjectUpdateDAO().save(buyerProjectUpdate);
	}
	
	
}
