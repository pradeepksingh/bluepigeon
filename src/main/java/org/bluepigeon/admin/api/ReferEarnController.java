package org.bluepigeon.admin.api;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.CampaignDAO;
import org.bluepigeon.admin.dao.ReferEarnDAO;
import org.bluepigeon.admin.data.Refer;
import org.bluepigeon.admin.data.ReferEarnList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.CampaignBuyer;
import org.bluepigeon.admin.model.GlobalBuyer;

import com.google.gson.Gson;

@Path("api1.0/bp/refer")
public class ReferEarnController {
	@Context ServletContext context;
	GlobalBuyer globalBuyer=new GlobalBuyer();
	
	
	
	@GET
	@Path("refer.json/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ReferEarnList getReferEarn(@PathParam("id") int projectId){
		List<Refer> referList = new ReferEarnDAO().getReferEarnProjectId(projectId);
		List<Refer> newReferList = new ArrayList<>();
		ReferEarnList referEarnList = new ReferEarnList();
		for(Refer refer : referList){
			refer.setImage(context.getInitParameter("api_url")+refer.getImage());
			newReferList.add(refer);
		}
		referEarnList.setRefers(newReferList);
		
		return referEarnList;
	}
	
	
	@POST
	@Path("refer.json")
	@Produces(MediaType.APPLICATION_JSON)
	public String getReferEarn(@FormParam("pancard") String pancard, @FormParam("id") int projectId,@FormParam("view") int view){
		String json ="";
		ResponseMessage responseMessage= new ResponseMessage();
		Gson gson = new Gson();
		List<Refer> referList = new ReferEarnDAO().getReferEarnProjectId(projectId);
		List<Refer> newReferList = new ArrayList<Refer>();
		ReferEarnList referEarnList = new ReferEarnList();
		for(Refer refer : referList){
			refer.setImage(context.getInitParameter("api_url")+refer.getImage());
			newReferList.add(refer);
		}
		referEarnList.setRefers(newReferList);
		json = gson.toJson(referEarnList);
		new CampaignDAO().updateCampaignBuyer(pancard,projectId,view);
		CampaignBuyer campaignBuyer = new CampaignDAO().getCamapignBuyer(pancard, projectId);
		if(campaignBuyer != null){
			ReferEarnList newreferEarnList = gson.fromJson(json, ReferEarnList.class);
			newreferEarnList.setClicked(campaignBuyer.getClicks());
			newreferEarnList.setView(campaignBuyer.getView());
			json = gson.toJson(newreferEarnList);
		}else{
			responseMessage.setStatus(0);
			responseMessage.setMessage("User doesn't exist");
			json = gson.toJson(responseMessage);
		}
		return json;
	}
}
