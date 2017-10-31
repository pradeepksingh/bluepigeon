package org.bluepigeon.admin.controller;

import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import javax.ws.rs.core.UriInfo;

import org.bluepigeon.admin.dao.BuilderDetailsDAO;
import org.bluepigeon.admin.dao.BuyerDAO;
import org.bluepigeon.admin.dao.ProjectDAO;
import org.bluepigeon.admin.data.BarGraphData;
import org.bluepigeon.admin.data.BookingFlatList;
import org.bluepigeon.admin.data.BuildingData;
import org.bluepigeon.admin.data.BuildingList;
import org.bluepigeon.admin.data.BuyerList;
import org.bluepigeon.admin.data.ConfigData;
import org.bluepigeon.admin.data.FlatListData;
import org.bluepigeon.admin.data.InboxMessageData;
import org.bluepigeon.admin.data.NewLeadList;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.data.ProjectWiseData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AllotProject;
import org.bluepigeon.admin.data.BookedBuyerList;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderBuildingAmenity;
import org.bluepigeon.admin.model.BuilderBuildingStatus;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFlatStatus;
import org.bluepigeon.admin.model.BuilderFlatType;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuildingAmenityInfo;
import org.bluepigeon.admin.model.BuildingAmenityWeightage;
import org.bluepigeon.admin.model.BuildingOfferInfo;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.BuyerUploadDocuments;
import org.bluepigeon.admin.model.FlatAmenityWeightage;
import org.bluepigeon.admin.model.InboxMessage;
import org.bluepigeon.admin.model.InboxMessageReply;
import org.bluepigeon.admin.service.ImageUploader;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

@Path("builder")
public class BuilderController {

	@Context ServletContext context;
	ImageUploader imageUploader = new ImageUploader();
	@GET
	@Path("/building/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuildingList> addState(@QueryParam("project_id") int project_id) {
		ProjectDAO projectDAO = new ProjectDAO();
		System.out.println("projectId ::: "+project_id);
		return projectDAO.getBuildingByProjectId(project_id);
	}

	@POST
	@Path("/building/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuilding (
			@FormDataParam("project_id") int project_id,
			@FormDataParam("building_id") int building_id,
			@FormDataParam("name") String name, 
			@FormDataParam("total_floor") int total_floor
			
	) {
		ResponseMessage msg = new ResponseMessage();
		if(building_id > 0){
			msg = new BuilderDetailsDAO().updateProjectDetails(building_id,project_id,name,total_floor);
		} else {
			msg.setMessage("Failed to update building info.");
			msg.setStatus(0);
		}
		return msg;
	}
 	
	@POST
	@Path("/building/offer/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuildingInfo (
			@FormDataParam("building_id") int building_id,
			@FormDataParam("launch_date") String launch_date,
			@FormDataParam("possession_date") String possession_date,
			@FormDataParam("status") Integer status,
			@FormDataParam("amenity_type[]") List<FormDataBodyPart> amenity_type,
			@FormDataParam("amenity_wt") String amenity_wts,
			@FormDataParam("offer_id[]") List<FormDataBodyPart> offer_id,
			@FormDataParam("offer_title[]") List<FormDataBodyPart> offer_title,
			@FormDataParam("discount[]") List<FormDataBodyPart> discount,
			@FormDataParam("discount_amount[]") List<FormDataBodyPart> discount_amount,
			@FormDataParam("description[]") List<FormDataBodyPart> description,
			@FormDataParam("offer_type[]") List<FormDataBodyPart> offer_type,
			@FormDataParam("offer_status[]") List<FormDataBodyPart> offer_status
	) {
		String [] amenityWeightages = amenity_wts.split(",");
		List<BuildingAmenityWeightage> baws = new ArrayList<BuildingAmenityWeightage>();
		SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
		Date launchDate = null,possessionDate = null;
		try {
			launchDate = format.parse(launch_date);
			possessionDate = format.parse(possession_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		byte bstatus = 1;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
		BuilderBuildingStatus builderBuildingStatus = new BuilderBuildingStatus();
		builderBuildingStatus.setId(status);
		BuilderBuilding builderBuilding = new ProjectDAO().getBuilderProjectBuildingById(building_id).get(0);
		msg = builderDetailsDAO.updateBuilding(building_id,launchDate,possessionDate,status);
		if(msg.getId() > 0) {
			if (amenity_type.size() > 0) {
				List<BuildingAmenityInfo> buildingAmenityInfos = new ArrayList<BuildingAmenityInfo>();
				int i = 0;
				for(FormDataBodyPart amenity : amenity_type)
				{
					if(amenity.getValueAs(Integer.class) != null && amenity.getValueAs(Integer.class) != 0) {
						Byte milestone_status = 0;
						BuildingAmenityInfo amenityInfo = new BuildingAmenityInfo();
						BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
						builderBuildingAmenity.setId(amenity.getValueAs(Integer.class));
						amenityInfo.setBuilderBuildingAmenity(builderBuildingAmenity);
						amenityInfo.setBuilderBuilding(builderBuilding);
						buildingAmenityInfos.add(amenityInfo);
					}
					i++;
				}
				if(buildingAmenityInfos.size() > 0) {
					projectDAO.deleteBuildingAmenityInfo(building_id);
					projectDAO.addBuildingAmenityInfo(buildingAmenityInfos);
				}
				msg = new ResponseMessage();
				msg.setStatus(1);
				msg.setMessage("Builing Details updated successfully.");
			}
		}
		if(offer_title != null){
			if (offer_title.size() > 0) {
				List<BuildingOfferInfo> newBuildingOfferInfos = new ArrayList<BuildingOfferInfo>();
				List<BuildingOfferInfo> buildingOfferInfos = new ArrayList<BuildingOfferInfo>();
				int i = 0;
				for(FormDataBodyPart title : offer_title)
				{
					if(title.getValueAs(String.class).toString() != null && !title.getValueAs(String.class).toString().isEmpty()) {
						if(offer_id.get(i).getValueAs(Integer.class) != 0 && offer_id.get(i).getValueAs(Integer.class) != null) {
							BuildingOfferInfo buildingOfferInfo = new BuildingOfferInfo();
							buildingOfferInfo.setId(offer_id.get(i).getValueAs(Integer.class));
							buildingOfferInfo.setTitle(title.getValueAs(String.class).toString());
							buildingOfferInfo.setAmount(discount_amount.get(i).getValueAs(Double.class));
							buildingOfferInfo.setDiscount(discount.get(i).getValueAs(Double.class));
							buildingOfferInfo.setDescription(description.get(i).getValueAs(String.class).toString());
							buildingOfferInfo.setType(offer_type.get(i).getValueAs(Integer.class));
							buildingOfferInfo.setStatus(offer_status.get(i).getValueAs(Byte.class));
							buildingOfferInfo.setBuilderBuilding(builderBuilding);
							buildingOfferInfos.add(buildingOfferInfo);
						} else {
							BuildingOfferInfo buildingOfferInfo = new BuildingOfferInfo();
							buildingOfferInfo.setTitle(title.getValueAs(String.class).toString());
							buildingOfferInfo.setAmount(discount_amount.get(i).getValueAs(Double.class));
							buildingOfferInfo.setDiscount(discount.get(i).getValueAs(Double.class));
							buildingOfferInfo.setDescription(description.get(i).getValueAs(String.class).toString());
							buildingOfferInfo.setType(offer_type.get(i).getValueAs(Integer.class));
							buildingOfferInfo.setStatus(offer_status.get(i).getValueAs(Byte.class));
							buildingOfferInfo.setBuilderBuilding(builderBuilding);
							newBuildingOfferInfos.add(buildingOfferInfo);
						}
					}
					i++;
				}
				if(buildingOfferInfos.size() > 0) {
					projectDAO.updateBuildingOfferInfo(buildingOfferInfos);
				}
				if(newBuildingOfferInfos.size() > 0) {
					projectDAO.addBuildingOfferInfo(newBuildingOfferInfos);
				}
				msg.setStatus(1);
				msg.setMessage("Builing Details updated successfully.");
			} else {
				msg.setMessage("Failed to update building Details.");
				msg.setStatus(0);
			}
		}
		return msg;
	}
	
	@POST
	@Path("/building/floor/flat/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuildingFloorFlat (
			@FormDataParam("flat_id") int flat_id,
			@FormDataParam("floor_id") int floor_id,
			@FormDataParam("flat_type_id") int flat_type_id,
			@FormDataParam("flat_no") String flat_no, 
			@FormDataParam("bedroom") Integer bedroom,
			@FormDataParam("bathroom") Integer bathroom,
			@FormDataParam("balcony") Integer balcony,
			@FormDataParam("status") Integer status,
			@FormDataParam("possession_date") String possession_date
//			@FormDataParam("amenity_type[]") List<FormDataBodyPart> amenity_type,
//			@FormDataParam("payment_id[]") List<FormDataBodyPart> payment_id,
//			@FormDataParam("schedule[]") List<FormDataBodyPart> schedule,
//			@FormDataParam("payable[]") List<FormDataBodyPart> payable,
//			@FormDataParam("amount[]") List<FormDataBodyPart> amount,
//			@FormDataParam("admin_id") int admin_id,
//			@FormDataParam("amenity_wt") String amenity_wts
	) {
		//String [] amenityWeightages = amenity_wts.split(",");
		List<FlatAmenityWeightage> baws = new ArrayList<FlatAmenityWeightage>();
		SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
		Date possessionDate = null;
		try {
			possessionDate = format.parse(possession_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		byte floor_status = 1;
		ResponseMessage msg = new ResponseMessage();
		ProjectDAO projectDAO = new ProjectDAO();
		BuilderFloor builderFloor = new BuilderFloor();
		builderFloor.setId(floor_id);
//		AdminUser adminUser = new AdminUser();
//		adminUser.setId(admin_id);
		BuilderFlatStatus builderFlatStatus = new BuilderFlatStatus();
		builderFlatStatus.setId(status);
		BuilderFlatType builderFlatType = new BuilderFlatType();
		builderFlatType.setId(flat_type_id);
		BuilderFlat builderFlat = projectDAO.getBuildingFlatById(flat_id).get(0);
		builderFlat.setBuilderFloor(builderFloor);
		builderFlat.setBuilderFlatStatus(builderFlatStatus);
		builderFlat.setBuilderFlatType(builderFlatType);
		builderFlat.setFlatNo(flat_no);
		builderFlat.setBedroom(bedroom);
		builderFlat.setBathroom(bathroom);
		builderFlat.setBalcony(balcony);
		builderFlat.setPossessionDate(possessionDate);
	//	builderFlat.setAdminUser(adminUser);
		msg = projectDAO.updateBuildingFlat(builderFlat);
		if(msg.getId() > 0) {
			//add gallery images
//			if (amenity_type.size() > 0) {
//				List<FlatAmenityInfo> flatAmenityInfos = new ArrayList<FlatAmenityInfo>();
//				int i = 0;
//				for(FormDataBodyPart amenity : amenity_type)
//				{
//					if(amenity.getValueAs(Integer.class) != null && amenity.getValueAs(Integer.class) != 0) {
//						Byte milestone_status = 0;
//						BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
//						builderFlatAmenity.setId(amenity.getValueAs(Integer.class));
//						FlatAmenityInfo amenityInfo = new FlatAmenityInfo();
//						amenityInfo.setBuilderFlatAmenity(builderFlatAmenity);
//						amenityInfo.setBuilderFlat(builderFlat);
//						flatAmenityInfos.add(amenityInfo);
//					}
//					i++;
//				}
//				if(flatAmenityInfos.size() > 0) {
//					projectDAO.deleteFlatAmenityInfo(flat_id);
//					projectDAO.addFlatAmenityInfo(flatAmenityInfos);
//				}
//			}
//			if(amenity_wts != "") {
//				for(String aw :amenityWeightages) {
//					FlatAmenityWeightage baw = new FlatAmenityWeightage();
//					String [] amenityWeightage = aw.split("#");
//					Integer amenity_id = Integer.parseInt(amenityWeightage[0]);
//					Double amenity_weightage = Double.parseDouble(amenityWeightage[1]);
//					Integer stage_id = Integer.parseInt(amenityWeightage[2]);
//					Double stage_weightage = Double.parseDouble(amenityWeightage[3]);
//					Integer substage_id = Integer.parseInt(amenityWeightage[4]);
//					Double substage_weightage = Double.parseDouble(amenityWeightage[5]);
//					Boolean wstatus = Boolean.parseBoolean(amenityWeightage[6]);
//					BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
//					builderFlatAmenity.setId(amenity_id);
//					BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
//					builderFlatAmenityStages.setId(stage_id);
//					BuilderFlatAmenitySubstages builderFlatAmenitySubstages = new BuilderFlatAmenitySubstages();
//					builderFlatAmenitySubstages.setId(substage_id);
//					baw.setBuilderFlatAmenity(builderFlatAmenity);
//					baw.setAmenityWeightage(amenity_weightage);
//					baw.setBuilderFlatAmenityStages(builderFlatAmenityStages);
//					baw.setStageWeightage(stage_weightage);
//					baw.setBuilderFlatAmenitySubstages(builderFlatAmenitySubstages);
//					baw.setSubstageWeightage(substage_weightage);
//					baw.setStatus(wstatus);
//					baw.setBuilderFlat(builderFlat);
//					baws.add(baw);
//				}
//				projectDAO.deleteFlatAmenityWeightage(flat_id);
//				projectDAO.addFlatAmenityWeightage(baws);
//			}
//			try{
//				if (schedule.size() > 0) {
//					List<FlatPaymentSchedule> flatPaymentSchedules = new ArrayList<FlatPaymentSchedule>();
//					List<FlatPaymentSchedule> newFlatPaymentSchedules = new ArrayList<FlatPaymentSchedule>();
//					int i = 0;
//					for(FormDataBodyPart milestone : schedule)
//					{
//						if(milestone.getValueAs(String.class).toString() != null && !milestone.getValueAs(String.class).toString().isEmpty()) {
//							if(payment_id.get(i).getValueAs(Integer.class) != 0 && payment_id.get(i).getValueAs(Integer.class) != null) {
//								Byte milestone_status = 0;
//								FlatPaymentSchedule flatPaymentSchedule = new FlatPaymentSchedule();
//								flatPaymentSchedule.setId(payment_id.get(i).getValueAs(Integer.class));
//								flatPaymentSchedule.setMilestone(milestone.getValueAs(String.class).toString());
//								flatPaymentSchedule.setPayable(payable.get(i).getValueAs(Double.class));
//								flatPaymentSchedule.setAmount(amount.get(i).getValueAs(Double.class));
//								flatPaymentSchedule.setStatus(milestone_status);
//								flatPaymentSchedule.setBuilderFlat(builderFlat);
//								flatPaymentSchedules.add(flatPaymentSchedule);
//							} else {
//								Byte milestone_status = 0;
//								FlatPaymentSchedule flatPaymentSchedule = new FlatPaymentSchedule();
//								flatPaymentSchedule.setMilestone(milestone.getValueAs(String.class).toString());
//								flatPaymentSchedule.setPayable(payable.get(i).getValueAs(Double.class));
//								flatPaymentSchedule.setAmount(amount.get(i).getValueAs(Double.class));
//								flatPaymentSchedule.setStatus(milestone_status);
//								flatPaymentSchedule.setBuilderFlat(builderFlat);
//								newFlatPaymentSchedules.add(flatPaymentSchedule);
//							}
//						}
//						i++;
//					}
//					if(flatPaymentSchedules.size() > 0) {
//						projectDAO.updateFlatPaymentInfo(flatPaymentSchedules);
//						projectDAO.addFlatPaymentInfo(newFlatPaymentSchedules);
//					}
//				}
//			} catch(Exception e) {
//				
//			}
		} else {
			msg.setMessage("Failed to update flat.");
			msg.setStatus(0);
		}
		return msg;
	}
	@GET
	@Path("/building/flat/names/{building_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderFlat> getProjectBuildingFlatNames(@PathParam("building_id") int building_id) {
		ProjectDAO projectDAO = new ProjectDAO();
		List<BuilderFlat> flats = projectDAO.getBuildingActiveFlatByBuildingId(building_id);
		List<BuilderFlat> newflats = new ArrayList<BuilderFlat>();
		for(BuilderFlat builderFlat :flats) {
			BuilderFlat flat = new BuilderFlat();
			flat.setId(builderFlat.getId());
			flat.setFlatNo(builderFlat.getFlatNo());
			newflats.add(flat);
		}
		return newflats;
	}
	
	
	@GET
	@Path("/building/names/{project_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderBuilding> getProjectBuildingNames(@PathParam("project_id") int project_id) {
		ProjectDAO projectDAO = new ProjectDAO();
		List<BuilderBuilding> buildings = projectDAO.getBuilderActiveProjectBuildings(project_id);
		List<BuilderBuilding> newbuildings = new ArrayList<BuilderBuilding>();
		for(BuilderBuilding builderBuilding :buildings) {
			BuilderBuilding building = new BuilderBuilding();
			building.setId(builderBuilding.getId());
			building.setName(builderBuilding.getName());
			newbuildings.add(building);
		}
		return newbuildings;
	}
	
	@POST
	@Path("/building/floor/filternames/")
	@Produces(MediaType.APPLICATION_JSON)
	public List<FlatListData> getFloorNamebyBuidingId(
			@FormParam("project_id") int projectId,
			@FormParam("building_id") int buildingId,
			@FormParam("floor_id") int floorId,
			@FormParam("evenOrodd") int evenorodd){
		List<FlatListData>  flatList =  new ProjectDAO().getFlatDetails(projectId, buildingId, floorId, evenorodd);
		return flatList;
	}
	
	@POST
	@Path("/building/floor/flatfilter/")
	@Produces(MediaType.APPLICATION_JSON)
	public BookingFlatList getFlatdata(
			@FormParam("emp_id") int empId,
			@FormParam("project_id") int projectId,
			@FormParam("building_id") int buildingId,
			@FormParam("floor_id") int floorId,
			@FormParam("evenOrodd") int evenorodd){
		BookingFlatList flatList =  new BuilderDetailsDAO().getFlatFliterByIds(empId, projectId, buildingId, floorId, evenorodd);
		return flatList;
	}
	
	@POST
	@Path("/filter/bargraph")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BarGraphData> getBarGraphDataByProjectId(@FormParam("project_id") int projectId){
		
		return new BuilderDetailsDAO().getBarGraphByProjectId(projectId);
	}
	
	@POST
	@Path("/filter/bargraph/source")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectWiseData> getBarGraphDataBySource(@FormParam("emp_id") int empId){
		
		return new BuilderDetailsDAO().getEmployeeBarGraphBySource(empId);
	}
	
	@POST
	@Path("/filter/bargraph/project")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectWiseData> getBarGraphDataByProject(@FormParam("emp_id") int empId){
		
		return new BuilderDetailsDAO().getEmployeeBarGraphByProject(empId);
	}
	
	@POST
	@Path("/filter/bargraph/month")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectWiseData> getBarGraphDataByMonth(@FormParam("emp_id") int empId){
		
		return new BuilderDetailsDAO().getEmployeeBarGraphByMonth(empId);
	}
	
	@POST
	@Path("/filter/bargraph/saleman")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectWiseData> getBarGraphDataBySalesman(@FormParam("emp_id") int empId){
		
		return new BuilderDetailsDAO().getEmployeeBarGraphBySalesman(empId);
	}
	
	@POST
	@Path("/filter/booked/buyers")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BookedBuyerList> getBookedBuyerList(
			@FormParam("emp_id") int empId,
			@FormParam("project_id") int projectId,
			@FormParam("keyword") String keyword
		){
		
		return new BuilderDetailsDAO().getBookedBuyerList(empId,projectId,keyword);
	}
	/**
	 * save message
	 * @author pankaj
	 * @param filter_buyer_id
	 * @param subject
	 * @param empId
	 * @param message
	 * @param attachment
	 * @return ResponseMessage
	 */
	@POST
	@Path("/inbox/new")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage saveNewInbox(
			@FormDataParam("filter_buyer_id[]") List<FormDataBodyPart> filter_buyer_id,
			@FormDataParam("subject") String subject,
			@FormDataParam("emp_id") int empId,
			
			@FormDataParam("message") String message, 
			@FormDataParam("attachment[]") List<FormDataBodyPart> attachment
			
	) {
		ResponseMessage msg = new ResponseMessage();
		 List<InboxMessage> inboxMessageList = new ArrayList<InboxMessage>();
		
		if(filter_buyer_id.size() > 0){
			
		     for(FormDataBodyPart buyers : filter_buyer_id){
		    	 if(buyers.getValueAs(Integer.class) != null && buyers.getValueAs(Integer.class) != 0){
		    		 Date now = new Date();
		    		 Buyer buyer = new ProjectDAO().getBuyerById(buyers.getValueAs(Integer.class));
		    		 InboxMessage inboxMessage = new InboxMessage();
		    		 inboxMessage.setSubject(subject);
		 			 inboxMessage.setEmpId(empId);
		 			 inboxMessage.setMessage(message);
		    		 inboxMessage.setBuyer(buyer);
		    		 inboxMessage.setBuilderProject(buyer.getBuilderProject());
		    		 inboxMessage.setImDate(now);
		    		 try {
		 				//for inserting attachment.
		 				if (attachment.size() > 0) {
		 					for(int i=0 ;i < attachment.size();i++)
		 					{
		 						if(attachment.get(i).getFormDataContentDisposition().getFileName() != null && !attachment.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
		 							String gallery_name = attachment.get(i).getFormDataContentDisposition().getFileName();
		 							long millis = System.currentTimeMillis() % 1000;
		 							gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
		 							gallery_name = "images/project/images/"+gallery_name;
		 							String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
		 							//System.out.println("for loop image path: "+uploadGalleryLocation);
		 							this.imageUploader.writeToFile(attachment.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
		 							inboxMessage.setAttachment(gallery_name);
		 						}
		 					}
		 				}
		 			} catch(NullPointerException e){
		 				inboxMessage.setAttachment("");
		 			}
		 			catch(Exception e) {
		 				msg.setStatus(0);
		 				msg.setMessage("Unable to save message");
		 				return msg;
		 			}
		    		 inboxMessageList.add(inboxMessage);
		    	 }
		     }
		     if(inboxMessageList.size() > 0){
		    	 msg = new BuilderDetailsDAO().saveInboxMessages(inboxMessageList);
		     }
		} else {
			msg.setMessage("Failed to save message.");
			msg.setStatus(0);
		}
		return msg;
	}
	
	@POST
	@Path("/filter/inbox")
	@Produces(MediaType.APPLICATION_JSON)
	public List<InboxMessageData> getBookedBuyerList(
			@FormParam("emp_id") int empId,
			@FormParam("nameOrNumber") String nameOrNumber
		){
		System.err.println("Emp ID :: "+empId);
		int contactNumber = 0;
		String name = "";
		try{
			contactNumber = Integer.parseInt(nameOrNumber);
			System.err.println("contact Number :: "+contactNumber);
		}catch(NumberFormatException e){
			name = nameOrNumber;
			contactNumber = 0;
			System.err.println("Name :: "+name);
		}catch(NullPointerException e){
			
		}
		catch(Exception e){
			
		}
		return new BuilderDetailsDAO().getnameOrNumberList(empId,nameOrNumber);
	}
	
	@POST
	@Path("/changeleadAuthority/")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateLeadStatus(
			@FormParam("id") int leadId,
			@FormParam("value") int value
			){
		ResponseMessage responseMessage =  new BuilderDetailsDAO().updateLeadStatus(value, leadId);
		return responseMessage;
	}
	
	@POST
	@Path("/filter/newlead")
	@Produces(MediaType.APPLICATION_JSON)
	public List<NewLeadList> getLeadList(
			@FormParam("emp_id") int empId,
			@FormParam("project_id") int projectId,
			@FormParam("name") String nameOrNumber
		){
		int contactNumber = 0;
		String name = "";
		try{
			contactNumber = Integer.parseInt(nameOrNumber);
			System.err.println("contact Number :: "+contactNumber);
		}catch(NumberFormatException e){
			name = nameOrNumber;
			contactNumber = 0;
			System.err.println("Name :: "+name);
		}catch(NullPointerException e){
			
		}
		catch(Exception e){
			
		}
		return new ProjectDAO().getNewLeadListFilter(empId,projectId,name,contactNumber);
	}
	
	@POST
	@Path("/filter/newleadlist")
	@Produces(MediaType.APPLICATION_JSON)
	public List<NewLeadList> getLeadListsts(
			@FormParam("emp_id") int empId,
			@FormParam("project_id") int projectId,
			@FormParam("nameOrNumber") String keyword
		){
	
		return new ProjectDAO().getNewLeadLists(empId,projectId,keyword);
	}
	
	@POST
	@Path("/inbox/reply")
	@Produces(MediaType.APPLICATION_JSON)
	public InboxMessageData getInboxMessage(
			@FormParam("id") int id
		){
		return new BuilderDetailsDAO().getInboxMessageData(id);
	}
	
	@POST
	@Path("/inbox/new/reply")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage saveReplyMessage(
			@FormDataParam("subject") String subject,
			@FormDataParam("emp_id") int empId,
			@FormDataParam("inbox_id") int inboxId,
			@FormDataParam("message") String message, 
			@FormDataParam("attachment[]") List<FormDataBodyPart> attachment
			
	) {
		ResponseMessage msg = new ResponseMessage();
//		 List<InboxMessage> inboxMessageList = new ArrayList<InboxMessage>();
		Byte isReply = 1;
		InboxMessageReply inboxMessage =  new InboxMessageReply();
		BuilderEmployee builderEmployee = new BuilderEmployee();
		InboxMessage inboxMessage2 = new InboxMessage();
		inboxMessage2.setId(inboxId);
		builderEmployee.setId(empId);
		inboxMessage.setBuilderEmployee(builderEmployee);
		inboxMessage.setInboxMessage(inboxMessage2);
		inboxMessage.setSubject(subject);
		inboxMessage.setIsReply(isReply);
		inboxMessage.setMessage(message);
		    		 try {
		 				//for inserting attachment.
		    			 if(attachment != null){
			 				if (attachment.size() > 0) {
			 					for(int i=0 ;i < attachment.size();i++)
			 					{
			 						if(attachment.get(i).getFormDataContentDisposition().getFileName() != null && !attachment.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
			 							String gallery_name = attachment.get(i).getFormDataContentDisposition().getFileName();
			 							long millis = System.currentTimeMillis() % 1000;
			 							gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
			 							gallery_name = "images/project/images/"+gallery_name;
			 							String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
			 							//System.out.println("for loop image path: "+uploadGalleryLocation);
			 							this.imageUploader.writeToFile(attachment.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
			 							inboxMessage.setAttachment(gallery_name);
			 						}
			 					}
			 				}
			 			
		    			 }else{
		    				 inboxMessage.setAttachment("");
		    			 }
		    				msg = new BuilderDetailsDAO().saveInboxReply(inboxMessage);
		    		 } catch(NullPointerException e){
		 				inboxMessage.setAttachment("");
		 			}
		 			catch(Exception e) {
		 				e.printStackTrace();
		 				msg.setStatus(0);
		 				msg.setMessage("Unable to save message");
		 				return msg;
		 			}
		return msg;
	}
	
	@POST
	@Path("/filter/bargraph/building")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectWiseData> getBarGraphDataByBuilding(@FormParam("project_id") int projectId){
		
		return new BuilderDetailsDAO().getEmployeeBarGraphByBuilding(projectId);
	}
	
	@GET
	@Path("/flat/markhold/{flat_ids}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage putFlatOnHold(@PathParam("flat_ids") String flatIds) {
		System.err.println("FlatIds :: "+flatIds);
		return new ProjectDAO().putFlatsOnHold(flatIds);
	}
	
	@GET
	@Path("/flat/markunhold/{flat_ids}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage putFlatOnUnHold(@PathParam("flat_ids") String flatIds) {
		return new ProjectDAO().putFlatsOnUnHold(flatIds);
	}
	
	@POST
	@Path("/filter/bargraph/ceo/source")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectWiseData> getBarGraphDataBySourceCEO(@FormParam("project_id") int projectId){
		
		return new BuilderDetailsDAO().getEmployeeBarGraphBySourceCEO(projectId);
	}
	
	@POST
	@Path("/filter/bargraph/ceo/month")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectWiseData> getBarGraphDataByMonthCEO(@FormParam("project_id") int projectId){
		
		return new BuilderDetailsDAO().getEmployeeBarGraphByMonthCEO(projectId);
	}
	
	@POST
	@Path("/filter/bargraph/ceo/saleman")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectWiseData> getBarGraphDataBySalesmanCEO(@FormParam("project_id") int projectId){
		
		return new BuilderDetailsDAO().getEmployeeBarGraphBySalesmanCEO(projectId);
	}
	
	@GET
	@Path("/building/data")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuildingData> getBuildingData(
			@Context UriInfo uriInfo
			) {
		BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
		List<String> projectIds = uriInfo.getQueryParameters().get("project_ids[]");
		System.err.println("Received List :: "+projectIds);
		List<BuildingData> buildingList = builderDetailsDAO.getBuildingData(projectIds);
		return buildingList;
	}
	
//	@GET
//	@Path("/flatbuyer/data")
//	@Produces(MediaType.APPLICATION_JSON)
//	public List<BuyerList> getFlatBuyerData(
//			@Context UriInfo uriInfo
//			) {
//		BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
//		List<String> projectIds = uriInfo.getQueryParameters().get("building_ids[]");
//		System.err.println("Received List :: "+projectIds);
//		List<BuyerList> buildingList = builderDetailsDAO.getFlatBuyerList(projectIds);
//		return buildingList;
//	}
	
	@POST
	@Path("/save/newdoc")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addNewBuyerInfoNew (
			@FormDataParam("flat_buyer_ids[]") List<FormDataBodyPart> buyerIds,
	@FormDataParam("doc_name[]") List<FormDataBodyPart> doc_name,
	@FormDataParam("doc_url[]") List<FormDataBodyPart> doc_url
	){
		ResponseMessage responseMessage = new ResponseMessage();
		try {
			if(buyerIds != null && buyerIds.size() >0){
				int b=0;
				int d=0;
				List<Buyer> buyers = new ArrayList<Buyer>();
				List<BuyerUploadDocuments> savebuyerDoc = new ArrayList<BuyerUploadDocuments>();
				for(FormDataBodyPart buyernames : buyerIds){
					Buyer buyer = new Buyer();
					BuyerUploadDocuments buDocuments = new BuyerUploadDocuments();
					if(buyernames.getValueAs(Integer.class) != 0 && buyernames.getValueAs(Integer.class) != null){
						buyer.setId(buyernames.getValueAs(Integer.class));
					}
					if(doc_url.get(d).getFormDataContentDisposition().getFileName() != null && !doc_url.get(d).getFormDataContentDisposition().getFileName().isEmpty()) {
						String gallery_name = doc_url.get(d).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/buyer/docs/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						this.imageUploader.writeToFile(doc_url.get(d).getValueAs(InputStream.class), uploadGalleryLocation);
						buDocuments.setDocUrl(gallery_name);
						buDocuments.setBuyer(buyer);
						buDocuments.setName(doc_name.get(d).getValueAs(String.class).toString());
						buDocuments.setBuilderdoc(true);
						buDocuments.setUploadedDate(new Date());
					}
					savebuyerDoc.add(buDocuments);
					b++;
				}
				if(savebuyerDoc.size()>0){
					responseMessage = new BuyerDAO().saveBuyerUploadDouments(savebuyerDoc);
				}
			}
			return responseMessage;
		}catch(Exception e) {
			return null;
		}
	}
	
	@POST
	@Path("/allot/projects")
	@Produces(MediaType.APPLICATION_JSON)
//	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseMessage saveAllotedProjets(	@FormParam("project_ids") String projectId, @FormParam("emp_id") int empId){
		ResponseMessage responseMessage = new ResponseMessage();
		String strProject [] = projectId.split(",");
		System.err.println(projectId);
		BuilderEmployee builderEmployee = new BuilderEmployee();
		builderEmployee.setId(empId);
		List<AllotProject> allotProjectList = new ArrayList<>();
		if(strProject != null){
			for(int i=0;i<strProject.length;i++){
				int project_id = Integer.parseInt(strProject[i]);
				AllotProject allotProject = new AllotProject();
				allotProject.setBuilderEmployee(builderEmployee);
				BuilderProject builderProject = new BuilderProject();
				builderProject.setId(project_id);
				allotProject.setBuilderProject(builderProject);
				allotProjectList.add(allotProject);
			}
			
			if(allotProjectList.size() > 0){
				responseMessage =  new BuilderDetailsDAO().saveAllotedProjects(allotProjectList);
			}
		}else{
			responseMessage.setStatus(0);
			responseMessage.setMessage("Fail to allot project");
		}
		return responseMessage;
	}
	
	@GET
	@Path("/building/data/{project_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuildingData> getBuildingData(
			@PathParam("project_id") String projectIds
			) {
		BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
		System.err.println("Received List :: "+projectIds);
		List<BuildingData> buildingList = builderDetailsDAO.getBuildingData(projectIds);
		return buildingList;
	}
	
	@GET
	@Path("/flatbuyer/data/{building_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuyerList> getFlatBuyerData(
			@PathParam("building_id") String buildingIds
			) {
		BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
		System.err.println("Received List :: "+buildingIds);
		List<BuyerList> buildingList = builderDetailsDAO.getFlatBuyerList(buildingIds);
		return buildingList;
	}
	
	@POST
	@Path("/filter/bargraph/campaign")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectWiseData> getCampaignBarGraphData(@FormParam("emp_id") int empId){
		
		return new BuilderDetailsDAO().getCampaignWiseData(empId);
	}
	
	@GET
	@Path("/projectdata/{city_ids}/{emp_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectData> getProjectData(
			@PathParam("city_ids") String cityIds,
			@PathParam("emp_id") int empId
			) {
		BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
		List<ProjectData> projectDatas = builderDetailsDAO.getProjectList(cityIds,empId);
		return projectDatas;
	}
	
	@GET
	@Path("/buyerorbuilding/data/{project_ids}/{user_type}/{emp_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectData> getBuyerData(
			@PathParam("project_ids") String projectIds,
			@PathParam("user_type") String userType,
			@PathParam("emp_id") int empId
			) {
		BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
		List<ProjectData> projectDatas = builderDetailsDAO.getBuyerOrBuilding(projectIds,userType,empId);
		return projectDatas;
	}
	
	@GET
	@Path("/buyer/data/{building_ids}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectData> getBuyerData(
			@PathParam("building_ids") String buildingIds
			) {
		BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
		List<ProjectData> projectDatas = builderDetailsDAO.getBuyerLists(buildingIds);
		return projectDatas;
	}
}