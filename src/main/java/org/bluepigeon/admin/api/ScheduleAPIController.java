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
import org.bluepigeon.admin.model.GlobalBuyer;

@Path("api1.0/bp/schedule")
public class ScheduleAPIController {
	@Context ServletContext context;
	GlobalBuyer globalBuyer=new GlobalBuyer();
	
	@GET
	@Path("schedule.json/{pancard}/{projectid}")
	@Produces(MediaType.APPLICATION_JSON)
	public ScheduleList getScheduleDetails(@PathParam("pancard") String pancard,@PathParam("projectid") int projectId){
		ScheduleList payableList = new ScheduleAPIDAO().getScheduleDetails(pancard, projectId);
		return payableList;
	}
}
