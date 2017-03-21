package org.bluepigeon.admin.controller;

import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.BuilderBuildingAmenityDAO;
import org.bluepigeon.admin.dao.BuilderBuildingAmenityStagesDAO;
import org.bluepigeon.admin.dao.BuilderBuildingAmenitySubstagesDAO;
import org.bluepigeon.admin.dao.BuilderBuildingStatusDAO;
import org.bluepigeon.admin.dao.BuilderCompanyDAO;
import org.bluepigeon.admin.dao.BuilderDetailsDAO;
import org.bluepigeon.admin.dao.BuilderFlatAmenityDAO;
import org.bluepigeon.admin.dao.BuilderFlatAmenityStagesDAO;
import org.bluepigeon.admin.dao.BuilderFlatAmenitySubstagesDAO;
import org.bluepigeon.admin.dao.BuilderFlatStatusDAO;
import org.bluepigeon.admin.dao.BuilderFloorAmenityDAO;
import org.bluepigeon.admin.dao.BuilderFloorAmenityStagesDAO;
import org.bluepigeon.admin.dao.BuilderFloorAmenitySubstagesDAO;
import org.bluepigeon.admin.dao.BuilderGroupDAO;
import org.bluepigeon.admin.dao.BuilderOverallProjectStagesAndSubStagesDAO;
import org.bluepigeon.admin.dao.BuilderPaymentStagesDAO;
import org.bluepigeon.admin.dao.BuilderPaymentSubstagesDAO;
import org.bluepigeon.admin.dao.BuilderProjectAmenityDAO;
import org.bluepigeon.admin.dao.BuilderProjectAmenityStagesDAO;
import org.bluepigeon.admin.dao.BuilderProjectAmenitySubstagesDAO;
import org.bluepigeon.admin.dao.BuilderProjectApprovalTypeDAO;
import org.bluepigeon.admin.dao.BuilderProjectLevelDAO;
import org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationDAO;
import org.bluepigeon.admin.dao.BuilderProjectStatusDAO;
import org.bluepigeon.admin.dao.BuilderProjectTypeDAO;
import org.bluepigeon.admin.dao.BuilderPropertyTypeDAO;
import org.bluepigeon.admin.dao.BuilderSellerTypeDAO;
import org.bluepigeon.admin.dao.BuilderTaxTypeDAO;
import org.bluepigeon.admin.data.BuilderDetails;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderBuildingAmenity;
import org.bluepigeon.admin.model.BuilderBuildingAmenityStages;
import org.bluepigeon.admin.model.BuilderBuildingAmenitySubstages;
import org.bluepigeon.admin.model.BuilderBuildingStatus;
import org.bluepigeon.admin.model.BuilderCompany;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderFlatAmenity;
import org.bluepigeon.admin.model.BuilderFlatAmenityStages;
import org.bluepigeon.admin.model.BuilderFlatAmenitySubstages;
import org.bluepigeon.admin.model.BuilderFlatStatus;
import org.bluepigeon.admin.model.BuilderFloorAmenity;
import org.bluepigeon.admin.model.BuilderFloorAmenityStages;
import org.bluepigeon.admin.model.BuilderFloorAmenitySubstages;
import org.bluepigeon.admin.model.BuilderGroup;
import org.bluepigeon.admin.model.BuilderOverallProjectStagesAndSubStages;
import org.bluepigeon.admin.model.BuilderPaymentStages;
import org.bluepigeon.admin.model.BuilderPaymentSubstages;
import org.bluepigeon.admin.model.BuilderProjectAmenity;
import org.bluepigeon.admin.model.BuilderProjectAmenityStages;
import org.bluepigeon.admin.model.BuilderProjectAmenitySubstages;
import org.bluepigeon.admin.model.BuilderProjectApprovalType;
import org.bluepigeon.admin.model.BuilderProjectLevel;
import org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration;
import org.bluepigeon.admin.model.BuilderProjectStatus;
import org.bluepigeon.admin.model.BuilderProjectType;
import org.bluepigeon.admin.model.BuilderPropertyType;
import org.bluepigeon.admin.model.BuilderSellerType;
import org.bluepigeon.admin.model.BuilderTaxType;

import com.fasterxml.jackson.databind.deser.BuilderBasedDeserializer;

@Path("create")
public class CreateProjectController {

	@POST
	@Path("/builder/new/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilder(BuilderDetails builderDetails) {
		
		 BuilderDetailsDAO builderDetalsDAO = new BuilderDetailsDAO();
		  return  builderDetalsDAO.save(builderDetails);
	
	}

	@POST
	@Path("/builder/new/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilder(BuilderDetails builderDetails) {
		 BuilderDetailsDAO builderDetalsDAO = new BuilderDetailsDAO();
		  return  builderDetalsDAO.update(builderDetails);
	}

	@DELETE
	@Path("/builder/new/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilder(@FormParam("amenityid") int amenityid) {
		byte isDeleted = 1;
		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
		builderBuildingAmenity.setId(amenityid);
		builderBuildingAmenity.setIsDeleted(isDeleted);
		System.out.println("Hi from Bulder amenity delete id :: " + amenityid);
		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
		return builderBuildingAmenityDAO.delete(builderBuildingAmenity);
	}

	@POST
	@Path("/builder/building/amenity/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderBuildingAmenity(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();

		builderBuildingAmenity.setName(name);
		builderBuildingAmenity.setStatus(status);
		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
		return builderBuildingAmenityDAO.save(builderBuildingAmenity);
	}

	@POST
	@Path("/builder/building/amenity/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderBuildingAmenity(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {

		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
		builderBuildingAmenity.setId(id);
		builderBuildingAmenity.setName(name);
		builderBuildingAmenity.setStatus(status);

		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
		return builderBuildingAmenityDAO.update(builderBuildingAmenity);
	}

	@DELETE
	@Path("/builder/building/amenity/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderBuildingAmenity(@FormParam("amenityid") int amenityid) {
		byte isDeleted = 1;
		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
		builderBuildingAmenity.setId(amenityid);
		builderBuildingAmenity.setIsDeleted(isDeleted);
		System.out.println("Hi from Bulder amenity delete id :: " + amenityid);
		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
		return builderBuildingAmenityDAO.delete(builderBuildingAmenity);
	}

	@GET
	@Path("/builder/building/amenity/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderBuildingAmenity> getBuilderBuildingAmenity(@QueryParam("amenity_id") int amenity_id) {
		BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
		return builderBuildingAmenityDAO.getBuilderBuildingAmenityById(amenity_id);
	}

	@POST
	@Path("/builder/building/amenity/stages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderBuildingAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
		builderBuildingAmenity.setId(amenityId);

		BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();

		builderBuildingAmenityStages.setName(name);
		builderBuildingAmenityStages.setStatus(status);
		builderBuildingAmenityStages.setBuilderBuildingAmenity(builderBuildingAmenity);
		BuilderBuildingAmenityStagesDAO builderBuildingAmenityStagesDAO = new BuilderBuildingAmenityStagesDAO();
		return builderBuildingAmenityStagesDAO.save(builderBuildingAmenityStages);
	}

	@POST
	@Path("/builder/building/amenity/stages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderBuildingAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderBuildingAmenity builderBuildingAmenity = new BuilderBuildingAmenity();
		builderBuildingAmenity.setId(amenityId);

		BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();
		builderBuildingAmenityStages.setId(id);
		builderBuildingAmenityStages.setName(name);
		builderBuildingAmenityStages.setStatus(status);
		builderBuildingAmenityStages.setBuilderBuildingAmenity(builderBuildingAmenity);
		BuilderBuildingAmenityStagesDAO builderBuildingAmenityStagesDAO = new BuilderBuildingAmenityStagesDAO();
		return builderBuildingAmenityStagesDAO.update(builderBuildingAmenityStages);
	}

	@DELETE
	@Path("/builder/building/amenity/stages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderBuildingAmenityStages(@FormParam("amenity_substage_id") int amenityid) {
		byte isDeleted = 1;
		BuilderBuildingAmenityStages builderBuildingAmenity = new BuilderBuildingAmenityStages();
		builderBuildingAmenity.setId(amenityid);
		builderBuildingAmenity.setIsDeleted(isDeleted);
		BuilderBuildingAmenityStagesDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityStagesDAO();
		return builderBuildingAmenityDAO.delete(builderBuildingAmenity);
	}

	@GET
	@Path("/builder/building/amenity/stages/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderBuildingAmenityStages> getBuilderBuildingAmenityStages(
			@QueryParam("amenity_id") int amenity_id) {
		BuilderBuildingAmenityStagesDAO builderBuildingAmenityStagesDAO = new BuilderBuildingAmenityStagesDAO();
		return builderBuildingAmenityStagesDAO.getStateByAmenityId(amenity_id);
	}

	@POST
	@Path("/builder/building/amenity/substages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderBuildingAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();
		builderBuildingAmenityStages.setId(stageId);

		BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages = new BuilderBuildingAmenitySubstages();

		builderBuildingAmenitySubstages.setName(name);
		builderBuildingAmenitySubstages.setStatus(status);
		builderBuildingAmenitySubstages.setBuilderBuildingAmenityStages(builderBuildingAmenityStages);
		BuilderBuildingAmenitySubstagesDAO builderBuildingAmenitySubstagesDAO = new BuilderBuildingAmenitySubstagesDAO();
		return builderBuildingAmenitySubstagesDAO.save(builderBuildingAmenitySubstages);
	}

	@POST
	@Path("/builder/building/amenity/substages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderBuildingAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderBuildingAmenityStages builderBuildingAmenityStages = new BuilderBuildingAmenityStages();
		builderBuildingAmenityStages.setId(stageId);

		BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages = new BuilderBuildingAmenitySubstages();
		builderBuildingAmenitySubstages.setId(id);
		builderBuildingAmenitySubstages.setName(name);
		builderBuildingAmenitySubstages.setStatus(status);
		builderBuildingAmenitySubstages.setBuilderBuildingAmenityStages(builderBuildingAmenityStages);
		BuilderBuildingAmenitySubstagesDAO builderBuildingAmenitySubstagesDAO = new BuilderBuildingAmenitySubstagesDAO();
		return builderBuildingAmenitySubstagesDAO.update(builderBuildingAmenitySubstages);
	}

	@DELETE
	@Path("/builder/building/amenity/substages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderBuildingAmenitySubstages(@FormParam("substage_id") int substageid) {

		BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages = new BuilderBuildingAmenitySubstages();
		builderBuildingAmenitySubstages.setId(substageid);
		BuilderBuildingAmenitySubstagesDAO builderBuildingAmenitySubstagesDAO = new BuilderBuildingAmenitySubstagesDAO();
		return builderBuildingAmenitySubstagesDAO.delete(builderBuildingAmenitySubstages);
	}

	@POST
	@Path("/builder/project/amenity/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectAmenity(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();

		builderProjectAmenity.setName(name);
		builderProjectAmenity.setStatus(status);
		BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
		return builderProjectAmenityDAO.save(builderProjectAmenity);
	}

	@POST
	@Path("/builder/project/amenity/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectAmenity(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {

		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();
		builderProjectAmenity.setId(id);
		builderProjectAmenity.setName(name);
		builderProjectAmenity.setStatus(status);
		BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
		return builderProjectAmenityDAO.update(builderProjectAmenity);
	}

	@DELETE
	@Path("/builder/project/amenity/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectAmenity(@FormParam("amenityid") int amenityid) {

		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();
		builderProjectAmenity.setId(amenityid);

		BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
		return builderProjectAmenityDAO.delete(builderProjectAmenity);
	}

	@GET
	@Path("/builder/project/amenity/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderProjectAmenity> getBuilderProjectAmenity(@QueryParam("amenity_id") int amenity_id) {
		BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
		return builderProjectAmenityDAO.getBuilderProjectAmenityById(amenity_id);
	}

	@POST
	@Path("/builder/project/amenity/stages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();
		builderProjectAmenity.setId(amenityId);

		BuilderProjectAmenityStages builderProjectAmenityStages = new BuilderProjectAmenityStages();

		builderProjectAmenityStages.setName(name);
		builderProjectAmenityStages.setStatus(status);
		builderProjectAmenityStages.setBuilderProjectAmenity(builderProjectAmenity);
		BuilderProjectAmenityStagesDAO builderProjectAmenityStagesDAO = new BuilderProjectAmenityStagesDAO();
		return builderProjectAmenityStagesDAO.save(builderProjectAmenityStages);
	}

	@POST
	@Path("/builder/project/amenity/stages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderProjectAmenity builderProjectAmenity = new BuilderProjectAmenity();
		builderProjectAmenity.setId(amenityId);

		BuilderProjectAmenityStages builderProjectAmenityStages = new BuilderProjectAmenityStages();
		builderProjectAmenityStages.setId(id);
		builderProjectAmenityStages.setName(name);
		builderProjectAmenityStages.setStatus(status);
		builderProjectAmenityStages.setBuilderProjectAmenity(builderProjectAmenity);
		BuilderProjectAmenityStagesDAO builderProjectAmenityStagesDAO = new BuilderProjectAmenityStagesDAO();
		return builderProjectAmenityStagesDAO.update(builderProjectAmenityStages);
	}

	@DELETE
	@Path("/builder/project/amenity/stages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectAmenityStages(@FormParam("amenity_substage_id") int amenityid) {

		BuilderProjectAmenityStages builderProjectAmenityStages = new BuilderProjectAmenityStages();
		builderProjectAmenityStages.setId(amenityid);
		BuilderProjectAmenityStagesDAO builderProjectAmenityDAO = new BuilderProjectAmenityStagesDAO();
		return builderProjectAmenityDAO.delete(builderProjectAmenityStages);
	}

	@GET
	@Path("/builder/project/amenity/stages/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderProjectAmenityStages> getBuilderProjectAmenityStages(@QueryParam("amenity_id") int amenity_id) {
		BuilderProjectAmenityStagesDAO builderProjectAmenityStagesDAO = new BuilderProjectAmenityStagesDAO();
		return builderProjectAmenityStagesDAO.getStateByAmenityId(amenity_id);
	}

	@POST
	@Path("/builder/project/amenity/substages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderProjectAmenityStages builderProjectAmenityStages = new BuilderProjectAmenityStages();
		builderProjectAmenityStages.setId(stageId);

		BuilderProjectAmenitySubstages builderProjectAmenitySubstages = new BuilderProjectAmenitySubstages();

		builderProjectAmenitySubstages.setName(name);
		builderProjectAmenitySubstages.setStatus(status);
		builderProjectAmenitySubstages.setBuilderProjectAmenityStages(builderProjectAmenityStages);
		BuilderProjectAmenitySubstagesDAO builderProjectAmenitySubstagesDAO = new BuilderProjectAmenitySubstagesDAO();
		return builderProjectAmenitySubstagesDAO.save(builderProjectAmenitySubstages);
	}

	@POST
	@Path("/builder/project/amenity/substages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderProjectAmenityStages builderProjectAmenityStages = new BuilderProjectAmenityStages();
		builderProjectAmenityStages.setId(stageId);

		BuilderProjectAmenitySubstages builderProjectAmenitySubstages = new BuilderProjectAmenitySubstages();
		builderProjectAmenitySubstages.setId(id);
		builderProjectAmenitySubstages.setName(name);
		builderProjectAmenitySubstages.setStatus(status);
		builderProjectAmenitySubstages.setBuilderProjectAmenityStages(builderProjectAmenityStages);
		BuilderProjectAmenitySubstagesDAO builderProjectAmenitySubstagesDAO = new BuilderProjectAmenitySubstagesDAO();
		return builderProjectAmenitySubstagesDAO.update(builderProjectAmenitySubstages);
	}

	@DELETE
	@Path("/builder/project/amenity/substages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectAmenitySubstages(@FormParam("substage_id") int substageid) {

		BuilderProjectAmenitySubstages builderProjectAmenitySubstages = new BuilderProjectAmenitySubstages();
		builderProjectAmenitySubstages.setId(substageid);
		BuilderProjectAmenitySubstagesDAO builderProjectAmenitySubstagesDAO = new BuilderProjectAmenitySubstagesDAO();
		return builderProjectAmenitySubstagesDAO.delete(builderProjectAmenitySubstages);
	}

	@POST
	@Path("/builder/floor/amenity/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFloorAmenity(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();

		builderFloorAmenity.setName(name);
		builderFloorAmenity.setStatus(status);
		BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
		return builderFloorAmenityDAO.save(builderFloorAmenity);
	}

	@POST
	@Path("/builder/floor/amenity/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFloorAmenity(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {

		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
		builderFloorAmenity.setId(id);
		builderFloorAmenity.setName(name);
		builderFloorAmenity.setStatus(status);
		BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
		return builderFloorAmenityDAO.update(builderFloorAmenity);
	}

	@DELETE
	@Path("/builder/floor/amenity/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFloorAmenity(@FormParam("amenityid") int amenityid) {

		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
		builderFloorAmenity.setId(amenityid);

		BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
		return builderFloorAmenityDAO.delete(builderFloorAmenity);
	}

	@GET
	@Path("/builder/floor/amenity/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderFloorAmenity> getBuilderFloorAmenity(@QueryParam("amenity_id") int amenity_id) {
		BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
		return builderFloorAmenityDAO.getBuilderFloorAmenityById(amenity_id);
	}

	@POST
	@Path("/builder/floor/amenity/stages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFloorAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
		builderFloorAmenity.setId(amenityId);

		BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();

		builderFloorAmenityStages.setName(name);
		builderFloorAmenityStages.setStatus(status);
		builderFloorAmenityStages.setBuilderFloorAmenity(builderFloorAmenity);
		BuilderFloorAmenityStagesDAO builderFloorAmenityStagesDAO = new BuilderFloorAmenityStagesDAO();
		return builderFloorAmenityStagesDAO.save(builderFloorAmenityStages);
	}

	@POST
	@Path("/builder/floor/amenity/stages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFloorAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFloorAmenity builderFloorAmenity = new BuilderFloorAmenity();
		builderFloorAmenity.setId(amenityId);

		BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
		builderFloorAmenityStages.setId(id);
		builderFloorAmenityStages.setName(name);
		builderFloorAmenityStages.setStatus(status);
		builderFloorAmenityStages.setBuilderFloorAmenity(builderFloorAmenity);
		BuilderFloorAmenityStagesDAO builderFloorAmenityStagesDAO = new BuilderFloorAmenityStagesDAO();
		return builderFloorAmenityStagesDAO.update(builderFloorAmenityStages);
	}

	@DELETE
	@Path("/builder/floor/amenity/stages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFloorAmenityStages(@FormParam("amenity_substage_id") int amenityid) {

		BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
		builderFloorAmenityStages.setId(amenityid);
		BuilderFloorAmenityStagesDAO builderFloorAmenityDAO = new BuilderFloorAmenityStagesDAO();
		return builderFloorAmenityDAO.delete(builderFloorAmenityStages);
	}

	@GET
	@Path("/builder/floor/amenity/stages/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderFloorAmenityStages> getBuilderFloorAmenityStages(@QueryParam("amenity_id") int amenity_id) {
		BuilderFloorAmenityStagesDAO builderFloorAmenityStagesDAO = new BuilderFloorAmenityStagesDAO();
		return builderFloorAmenityStagesDAO.getStateByAmenityId(amenity_id);
	}

	@POST
	@Path("/builder/floor/amenity/substages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFloorAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
		builderFloorAmenityStages.setId(stageId);

		BuilderFloorAmenitySubstages builderFloorAmenitySubstages = new BuilderFloorAmenitySubstages();

		builderFloorAmenitySubstages.setName(name);
		builderFloorAmenitySubstages.setStatus(status);
		builderFloorAmenitySubstages.setBuilderFloorAmenityStages(builderFloorAmenityStages);
		BuilderFloorAmenitySubstagesDAO builderFloorAmenitySubstagesDAO = new BuilderFloorAmenitySubstagesDAO();
		return builderFloorAmenitySubstagesDAO.save(builderFloorAmenitySubstages);
	}

	@POST
	@Path("/builder/floor/amenity/substages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFloorAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFloorAmenityStages builderFloorAmenityStages = new BuilderFloorAmenityStages();
		builderFloorAmenityStages.setId(stageId);

		BuilderFloorAmenitySubstages builderFloorAmenitySubstages = new BuilderFloorAmenitySubstages();
		builderFloorAmenitySubstages.setId(id);
		builderFloorAmenitySubstages.setName(name);
		builderFloorAmenitySubstages.setStatus(status);
		builderFloorAmenitySubstages.setBuilderFloorAmenityStages(builderFloorAmenityStages);
		BuilderFloorAmenitySubstagesDAO builderProjectAmenitySubstagesDAO = new BuilderFloorAmenitySubstagesDAO();
		return builderProjectAmenitySubstagesDAO.update(builderFloorAmenitySubstages);
	}

	@DELETE
	@Path("/builder/floor/amenity/substages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFloorAmenitySubstages(@FormParam("substage_id") int substageid) {

		BuilderFloorAmenitySubstages builderFloorAmenitySubstages = new BuilderFloorAmenitySubstages();
		builderFloorAmenitySubstages.setId(substageid);
		BuilderFloorAmenitySubstagesDAO builderFloorAmenitySubstagesDAO = new BuilderFloorAmenitySubstagesDAO();
		return builderFloorAmenitySubstagesDAO.delete(builderFloorAmenitySubstages);
	}
	// ================================================================================================================================

	@POST
	@Path("/builder/flat/amenity/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFlatAmenity(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();

		builderFlatAmenity.setName(name);
		builderFlatAmenity.setStatus(status);
		BuilderFlatAmenityDAO builderFloorAmenityDAO = new BuilderFlatAmenityDAO();
		return builderFloorAmenityDAO.save(builderFlatAmenity);
	}

	@POST
	@Path("/builder/flat/amenity/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFlatAmenity(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {

		BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
		builderFlatAmenity.setId(id);
		builderFlatAmenity.setName(name);
		builderFlatAmenity.setStatus(status);
		BuilderFlatAmenityDAO builderFlatAmenityDAO = new BuilderFlatAmenityDAO();
		return builderFlatAmenityDAO.update(builderFlatAmenity);
	}

	@DELETE
	@Path("/builder/flat/amenity/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFlatAmenity(@FormParam("amenityid") int amenityid) {

		BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
		builderFlatAmenity.setId(amenityid);

		BuilderFlatAmenityDAO builderFlatAmenityDAO = new BuilderFlatAmenityDAO();
		return builderFlatAmenityDAO.delete(builderFlatAmenity);
	}

	@GET
	@Path("/builder/flat/amenity/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderFlatAmenity> getBuilderFlatAmenity(@QueryParam("amenity_id") int amenity_id) {
		BuilderFlatAmenityDAO builderFlatAmenityDAO = new BuilderFlatAmenityDAO();
		return builderFlatAmenityDAO.getBuilderFlatAmenityById(amenity_id);
	}

	@POST
	@Path("/builder/flat/amenity/stages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFlatAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
		builderFlatAmenity.setId(amenityId);

		BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();

		builderFlatAmenityStages.setName(name);
		builderFlatAmenityStages.setStatus(status);
		builderFlatAmenityStages.setBuilderFlatAmenity(builderFlatAmenity);
		BuilderFlatAmenityStagesDAO builderFlatAmenityStagesDAO = new BuilderFlatAmenityStagesDAO();
		return builderFlatAmenityStagesDAO.save(builderFlatAmenityStages);
	}

	@POST
	@Path("/builder/flat/amenity/stages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFlatAmenityStages(@FormParam("amenity_id") int amenityId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFlatAmenity builderFlatAmenity = new BuilderFlatAmenity();
		builderFlatAmenity.setId(amenityId);

		BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
		builderFlatAmenityStages.setId(id);
		builderFlatAmenityStages.setName(name);
		builderFlatAmenityStages.setStatus(status);
		builderFlatAmenityStages.setBuilderFlatAmenity(builderFlatAmenity);
		BuilderFlatAmenityStagesDAO builderFlatAmenityStagesDAO = new BuilderFlatAmenityStagesDAO();
		return builderFlatAmenityStagesDAO.update(builderFlatAmenityStages);
	}

	@DELETE
	@Path("/builder/flat/amenity/stages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFlatAmenityStages(@FormParam("amenity_substage_id") int amenityid) {

		BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
		builderFlatAmenityStages.setId(amenityid);
		BuilderFlatAmenityStagesDAO builderFlatAmenityDAO = new BuilderFlatAmenityStagesDAO();
		return builderFlatAmenityDAO.delete(builderFlatAmenityStages);
	}

	@GET
	@Path("/builder/flat/amenity/stages/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderFlatAmenityStages> getBuilderFlatAmenityStages(@QueryParam("amenity_id") int amenity_id) {
		BuilderFlatAmenityStagesDAO builderFlatAmenityStagesDAO = new BuilderFlatAmenityStagesDAO();
		return builderFlatAmenityStagesDAO.getStateByAmenityId(amenity_id);
	}

	@POST
	@Path("/builder/flat/amenity/substages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFlatAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
		builderFlatAmenityStages.setId(stageId);

		BuilderFlatAmenitySubstages builderFlatAmenitySubstages = new BuilderFlatAmenitySubstages();

		builderFlatAmenitySubstages.setName(name);
		builderFlatAmenitySubstages.setStatus(status);
		builderFlatAmenitySubstages.setBuilderFlatAmenityStages(builderFlatAmenityStages);
		BuilderFlatAmenitySubstagesDAO builderFlatAmenitySubstagesDAO = new BuilderFlatAmenitySubstagesDAO();
		return builderFlatAmenitySubstagesDAO.save(builderFlatAmenitySubstages);
	}

	@POST
	@Path("/builder/flat/amenity/substages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFlatAmenitySubstages(@FormParam("stage_id") int stageId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderFlatAmenityStages builderFlatAmenityStages = new BuilderFlatAmenityStages();
		builderFlatAmenityStages.setId(stageId);

		BuilderFlatAmenitySubstages builderFlatAmenitySubstages = new BuilderFlatAmenitySubstages();
		builderFlatAmenitySubstages.setId(id);
		builderFlatAmenitySubstages.setName(name);
		builderFlatAmenitySubstages.setStatus(status);
		builderFlatAmenitySubstages.setBuilderFlatAmenityStages(builderFlatAmenityStages);
		BuilderFlatAmenitySubstagesDAO builderProjectAmenitySubstagesDAO = new BuilderFlatAmenitySubstagesDAO();
		return builderProjectAmenitySubstagesDAO.update(builderFlatAmenitySubstages);
	}

	@DELETE
	@Path("/builder/flat/amenity/substages/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFlatAmenitySubstages(@FormParam("substage_id") int substageid) {

		BuilderFlatAmenitySubstages builderFlatAmenitySubstages = new BuilderFlatAmenitySubstages();
		builderFlatAmenitySubstages.setId(substageid);
		BuilderFlatAmenitySubstagesDAO builderFlatAmenitySubstagesDAO = new BuilderFlatAmenitySubstagesDAO();
		return builderFlatAmenitySubstagesDAO.delete(builderFlatAmenitySubstages);
	}

	@POST
	@Path("/building/status/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBulidingStatus(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderBuildingStatus buildingAmenetiesType = new BuilderBuildingStatus();
	
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderBuildingStatusDAO stateImp = new BuilderBuildingStatusDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/building/status/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuildingStatus(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
		
		BuilderBuildingStatus state = new BuilderBuildingStatus();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderBuildingStatusDAO stateImp = new BuilderBuildingStatusDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/building/status/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuildingStatus(@FormParam("id") int id) {

		BuilderBuildingStatus country = new BuilderBuildingStatus();
		country.setId(id);

		BuilderBuildingStatusDAO countryService = new BuilderBuildingStatusDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/company/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderCompany(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderCompany buildingAmenetiesType = new BuilderCompany();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderCompanyDAO stateImp = new BuilderCompanyDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/company/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderCompany(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("stock") String sstatus) {
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		BuilderCompany state = new BuilderCompany();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderCompanyDAO stateImp = new BuilderCompanyDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/company/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderCompany(@FormParam("id") int id) {

		BuilderCompany country = new BuilderCompany();
		country.setId(id);

		BuilderCompanyDAO countryService = new BuilderCompanyDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/flat/status/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderFlatStatus(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderFlatStatus buildingAmenetiesType = new BuilderFlatStatus();
		
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderFlatStatusDAO stateImp = new BuilderFlatStatusDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/flat/status/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderFlatStatus(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
	
		BuilderFlatStatus state = new BuilderFlatStatus();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderFlatStatusDAO stateImp = new BuilderFlatStatusDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/flat/status/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderFlatStatus(@FormParam("id") int id) {

		BuilderFlatStatus country = new BuilderFlatStatus();
		country.setId(id);

		BuilderFlatStatusDAO countryService = new BuilderFlatStatusDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/group/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderGroup(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderGroup buildingAmenetiesType = new BuilderGroup();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderGroupDAO stateImp = new BuilderGroupDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/group/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderGroup(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("stock") String sstatus) {
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		BuilderGroup state = new BuilderGroup();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderGroupDAO stateImp = new BuilderGroupDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/group/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderGroup(@FormParam("id") int id) {

		BuilderGroup country = new BuilderGroup();
		country.setId(id);

		BuilderGroupDAO countryService = new BuilderGroupDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/project/satges/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderOverallProjectStagesAndSubStages(@FormParam("name") String name,
			@FormParam("stock") String sstatus) {
		BuilderOverallProjectStagesAndSubStages buildingAmenetiesType = new BuilderOverallProjectStagesAndSubStages();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderOverallProjectStagesAndSubStagesDAO stateImp = new BuilderOverallProjectStagesAndSubStagesDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/satges/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderOverallProjectStagesAndSubStages(@FormParam("id") int id,
			@FormParam("name") String name, @FormParam("stock") String sstatus) {
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		BuilderOverallProjectStagesAndSubStages state = new BuilderOverallProjectStagesAndSubStages();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderOverallProjectStagesAndSubStagesDAO stateImp = new BuilderOverallProjectStagesAndSubStagesDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/satges/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderOverallProjectStagesAndSubStages(@FormParam("id") int id) {

		BuilderOverallProjectStagesAndSubStages country = new BuilderOverallProjectStagesAndSubStages();
		country.setId(id);

		BuilderOverallProjectStagesAndSubStagesDAO countryService = new BuilderOverallProjectStagesAndSubStagesDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/payment/satges/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderPaymentStages(@FormParam("name") String name,
			@FormParam("status") byte status) {
		BuilderPaymentStages builderPaymentStages = new BuilderPaymentStages();
		
		builderPaymentStages.setName(name);
		builderPaymentStages.setStatus(status);
		BuilderPaymentStagesDAO builderPaymentStagesDAO = new BuilderPaymentStagesDAO();
		return builderPaymentStagesDAO.save(builderPaymentStages);
	}

	@POST
	@Path("/builder/payment/satges/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderPaymentStages(@FormParam("id") int id,
			@FormParam("name") String name, @FormParam("status") byte status) {
		
		BuilderPaymentStages builderPaymentStages = new BuilderPaymentStages();
		builderPaymentStages.setId(id);
		builderPaymentStages.setName(name);
		builderPaymentStages.setStatus(status);
		BuilderPaymentStagesDAO builderPaymentStagesDAO = new BuilderPaymentStagesDAO();
		return builderPaymentStagesDAO.update(builderPaymentStages);
	}

	@DELETE
	@Path("/builder/payment/satges/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderPaymentStages(@FormParam("id") int id) {

		BuilderPaymentStages builderPaymentStages = new BuilderPaymentStages();
		builderPaymentStages.setId(id);

		BuilderPaymentStagesDAO builderPaymentStagesDAO = new BuilderPaymentStagesDAO();
		return builderPaymentStagesDAO.delete(builderPaymentStages);
	}
	
	@GET
	@Path("/builder/payment/stage/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderPaymentStages> getBuilderPaymentList(@QueryParam("payment_id") int payment_id) {
		BuilderPaymentStagesDAO builderPaymentStagesDAO = new BuilderPaymentStagesDAO();
		return builderPaymentStagesDAO.getBuilderPaymentStagesById(payment_id);
	}
	
	@POST
	@Path("/builder/payment/substages/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderPaymentSbubstages(@FormParam("payment_id") int paymentId,
			@FormParam("name") String name, @FormParam("status") byte status) {

		BuilderPaymentStages builderPaymentStages = new BuilderPaymentStages();
		builderPaymentStages.setId(paymentId);

		BuilderPaymentSubstages builderPaymentSubstages = new BuilderPaymentSubstages();

		builderPaymentSubstages.setName(name);
		builderPaymentSubstages.setStatus(status);
		builderPaymentSubstages.setBuilderPaymentStages(builderPaymentStages);
		BuilderPaymentSubstagesDAO builderPaymentSubstagesDAO = new BuilderPaymentSubstagesDAO();
		return builderPaymentSubstagesDAO.save(builderPaymentSubstages);
	}

	@POST
	@Path("/builder/payment/substages/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderPaymentSubstages(@FormParam("payment_id") int paymentId,
			@FormParam("id") int id, @FormParam("name") String name, @FormParam("status") byte status) {

		BuilderPaymentStages builderPaymentStages = new BuilderPaymentStages();
		builderPaymentStages.setId(paymentId);

		BuilderPaymentSubstages builderPaymentSubstages = new BuilderPaymentSubstages();
		builderPaymentSubstages.setId(id);
		builderPaymentSubstages.setName(name);
		builderPaymentSubstages.setStatus(status);
		builderPaymentSubstages.setBuilderPaymentStages(builderPaymentStages);
		BuilderPaymentSubstagesDAO builderPaymentSubstagesDAO = new BuilderPaymentSubstagesDAO();
		return builderPaymentSubstagesDAO.update(builderPaymentSubstages);
	}

//	@DELETE
//	@Path("/builder/payment/substages/delete")
//	@Produces(MediaType.APPLICATION_JSON)
//	public ResponseMessage deleteBuilderPaymentSubstages(@FormParam("substage_id") int substageid) {
//
//		BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages = new BuilderBuildingAmenitySubstages();
//		builderBuildingAmenitySubstages.setId(substageid);
//		BuilderBuildingAmenitySubstagesDAO builderBuildingAmenitySubstagesDAO = new BuilderBuildingAmenitySubstagesDAO();
//		return builderBuildingAmenitySubstagesDAO.delete(builderBuildingAmenitySubstages);
//	}

	@POST
	@Path("/builder/project/approval/type/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectApprovalType(@FormParam("name") String name,
			@FormParam("status") byte status) {
		BuilderProjectApprovalType buildingAmenetiesType = new BuilderProjectApprovalType();

		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderProjectApprovalTypeDAO stateImp = new BuilderProjectApprovalTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/approval/type/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectApprovalType(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
		
		BuilderProjectApprovalType state = new BuilderProjectApprovalType();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderProjectApprovalTypeDAO stateImp = new BuilderProjectApprovalTypeDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/approval/type/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectApprovalType(@FormParam("id") int id) {

		BuilderProjectApprovalType country = new BuilderProjectApprovalType();
		country.setId(id);

		BuilderProjectApprovalTypeDAO countryService = new BuilderProjectApprovalTypeDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/project/level/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectLevel(@FormParam("name") String name, @FormParam("status") byte status) {
		BuilderProjectLevel buildingAmenetiesType = new BuilderProjectLevel();
		
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderProjectLevelDAO stateImp = new BuilderProjectLevelDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/level/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectLevel(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("status") byte status) {
		
		BuilderProjectLevel state = new BuilderProjectLevel();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderProjectLevelDAO stateImp = new BuilderProjectLevelDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/level/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectLevel(@FormParam("id") int id) {

		BuilderProjectLevel country = new BuilderProjectLevel();
		country.setId(id);

		BuilderProjectLevelDAO countryService = new BuilderProjectLevelDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/project/propertyconfig/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectPropertyConfiguration(@FormParam("name") String name,
			@FormParam("status") byte status) {
		BuilderProjectPropertyConfiguration buildingAmenetiesType = new BuilderProjectPropertyConfiguration();
		
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderProjectPropertyConfigurationDAO stateImp = new BuilderProjectPropertyConfigurationDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/propertyconfig/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectPropertyConfiguration(@FormParam("id") int id,
			@FormParam("name") String name, @FormParam("status") byte status) {
		
		BuilderProjectPropertyConfiguration state = new BuilderProjectPropertyConfiguration();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderProjectPropertyConfigurationDAO stateImp = new BuilderProjectPropertyConfigurationDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/propertyconfig/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectPropertyConfiguration(@FormParam("id") int id) {

		BuilderProjectPropertyConfiguration country = new BuilderProjectPropertyConfiguration();
		country.setId(id);

		BuilderProjectPropertyConfigurationDAO countryService = new BuilderProjectPropertyConfigurationDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/project/status/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectStatus(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderProjectStatus buildingAmenetiesType = new BuilderProjectStatus();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderProjectStatusDAO stateImp = new BuilderProjectStatusDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/status/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectStatus(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("stock") String sstatus) {
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		BuilderProjectStatus state = new BuilderProjectStatus();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderProjectStatusDAO stateImp = new BuilderProjectStatusDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/status/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectStatus(@FormParam("id") int id) {

		BuilderProjectStatus country = new BuilderProjectStatus();
		country.setId(id);

		BuilderProjectStatusDAO countryService = new BuilderProjectStatusDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/project/type/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderProjectType(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderProjectType buildingAmenetiesType = new BuilderProjectType();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderProjectTypeDAO stateImp = new BuilderProjectTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/project/type/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderProjectType(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("stock") String sstatus) {
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		BuilderProjectType state = new BuilderProjectType();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderProjectTypeDAO stateImp = new BuilderProjectTypeDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/project/type/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderProjectType(@FormParam("id") int id) {

		BuilderProjectType country = new BuilderProjectType();
		country.setId(id);

		BuilderProjectTypeDAO countryService = new BuilderProjectTypeDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/property/type/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderPropertyType(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderPropertyType buildingAmenetiesType = new BuilderPropertyType();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderPropertyTypeDAO stateImp = new BuilderPropertyTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/property/type/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderPropertyType(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("stock") String sstatus) {
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		BuilderPropertyType state = new BuilderPropertyType();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderPropertyTypeDAO stateImp = new BuilderPropertyTypeDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/property/type/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderPropertyType(@FormParam("id") int id) {

		BuilderPropertyType country = new BuilderPropertyType();
		country.setId(id);

		BuilderPropertyTypeDAO countryService = new BuilderPropertyTypeDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/seller/type/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderSellerType(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderSellerType buildingAmenetiesType = new BuilderSellerType();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderSellerTypeDAO stateImp = new BuilderSellerTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/seller/type/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderSellerType(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("stock") String sstatus) {
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		BuilderSellerType state = new BuilderSellerType();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderSellerTypeDAO stateImp = new BuilderSellerTypeDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/seller/type/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderSellerType(@FormParam("id") int id) {

		BuilderSellerType country = new BuilderSellerType();
		country.setId(id);

		BuilderSellerTypeDAO countryService = new BuilderSellerTypeDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/tax/type/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilderTaxType(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderTaxType buildingAmenetiesType = new BuilderTaxType();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderTaxTypeDAO stateImp = new BuilderTaxTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@POST
	@Path("/builder/tax/type/update")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderTaxType(@FormParam("id") int id, @FormParam("name") String name,
			@FormParam("stock") String sstatus) {
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		BuilderTaxType state = new BuilderTaxType();
		state.setId(id);
		state.setName(name);
		state.setStatus(status);
		BuilderTaxTypeDAO stateImp = new BuilderTaxTypeDAO();
		return stateImp.update(state);
	}

	@DELETE
	@Path("/builder/tax/type/delete")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuilderTaxType(@FormParam("id") int id) {

		BuilderTaxType country = new BuilderTaxType();
		country.setId(id);

		BuilderTaxTypeDAO countryService = new BuilderTaxTypeDAO();
		return countryService.delete(country);
	}

	@POST
	@Path("/builder/save")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage addBuilder(@FormParam("name") String name, @FormParam("stock") String sstatus) {
		BuilderTaxType buildingAmenetiesType = new BuilderTaxType();
		byte status = 0;
		if (sstatus.equals("Yes"))
			status = 1;
		buildingAmenetiesType.setName(name);
		buildingAmenetiesType.setStatus(status);
		BuilderTaxTypeDAO stateImp = new BuilderTaxTypeDAO();
		return stateImp.save(buildingAmenetiesType);
	}

	@GET
	@Path("/project/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<BuilderCompanyNames> getCompanyName(@QueryParam("builder_id") int builder_id) {
		BuilderDetailsDAO builderBuildingAmenityDAO = new BuilderDetailsDAO();
		return builderBuildingAmenityDAO.getBuilderCompanyNameList(builder_id);
	}
}
