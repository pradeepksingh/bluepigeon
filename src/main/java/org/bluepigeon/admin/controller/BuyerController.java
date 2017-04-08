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
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.AgreementDAO;
import org.bluepigeon.admin.dao.BuyerDAO;
import org.bluepigeon.admin.data.AgreementList;
import org.bluepigeon.admin.data.BuildingData;
import org.bluepigeon.admin.data.BuyerList;
import org.bluepigeon.admin.data.FlatData;
import org.bluepigeon.admin.data.FloorData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.Agreement;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.BuyerDocuments;
import org.bluepigeon.admin.service.ImageUploader;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.hibernate.validator.metadata.AggregatedMethodMetaData;

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
	public ResponseMessage addBuyerInfo (
			@FormDataParam("project_id") int project_id,
			@FormDataParam("building_id") int building_id,
			@FormDataParam("floor_id") int floor_id,
			@FormDataParam("flat_id") int flat_id,
			@FormDataParam("name") String name,
			@FormDataParam("admin_id") int emp_id,
			@FormDataParam("contact") String contact,
			@FormDataParam("email") String email,
			@FormDataParam("pan") String pan,
			@FormDataParam("address") String address,
			@FormDataParam("status") byte status,
			@FormDataParam("buyer_image[]") List<FormDataBodyPart> image,
			@FormDataParam("document_type[]") List<FormDataBodyPart> douments 
			){
				ResponseMessage msg = new ResponseMessage();
				BuyerDAO buyerDAO = new BuyerDAO();
				AdminUser adminUser = new AdminUser();
				adminUser.setId(emp_id);
				
				
				
				Buyer buyer = new Buyer();
				buyer.setName(name);
				buyer.setAdminUser(adminUser);
				buyer.setPan(pan);
				buyer.setEmail(email);
				buyer.setContact(contact);
				buyer.setAddress(address);
				buyer.setStatus(status);
				if(project_id>0){
					BuilderProject builderProject = new BuilderProject();
					builderProject.setId(project_id);
					buyer.setBuilderProject(builderProject);
				}
				if(building_id>0){
					BuilderBuilding builderBuilding = new BuilderBuilding();
					builderBuilding.setId(building_id);
					buyer.setBuilderBuilding(builderBuilding);
				}
				if(floor_id>0){
					BuilderFloor builderFloor = new BuilderFloor();
					builderFloor.setId(floor_id);
					buyer.setBuilderFloor(builderFloor);
				}
				if(flat_id>0){
					BuilderFlat builderFlat = new BuilderFlat();
					builderFlat.setId(flat_id);
					buyer.setBuilderFlat(builderFlat);
				}
				if(image.size()>0){
					try{
						for(int i=0 ;i < image.size();i++)
						{
							if(image.get(i).getFormDataContentDisposition().getFileName() != null && !image.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
								String gallery_name = image.get(i).getFormDataContentDisposition().getFileName();
								long millis = System.currentTimeMillis() % 1000;
								gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
								gallery_name = "/images/project/buyer/images/"+gallery_name;
								String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
								this.imageUploader.writeToFile(image.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
								buyer.setPhoto(gallery_name);
							}
						}
					}catch(Exception e){
						msg.setStatus(0);
						msg.setMessage("Unable to save image");
					}
					msg = buyerDAO.saveBuyer(buyer);
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
				
				}
				return msg;
	}
	@GET
	@Path("/building/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuildingData> getBuildingList(@QueryParam("project_id") int project_id) {
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
		if(floorId > 0){
			BuilderFloor builderFloor = new BuilderFloor();
			builderFloor.setId(floorId);
			agreement.setBuilderFloor(builderFloor);
		}
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