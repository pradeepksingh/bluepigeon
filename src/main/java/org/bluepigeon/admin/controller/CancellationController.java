package org.bluepigeon.admin.controller;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.CancellationDAO;
import org.bluepigeon.admin.data.CancellationList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.Cancellation;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

@Path("/cancellation")
public class CancellationController {

	@POST
	@Path("/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addCancellation (
			@FormDataParam("project_id") int projectId,
			@FormDataParam("building_id") int buildingId,
			@FormDataParam("flat_id") int flatId,
			@FormDataParam("buyer_name") String name,
			@FormDataParam("buyer_contact") String mobile,
			@FormDataParam("pan_card") String pancard,
			@FormDataParam("reason") String reason,
			@FormDataParam("charges") Double charges,
			@FormDataParam("builder_id") int builderId){
		
		Cancellation cancellation = new Cancellation();
		if(projectId > 0){
			BuilderProject builderProject = new BuilderProject();
			builderProject.setId(projectId);
			cancellation.setBuilderProject(builderProject);
		}
		
		if(buildingId > 0){
			BuilderBuilding builderBuilding = new BuilderBuilding();
			builderBuilding.setId(buildingId);
			cancellation.setBuilderBuilding(builderBuilding);
		}
		
		if(flatId > 0){
			BuilderFlat builderFlat = new BuilderFlat();
			builderFlat.setId(flatId);
			cancellation.setBuilderFlat(builderFlat);
		}
		cancellation.setBuyerName(name);
		cancellation.setBuyerContact(mobile);
		cancellation.setReason(reason);
		cancellation.setCharges(charges);
		cancellation.setPanCard(pancard);
		
		
		return new CancellationDAO().save(cancellation);
	}
	
	@GET
	@Path("/buyer/{flat_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Buyer getBuyerByFlatId(@PathParam("flat_id") int flatId){
		return new CancellationDAO().getPrimaryBuyerByFlatId(flatId);
	}
	
	@POST
	@Path("/buyer/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<CancellationList> getBuildingList(@FormParam("project_id") int project_id, 
			@FormParam("building_id") int building_id,
			@FormParam("flat_id") int flat_id
	) {
		List<CancellationList> project_list = new CancellationDAO().getCancellationListFilter(project_id, building_id, flat_id);
		return project_list;
	}
	
}
