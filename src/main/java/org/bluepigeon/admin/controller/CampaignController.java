package org.bluepigeon.admin.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.CampaignDAO;
import org.bluepigeon.admin.data.BuyerBuildingList;
import org.bluepigeon.admin.data.BuyerFlatList;
import org.bluepigeon.admin.data.BuyerProjectList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderEmployeeAccessType;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.Campaign;
import org.bluepigeon.admin.model.CampaignBuyer;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.service.ImageUploader;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

@Path("campaign")
public class CampaignController {
	@Context ServletContext context;
	ImageUploader imageUploader = new ImageUploader();
	
	@POST
	@Path("/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuyerInfoNew (
			@FormDataParam("admin_id") int admin_id,
			@FormDataParam("title") String  name,
			@FormDataParam("campaign_type") int  campaignType,
			@FormDataParam("set_date") String setDate,
			@FormDataParam("content") String content,
			@FormDataParam("terms") String terms,
			@FormDataParam("city_id") int city_id,
			@FormDataParam("project_id") int project_id,
			@FormDataParam("builder_id") int builder_id,
			@FormDataParam("emp_id") int emp_id,
			@FormDataParam("recipient_type_id") int recipientType,
			@FormDataParam("buyer_name[]") List<FormDataBodyPart> buyerNames
			
			){
				ResponseMessage msg = new ResponseMessage();
				BuilderEmployee builderEmployee = new BuilderEmployee();
				Builder builder = new Builder();
				AdminUser adminUser = new AdminUser();
				City city = new City();
				BuilderProject builderProject = new BuilderProject();
				if(admin_id > 0)
					adminUser.setId(admin_id);
				
				if(city_id > 0){
					city.setId(city_id);
				}
				if(project_id>0){
					builderProject.setId(project_id);
				}
				if(builder_id > 0)
					builder.setId(builder_id);
				if(emp_id > 0)
					builderEmployee.setId(emp_id);
				
				Campaign campaign = new Campaign();
				campaign.setAdminUser(adminUser);
				campaign.setCity(city);
				campaign.setBuilderProject(builderProject);
				campaign.setTitle(name);
				campaign.setContent(content);
				campaign.setTerms(terms);
				campaign.setBuilder(builder);
				campaign.setType(campaignType);
				SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
				Date startDate = null;
				try {
					startDate = format.parse(setDate);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				campaign.setSetDate(startDate);
				campaign.setRecipientType(recipientType);
				CampaignDAO campaignDAO = new CampaignDAO();
				msg=campaignDAO.saveCampaign(campaign);
				if(msg.getId()>0){
					campaign.setId(msg.getId());
					List<CampaignBuyer> campaignBuyers = new ArrayList<CampaignBuyer>();
					
					for(FormDataBodyPart campaignList :buyerNames ){
						if(campaignList.getValueAs(Integer.class) != null || campaignList.getValueAs(Integer.class) !=0){
							CampaignBuyer campaignBuyer = new CampaignBuyer();
							campaignBuyer.setCampaign(campaign);
							Buyer buyer = new Buyer();
							buyer.setId(campaignList.getValueAs(Integer.class));
							campaignBuyer.setBuyer(buyer);
							campaignBuyers.add(campaignBuyer);
						}
					}
					if(campaignBuyers.size()>0){
						msg=campaignDAO.saveBuyerCampaign(campaignBuyers);
					}
				}
				return msg;
	}
	@GET
	@Path("/projectlist/{city_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuyerProjectList> getBuildingList(@PathParam("city_id") int city_id) {
		return  new CampaignDAO().getBuyerProjectByCityId(city_id);
	}
	
	@GET
	@Path("/building/names/{project_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuyerBuildingList> getProjectBuildingNames(@PathParam("project_id") int project_id) {
		return new CampaignDAO().getBuyerBuildingListByProjectId(project_id);
	}
	
	@GET
	@Path("/building/flat/names/{building_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuyerFlatList> getProjectBuildingFlatNames(@PathParam("building_id") int building_id) {
		return new CampaignDAO().getBuyerFlatListByBuildingId(building_id);
	}

	@GET
	@Path("/flat/buyer/names/{flat_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Buyer> getBuyerNamesByFlatId(@PathParam("flat_id") int flat_id) {
		return new CampaignDAO().getBuyerbyFlatId(flat_id);
	}
	@POST
	@Path("/save1")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuyerInfoNew (
			@FormDataParam("title") String  name,
			@FormDataParam("campaign_type") int  campaignType,
			@FormDataParam("set_date") String setDate,
			@FormDataParam("content") String content,
			@FormDataParam("terms") String terms,
			@FormDataParam("city_id") int city_id,
			@FormDataParam("project_id") int project_id,
			@FormDataParam("recipient_type_id") int recipientType,
			@FormDataParam("builder_id") int builderId,
			@FormDataParam("buyer_name[]") List<FormDataBodyPart> buyerNames
			){
				ResponseMessage msg = new ResponseMessage();
				AdminUser adminUser = new AdminUser();
				adminUser.setId(1);
				Builder builder = new Builder();
				Campaign campaign = new Campaign();
				if(buyerNames != null){
					campaign.setAdminUser(adminUser);
					campaign.setTitle(name);
					campaign.setType(campaignType);
					campaign.setContent(content);
					campaign.setTerms(terms);
					if(builderId > 0){
						builder.setId(builderId);
						campaign.setBuilder(builder);
					}
					if(city_id > 0){
						City city = new City();
						city.setId(city_id);
						campaign.setCity(city); 
					}
					if(project_id > 0){
						BuilderProject builderProject = new BuilderProject();
						builderProject.setId(project_id);
						campaign.setBuilderProject(builderProject);
					}
					SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
					Date startDate = null;
					try {
						startDate = format.parse(setDate);
					} catch (ParseException e) {
						e.printStackTrace();
					}
					campaign.setSetDate(startDate);
					campaign.setRecipientType(recipientType);
					CampaignDAO campaignDAO = new CampaignDAO();
					msg=campaignDAO.saveCampaign(campaign);
					if(msg.getId()>0){
						campaign.setId(msg.getId());
						List<CampaignBuyer> campaignBuyers = new ArrayList<CampaignBuyer>();
							for(FormDataBodyPart campaignList :buyerNames ){
								if(campaignList.getValueAs(Integer.class) != null || campaignList.getValueAs(Integer.class) !=0){
									CampaignBuyer campaignBuyer = new CampaignBuyer();
									campaignBuyer.setCampaign(campaign);
									Buyer buyer = new Buyer();
									buyer.setId(campaignList.getValueAs(Integer.class));
									campaignBuyer.setBuyer(buyer);
									campaignBuyers.add(campaignBuyer);
								}
							}
							if(campaignBuyers.size()>0){
								msg=campaignDAO.saveBuyerCampaign(campaignBuyers);
							}
						}
				}else{
					msg.setStatus(0);
					msg.setMessage("Please Select Recipients Name");
				}
				return msg;
	}
}
