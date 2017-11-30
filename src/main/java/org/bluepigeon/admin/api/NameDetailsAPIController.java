package org.bluepigeon.admin.api;

import java.util.List;

import javax.servlet.ServletContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.NameDetailsDAO;
import org.bluepigeon.admin.data.NameDetails;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.GlobalBuyer;

import com.google.gson.Gson;

@Path("api1.0/bp/building")
public class NameDetailsAPIController {
	@Context ServletContext context;
	GlobalBuyer globalBuyer=new GlobalBuyer();
	
	@GET
	@Path("buildingdetails.json/{buildingid}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getBuildingDetails(@PathParam("buildingid") int buildingid){
		Gson gson = new Gson();
		String json = "";
		NameDetails nameDetails = null;
		ResponseMessage responseMessage = new ResponseMessage();
		try{
			nameDetails = new NameDetailsDAO().getBuildingDetails(buildingid);
			nameDetails.setImage(context.getInitParameter("api_url")+nameDetails.getImage());
			
			json = gson.toJson(nameDetails);
		}catch(Exception e){
			e.printStackTrace();
			responseMessage.setStatus(0);
			responseMessage.setMessage(e.getMessage());
			json= gson.toJson(responseMessage);
		}
		return json;
	}
	
	@GET
	@Path("floor/floordetails.json/{floorid}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getFloorDetails(@PathParam("floorid") int floorId){
		Gson gson = new Gson();
		String json = "";
		NameDetails nameDetails = null;
		ResponseMessage responseMessage = new ResponseMessage();
		try{
			nameDetails = new NameDetailsDAO().getFloorDetails(floorId);
			nameDetails.setImage(context.getInitParameter("api_url")+nameDetails.getImage());
			json = gson.toJson(nameDetails);
		}catch(Exception e){
			e.printStackTrace();
			responseMessage.setStatus(0);
			responseMessage.setMessage(e.getMessage());
			json= gson.toJson(responseMessage);
		}
		return json;
	}
	
	@GET
	@Path("floor/flat/flatdetails.json/{flatid}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getFlatDetails(@PathParam("flatid") int flatId){
		Gson gson = new Gson();
		String json = "";
		NameDetails nameDetails = null;
		ResponseMessage responseMessage = new ResponseMessage();
		try{
			nameDetails = new NameDetailsDAO().getFlatDetails(flatId);
			nameDetails.setImage(context.getInitParameter("api_url")+nameDetails.getImage());
			json = gson.toJson(nameDetails);
		}catch(Exception e){
			e.printStackTrace();
			responseMessage.setStatus(0);
			responseMessage.setMessage(e.getMessage());
			json= gson.toJson(responseMessage);
		}
		return json;
	}
}