package org.bluepigeon.admin.controller;

import java.util.Date;
import java.io.InputStream;
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
import org.bluepigeon.admin.dao.DemandLettersDAO;
import org.bluepigeon.admin.dao.PossessionDAO;
import org.bluepigeon.admin.dao.ProjectDAO;
import org.bluepigeon.admin.data.BuildingData;
import org.bluepigeon.admin.data.BuildingPaymentList;
import org.bluepigeon.admin.data.BuyerList;
import org.bluepigeon.admin.data.BuyerPaymentList;
import org.bluepigeon.admin.data.FlatData;
import org.bluepigeon.admin.data.FlatPaymentList;
import org.bluepigeon.admin.data.FloorData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.Agreement;
import org.bluepigeon.admin.model.AgreementInfo;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuildingImageGallery;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.BuyerDocuments;
import org.bluepigeon.admin.model.DemandLetters;
import org.bluepigeon.admin.model.DemandLettersInfo;
import org.bluepigeon.admin.model.Possession;
import org.bluepigeon.admin.model.PossessionInfo;
import org.bluepigeon.admin.service.ImageUploader;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

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
				int flag =0;
				Short isPrimary =0;
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
						if(is_primary.get(i).getValueAs(Short.class).shortValue() == 1){
							flag++;
							buyer.setIsPrimary(is_primary.get(i).getValueAs(Short.class).shortValue());
						}
						if(flag>1){
							buyer.setIsPrimary(isPrimary);
						}
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
				
				//	msg = buyerDAO.saveBuyer(buyerList);
					
					//if(msg.getId()>0){
						//Buyer msgBuyer = (Buyer)msg.getData();
						//System.out.println("Buyer data :: "+msgBuyer.getId());
					//	buyer.setId(msg.getId());
						if(douments.size()>0){
							List<BuyerDocuments> buyerDocumentsList = new ArrayList<BuyerDocuments>();
							for(FormDataBodyPart buyerDocuments : douments ){
								if(buyerDocuments.getValueAs(Integer.class) != null && buyerDocuments.getValueAs(Integer.class) != 0) {
								//	BuyerDocuments buyerDocuments2 = new BuyerDocuments();
								//	buyerDocuments2.setBuyer(buyer);
								//	buyerDocuments2.setDocuments(buyerDocuments.getValue());
									System.out.println("<script>console.log(Douments :: "+buyerDocuments.getValueAs(Integer.class)+");<script>");
								//	buyerDocumentsList.add(buyerDocuments2);
								}
							}
							if(buyerDocumentsList.size()>0){
								//buyerDAO.saveBuyerDocuments(buyerDocumentsList);
							}
						}
					//}
				
				//}
//				if(image.isEmpty()){
//					msg.setStatus(0);
//					msg.setMessage("Unable to save image");
//				}
//				msg.setStatus(0);
//				msg.setMessage("Unable to save image");
			//	return msg;
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
	public List<FlatData> getFloorList(@QueryParam("building_id") int building_id) {
		BuyerDAO buyerDAO = new BuyerDAO();
		return buyerDAO.getBuilderFlatTypeByFloorId(building_id);
	}
//	@GET
//	@Path("/flat/list")
//	@Produces(MediaType.APPLICATION_JSON)
//	public List<FlatData> getFlatList(@QueryParam("floor_id") int floor_id) {
//		BuyerDAO buyerDAO = new BuyerDAO();
//		return buyerDAO.getBuilderFlatTypeByFloorId(floor_id);
//	}
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
	
	@POST
	@Path("/agreement/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateAgeement(
			@FormDataParam("agreement_id") int id,
			@FormDataParam("project_id") int projectId,
			@FormDataParam("building_id") int buildingId,
			//@FormParam("floor_id") int floorId,
			@FormDataParam("flat_id") int flatId,
			@FormDataParam("name") String name,
			@FormDataParam("contact") String contact,
			@FormDataParam("email") String email,
			@FormDataParam("remind") String remind,
			@FormDataParam("content") String content,
			@FormDataParam("last_date") String last_date,
			@FormDataParam("agreement_doc[]")List<FormDataBodyPart> agreementDocument
			){
		SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
		Date lastDate = null;
		try {
			lastDate = format.parse(last_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Agreement agreement = new Agreement();
		agreement.setId(id);
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
		ResponseMessage msg = new AgreementDAO().updateAgreement(agreement);
		if(msg.getId() > 0) {
			agreement.setId(msg.getId());
		//add gallery images
		try {	
			List<AgreementInfo> buildingImageGalleries = new ArrayList<AgreementInfo>();
			//for multiple inserting images.
			if (agreementDocument.size() > 0) {
				for(int i=0 ;i < agreementDocument.size();i++)
				{
					if(agreementDocument.get(i).getFormDataContentDisposition().getFileName() != null && !agreementDocument.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						AgreementInfo buildingImageGallery = new AgreementInfo();
						String gallery_name = agreementDocument.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/building/images/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						//System.out.println("for loop image path: "+uploadGalleryLocation);
						this.imageUploader.writeToFile(agreementDocument.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						buildingImageGallery.setDocUrl(gallery_name);
						buildingImageGallery.setAgreement(agreement);
						buildingImageGalleries.add(buildingImageGallery);
					}
				}
				if(buildingImageGalleries.size() > 0) {
					new AgreementDAO().updateAgreementDocuments(buildingImageGalleries);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to save Agreement Documents");
			}
		}
		return msg;
	}
	
	@GET
	@Path("/agreement/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteFloorPlan(@PathParam("id") int agreement_id) {
		ResponseMessage msg = new ResponseMessage();
		AgreementDAO agreementDAO = new AgreementDAO();
		msg = agreementDAO.deleteAgreementDoc(agreement_id);
		return msg;
	}
	
	@POST
	@Path("/possession/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addPossession(
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
		Possession possession = new Possession();
		possession.setLastDate(lastDate);
		possession.setRemind(remind);
		possession.setContent(content);
		if(projectId > 0){
			BuilderProject builderProject = new BuilderProject();
			builderProject.setId(projectId);
			possession.setBuilderProject(builderProject);
		}
		if(buildingId > 0){
			BuilderBuilding builderBuilding = new BuilderBuilding();
			builderBuilding.setId(buildingId);
			possession.setBuilderBuilding(builderBuilding);
		}
//		if(floorId > 0){
//			BuilderFloor builderFloor = new BuilderFloor();
//			builderFloor.setId(floorId);
//			agreement.setBuilderFloor(builderFloor);
//		}
		if(flatId > 0){
			BuilderFlat builderFlat = new BuilderFlat();
			builderFlat.setId(flatId);
			possession.setBuilderFlat(builderFlat);
		}
		possession.setName(name);
		possession.setContact(contact);
		possession.setEmail(email);
		
		return new PossessionDAO().savePossession(possession);
	}
	
	@POST
	@Path("/possession/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updatePossession(
			@FormDataParam("possession_id") int id,
			@FormDataParam("project_id") int projectId,
			@FormDataParam("building_id") int buildingId,
			//@FormParam("floor_id") int floorId,
			@FormDataParam("flat_id") int flatId,
			@FormDataParam("name") String name,
			@FormDataParam("contact") String contact,
			@FormDataParam("email") String email,
			@FormDataParam("remind") String remind,
			@FormDataParam("content") String content,
			@FormDataParam("last_date") String last_date,
			@FormDataParam("possession_doc[]")List<FormDataBodyPart> agreementDocument
			){
		SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
		Date lastDate = null;
		try {
			lastDate = format.parse(last_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Possession possession = new Possession();
		possession.setId(id);
		possession.setLastDate(lastDate);
		possession.setRemind(remind);
		possession.setContent(content);
		if(projectId > 0){
			BuilderProject builderProject = new BuilderProject();
			builderProject.setId(projectId);
			possession.setBuilderProject(builderProject);
		}
		if(buildingId > 0){
			BuilderBuilding builderBuilding = new BuilderBuilding();
			builderBuilding.setId(buildingId);
			possession.setBuilderBuilding(builderBuilding);
		}
//		if(floorId > 0){
//			BuilderFloor builderFloor = new BuilderFloor();
//			builderFloor.setId(floorId);
//			agreement.setBuilderFloor(builderFloor);
//		}
		if(flatId > 0){
			BuilderFlat builderFlat = new BuilderFlat();
			builderFlat.setId(flatId);
			possession.setBuilderFlat(builderFlat);
		}
		possession.setName(name);
		possession.setContact(contact);
		possession.setEmail(email);
		ResponseMessage msg = new PossessionDAO().updatePossession(possession);
		if(msg.getId() > 0) {
			possession.setId(msg.getId());
		//add gallery images
		try {	
			List<PossessionInfo> buildingImageGalleries = new ArrayList<PossessionInfo>();
			//for multiple inserting images.
			if (agreementDocument.size() > 0) {
				for(int i=0 ;i < agreementDocument.size();i++)
				{
					if(agreementDocument.get(i).getFormDataContentDisposition().getFileName() != null && !agreementDocument.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						PossessionInfo buildingImageGallery = new PossessionInfo();
						String gallery_name = agreementDocument.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/building/images/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						System.out.println("for loop image path: "+uploadGalleryLocation);
						this.imageUploader.writeToFile(agreementDocument.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						buildingImageGallery.setDocUrl(gallery_name);
						buildingImageGallery.setPossession(possession);
						buildingImageGalleries.add(buildingImageGallery);
					}
				}
				if(buildingImageGalleries.size() > 0) {
					new PossessionDAO().updateAgreementDocuments(buildingImageGalleries);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to update Possession Documents");
			}
		}
		return msg;
	}
	
	@GET
	@Path("/possession/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deletePossessionPlan(@PathParam("id") int possession_id) {
		ResponseMessage msg = new ResponseMessage();
		PossessionDAO agreementDAO = new PossessionDAO();
		msg = agreementDAO.deletePossessionDoc(possession_id);
		return msg;
	}
	
	@GET
	@Path("/demandletter/building/{project_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public  List<BuildingPaymentList> getDemandLetterByProjectId(@PathParam("project_id") int projectId){
		DemandLettersDAO demandLettersDAO = new DemandLettersDAO();
		return demandLettersDAO.getPaymentByProejctId(projectId);
	}
	
	@GET
	@Path("/demandletter/flat/")
	@Produces(MediaType.APPLICATION_JSON)
	public  List<FlatPaymentList> getDemandLetterByBuildingId(@QueryParam("building_id") int buildingId){
		DemandLettersDAO demandLettersDAO = new DemandLettersDAO();
		return demandLettersDAO.getPaymentByBuildingId(buildingId);
	}
	
	@GET
	@Path("/demandletter/flat/buyer")
	@Produces(MediaType.APPLICATION_JSON)
	public  List<BuyerPaymentList> getDemandLetterByFlatId(@QueryParam("flat_id") int flatId){
		DemandLettersDAO demandLettersDAO = new DemandLettersDAO();
		return demandLettersDAO.getBuyerPaymentByFlatId(flatId);
	}
	

	@POST
	@Path("/demandletter/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateDemandletter(
			@FormDataParam("demandletter_id") int id,
			@FormDataParam("project_id") int projectId,
			@FormDataParam("building_id") int buildingId,
			//@FormParam("floor_id") int floorId,
			@FormDataParam("milestone_id") int milestone_id,
			@FormDataParam("flat_id") int flatId,
			@FormDataParam("name") String name,
			@FormDataParam("contact") String contact,
			@FormDataParam("email") String email,
			@FormDataParam("remind") String remind,
			@FormDataParam("content") String content,
			@FormDataParam("last_date") String last_date,
			@FormDataParam("demandletter_doc[]")List<FormDataBodyPart> demandletterDocument
			){
		SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
		Date lastDate = null;
		try {
			lastDate = format.parse(last_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		DemandLetters demandLetters = new DemandLetters();
		demandLetters.setId(id);
		demandLetters.setLastDate(lastDate);
		demandLetters.setRemind(remind);
		demandLetters.setContent(content);
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
		else{
			demandLetters.setBuilderBuilding(null);
		}
//		if(floorId > 0){
//			BuilderFloor builderFloor = new BuilderFloor();
//			builderFloor.setId(floorId);
//			agreement.setBuilderFloor(builderFloor);
//		}
		if(flatId > 0){
			BuilderFlat builderFlat = new BuilderFlat();
			builderFlat.setId(flatId);
			demandLetters.setBuilderFlat(builderFlat);
		}
		else{
			demandLetters.setBuilderFlat(null);
		}
		demandLetters.setPaymentId(milestone_id);
		demandLetters.setName(name);
		demandLetters.setContact(contact);
		demandLetters.setEmail(email);
		ResponseMessage msg = new DemandLettersDAO().updateDemandLetters(demandLetters);
		if(msg.getId() > 0) {
			demandLetters.setId(msg.getId());
		//add gallery images
		try {	
			List<DemandLettersInfo> buildingImageGalleries = new ArrayList<DemandLettersInfo>();
			//for multiple inserting images.
			if (demandletterDocument.size() > 0) {
				for(int i=0 ;i < demandletterDocument.size();i++)
				{
					if(demandletterDocument.get(i).getFormDataContentDisposition().getFileName() != null && !demandletterDocument.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						DemandLettersInfo buildingImageGallery = new DemandLettersInfo();
						String gallery_name = demandletterDocument.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/building/images/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						//System.out.println("for loop image path: "+uploadGalleryLocation);
						this.imageUploader.writeToFile(demandletterDocument.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						buildingImageGallery.setDocUrl(gallery_name);
						buildingImageGallery.setDemandLetters(demandLetters);
						buildingImageGalleries.add(buildingImageGallery);
					}
				}
				if(buildingImageGalleries.size() > 0) {
					new DemandLettersDAO().updateDemandLetterDocuments(buildingImageGalleries);
				}
			}
		} catch(Exception e) {
			msg.setStatus(0);
			msg.setMessage("Unable to update Demand Letter Documents");
			}
		}
		return msg;
	}
	
	@GET
	@Path("/demandletter/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteDemandletterPlan(@PathParam("id") int demandletter_id) {
		return new DemandLettersDAO().deleteDemandLettersDoc(demandletter_id);
	}
}
	
	