package org.bluepigeon.admin.controller;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.DemandDAO;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderEmployeeAccessType;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Cancellation;
import org.bluepigeon.admin.model.DemandLetters;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

@Path("demand")
public class DemandController {

	@POST
	@Path("/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addDemand (
			@FormDataParam("project_id") int projectId,
			@FormDataParam("building_id") int buildingId,
			@FormDataParam("flat_id") int flatId,
			@FormDataParam("demand_name") String name,
			@FormDataParam("last_date") String last_date,
			@FormDataParam("remind") String remind,
			@FormDataParam("builder_id") int builderId
			
			){
		
			SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
			Date lastDate = null;
			try {
				lastDate = format.parse(last_date);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			DemandLetters demandLetters = new DemandLetters();
			if(projectId > 0){
				BuilderProject builderProject = new BuilderProject();
				builderProject.setId(projectId);
				demandLetters.setBuilderProject(builderProject);
			}
			
			if(buildingId > 0){
				BuilderBuilding builderBuilding = new BuilderBuilding();
				builderBuilding.setId(buildingId);
				demandLetters.setBuilderBuilding(builderBuilding);
			}
			
			if(flatId > 0){
				BuilderFlat builderFlat = new BuilderFlat();
				builderFlat.setId(flatId);
				demandLetters.setBuilderFlat(builderFlat);
			}
			demandLetters.setName(name);
			demandLetters.setLastDate(lastDate);
			demandLetters.setRemind(remind);
			
			
			
			
		return new DemandDAO().save(demandLetters);
	}
	
	@POST
	@Path("/save1")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addDemand1 (
			@FormDataParam("project_id") int projectId,
			@FormDataParam("building_id") int buildingId,
			@FormDataParam("flat_id") int flatId,
			@FormDataParam("demand_name") String name,
			@FormDataParam("last_date") String last_date,
			@FormDataParam("remind") String remind,
			@FormDataParam("amount") Double amount,
			@FormDataParam("payment_status") int paymentStatus,
			@FormDataParam("payment_method") int paymentMethod,
			@FormDataParam("builder_id") int builderId
			
			){
		
			SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
			Date lastDate = null;
			try {
				lastDate = format.parse(last_date);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			DemandLetters demandLetters = new DemandLetters();
			if(projectId > 0){
				BuilderProject builderProject = new BuilderProject();
				builderProject.setId(projectId);
				demandLetters.setBuilderProject(builderProject);
			}
			
			if(buildingId > 0){
				BuilderBuilding builderBuilding = new BuilderBuilding();
				builderBuilding.setId(buildingId);
				demandLetters.setBuilderBuilding(builderBuilding);
			}
			
			if(flatId > 0){
				BuilderFlat builderFlat = new BuilderFlat();
				builderFlat.setId(flatId);
				demandLetters.setBuilderFlat(builderFlat);
			}
			demandLetters.setName(name);
			demandLetters.setLastDate(lastDate);
			demandLetters.setRemind(remind);
			demandLetters.setAmount(amount);
			demandLetters.setPaymentStatus(paymentStatus);
			demandLetters.setPaymentMethod(paymentMethod);
		return new DemandDAO().save(demandLetters);
	}
}
