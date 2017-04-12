package org.bluepigeon.admin.controller;

import java.io.InputStream;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.AgreementDAO;
import org.bluepigeon.admin.dao.BuyerDAO;
import org.bluepigeon.admin.dao.ProjectDAO;
import org.bluepigeon.admin.data.BuildingData;
import org.bluepigeon.admin.data.BuyerList;
import org.bluepigeon.admin.data.FlatData;
import org.bluepigeon.admin.data.FloorData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.Agreement;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.BuyerDocuments;
import org.bluepigeon.admin.service.ImageUploader;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

import javassist.expr.NewArray;

@Path("buyer")
public class BuyerController {
	@Context ServletContext context;
	ImageUploader imageUploader = new ImageUploader();
	@POST
	@Path("/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuyerList> getBuilderProjects(
			@FormParam("company_id") int company_id,
			@FormParam("project_name") String project_name
	) {
		List<BuyerList> buyer_list = new BuyerDAO().getBuyerListByCompanyId(company_id, project_name);
		return buyer_list;
	}
	
	@POST
	@Path("/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addBuyerInfoNew (
			@FormDataParam("admin_id") int emp_id,
			@FormDataParam("buyer_name[]") List<FormDataBodyPart>  name,
			@FormDataParam("contact[]") List<FormDataBodyPart>  contact,
			@FormDataParam("email[]") List<FormDataBodyPart>  email,
			@FormDataParam("pan[]") List<FormDataBodyPart>  pan,
			@FormDataParam("address[]") List<FormDataBodyPart>  address,
			@FormDataParam("is_primary[]") List<FormDataBodyPart>  is_primary,
			@FormDataParam("document_type[]") List<FormDataBodyPart> douments ,
			@FormDataParam("project_id") int project_id,
			@FormDataParam("building_id") int building_id,
			@FormDataParam("flat_id") int flat_id,
			//@FormDataParam("agreement") Short agreement,
			//@FormDataParam("possession") Short possession,
			@FormDataParam("status") Short status
			//@FormDataParam("buyer_image[]") List<FormDataBodyPart> image,
			){
				ResponseMessage msg = new ResponseMessage();
				BuyerDAO buyerDAO = new BuyerDAO();
				AdminUser adminUser = new AdminUser();
				adminUser.setId(emp_id);
				Short agreement=0;
				Short possession=0;
				Buyer buyer = null;
				List<Buyer> buyerList = new ArrayList<Buyer>();
				
				if(name.size()>0){
				
					int i=0;
					for(FormDataBodyPart buyers : name){
						buyer = new Buyer();
						buyer.setAdminUser(adminUser);
						buyer.setStatus(status);
						buyer.setAgreement(agreement);
						buyer.setPossession(possession);
						if(project_id>0){
							BuilderProject builderProject = new BuilderProject();
							builderProject.setId(project_id);
							buyer.setBuilderProject(builderProject);
						}
						
						if(flat_id>0){
							BuilderFlat builderFlat = new BuilderFlat();
							builderFlat.setId(flat_id);
							buyer.setBuilderFlat(builderFlat);
						}
						if(buyers.getValueAs(String.class).toString()!=null || !buyers.getValueAs(String.class).isEmpty()){
							buyer.setName(name.get(i).getValueAs(String.class).toString());
							buyer.setContact(contact.get(i).getValueAs(String.class).toString());
							buyer.setEmail(email.get(i).getValueAs(String.class).toString());
							buyer.setAddress(address.get(i).getValueAs(String.class).toString());
							buyer.setPan(pan.get(i).getValueAs(String.class).toString());
						}
						//if(buyers.getValueAs(Short.class) != null)
							buyer.setIsPrimary(is_primary.get(i).getValueAs(Short.class).shortValue());
						buyerList.add(buyer);
						
						i++;	
					}
				}
				
				//buyer.setPan(pan);
				//buyer.setEmail(email);
//				buyer.setContact(contact);
//				buyer.setAddress(address);
				
				
//				if(image.size()>0){
//					try{
//						for(int i=0 ;i < image.size();i++)
//						{
//							if(image.get(i).getFormDataContentDisposition().getFileName() != null && !image.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
//								String gallery_name = image.get(i).getFormDataContentDisposition().getFileName();
//								long millis = System.currentTimeMillis() % 1000;
//								gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
//								gallery_name = "/images/project/buyer/images/"+gallery_name;
//								String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
//								this.imageUploader.writeToFile(image.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
//								buyer.setPhoto(gallery_name);
//							}
//						}
//					}catch(Exception e){
//						msg.setStatus(0);
//						msg.setMessage("Unable to save image");
//					}
				
					msg = buyerDAO.saveBuyer(buyerList);
					if(msg.getId()>0){
						buyer.setId(msg.getId());
						if(douments.size()>0){
							List<BuyerDocuments> buyerDocumentsList = new ArrayList<BuyerDocuments>();
							for(FormDataBodyPart buyerDocuments : douments ){
								if(buyerDocuments.getValueAs(Integer.class) != null && buyerDocuments.getValueAs(Integer.class) != 0) {
									BuyerDocuments buyerDocuments2 = new BuyerDocuments();
									buyerDocuments2.setBuyer(buyer);
									buyerDocuments2.setDocuments(buyerDocuments.getValue());
									buyerDocumentsList.add(buyerDocuments2);
								}
							}
							if(buyerDocumentsList.size()>0){
								buyerDAO.saveBuyerDocuments(buyerDocumentsList);
							}
						}
					}
				
				//}
//				if(image.isEmpty()){
//					msg.setStatus(0);
//					msg.setMessage("Unable to save image");
//				}
//				msg.setStatus(0);
//				msg.setMessage("Unable to save image");
				return msg;
	}
	@GET
	@Path("/building/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuildingData> getBuildingList(@QueryParam("project_id") int project_id) {
		System.out.println("BuilderBuilding ProjectId :: "+project_id);
		BuyerDAO buyerDAO = new BuyerDAO();
		return buyerDAO.getBuildingByProjectId(project_id);
	}
	
	@GET
	@Path("/floor/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<FloorData> getFloorList(@QueryParam("building_id") int building_id) {
		BuyerDAO buyerDAO = new BuyerDAO();
		return buyerDAO.getBuilderFloorByBuildingId(building_id);
	}
	@GET
	@Path("/flat/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<FlatData> getFlatList(@QueryParam("floor_id") int floor_id) {
		BuyerDAO buyerDAO = new BuyerDAO();
		return buyerDAO.getBuilderFlatTypeByFloorId(floor_id);
	}
	@GET
	@Path("/flat/booked/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<FlatData> getBookedFlatList(@QueryParam("floor_id") int floor_id) {
		BuyerDAO buyerDAO = new BuyerDAO();
		return buyerDAO.getBookedFlatByFloorId(floor_id);
	}
	
	@GET
	@Path("/flat")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Buyer> getBuyerListByFlatId(@QueryParam("flat_id") int flat_id) {
		BuyerDAO buyerDAO = new BuyerDAO();
		return buyerDAO.getBuyerByFlatId(flat_id);
	}
	
	@GET
	@Path("/building/available/flat/names/{building_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<FlatData> getProjectBuildingFlatNames(@PathParam("building_id") int building_id) {
		return new BuyerDAO().getBuilderProjectBuildingFlats(building_id);
	}
	/**
	 * Get Building List by passing project id
	 * @param project_id
	 * @return
	 */
	@GET
	@Path("/buildings/names/{project_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuildingData> getProjectBuildingNames(@PathParam("project_id") int project_id) {
		BuyerDAO projectDAO = new BuyerDAO();
		List<BuildingData> buildings = projectDAO.getBuildingsByProjectId(project_id);
//				List<BuilderBuilding> newbuildings = new ArrayList<BuilderBuilding>();
//				for(BuilderBuilding builderBuilding :buildings) {
//					BuilderBuilding building = new BuilderBuilding();
//					building.setId(builderBuilding.getId());
//					building.setName(builderBuilding.getName());
//					newbuildings.add(building);
//				}
		return buildings;
	}
	
	@POST
	@Path("/agreement/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addAgeement(
			@FormParam("project_id") int projectId,
			@FormParam("building_id") int buildingId,
			@FormParam("floor_id") int floorId,
			@FormParam("flat_id") int flatId,
			@FormParam("name") String name,
			@FormParam("contact") String contact,
			@FormParam("email") String email,
			@FormParam("remind") String remind,
			@FormParam("content") String content,
			@FormParam("last_date") String last_date){
		SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
		Date lastDate = null;
		try {
			lastDate = format.parse(last_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Agreement agreement = new Agreement();
		agreement.setLastDate(lastDate);
		agreement.setRemind(remind);
		agreement.setContent(content);
		if(projectId > 0){
			BuilderProject builderProject = new BuilderProject();
			builderProject.setId(projectId);
			agreement.setBuilderProject(builderProject);
		}
		if(buildingId > 0){
			BuilderBuilding builderBuilding = new BuilderBuilding();
			builderBuilding.setId(buildingId);
			agreement.setBuilderBuilding(builderBuilding);
		}
//		if(floorId > 0){
//			BuilderFloor builderFloor = new BuilderFloor();
//			builderFloor.setId(floorId);
//			agreement.setBuilderFloor(builderFloor);
//		}
		if(flatId > 0){
			BuilderFlat builderFlat = new BuilderFlat();
			builderFlat.setId(flatId);
			agreement.setBuilderFlat(builderFlat);
		}
		agreement.setName(name);
		agreement.setContact(contact);
		agreement.setEmail(email);
		
		return new AgreementDAO().saveAgreement(agreement);
	}
}