package org.bluepigeon.admin.api;

import javax.servlet.ServletContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.ScheduleAPIDAO;
import org.bluepigeon.admin.data.ScheduleList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.GlobalBuyer;

import com.google.gson.Gson;

@Path("api1.0/bp/schedule")
public class ScheduleAPIController {
	@Context ServletContext context;
	GlobalBuyer globalBuyer=new GlobalBuyer();
	
	@GET
	@Path("schedule.json/{pancard}/{projectid}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getScheduleDetails(@PathParam("pancard") String pancard,@PathParam("projectid") int projectId){
		Gson gson = new Gson();
		String json ="";
		ResponseMessage responseMessage = new ResponseMessage();
		try{
			ScheduleList scheduleList = new ScheduleAPIDAO().getScheduleDetails(pancard, projectId);
			json = gson.toJson(scheduleList);
		}catch(Exception e){
			responseMessage.setStatus(0);
			responseMessage.setMessage("User doesn't exist");
			json = gson.toJson(responseMessage);
		}
		return json;
	}
}
