package org.bluepigeon.admin.controller;

import java.util.Date;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Named;
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
import org.bluepigeon.admin.dao.BuilderProjectPriceInfoDAO;
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
import org.bluepigeon.admin.data.ProjectData;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.Agreement;
import org.bluepigeon.admin.model.AgreementBuyer;
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
//import org.bluepigeon.admin.model.GlobalBuyer;
import org.bluepigeon.admin.model.Possession;
import org.bluepigeon.admin.model.PossessionBuyer;
import org.bluepigeon.admin.model.PossessionInfo;
import org.bluepigeon.admin.service.ImageUploader;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

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
		List<Buyer> buyerList = new ArrayList<Buyer>();
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
				}else{
					project_id =  new ProjectDAO().getBuildingFlatById(flat_id).get(0).getBuilderFloor().getBuilderBuilding().getBuilderProject().getId();
					BuilderProject builderProject = new BuilderProject();
					builderProject.setId(project_id);
					buyer.setBuilderProject(builderProject);
				}
				
			//	int building_id = new ProjectDAO().getBuildingFlatById(flat_id).get(0).getBuilderFloor().getBuilderBuilding().getId();
				if(building_id > 0){
					BuilderBuilding builderBuilding = new BuilderBuilding();
					builderBuilding.setId(building_id);
					buyer.setBuilderBuilding(builderBuilding);
				}else{
					 building_id = new ProjectDAO().getBuildingFlatById(flat_id).get(0).getBuilderFloor().getBuilderBuilding().getId();
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
			if(schedule != null){
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
	
	
	/********************************************************new code for saving buyer's data***********************/
	/**
	 * @author pankaj
	 * @param emp_id
	 * @param name
	 * @param contact
	 * @param email
	 * @param pan
	 * @param address
	 * @param is_primary
	 * @param photos
	 * @param douments
	 * @param aadhar
	 * @param passport
	 * @param rra
	 * @param voterid
	 * @param builder_id
	 * @param project_id
	 * @param building_id
	 * @param flat_id
	 * @param booking_date
	 * @param base_rate
	 * @param rise_rate
	 * @param amenity_rate
	 * @param maintenance
	 * @param tenure
	 * @param registration
	 * @param parking
	 * @param stamp_duty
	 * @param tax
	 * @param vat
	 * @param offer_title
	 * @param discount
	 * @param discount_amount
	 * @param applicable_on
	 * @param apply
	 * @param schedule
	 * @param payable
	 * @param amount
	 * @param doc_name
	 * @param doc_url
	 * @return
	 */
	@POST
	@Path("/save/new")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addNewBuyerInfoNew (
			@FormDataParam("admin_id") int emp_id,
			@FormDataParam("buyer_name[]") List<FormDataBodyPart>  name,
			@FormDataParam("contact[]") List<FormDataBodyPart>  contact,
			@FormDataParam("email[]") List<FormDataBodyPart>  email,
			@FormDataParam("pan[]") List<FormDataBodyPart>  pan,
			@FormDataParam("address[]") List<FormDataBodyPart>  address,
			@FormDataParam("current_address[]") List<FormDataBodyPart> currentAddress,
			@FormDataParam("refferal_id[]") List<FormDataBodyPart> refferalIds,
			@FormDataParam("aadhaar_no[]") List<FormDataBodyPart> aadhaarNumber,
			@FormDataParam("is_primary[]") List<FormDataBodyPart>  is_primary,
			@FormDataParam("photo[]") List<FormDataBodyPart>  photos,
			@FormDataParam("document_pan[]") List<FormDataBodyPart> douments,
			@FormDataParam("document_aadhar[]") List<FormDataBodyPart> aadhar,
			@FormDataParam("document_passport[]") List<FormDataBodyPart> passport,
			//@FormDataParam("document_rra[]") List<FormDataBodyPart> rra,
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
			//@FormDataParam("offer_title[]") List<FormDataBodyPart> offer_title,
			//@FormDataParam("discount[]") List<FormDataBodyPart> discount,
			//@FormDataParam("discount_amount[]") List<FormDataBodyPart> discount_amount,
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
		List<Buyer> buyerList = new ArrayList<Buyer>();
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
				}else{
					project_id =  new ProjectDAO().getBuildingFlatById(flat_id).get(0).getBuilderFloor().getBuilderBuilding().getBuilderProject().getId();
					BuilderProject builderProject = new BuilderProject();
					builderProject.setId(project_id);
					buyer.setBuilderProject(builderProject);
				}
				
			//	int building_id = new ProjectDAO().getBuildingFlatById(flat_id).get(0).getBuilderFloor().getBuilderBuilding().getId();
				if(building_id > 0){
					BuilderBuilding builderBuilding = new BuilderBuilding();
					builderBuilding.setId(building_id);
					buyer.setBuilderBuilding(builderBuilding);
				}else{
					 building_id = new ProjectDAO().getBuildingFlatById(flat_id).get(0).getBuilderFloor().getBuilderBuilding().getId();
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
//				List<BuyerDocuments> buyerDocumentsList = new ArrayList<BuyerDocuments>();
//				if(douments != null && douments.size() > 0) {
//					if(douments.get(i).getValueAs(String.class).toString()!=null && !douments.get(i).getValueAs(String.class).isEmpty()){
//						BuyerDocuments buyerDocuments = new BuyerDocuments();
//						buyerDocuments.setDocuments(douments.get(i).getValueAs(String.class).toString());
//						buyerDocuments.setBuyer(buyer);
//						buyerDocumentsList.add(buyerDocuments);
//					}
//				}
//				if(aadhar != null && aadhar.size() > 0) {
//					if(aadhar.get(i).getValueAs(String.class).toString()!=null && !aadhar.get(i).getValueAs(String.class).isEmpty()){
//						BuyerDocuments buyerDocuments = new BuyerDocuments();
//						buyerDocuments.setDocuments(aadhar.get(i).getValueAs(String.class).toString());
//						buyerDocuments.setBuyer(buyer);
//						buyerDocumentsList.add(buyerDocuments);
//					}
//				}
//				if(passport != null && passport.size() > 0) {
//					if(passport.get(i).getValueAs(String.class).toString()!=null && !passport.get(i).getValueAs(String.class).isEmpty()){
//						BuyerDocuments buyerDocuments = new BuyerDocuments();
//						buyerDocuments.setDocuments(passport.get(i).getValueAs(String.class).toString());
//						buyerDocuments.setBuyer(buyer);
//						buyerDocumentsList.add(buyerDocuments);
//					}
//				}
//				if(rra != null && rra.size() > 0) {
//					if(rra.get(i).getValueAs(String.class).toString()!=null && !rra.get(i).getValueAs(String.class).isEmpty()){
//						BuyerDocuments buyerDocuments = new BuyerDocuments();
//						buyerDocuments.setDocuments(rra.get(i).getValueAs(String.class).toString());
//						buyerDocuments.setBuyer(buyer);
//						buyerDocumentsList.add(buyerDocuments);
//					}
//				}
//				if(voterid != null && voterid.size() > 0) {
//					if(voterid.get(i).getValueAs(String.class).toString()!=null && !voterid.get(i).getValueAs(String.class).isEmpty()){
//						BuyerDocuments buyerDocuments = new BuyerDocuments();
//						buyerDocuments.setDocuments(voterid.get(i).getValueAs(String.class).toString());
//						buyerDocuments.setBuyer(buyer);
//						buyerDocumentsList.add(buyerDocuments);
//					}
//				}
//				buyerDAO.saveBuyerDocuments(buyerDocumentsList);
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
			if(schedule != null){
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
			}
			
//			if (offer_title.size() > 0) {
//				List<BuyerOffer> buyerOffers = new ArrayList<BuyerOffer>();
//				i = 0;
//				for(FormDataBodyPart title : offer_title)
//				{
//					if(title.getValueAs(String.class).toString() != null && !title.getValueAs(String.class).toString().isEmpty()) {
//						BuyerOffer buyerOffer = new BuyerOffer();
//						buyerOffer.setTitle(title.getValueAs(String.class).toString());
//						buyerOffer.setOfferAmount(discount_amount.get(i).getValueAs(Double.class));
//						buyerOffer.setOfferPercentage(discount.get(i).getValueAs(Double.class));
//						buyerOffer.setApplicable(applicable_on.get(i).getValueAs(Byte.class));
//						buyerOffer.setStatus(apply.get(i).getValueAs(Byte.class));
//						buyerOffer.setBuyer(primaryBuyer);
//						buyerOffers.add(buyerOffer);
//					}
//					i++;
//				}
//				if(buyerOffers.size() > 0) {
//					buyerDAO.saveBuyerOffers(buyerOffers);
//				}
//			}
//			try {
//				List<BuyerUploadDocuments> buyerUploadDocuments = new ArrayList<BuyerUploadDocuments>();
//				i = 0;
//				for(FormDataBodyPart title : offer_title)
//				{
//					BuyerUploadDocuments buDocuments = new BuyerUploadDocuments();
//					if(doc_url.get(i).getFormDataContentDisposition().getFileName() != null && !doc_url.get(i).getFormDataContentDisposition().getFileName().isEmpty()) {
//						String gallery_name = doc_url.get(i).getFormDataContentDisposition().getFileName();
//						long millis = System.currentTimeMillis() % 1000;
//						gallery_name = Long.toString(millis) + gallery_name.replaceAll(" ", "_").toLowerCase();
//						gallery_name = "images/project/buyer/docs/"+gallery_name;
//						String uploadGalleryLocation = this.context.getInitParameter("building_image_url")+gallery_name;
//						this.imageUploader.writeToFile(photos.get(i).getValueAs(InputStream.class), uploadGalleryLocation);
//						buDocuments.setDocUrl(gallery_name);
//						buDocuments.setBuyer(primaryBuyer);
//						buDocuments.setName(doc_name.get(i).getValueAs(String.class).toString());
//						buDocuments.setBuilderdoc(true);
//						buDocuments.setUploadedDate(new Date());
//					}
//					buyerUploadDocuments.add(buDocuments);
//				}
//				buyerDAO.saveBuyerUploadDouments(buyerUploadDocuments);
//			} catch(Exception e) {
//				buyer.setPhoto("");
//			}
		}
		return msg;
	}
	
	@POST
	@Path("/update/basic")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuyerInfoNew (
			@FormDataParam("buyer_id[]") List<FormDataBodyPart> buyer_id,
			@FormDataParam("buyer_name[]") List<FormDataBodyPart>  name,
			@FormDataParam("contact[]") List<FormDataBodyPart>  contact,
			@FormDataParam("email[]") List<FormDataBodyPart>  email,
			@FormDataParam("pan[]") List<FormDataBodyPart>  pan,
			@FormDataParam("address[]") List<FormDataBodyPart>  address,
			@FormDataParam("is_primary[]") List<FormDataBodyPart>  is_primary,
			@FormDataParam("photo[]") List<FormDataBodyPart>  photos,
			@FormDataParam("doc_pan") String docs,
			@FormDataParam("doc_aadhar") String aadhar,
			@FormDataParam("doc_rra") String rra,
			@FormDataParam("doc_passport") String passport,
			@FormDataParam("doc_voterid") String voterid,
			@FormDataParam("builder_id") int builder_id,
			@FormDataParam("project_id") int project_id,
			@FormDataParam("building_id") int building_id,
			@FormDataParam("flat_id") int flat_id,
			@FormDataParam("employee_id") int employee_id
	){
		ResponseMessage msg = new ResponseMessage();
		BuyerDAO buyerDAO = new BuyerDAO();
		BuilderEmployee builderEmployee = new BuilderEmployee();
		builderEmployee.setId(employee_id);
		Short agreement=0;
		Short possession=0;
		Buyer buyer = null;
		//GlobalBuyer globalBuyer = new GlobalBuyer();
		Buyer primaryBuyer = new Buyer();
		if(name.size()>0){
			int i=0;
			String[] doc_pan = docs.split(",");
			String[] doc_aadhar = aadhar.split(",");
			String[] doc_passport = passport.split(",");
			String[] doc_rra = rra.split(",");
			String[] doc_voterid = voterid.split(",");
			for(FormDataBodyPart buyers : name){
				buyer = new Buyer();
				buyer.setBuilderEmployee(builderEmployee);
				buyer.setAgreement(agreement);
				buyer.setPossession(possession);
				if(buyer_id.get(i).getValueAs(Integer.class).intValue() != 0) {
					buyer.setId(buyer_id.get(i).getValueAs(Integer.class).intValue());
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
					System.out.println("Buyer name :: "+name.get(i).getValueAs(String.class).toString());
					buyer.setName(name.get(i).getValueAs(String.class).toString());
				}
				if(contact.get(i).getValueAs(String.class).toString()!=null && !contact.get(i).getValueAs(String.class).isEmpty()) {
					System.out.println("Buyer contact :: "+contact.get(i).getValueAs(String.class).toString());
					buyer.setMobile(contact.get(i).getValueAs(String.class).toString());
				}
				buyer.setEmail(email.get(i).getValueAs(String.class).toString());
				if(address.get(i).getValueAs(String.class).toString()!=null && !address.get(i).getValueAs(String.class).isEmpty()){
					System.out.println("Buyer email :: "+email.get(i).getValueAs(String.class).toString());
					buyer.setAddress(address.get(i).getValueAs(String.class).toString());
				}
				if(pan.get(i).getValueAs(String.class).toString()!=null && !pan.get(i).getValueAs(String.class).isEmpty()){
					System.out.println("Buyer pan :: "+pan.get(i).getValueAs(String.class).toString());
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
					} else {
						buyer.setPhoto("");
					}
				} catch(Exception e) {
					buyer.setPhoto("");
				}
				msg = buyerDAO.updateBuyer(buyer);
				buyer.setId(msg.getId());
				List<BuyerDocuments> buyerDocumentsList = new ArrayList<BuyerDocuments>();
				if(docs != "") {
					if(doc_pan[i].toString().equals("1") ){
						System.out.println("System doc:"+doc_pan[i]);
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(doc_pan[i].toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				if(aadhar != "") {
					if(doc_aadhar[i].toString().equals("2") ){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(doc_aadhar[i].toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				if(passport != "") {
					if(doc_passport[i].toString().equals("3") ){
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(doc_passport[i].toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				if(rra != "") {
					if(doc_rra[i].toString().equals("4") ){
						System.out.println("System doc:"+doc_rra[i]);
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(doc_rra[i].toString());
						buyerDocuments.setBuyer(buyer);
						buyerDocumentsList.add(buyerDocuments);
					}
				}
				
				if(voterid != "") {
					if(doc_voterid[i].toString().equals("5") ){
						System.out.println("System doc:"+doc_voterid[i]);
						BuyerDocuments buyerDocuments = new BuyerDocuments();
						buyerDocuments.setDocuments(doc_voterid[i].toString());
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
	@Path("/update/flat")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuyerFlat (
			@FormParam("old_flat_id") int old_flat_id,
			@FormParam("project_id") int project_id,
			@FormParam("building_id") int building_id,
			@FormParam("flat_id") int flat_id,
			@FormParam("employee_id") int employee_id
	){
		ResponseMessage msg = new ResponseMessage();
		BuilderProject builderProject = new BuilderProject();
		builderProject.setId(project_id);
		BuilderBuilding builderBuilding = new BuilderBuilding();
		builderBuilding.setId(building_id);
		BuilderFlat builderFlat = new BuilderFlat();
		builderFlat.setId(flat_id);
		BuilderEmployee builderEmployee = new BuilderEmployee();
		builderEmployee.setId(employee_id);
		BuyerDAO buyerDAO = new BuyerDAO();
		buyerDAO.changeFlatStatus(1, old_flat_id);
		List<Buyer> buyers = buyerDAO.getFlatBuyersByFlatId(old_flat_id);
		for(Buyer buyer :buyers) {
			buyer.setBuilderProject(builderProject);
			buyer.setBuilderBuilding(builderBuilding);
			buyer.setBuilderFlat(builderFlat);
			buyer.setBuilderEmployee(builderEmployee);
			msg = buyerDAO.updateBuyer(buyer);
		}
		return msg;
	}
	
	
	@POST
	@Path("/update/doc")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuyerUploadDoc (
			@FormDataParam("buyer_id") int buyer_id,
			@FormDataParam("doc_id[]") List<FormDataBodyPart> doc_id,
			@FormDataParam("doc_name[]") List<FormDataBodyPart> doc_name,
			@FormDataParam("doc_url[]") List<FormDataBodyPart> doc_url
	){
			ResponseMessage resp = new ResponseMessage();
		 Buyer primaryBuyer = new Buyer();
		 BuyerDAO buyerDAO = new BuyerDAO();
		 if(buyer_id > 0){
			 primaryBuyer.setId(buyer_id);
		 }
			 
		try {
			List<BuyerUploadDocuments> buyerUploadDocuments = new ArrayList<BuyerUploadDocuments>();
			List<BuyerUploadDocuments> newbuyerUploadDocuments = new ArrayList<BuyerUploadDocuments>();
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
					if(doc_id.get(i).getValueAs(Integer.class) != 0) {
						buDocuments.setId(doc_id.get(i).getValueAs(Integer.class));
					}
					buDocuments.setName(doc_name.get(i).getValueAs(String.class).toString());
					buDocuments.setBuilderdoc(true);
					buDocuments.setUploadedDate(new Date());
					if(doc_id.get(i).getValueAs(Integer.class) != 0) {
						buyerUploadDocuments.add(buDocuments);
					} else {
						newbuyerUploadDocuments.add(buDocuments);
					}
				}
				i++;
			}
			if(buyerUploadDocuments.size() > 0) {
				resp = buyerDAO.updateBuyerUploadDocuments(buyerUploadDocuments);
			}
			if(newbuyerUploadDocuments.size() > 0) {
				resp = buyerDAO.saveBuyerUploadDouments(newbuyerUploadDocuments);
			}
		} catch(Exception e) {
			//exception
			resp.setStatus(0);
		}
		return resp;
	}
	
	@POST
	@Path("/payment/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuyerPayment(
			@FormDataParam("buyer_id") int buyer_id,
			@FormDataParam("payment_id[]") List<FormDataBodyPart> payment_id,
			@FormDataParam("schedule[]") List<FormDataBodyPart> schedule,
			@FormDataParam("payable[]") List<FormDataBodyPart> payable,
			@FormDataParam("amount[]") List<FormDataBodyPart> amount
			) {
		Buyer buyer =new BuyerDAO().getBuyerById(buyer_id);
		Buyer primaryBuyer = new Buyer();
		BuyerDAO buyerDAO = new BuyerDAO();
		ResponseMessage resp = new ResponseMessage();
		  if(buyer_id > 0){
			  buyer.setId(buyer_id);
		  }
		  if(buyer.getIsPrimary()){
			  primaryBuyer = buyer;
		  }
		  if (schedule.size() > 0) {
				List<BuyerPayment> updateBuyerPayments = new ArrayList<BuyerPayment>();
				List<BuyerPayment> newBuyerPayments = new ArrayList<BuyerPayment>();
				int i = 0;
				for(FormDataBodyPart milestone : schedule)
				{
					if(milestone.getValueAs(String.class).toString() != null && !milestone.getValueAs(String.class).toString().isEmpty()) {
						if(payment_id.get(i).getValueAs(Integer.class) != 0){
							if(payment_id.get(i).getValueAs(Integer.class) != null && payment_id.get(i).getValueAs(Integer.class) !=0) {
								boolean isPaid = false;
								BuyerPayment buyerPayment = new BuyerPayment();
								buyerPayment.setId(payment_id.get(i).getValueAs(Integer.class));
								buyerPayment.setMilestone(milestone.getValueAs(String.class).toString());
								buyerPayment.setNetPayable(payable.get(i).getValueAs(Double.class));
								buyerPayment.setAmount(amount.get(i).getValueAs(Double.class));
								buyerPayment.setPaid(isPaid);
								buyerPayment.setBuyer(primaryBuyer);
								updateBuyerPayments.add(buyerPayment);
						}
						}else{
								boolean isPaid = false;
								BuyerPayment buyerPayment = new BuyerPayment();
								buyerPayment.setMilestone(milestone.getValueAs(String.class).toString());
								buyerPayment.setNetPayable(payable.get(i).getValueAs(Double.class));
								buyerPayment.setAmount(amount.get(i).getValueAs(Double.class));
								buyerPayment.setPaid(isPaid);
								buyerPayment.setBuyer(primaryBuyer);
								newBuyerPayments.add(buyerPayment);
					}
					}
					i++;
				
				}
				if(updateBuyerPayments.size() > 0) {
					buyerDAO.updateBuyerPayments(updateBuyerPayments);
				}
				if(newBuyerPayments.size() > 0){
					buyerDAO.saveBuyerPayment(newBuyerPayments);
				}
				resp.setStatus(1);
				resp.setMessage("Buyer payment updated successfully.");
	  }
		  return resp;
 }
	
	@POST
	@Path("/offer/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuyerOffer(
			@FormDataParam("buyer_id") int buyer_id,
			@FormDataParam("offer_id[]") List<FormDataBodyPart> offer_id,
			@FormDataParam("offer_title[]") List<FormDataBodyPart> offer_title,
			@FormDataParam("discount[]") List<FormDataBodyPart> discount,
			@FormDataParam("discount_amount[]") List<FormDataBodyPart> discount_amount,
			@FormDataParam("applicable_on[]") List<FormDataBodyPart> applicable_on,
			@FormDataParam("description[]") List<FormDataBodyPart> description,
			@FormDataParam("apply[]") List<FormDataBodyPart> apply
			) {
			Buyer buyer = new BuyerDAO().getBuyerById(buyer_id);
			Buyer primaryBuyer = new Buyer();
			BuyerDAO buyerDAO = new BuyerDAO();
			ResponseMessage resp = new ResponseMessage();
			if(buyer_id > 0)
				buyer.setId(buyer_id);
			if(buyer.getIsPrimary())
				primaryBuyer = buyer;
			if (offer_title.size() > 0) {
				List<BuyerOffer> updateBuyerOffers = new ArrayList<BuyerOffer>();
				List<BuyerOffer> addBuyerOffers = new ArrayList<BuyerOffer>();
				int i = 0;
				for(FormDataBodyPart title : offer_title)
				{
					if(title.getValueAs(String.class).toString() != null && !title.getValueAs(String.class).toString().isEmpty()) {
						if(offer_id!=null){
						if( offer_id.get(i).getValueAs(Integer.class) != 0 && offer_id.get(i).getValueAs(Integer.class) != null) {
							BuyerOffer buyerOffer = new BuyerOffer();
							buyerOffer.setId(offer_id.get(i).getValueAs(Integer.class) );
							buyerOffer.setTitle(title.getValueAs(String.class).toString());
							buyerOffer.setDescription(description.get(i).getValueAs(String.class).toString());
							buyerOffer.setOfferAmount(discount_amount.get(i).getValueAs(Double.class));
							buyerOffer.setOfferPercentage(discount.get(i).getValueAs(Double.class));
							buyerOffer.setApplicable(applicable_on.get(i).getValueAs(Byte.class));
							buyerOffer.setStatus(apply.get(i).getValueAs(Byte.class));
							buyerOffer.setBuyer(primaryBuyer);
							updateBuyerOffers.add(buyerOffer);
						}}else{
							BuyerOffer buyerOffer = new BuyerOffer();
							buyerOffer.setTitle(title.getValueAs(String.class).toString());
							buyerOffer.setDescription(description.get(i).getValueAs(String.class).toString());
							buyerOffer.setOfferAmount(discount_amount.get(i).getValueAs(Double.class));
							buyerOffer.setOfferPercentage(discount.get(i).getValueAs(Double.class));
							buyerOffer.setApplicable(applicable_on.get(i).getValueAs(Byte.class));
							buyerOffer.setStatus(apply.get(i).getValueAs(Byte.class));
							buyerOffer.setBuyer(primaryBuyer);
							addBuyerOffers.add(buyerOffer);
						}
				}
					i++;
			}
				if(updateBuyerOffers.size() > 0) {
					resp=buyerDAO.updateBuyerOffers(updateBuyerOffers);
					
				}
				if(addBuyerOffers.size() > 0){
					buyerDAO.saveBuyerOffers(addBuyerOffers);
				}
				resp.setStatus(1);
				resp.setMessage("Buyer Offers updated successfully");
			} else{
				resp.setStatus(0);
				resp.setMessage("Failed to update Buyer Offers");
			}
			return resp;
	}
	@POST
	@Path("/update/price")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuyerPrice (
			@FormParam("id") int id,
			@FormParam("buyer_id") int buyer_id,
			@FormParam("booking_date") String booking_date,
			@FormParam("base_rate") Double base_rate,
			@FormParam("rise_rate") Double rise_rate,
			@FormParam("amenity_rate") Double amenity_rate,
			@FormParam("maintenance") Double maintenance,
			@FormParam("tenure") Integer tenure,
			@FormParam("registration") Double registration,
			@FormParam("parking") Double parking,
			@FormParam("stamp_duty") Double stamp_duty,
			@FormParam("tax") Double tax,
			@FormParam("vat") Double vat
	){
		ResponseMessage msg = new ResponseMessage();
		BuyerDAO buyerDAO = new BuyerDAO();
		System.out.println("Buyer Id :: "+buyer_id);
		Buyer buyer =null;
		Buyer primaryBuyer = new Buyer();
	     buyer = buyerDAO.getBuyerById(buyer_id);
			if(buyer_id>0){
				buyer.setId(buyer_id);
			}
			System.err.println("Buyer is primary ? "+buyer.getIsPrimary());
			System.err.println("Primary Buyer ?");
			if(buyer.getIsPrimary()) {
				System.out.println("Yes");
				primaryBuyer = buyer;
				primaryBuyer.setId(buyer.getId());
			}
			System.out.println("No");
			if(primaryBuyer.getId() > 0) {
				SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
				Date bookingDate = null;
				try {
					bookingDate = format.parse(booking_date);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				BuyingDetails buyingDetails = new BuyingDetails();
				buyingDetails.setId(id);
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
	
	@POST
	@Path("/update/pricenoffer")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage updateBuyerPriceAndOffer (
			@FormDataParam("id") int id,
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
			@FormDataParam("vat") Double vat,
			@FormDataParam("offer_id[]") List<FormDataBodyPart> offer_id,
			@FormDataParam("offer_title[]") List<FormDataBodyPart> offer_title,
			@FormDataParam("discount[]") List<FormDataBodyPart> discount,
			@FormDataParam("discount_amount[]") List<FormDataBodyPart> discount_amount,
			@FormDataParam("applicable_on[]") List<FormDataBodyPart> applicable_on,
			@FormDataParam("apply[]") List<FormDataBodyPart> apply,
			@FormDataParam("description[]") List<FormDataBodyPart> description
	){
		ResponseMessage msg = new ResponseMessage();
		BuyerDAO buyerDAO = new BuyerDAO();
		System.out.println("Buyer Id :: "+buyer_id);
		Buyer buyer =null;
		Buyer primaryBuyer = new Buyer();
	     buyer = buyerDAO.getBuyerById(buyer_id);
			if(buyer_id>0){
				buyer.setId(buyer_id);
			}
			System.err.println("Buyer is primary ? "+buyer.getIsPrimary());
			System.err.println("Primary Buyer ?");
			if(buyer.getIsPrimary()) {
				System.out.println("Yes");
				primaryBuyer = buyer;
				primaryBuyer.setId(buyer.getId());
			}
			System.out.println("No");
			if(primaryBuyer.getId() > 0) {
				SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
				Date bookingDate = null;
				try {
					bookingDate = format.parse(booking_date);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				BuyingDetails buyingDetails = new BuyingDetails();
				buyingDetails.setId(id);
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
			if (offer_title.size() > 0) {
				List<BuyerOffer> updateBuyerOffers = new ArrayList<BuyerOffer>();
				List<BuyerOffer> addBuyerOffers = new ArrayList<BuyerOffer>();
				int i = 0;
				for(FormDataBodyPart title : offer_title)
				{
					if(title.getValueAs(String.class).toString() != null && !title.getValueAs(String.class).toString().isEmpty()) {
						if(offer_id.get(i).getValueAs(Integer.class) != null){
						if( offer_id.get(i).getValueAs(Integer.class) != 0 && offer_id.get(i).getValueAs(Integer.class) != null) {
							BuyerOffer buyerOffer = new BuyerOffer();
							buyerOffer.setId(offer_id.get(i).getValueAs(Integer.class) );
							buyerOffer.setTitle(title.getValueAs(String.class).toString());
							buyerOffer.setDescription(description.get(i).getValueAs(String.class).toString());
							buyerOffer.setOfferAmount(discount_amount.get(i).getValueAs(Double.class));
							buyerOffer.setOfferPercentage(discount.get(i).getValueAs(Double.class));
							buyerOffer.setApplicable(applicable_on.get(i).getValueAs(Byte.class));
							buyerOffer.setStatus(apply.get(i).getValueAs(Byte.class));
							buyerOffer.setBuyer(primaryBuyer);
							updateBuyerOffers.add(buyerOffer);
						}}else{
							BuyerOffer buyerOffer = new BuyerOffer();
							buyerOffer.setTitle(title.getValueAs(String.class).toString());
							buyerOffer.setDescription(description.get(i).getValueAs(String.class).toString());
							buyerOffer.setOfferAmount(discount_amount.get(i).getValueAs(Double.class));
							buyerOffer.setOfferPercentage(discount.get(i).getValueAs(Double.class));
							buyerOffer.setApplicable(applicable_on.get(i).getValueAs(Byte.class));
							buyerOffer.setStatus(apply.get(i).getValueAs(Byte.class));
							buyerOffer.setBuyer(primaryBuyer);
							addBuyerOffers.add(buyerOffer);
						}
					}
					i++;
				}
				if(updateBuyerOffers.size() > 0) {
					msg=buyerDAO.updateBuyerOffers(updateBuyerOffers);
					
				}
				if(addBuyerOffers.size() > 0){
					buyerDAO.saveBuyerOffers(addBuyerOffers);
				}
				msg.setStatus(1);
				msg.setMessage("Buyer pricing updated successfully");
			}
		return msg;
	}
	
	@GET
	@Path("/delete/coowner/{buyer_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteCoOwner(@PathParam("buyer_id") int buyer_id) {
		BuyerDAO buyerDAO = new BuyerDAO();
		return buyerDAO.deleteSecondaryBuyerById(buyer_id);
	}
	
	@GET
	@Path("/project/list")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ProjectData> getProjectList(@PathParam("builder_id") int builder_id) {
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
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addAgeement(
			@FormDataParam("project_id") int projectId,
			@FormDataParam("building_id") int buildingId,
			@FormDataParam("floor_id") int floorId,
			@FormDataParam("flat_id") int flatId,
			@FormDataParam("owner_name") String name,
			@FormDataParam("contact") String contact,
			@FormDataParam("email") String email,
			@FormDataParam("remind") String remind,
			@FormDataParam("content") String content,
			@FormDataParam("select_date") String last_date,
			@FormDataParam("buyer_name[]") List<FormDataBodyPart> buyer_names
			)throws DocumentException, IOException, FileNotFoundException {
		ResponseMessage responseMessage = new ResponseMessage();
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
		
		responseMessage = new AgreementDAO().saveAgreement(agreement);
		if(responseMessage.getId() > 0){
			List<AgreementBuyer> agreementBuyerList = new ArrayList<AgreementBuyer>();
			agreement.setId(responseMessage.getId());
			if(buyer_names.size()>0){
				Buyer buyerDetails = null;
				for(FormDataBodyPart buyers : buyer_names){
					if(buyers.getValueAs(Integer.class).toString() != null && !buyers.getValueAs(Integer.class).toString().isEmpty()) {
						AgreementBuyer agreementBuyer = new AgreementBuyer();
						agreementBuyer.setAgreement(agreement);
						Buyer buyer = new Buyer();
						buyer.setId(buyers.getValueAs(Integer.class));
						buyerDetails = new BuyerDAO().getBuyerById(buyer.getId());
						agreementBuyer.setBuyer(buyer);
						agreementBuyerList.add(agreementBuyer);
						String name1 = buyerDetails.getName();
						String name_url = name1.replaceAll(" ", "-").toLowerCase();
						final String RESULT = this.context.getInitParameter("building_image_url")+"images/project/buyer/agreement/"+buyerDetails.getBuilderProject().getName()+"-"+buyerDetails.getId()+"-"+name_url+".pdf";
						createAgreementPdf(RESULT, agreement, buyerDetails);
					}
				}
				if(agreementBuyerList.size()>0){
					AgreementDAO agreementDAO = new AgreementDAO();
					responseMessage=agreementDAO.saveAgreementBuyer(agreementBuyerList);
				}
			}
		}
		return responseMessage;
	}
	/**
	 * Create pdf file for agreement.
	 * @param fileName
	 * @param agreement
	 * @param buyer
	 * @throws DocumentException
	 * @throws IOException
	 */
	public void createAgreementPdf(String fileName, Agreement agreement, Buyer buyer) throws DocumentException, IOException, FileNotFoundException{
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date date =agreement.getLastDate();
		String p1="(a)	Subject to applicable legislation and, where such legislation does not exist or apply, in accordance with such prescribed regulations or industry practice respecting holdback percentages and in accordance with the provisions of the General Conditions of the Contract, the Owner shall:";
		String p2 = "(1)  make monthly payments to the Contractor on account of the Contract Price.  The amounts of such payments shall be as certified by the Engineer/Architect; and ";
		String p3 = "(2)  upon Substantial Performance of the work as certified by the Engineer/Architect pay to the contractor any unpaid balance of holdback monies then due; and ";
		String p4 = "(3)  upon Total Performance of the Work as certified by the Engineer/Architect pay to the contractor any unpaid balance of the Contract Price then due.";
		String p5 ="(b)	If the Owner fails to make payments to the Contractor as they become due under the terms of this Contract or in any award by a court, interest at the rate and in the manner specified in GC21-Certificates and Payments, shall become due and payable until payment.  Such interest shall be calculated and added to any unpaid amounts monthly.";
		Document document = new Document();
		PdfWriter.getInstance(document, new FileOutputStream(fileName));
		document.open();
		document.add(new Paragraph("Project Name : "+buyer.getBuilderProject().getName()));
		document.add(new Paragraph("Building : "+buyer.getBuilderBuilding().getName()));
		document.add(new Paragraph("Flat No : "+buyer.getBuilderFlat().getFlatNo()));
		document.add(new Paragraph("Agreement Date : "+dateFormat.format(date)));
		document.add(new Paragraph("Buyer Name "+buyer.getName()));
		document.add(new Paragraph("Buyer Contact "+buyer.getMobile()));
		document.add(new Paragraph("PAYMENT"));
		document.add(new Paragraph(p1));
		document.add(new Paragraph(p2));
		document.add(new Paragraph(p3));
		document.add(new Paragraph(p4));
		document.add(new Paragraph(p5));
		if(agreement.getContent()!=null)
			document.add(new Paragraph("Content "+agreement.getContent()));
		document.close();
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
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public ResponseMessage addPossession(
			@FormDataParam("project_id") int projectId,
			@FormDataParam("building_id") int buildingId,
			@FormDataParam("floor_id") int floorId,
			@FormDataParam("flat_id") int flatId,
			@FormDataParam("name") String name,
			@FormDataParam("contact") String contact,
			@FormDataParam("email") String email,
			@FormDataParam("remind") String remind,
			@FormDataParam("content") String content,
			@FormDataParam("possession_date") String last_date,
			@FormDataParam("buyer_name[]")List<FormDataBodyPart> buyer_names) throws DocumentException, IOException{
		SimpleDateFormat format = new SimpleDateFormat("dd MMM yyyy");
		ResponseMessage responseMessage = new ResponseMessage();
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
		responseMessage=new PossessionDAO().savePossession(possession);
		if(responseMessage.getId()>0){
			List<PossessionBuyer> possessionBuyerList = new ArrayList<PossessionBuyer>();
			possession.setId(responseMessage.getId());
			if(buyer_names.size()>0 || buyer_names != null ){
				Buyer buyerDetails = null;
				for(FormDataBodyPart buyers : buyer_names){
					if(buyers.getValueAs(Integer.class).toString() != null && !buyers.getValueAs(Integer.class).toString().isEmpty()) {
						PossessionBuyer possessionBuyer = new PossessionBuyer();
						possessionBuyer.setPossession(possession);
						Buyer buyer = new Buyer();
						buyer.setId(buyers.getValueAs(Integer.class));
						buyerDetails = new BuyerDAO().getBuyerById(buyer.getId());
						possessionBuyer.setBuyer(buyer);
						possessionBuyerList.add(possessionBuyer);
						String name1 = buyerDetails.getName();
						String name_url = name1.replaceAll(" ", "-").toLowerCase();
						final String RESULT = this.context.getInitParameter("building_image_url")+"images/project/buyer/possession/"+buyerDetails.getBuilderProject().getName()+"-"+buyerDetails.getId()+"-"+name_url+".pdf";
						createPossessionPdf(RESULT, possession, buyerDetails);
					}
				}
				if(possessionBuyerList.size()>0){
					PossessionDAO possessionDAO = new PossessionDAO();
					responseMessage=possessionDAO.savePossessionBuyer(possessionBuyerList);
					
				}
			}
		}
		return responseMessage;
	}
	/**
	 * Create pdf file for possession
	 * @param fileName
	 * @param possession
	 * @param buyer
	 * @throws DocumentException
	 * @throws IOException
	 */
	public void createPossessionPdf(String fileName, Possession possession, Buyer buyer) throws DocumentException, IOException{
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date date =possession.getLastDate();
		String p1="Possession Letter";
		String p2="The General Manager/Project Manager,";
		String p3="Sub: Handing over of flats in ";
		String p4="Shri/Smt/Ms. "+buyer.getName()+" who has been allotted flat no "+buyer.getBuilderFlat().getFlatNo()+"in "+buyer.getBuilderProject().getName()+" has made full"+
				   "payment. All documents required from the allottee have also been received. The allottee may please be handed over his/her dwelling unit.";
		String p5="2. The allottee has furnished Undertaking in the prescribed proforma.";
		String p6="3. It may be noted by the Allottee that the possession of the Dwelling Unit can be given only to the Allottee or Co-Allottee/Co-Owner and not to his representative or holder of General Power of Attorney.";
		String p7="4. Alllottee has not obtained /obtained loan through IRWO from ...................................................";
		String p8="5. Handing Over/Taking Over Certificate should be prepared in triplicate – 1 st copy (original) will be issued to the allottee concerned in case no loan is outstanding against him/her. 2 nd copy"+
				  "(duplicate) is required to be placed in the personal file of the allottee and the 3 rd copy (office copy) may be kept in the Project Office for their record. In case allottee has obtained loan"+
				  "through IRWO, both the copies (original as well as duplicate) shall be kept in the personal file of the allottee. The original copy will be given to the allottee only when the loan against him/her is cleared.";
		String p9="6. It may be ensured that the Handing Over / Taking Over Certificate is signed by the allottee before the dwelling unit is handed over.";
		String p10="7. Photographs of the Allottee and the Co-Allottee (where applicable) are affixed above for identification.";
		String p11= "Copy forwarded to Shri/Smt/Ms ..........................................................................................................."+
					 ".....................................................................................................................................................................";
		Document document = new Document();
		PdfWriter.getInstance(document, new FileOutputStream(fileName));
		document.open();
		document.add(new Paragraph(p1));
		document.add(new Paragraph(""));
		document.add(new Paragraph(p2));
		document.add(new Paragraph(buyer.getBuilderProject().getName()));
		document.add(new Paragraph("IRWO"));
		document.add(new Paragraph(""));
		document.add(new Paragraph(p3+buyer.getBuilderProject().getName()));
		document.add(new Paragraph(p4));
		document.add(new Paragraph(""));
		document.add(new Paragraph(p5));
		document.add(new Paragraph(""));
		document.add(new Paragraph(p6));
		document.add(new Paragraph(""));
		document.add(new Paragraph(p7));
		document.add(new Paragraph(""));
		document.add(new Paragraph(p8));
		document.add(new Paragraph(""));
		document.add(new Paragraph(p9));
		document.add(new Paragraph(""));
		document.add(new Paragraph(p10));
		document.add(new Paragraph(""));
		document.add(new Paragraph("For IRWO"));
		document.add(new Paragraph(""));
		document.add(new Paragraph(""));
		document.add(new Paragraph(""));
		document.add(new Paragraph(p11));
	
//		document.add(new Paragraph("Project Name : "+buyer.getBuilderProject().getName()));
//		document.add(new Paragraph("Building : "+buyer.getBuilderBuilding().getName()));
//		document.add(new Paragraph("Flat No : "+buyer.getBuilderFlat().getFlatNo()));
//		document.add(new Paragraph("Possession Date : "+dateFormat.format(date)));
//		document.add(new Paragraph("Buyer Name "+buyer.getName()));
//		document.add(new Paragraph("Buyer Contact "+buyer.getMobile()));
//		if(possession.getContent()!=null)
//			document.add(new Paragraph("Content "+possession.getContent()));
		document.close();
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
	
	@GET
	@Path("/offer/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuildingOfferInfo(@PathParam("id") int id) {
		ResponseMessage msg = new ResponseMessage();
		BuyerDAO buyerDAO = new BuyerDAO();
		msg = buyerDAO.deleteBuyerOfferInfo(id);
		return msg;
	}
	
	@GET
	@Path("/payment/delete/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage deleteBuildingPaymentInfo(@PathParam("id") int id) {
		ResponseMessage msg = new ResponseMessage();
		BuyerDAO buyerDAO = new BuyerDAO();
		msg = buyerDAO.deleteBuyerPaymentById(id);
		return msg;
	}
	
	@POST
	@Path("/sale")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage getTotalSaleValue(
			@FormParam("project_id") int projectId,
			@FormParam("base_rate") Double base_rate,
			@FormParam("rise_rate") Double rise_rate,
			@FormParam("amenity_rate") Double amenity_rate,
			@FormParam("parking") Double parking,
			@FormParam("maintenance") Double maintenance,
			@FormParam("stamp_duty") Double stamp_duty,
			@FormParam("tax") Double tax,
			@FormParam("vat") Double vat,
			@FormParam("no_of_floors") int noOfFloors 
			){
		ResponseMessage responseMessage = new ResponseMessage();
		Double totalSaleValue = 0.0;
		Double cost = 0.0, B = 0.0, C = 0.0, D = 0.0, E = 0.0, F = 0.0, G = 0.0;
		Double superBuildUpArea = new BuilderProjectPriceInfoDAO().getBuilderFlatTypeByProjectId(projectId).getSuperBuiltupArea();
		Double sqft = new BuilderProjectPriceInfoDAO().getBuilderProjectPriceInfo(projectId).getAreaUnit().getSqft_value();
		cost = base_rate * superBuildUpArea * sqft ; 
		if(noOfFloors > 0)
			B = rise_rate * superBuildUpArea * sqft ;
		if(maintenance > 0)
			C = maintenance;
		if(amenity_rate  > 0)
			D = amenity_rate;
		if(parking > 0)
			E = parking;
		F = cost+B+D;
		G = F*stamp_duty/100+F * tax/100+F * vat/100;
		totalSaleValue = F+C+E+G;
		responseMessage.setMessage(totalSaleValue.toString());
		return responseMessage;
	}
	
	@GET
	@Path("/flat/payments/{flat_id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<FlatData> getFlatPayment(@PathParam("flat_id") int flat_id) {
		return new BuyerDAO().getBuilderProjectBuildingFlats(flat_id);
	}
}
	
	