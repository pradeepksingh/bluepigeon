package org.bluepigeon.admin.api;

import javax.servlet.ServletContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.PayableListDAO;
import org.bluepigeon.admin.data.PayableList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.GlobalBuyer;

import com.google.gson.Gson;

@Path("api1.0/bp/payable")
public class NetPayableController {
	@Context ServletContext context;
	GlobalBuyer globalBuyer=new GlobalBuyer();
	
	@GET
	@Path("payable.json/{pancard}/{projectid}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getPropertyDocument(@PathParam("pancard") String pancard,@PathParam("projectid") int projectId){
		Gson gson = new Gson();
		String json = "";
		ResponseMessage responseMessage = new ResponseMessage();
		try{
			PayableList payableList = new PayableListDAO().getReferEarnProjectId(pancard, projectId);
			json = gson.toJson(payableList);
		}catch(Exception e){
			responseMessage.setStatus(0);
			responseMessage.setMessage("User doesn't exist");
			json= gson.toJson(responseMessage);
			
		}
		return json;
	}
}
