package org.bluepigeon.admin.controller;

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


import org.bluepigeon.admin.dao.BuilderDetailsDAO;
import org.bluepigeon.admin.dao.CityNamesImp;
import org.bluepigeon.admin.dao.LocalityNamesImp;
import org.bluepigeon.admin.dao.ProjectDAO;
import org.bluepigeon.admin.dao.StateImp;
import org.bluepigeon.admin.data.BarGraphData;
import org.bluepigeon.admin.data.BookingFlatList;
import org.bluepigeon.admin.data.BuilderProjectList;
import org.bluepigeon.admin.data.BuildingList;
import org.bluepigeon.admin.data.FlatData;
import org.bluepigeon.admin.data.FlatListData;
//import org.bluepigeon.admin.data.FlatListData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.data.BookedBuyerList;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderBuildingAmenity;
import org.bluepigeon.admin.model.BuilderBuildingAmenityStages;
import org.bluepigeon.admin.model.BuilderBuildingAmenitySubstages;
import org.bluepigeon.admin.model.BuilderBuildingStatus;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFlatAmenity;
import org.bluepigeon.admin.model.BuilderFlatAmenityStages;
import org.bluepigeon.admin.model.BuilderFlatAmenitySubstages;
import org.bluepigeon.admin.model.BuilderFlatStatus;
import org.bluepigeon.admin.model.BuilderFlatType;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuildingAmenityInfo;
import org.bluepigeon.admin.model.BuildingAmenityWeightage;
import org.bluepigeon.admin.model.BuildingOfferInfo;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.FlatAmenityInfo;
import org.bluepigeon.admin.model.FlatAmenityWeightage;
import org.bluepigeon.admin.model.FlatPaymentSchedule;
import org.bluepigeon.admin.model.Locality;
import org.bluepigeon.admin.model.State;
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
//			if(amenity_wts != "") {
//				for(String aw :amenityWeightages) {
//					BuildingAmenityWeightage baw = new BuildingAmenityWeightage();
//					String [] amenityWeightage = aw.split("#");
//					for(int i=0;i<amenityWeightage.length;i++){
//						System.out.println("AmenityWeightage "+amenityWeightage[i]);
//					}
//					Integer amenity_id = Integer.parseInt(amenityWeightage[0]);
//					Double amenity_weightage = Double.parseDouble(amenityWeightage[1]);
//					Integer stage_id = Integer.parseInt(amenityWeightage[2]);
//					Double stage_weightage = Double.parseDouble(amenityWeightage[3]);
//					Integer substage_id = Integer.parseInt(amenityWeightage[4]);
//					Double substage_weightage = Double.parseDouble(amenityWeightage[5]);
//					Boolean wstatus = Boolean.parseBoolean(amenityWeightage[6]);
//					BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
//					builderBuildingAmenity.setId(amenity_id);
//					BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();
//					builderBuildingAmenityStages.setId(stage_id);
//					BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages = new BuilderBuildingAmenitySubstages();
//					builderBuildingAmenitySubstages.setId(substage_id);
//					baw.setBuilderBuildingAmenity(builderBuildingAmenity);
//					baw.setAmenityWeightage(amenity_weightage);
//					baw.setBuilderBuildingAmenityStages(builderBuildingAmenityStages);
//					baw.setStageWeightage(stage_weightage);
//					baw.setBuilderBuildingAmenitySubstages(builderBuildingAmenitySubstages);
//					baw.setSubstageWeightage(substage_weightage);
//					baw.setStatus(wstatus);
//					baw.setBuilderBuilding(builderBuilding);
//					baws.add(baw);
//				}
//				projectDAO.deleteBuildingAmenityWeightage(building_id);
//				projectDAO.addBuildingAmenityWeightage(baws);
//			}
			
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
	@Path("/filter/booked/buyers")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BookedBuyerList> getBookedBuyerList(
			@FormParam("emp_id") int empId,
			@FormParam("project_id") int projectId,
			@FormParam("nameOrNumber") String nameOrNumber
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
		return new BuilderDetailsDAO().getBookedBuyerList(empId,projectId,name,contactNumber);
	}
}
