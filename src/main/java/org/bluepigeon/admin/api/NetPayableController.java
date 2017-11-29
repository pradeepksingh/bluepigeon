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
import org.bluepigeon.admin.model.GlobalBuyer;

@Path("api1.0/bp/payable")
public class NetPayableController {
	@Context ServletContext context;
	GlobalBuyer globalBuyer=new GlobalBuyer();
	
	@GET
	@Path("payable.json/{pancard}/{projectid}")
	@Produces(MediaType.APPLICATION_JSON)
	public PayableList getPropertyDocument(@PathParam("pancard") String pancard,@PathParam("projectid") int projectId){
		PayableList payableList = new PayableListDAO().getReferEarnProjectId(pancard, projectId);
		return payableList;
	}
}
