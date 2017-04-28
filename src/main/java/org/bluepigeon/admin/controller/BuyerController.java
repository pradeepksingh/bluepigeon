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
import org.bluepigeon.admin.data.BuyerData;
import org.bluepigeon.admin.data.BuyerList;
import org.bluepigeon.admin.data.BuyerPaymentList;
import org.bluepigeon.admin.data.FlatData;
import org.bluepigeon.admin.data.FlatPaymentList;
import org.bluepigeon.admin.data.FloorData;
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.data.ProjectDetail;
import org.bluepigeon.admin.data.ProjectOffer;
import org.bluepigeon.admin.data.ProjectPaymentSchedule;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.Agreement;
import org.bluepigeon.admin.model.AgreementInfo;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderEmployee;
import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuildingImageGallery;
import org.bluepigeon.admin.model.BuildingOfferInfo;
import org.bluepigeon.admin.model.BuildingPaymentInfo;
import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.BuyerDocuments;
import org.bluepigeon.admin.model.BuyerOffer;
import org.bluepigeon.admin.model.BuyerPayment;
import org.bluepigeon.admin.model.BuyerUploadDocuments;
import org.bluepigeon.admin.model.BuyingDetails;
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
			@FormDataParam("photo[]") List<FormDataBodyPart>  photos,
			@FormDataParam("document_pan[]") List<FormDataBodyPart> douments,
			@FormDataParam("document_aadhar[]") List<FormDataBodyPart> aadhar,
			@FormDataParam("document_passport[]") List<FormDataBodyPart> passport,
			@FormDataParam("document_rra[]") List<FormDataBodyPart> rra,
			@FormDataParam("document_voterid[]") List<FormDataBodyPart> voterid,
			@FormDataParam("builder_id") int builder_id,
			@FormDataParam("project_id") int project_id,
			@FormDataParam("building_id") int building_id,
			@FormDataParam("flat_id") int flat_id,
			@FormDataParam("booking_date") String booking_date,
			@FormDataParam("base_rate") Double base_rate,
			@FormDataParam("rise_rate") Double rise_rate,
			@FormDataParam("amenity_rate") Double amenity_rate,
			@FormDataParam("maintenance") Double maintenance,
			@FormDataParam("tenure") Integer tenure,
			@FormDataParam("registration") Double registration,
			@FormDataParam("parking") Double parking,
			@FormDataParam("stamp_duty") Double stamp_duty,
			@FormDataParam("tax") Double tax,
			@FormDataParam("vat") Double vat,
			@FormDataParam("offer_title[]") List<FormDataBodyPart> offer_title,
			@FormDataParam("discount[]") List<FormDataBodyPart> discount,
			@FormDataParam("discount_amount[]") List<FormDataBodyPart> discount_amount,
			@FormDataParam("applicable_on[]") List<FormDataBodyPart> applicable_on,
			@FormDataParam("apply[]") List<FormDataBodyPart> apply,
			@FormDataParam("schedule[]") List<FormDataBodyPart> schedule,
			@FormDataParam("payable[]") List<FormDataBodyPart> payable,
			@FormDataParam("amount[]") List<FormDataBodyPart> amount,
			@FormDataParam("doc_name[]") List<FormDataBodyPart> doc_name,
			@FormDataParam("doc_url[]") List<FormDataBodyPart> doc_url
	){
		ResponseMessage msg = new ResponseMessage();
		BuyerDAO buyerDAO = new BuyerDAO();
		BuilderEmployee builderEmployee = new BuilderEmployee();
		builderEmployee.setId(emp_id);
		Short agreement=0;
		Short possession=0;
		Buyer buyer = null;
		//List<Buyer> buyerList = new ArrayList<Buyer>();
		Buyer primaryBuyer = new Buyer();
		if(name.size()>0){
			int i=0;
			for(FormDataBodyPart buyers : name){
				buyer = new Buyer();
				buyer.setBuilderEmployee(builderEmployee);
				buyer.setAgreement(agreement);
				buyer.setPossession(possession);
				if(builder_id > 0){
					Builder builder = new Builder();
					builder.setId(builder_id);
					buyer.setBuilder(builder);
				}
				
				if(project_id > 0){
					BuilderProject builderProject = new BuilderProject();
					builderProject.setId(project_id);
					buyer.setBuilderProject(builderProject);
				}
				
				if(building_id > 0){
					BuilderBuilding builderBuilding = new BuilderBuilding();
					builderBuilding.setId(building_id);
					buyer.setBuilderBuilding(builderBuilding);
				}
				
				if(flat_id > 0){
					BuilderFlat builderFlat = new BuilderFlat();
					builderFlat.setId(flat_id);
					buyer.setBuilderFlat(builderFlat);
				}
				if(buyers.getValueAs(String.class).toString()!=null && !buyers.getValueAs(String.class).isEmpty()){
					buyer.setName(name.get(i).getValueAs(String.class).toString());
				}
				if(contact.get(i).getValueAs(String.class).toString()!=null && !contact.get(i).getValueAs(String.class).isEmpty()) {
					buyer.setMobile(contact.get(i).getValueAs(String.class).toString());
				}
				buyer.setEmail(email.get(i).getValueAs(String.class).toString());
				if(address.get(i).getValueAs(String.class).toString()!=null && !address.get(i).getValueAs(String.class).isEmpty()){
					buyer.setAddress(address.get(i).getValueAs(String.class).toString());
				}
				if(pan.get(i).getValueAs(String.class).toString()!=null && !pan.get(i).getValueAs(String.class).isEmpty()){
					buyer.setPancard(pan.get(i).getValueAs(String.class).toString());
				}
				if(is_primary.get(i).getValueAs(Integer.class).intValue() == 1) {
					buyer.setIsPrimary(true);
				} else {
					buyer.setIsPrimary(false);
				}
				buyer.setStatus(agreement);
				try {
					if(photos.get(i).getFormDataContentDisposition().getFileName() != null && !photos.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						String gallery_name = photos.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/buyer/images/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						this.imageUploader.writeToFile(photos.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						buyer.setPhoto(gallery_name);
					}
				} catch(Exception e) {
					buyer.setPhoto("");
				}
				msg = buyerDAO.addBuyer(buyer);
				buyer.setId(msg.getId());
				List<BuyerDocuments> buyerDocumentsList = new ArrayList<BuyerDocuments>();
				if(douments != null && douments.size() > 0) {
					if(douments.get(i).getValueAs(String.class).toString()!=null && !douments.get(i).getValueAs(String.class).isEmpty()){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(douments.get(i).getValueAs(String.class).toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				if(aadhar != null && aadhar.size() > 0) {
					if(aadhar.get(i).getValueAs(String.class).toString()!=null && !aadhar.get(i).getValueAs(String.class).isEmpty()){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(aadhar.get(i).getValueAs(String.class).toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				if(passport != null && passport.size() > 0) {
					if(passport.get(i).getValueAs(String.class).toString()!=null && !passport.get(i).getValueAs(String.class).isEmpty()){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(passport.get(i).getValueAs(String.class).toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				if(rra != null && rra.size() > 0) {
					if(rra.get(i).getValueAs(String.class).toString()!=null && !rra.get(i).getValueAs(String.class).isEmpty()){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(rra.get(i).getValueAs(String.class).toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				if(voterid != null && voterid.size() > 0) {
					if(voterid.get(i).getValueAs(String.class).toString()!=null && !voterid.get(i).getValueAs(String.class).isEmpty()){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(voterid.get(i).getValueAs(String.class).toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				buyerDAO.saveBuyerDocuments(buyerDocumentsList);
				System.out.println("Primary ID:"+buyer.getIsPrimary());
				if(buyer.getIsPrimary()) {
					primaryBuyer = buyer;
				}
				
				i++;	
			}
			if(primaryBuyer.getId() > 0) {
				SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
				Date bookingDate = null;
				try {
					bookingDate = format.parse(booking_date);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				BuyingDetails buyingDetails = new BuyingDetails();
				buyingDetails.setBuyer(primaryBuyer);
				buyingDetails.setAmenityFacingRate(amenity_rate);
				buyingDetails.setBaseRate(base_rate);
				buyingDetails.setBookingDate(bookingDate);
				buyingDetails.setFloorRiseRate(rise_rate);
				buyingDetails.setMaintenance(maintenance);
				buyingDetails.setParkingRate(parking);
				buyingDetails.setRegistration(registration);
				buyingDetails.setStampDuty(stamp_duty);
				buyingDetails.setTaxes(tax);
				buyingDetails.setTenure(tenure);
				buyingDetails.setVat(vat);
				buyerDAO.saveBuyingDetails(buyingDetails);
			}
			if (schedule.size() > 0) {
				List<BuyerPayment> buyerPayments = new ArrayList<BuyerPayment>();
				i = 0;
				for(FormDataBodyPart milestone : schedule)
				{
					if(milestone.getValueAs(String.class).toString() != null && !milestone.getValueAs(String.class).toString().isEmpty()) {
						boolean isPaid = false;
						BuyerPayment buyerPayment = new BuyerPayment();
						buyerPayment.setMilestone(milestone.getValueAs(String.class).toString());
						buyerPayment.setNetPayable(payable.get(i).getValueAs(Double.class));
						buyerPayment.setAmount(amount.get(i).getValueAs(Double.class));
						buyerPayment.setPaid(isPaid);
						buyerPayment.setBuyer(primaryBuyer);
						buyerPayments.add(buyerPayment);
					}
					i++;
				}
				if(buyerPayments.size() > 0) {
					buyerDAO.saveBuyerPayment(buyerPayments);
				}
			}
			
			if (offer_title.size() > 0) {
				List<BuyerOffer> buyerOffers = new ArrayList<BuyerOffer>();
				i = 0;
				for(FormDataBodyPart title : offer_title)
				{
					if(title.getValueAs(String.class).toString() != null && !title.getValueAs(String.class).toString().isEmpty()) {
						BuyerOffer buyerOffer = new BuyerOffer();
						buyerOffer.setTitle(title.getValueAs(String.class).toString());
						buyerOffer.setOfferAmount(discount_amount.get(i).getValueAs(Double.class));
						buyerOffer.setOfferPercentage(discount.get(i).getValueAs(Double.class));
						buyerOffer.setApplicable(applicable_on.get(i).getValueAs(Byte.class));
						buyerOffer.setStatus(apply.get(i).getValueAs(Byte.class));
						buyerOffer.setBuyer(primaryBuyer);
						buyerOffers.add(buyerOffer);
					}
					i++;
				}
				if(buyerOffers.size() > 0) {
					buyerDAO.saveBuyerOffers(buyerOffers);
				}
			}
			try {
				List<BuyerUploadDocuments> buyerUploadDocuments = new ArrayList<BuyerUploadDocuments>();
				i = 0;
				for(FormDataBodyPart title : offer_title)
				{
					BuyerUploadDocuments buDocuments = new BuyerUploadDocuments();
					if(doc_url.get(i).getFormDataContentDisposition().getFileName() != null && !doc_url.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						String gallery_name = doc_url.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/buyer/docs/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						this.imageUploader.writeToFile(photos.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						buDocuments.setDocUrl(gallery_name);
						buDocuments.setBuyer(primaryBuyer);
						buDocuments.setName(doc_name.get(i).getValueAs(String.class).toString());
						buDocuments.setBuilderdoc(true);
						buDocuments.setUploadedDate(new Date());
					}
					buyerUploadDocuments.add(buDocuments);
				}
				buyerDAO.saveBuyerUploadDouments(buyerUploadDocuments);
			} catch(Exception e) {
				buyer.setPhoto("");
			}
		}
		return msg;
	}
	
	@POST
	@Path("/update/basic")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuyerInfoNew (
			@FormDataParam("buyer_id") int buyer_id,
			@FormDataParam("admin_id") int emp_id,
			@FormDataParam("buyer_name[]") List<FormDataBodyPart>  name,
			@FormDataParam("contact[]") List<FormDataBodyPart>  contact,
			@FormDataParam("email[]") List<FormDataBodyPart>  email,
			@FormDataParam("pan[]") List<FormDataBodyPart>  pan,
			@FormDataParam("address[]") List<FormDataBodyPart>  address,
			@FormDataParam("is_primary[]") List<FormDataBodyPart>  is_primary,
			@FormDataParam("photo[]") List<FormDataBodyPart>  photos,
			@FormDataParam("document_pan[]") List<FormDataBodyPart> douments,
			@FormDataParam("document_aadhar[]") List<FormDataBodyPart> aadhar,
			@FormDataParam("document_passport[]") List<FormDataBodyPart> passport,
			@FormDataParam("document_rra[]") List<FormDataBodyPart> rra,
			@FormDataParam("document_voterid[]") List<FormDataBodyPart> voterid,
			@FormDataParam("builder_id") int builder_id,
			@FormDataParam("project_id") int project_id,
			@FormDataParam("building_id") int building_id,
			@FormDataParam("flat_id") int flat_id
	){
		ResponseMessage msg = new ResponseMessage();
		BuyerDAO buyerDAO = new BuyerDAO();
		BuilderEmployee builderEmployee = new BuilderEmployee();
		builderEmployee.setId(emp_id);
		Short agreement=0;
		Short possession=0;
		Buyer buyer = null;
		Buyer primaryBuyer = new Buyer();
		if(name.size()>0){
			int i=0;
			for(FormDataBodyPart buyers : name){
				buyer = new Buyer();
				buyer.setBuilderEmployee(builderEmployee);
				buyer.setAgreement(agreement);
				buyer.setPossession(possession);
				if(buyer_id>0){
					buyer.setId(buyer_id);
				}
				if(builder_id > 0){
					Builder builder = new Builder();
					builder.setId(builder_id);
					buyer.setBuilder(builder);
				}
				
				if(project_id > 0){
					BuilderProject builderProject = new BuilderProject();
					builderProject.setId(project_id);
					buyer.setBuilderProject(builderProject);
				}
				
				if(building_id > 0){
					BuilderBuilding builderBuilding = new BuilderBuilding();
					builderBuilding.setId(building_id);
					buyer.setBuilderBuilding(builderBuilding);
				}
				
				if(flat_id > 0){
					BuilderFlat builderFlat = new BuilderFlat();
					builderFlat.setId(flat_id);
					buyer.setBuilderFlat(builderFlat);
				}
				if(buyers.getValueAs(String.class).toString()!=null && !buyers.getValueAs(String.class).isEmpty()){
					buyer.setName(name.get(i).getValueAs(String.class).toString());
				}
				if(contact.get(i).getValueAs(String.class).toString()!=null && !contact.get(i).getValueAs(String.class).isEmpty()) {
					buyer.setMobile(contact.get(i).getValueAs(String.class).toString());
				}
				buyer.setEmail(email.get(i).getValueAs(String.class).toString());
				if(address.get(i).getValueAs(String.class).toString()!=null && !address.get(i).getValueAs(String.class).isEmpty()){
					buyer.setAddress(address.get(i).getValueAs(String.class).toString());
				}
				if(pan.get(i).getValueAs(String.class).toString()!=null && !pan.get(i).getValueAs(String.class).isEmpty()){
					buyer.setPancard(pan.get(i).getValueAs(String.class).toString());
				}
				if(is_primary.get(i).getValueAs(Integer.class).intValue() == 1) {
					buyer.setIsPrimary(true);
				} else {
					buyer.setIsPrimary(false);
				}
				buyer.setStatus(agreement);
				try {
					if(photos.get(i).getFormDataContentDisposition().getFileName() != null && !photos.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
						String gallery_name = photos.get(i).getFormDataContentDisposition().getFileName();
						long millis = System.currentTimeMillis() % 1000;
						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
						gallery_name = "images/project/buyer/images/"+gallery_name;
						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
						this.imageUploader.writeToFile(photos.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
						buyer.setPhoto(gallery_name);
					}
				} catch(Exception e) {
					buyer.setPhoto("");
				}
				msg = buyerDAO.updateBuyer(buyer);
				buyer.setId(msg.getId());
				List<BuyerDocuments> buyerDocumentsList = new ArrayList<BuyerDocuments>();
				if(douments != null && douments.size() > 0) {
					if(douments.get(i).getValueAs(String.class).toString()!=null && !douments.get(i).getValueAs(String.class).isEmpty()){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(douments.get(i).getValueAs(String.class).toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				if(aadhar != null && aadhar.size() > 0) {
					if(aadhar.get(i).getValueAs(String.class).toString()!=null && !aadhar.get(i).getValueAs(String.class).isEmpty()){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(aadhar.get(i).getValueAs(String.class).toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				if(passport != null && passport.size() > 0) {
					if(passport.get(i).getValueAs(String.class).toString()!=null && !passport.get(i).getValueAs(String.class).isEmpty()){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(passport.get(i).getValueAs(String.class).toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				if(rra != null && rra.size() > 0) {
					if(rra.get(i).getValueAs(String.class).toString()!=null && !rra.get(i).getValueAs(String.class).isEmpty()){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(rra.get(i).getValueAs(String.class).toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				if(voterid != null && voterid.size() > 0) {
					if(voterid.get(i).getValueAs(String.class).toString()!=null && !voterid.get(i).getValueAs(String.class).isEmpty()){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(voterid.get(i).getValueAs(String.class).toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				buyerDAO.updateBuyerDocuments(buyerDocumentsList);
				System.out.println("Primary ID:"+buyer.getIsPrimary());
				if(buyer.getIsPrimary()) {
					primaryBuyer = buyer;
				}
				
				i++;	
			}
		}
		return msg;
	}
	@POST
	@Path("/update/doc")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuyerUploadDoc (
			@FormDataParam("buyer_id") int buyer_id,
			@FormDataParam("doc_name[]") List<FormDataBodyPart> doc_name,
			@FormDataParam("doc_url[]") List<FormDataBodyPart> doc_url
			){
		 Buyer buyer = null;
		 Buyer primaryBuyer = new Buyer();
		 BuyerDAO buyerDAO = new BuyerDAO();
		 ResponseMessage resp = new ResponseMessage();
		 if(buyer_id > 0){
			 buyer = new Buyer();
			 buyer.setId(buyer_id);
		 }
		 if(buyer.getIsPrimary())
			 primaryBuyer = buyer;
		try {
			List<BuyerUploadDocuments> buyerUploadDocuments = new ArrayList<BuyerUploadDocuments>();
			int i = 0;
			for(FormDataBodyPart title : doc_name)
			{
				BuyerUploadDocuments buDocuments = new BuyerUploadDocuments();
				if(doc_url.get(i).getFormDataContentDisposition().getFileName() != null && !doc_url.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
					String gallery_name = doc_url.get(i).getFormDataContentDisposition().getFileName();
					long millis = System.currentTimeMillis() % 1000;
					gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
					gallery_name = "images/project/buyer/docs/"+gallery_name;
					String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
					this.imageUploader.writeToFile(doc_url.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
					buDocuments.setDocUrl(gallery_name);
					buDocuments.setBuyer(primaryBuyer);
					buDocuments.setName(doc_name.get(i).getValueAs(String.class).toString());
					buDocuments.setBuilderdoc(true);
					buDocuments.setUploadedDate(new Date());
				}
				buyerUploadDocuments.add(buDocuments);
			}
			resp = buyerDAO.updateBuyerUploadDocuments(buyerUploadDocuments);
		} catch(Exception e) {
			buyer.setPhoto("");
		}
		return resp;
	}

	
	@POST
	@Path("/payment/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuyerPayment(
			@FormDataParam("buyer_id") int buyer_id,
			@FormDataParam("schedule[]") List<FormDataBodyPart> schedule,
			@FormDataParam("payable[]") List<FormDataBodyPart> payable,
			@FormDataParam("amount[]") List<FormDataBodyPart> amount
			) {
		Buyer buyer = null;
		Buyer primaryBuyer = new Buyer();
		BuyerDAO buyerDAO = new BuyerDAO();
		ResponseMessage resp = new ResponseMessage();
		  if(buyer_id > 0){
			  buyer = new Buyer();
			  buyer.setId(buyer_id);
		  }
		  if(buyer.getIsPrimary()){
			  primaryBuyer = buyer;
		  }
		  if (schedule.size() > 0) {
				List<BuyerPayment> buyerPayments = new ArrayList<BuyerPayment>();
				int i = 0;
				for(FormDataBodyPart milestone : schedule)
				{
					if(milestone.getValueAs(String.class).toString() != null && !milestone.getValueAs(String.class).toString().isEmpty()) {
						boolean isPaid = false;
						BuyerPayment buyerPayment = new BuyerPayment();
						buyerPayment.setMilestone(milestone.getValueAs(String.class).toString());
						buyerPayment.setNetPayable(payable.get(i).getValueAs(Double.class));
						buyerPayment.setAmount(amount.get(i).getValueAs(Double.class));
						buyerPayment.setPaid(isPaid);
						buyerPayment.setBuyer(primaryBuyer);
						buyerPayments.add(buyerPayment);
					}
					i++;
				}
				if(buyerPayments.size() > 0) {
					resp = buyerDAO.updateBuyerPayments(buyerPayments);
				}
	  }
		  return resp;
 }
	
	@POST
	@Path("/offer/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuyerOffer(
			@FormDataParam("buyer_id") int buyer_id,
			@FormDataParam("offer_title[]") List<FormDataBodyPart> offer_title,
			@FormDataParam("discount[]") List<FormDataBodyPart> discount,
			@FormDataParam("discount_amount[]") List<FormDataBodyPart> discount_amount,
			@FormDataParam("applicable_on[]") List<FormDataBodyPart> applicable_on,
			@FormDataParam("apply[]") List<FormDataBodyPart> apply
			) {
			Buyer buyer = new Buyer();
			Buyer primaryBuyer = new Buyer();
			BuyerDAO buyerDAO = new BuyerDAO();
			ResponseMessage resp = new ResponseMessage();
			if(buyer_id > 0)
				buyer.setId(buyer_id);
			if(buyer.getIsPrimary())
				primaryBuyer = buyer;
			List<BuyerOffer> buyerOfferList = new ArrayList<BuyerOffer>();
			if (offer_title.size() > 0) {
				List<BuyerOffer> buyerOffers = new ArrayList<BuyerOffer>();
				int i = 0;
				for(FormDataBodyPart title : offer_title)
				{
					if(title.getValueAs(String.class).toString() != null && !title.getValueAs(String.class).toString().isEmpty()) {
						BuyerOffer buyerOffer = new BuyerOffer();
						buyerOffer.setTitle(title.getValueAs(String.class).toString());
						buyerOffer.setOfferAmount(discount_amount.get(i).getValueAs(Double.class));
						buyerOffer.setOfferPercentage(discount.get(i).getValueAs(Double.class));
						buyerOffer.setApplicable(applicable_on.get(i).getValueAs(Byte.class));
						buyerOffer.setStatus(apply.get(i).getValueAs(Byte.class));
						buyerOffer.setBuyer(primaryBuyer);
						buyerOffers.add(buyerOffer);
					}
					i++;
				}
				if(buyerOffers.size() > 0) {
					resp=buyerDAO.updateBuyerOffers(buyerOffers);
				//	buyerDAO.saveBuyerOffers(buyerOffers);
				}
			} 
			return resp;
	}
	@POST
	@Path("/update/price")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuyerPrice (
			@FormDataParam("buyer_id") int buyer_id,
			@FormDataParam("booking_date") String booking_date,
			@FormDataParam("base_rate") Double base_rate,
			@FormDataParam("rise_rate") Double rise_rate,
			@FormDataParam("amenity_rate") Double amenity_rate,
			@FormDataParam("maintenance") Double maintenance,
			@FormDataParam("tenure") Integer tenure,
			@FormDataParam("registration") Double registration,
			@FormDataParam("parking") Double parking,
			@FormDataParam("stamp_duty") Double stamp_duty,
			@FormDataParam("tax") Double tax,
			@FormDataParam("vat") Double vat
	){
		ResponseMessage msg = new ResponseMessage();
		BuyerDAO buyerDAO = new BuyerDAO();
		
		Buyer buyer = new Buyer();
		Buyer primaryBuyer = new Buyer();
		
			if(buyer_id>0){
				buyer.setId(buyer_id);
			}
			if(buyer.getIsPrimary()) {
				primaryBuyer = buyer;
			}
			if(primaryBuyer.getId() > 0) {
				SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
				Date bookingDate = null;
				try {
					bookingDate = format.parse(booking_date);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				BuyingDetails buyingDetails = new BuyingDetails();
				buyingDetails.setBuyer(primaryBuyer);
				buyingDetails.setAmenityFacingRate(amenity_rate);
				buyingDetails.setBaseRate(base_rate);
				buyingDetails.setBookingDate(bookingDate);
				buyingDetails.setFloorRiseRate(rise_rate);
				buyingDetails.setMaintenance(maintenance);
				buyingDetails.setParkingRate(parking);
				buyingDetails.setRegistration(registration);
				buyingDetails.setStampDuty(stamp_duty);
				buyingDetails.setTaxes(tax);
				buyingDetails.setTenure(tenure);
				buyingDetails.setVat(vat);
				msg = buyerDAO.updateBuyingDetails(buyingDetails);
			}
		return msg;
		}

	
	@GET
	@Path("/project/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectData> getProjectList(@QueryParam("builder_id") int builder_id) {
		BuyerDAO buyerDAO = new BuyerDAO();
		return buyerDAO.getProjectByBuilderId(builder_id);
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
	
	