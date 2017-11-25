package org.bluepigeon.admin.api;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.print.attribute.standard.DateTimeAtCompleted;
import javax.servlet.ServletContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.tomcat.jni.Time;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.glassfish.jersey.media.multipart.MultiPartFeature;
import org.glassfish.jersey.server.ResourceConfig;

import com.google.gson.Gson;

import org.bluepigeon.admin.dao.BuilderDetailsDAO;
import org.bluepigeon.admin.dao.BuyerDAO;
import org.bluepigeon.admin.dao.ProjectAPIDAO;
import org.bluepigeon.admin.data.CompletionList;
import org.bluepigeon.admin.data.CompletionStatus;
import org.bluepigeon.admin.data.ContactUs;
import org.bluepigeon.admin.data.ProjectAPI;
import org.bluepigeon.admin.data.ProjectAddress;
import org.bluepigeon.admin.data.ProjectCount;
import org.bluepigeon.admin.data.Projects;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.GlobalBuyer;

@Path("api1.0/bp/")
public class GeneralController extends ResourceConfig {
	@Context ServletContext context;
	GlobalBuyer globalBuyer=new GlobalBuyer();
	public GeneralController() {
		register(MultiPartFeature.class);
    }
	
	@POST
	@Path("signup.json")
	@Produces(MediaType.APPLICATION_JSON)
//	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseMessage signupUser(
			@FormParam("pancard") String pancard
			){
		ResponseMessage responseMessage = new ResponseMessage();
		String characters = "0123456789";
		String otp = RandomStringUtils.random( 6, characters );
		globalBuyer.setPancard(pancard);
		globalBuyer.setOtp(otp);
		responseMessage = new BuyerDAO().isUserExist(globalBuyer);
		return responseMessage;
	}
	
	@POST
	@Path("login.json")
	@Produces(MediaType.APPLICATION_JSON)
	public String loginUser(@FormParam("pancard") String pancard,
			@FormParam("password") String password){
		Gson gson = new Gson();
		String json = "";
		json = new BuyerDAO().validateBuyer(pancard,password);
	
			Projects projects = gson.fromJson(json, Projects.class);
			if(projects != null && projects.getId() > 0){
				if(projects.getBuyerImage()!=null){
					projects.setBuyerImage(context.getInitParameter("api_url")+projects.getBuyerImage());
				}else{
					projects.setBuyerImage("");
				}
				if(projects.getImage()!=null){
					projects.setImage(context.getInitParameter("api_url")+projects.getImage());
				}else{
					projects.setImage("");
				}
				json = gson.toJson(projects);
				return json;
			}else{
				return json;
			}
		
	}
	
	@POST
	@Path("otp.json")
	@Produces(MediaType.APPLICATION_JSON)
	public String verifyOtp(@FormParam("otp") String otp){
		String json = "";
		Gson gson = new Gson();
		json = new BuyerDAO().validateOtp(otp);
		
			Projects projects = gson.fromJson(json, Projects.class);
			if(projects != null && projects.getId()>0){
				if(projects.getBuyerImage()!=null){
					projects.setBuyerImage(context.getInitParameter("api_url")+projects.getBuyerImage());
				}else{
					projects.setBuyerImage("");
				}
				if(projects.getImage()!=null){
					projects.setImage(context.getInitParameter("api_url")+projects.getImage());
				}else{
					projects.setImage("");
				}
				json = gson.toJson(projects);
				return json;
			}else{
				return json;
			}
	}
	
	@GET
	@Path("forgotpassword.json/{email}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage retrivePassword(@PathParam("email") String emailId){
		return new BuyerDAO().getForgotPasswod(emailId);
	}
	
	@POST
	@Path("changepassword.json")
	@Produces(MediaType.APPLICATION_JSON)
	public String changePassword(
			@FormParam("pancard") String pancard,
			@FormParam("oldpassword") String oldpassword, 
			@FormParam("newpassword") String newpassword){
		String responseMessage = new String();
		responseMessage = new BuyerDAO().userChangePassword(pancard, oldpassword, newpassword);
		return responseMessage;
	}
	
	@POST
	@Path("accountsettings.json")
	@Produces(MediaType.APPLICATION_JSON)
	public String getBuyerDetails(@FormParam("accountotp") String otp){
		String response = new String();
		response = new BuyerDAO().getBuyerAccountDetailsByPancard(otp);
		return response;
	}
	
	@POST
	@Path("updateaccount.json")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuyerAccount(@FormParam("pancard") String pancard,
			@FormParam("name") String name,
			@FormParam("email") String email,
			@FormParam("contactno") String contactNumber,
			@FormParam("aadhaar") String aadhaarnumber,
			@FormParam("address") String address
			){
		ResponseMessage responseMessage =  new BuyerDAO().updateBuyerAccount(pancard,name,email,contactNumber,aadhaarnumber,address);
		return responseMessage;
	}
	
	
	@POST
	@Path("project")
	@Produces(MediaType.APPLICATION_JSON)
	public String getProjectdetails(@FormParam("pancard") String pancard){
		String response = new String();
		response = new BuyerDAO().getProjectDetails(pancard);
		return response;
	}
	
	@POST
	@Path("buildings")
	@Produces(MediaType.APPLICATION_JSON)
	public String getBuildingdetails(@FormParam("pancard") String pancard){
		String response = new String();
		response = new BuyerDAO().getBuildingDetails(pancard);
		return response;
	}
	
	@GET
	@Path("contactus.json/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ContactUs getClassInfoDetails(@PathParam("id") int id)
	{
		ContactUs contactUs = new BuilderDetailsDAO().getContactDetails(id);
		ContactUs result = new ContactUs();
		result.setEmail(contactUs.getEmail());
		result.setImage(context.getInitParameter("api_url")+contactUs.getImage());
		result.setMobile(contactUs.getMobile());
		
		return result;
	}
	
	@GET 
	@Path("projectaddress.json/{pancard}")
	@Produces(MediaType.APPLICATION_JSON)
	public Projects getProjectAddress(@PathParam("pancard") String pancard){
		Projects projects = new ProjectAPIDAO().getProjectAddresses(pancard);
		projects.setImage(context.getInitParameter("api_url")+projects.getImage());
		return projects;
	}
	@GET 
	@Path("projectdetails.json/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ProjectAPI getProjectAddress(@PathParam("id") int id){
		ProjectAPI projectAddresses = new ProjectAPIDAO().getProjectDetails(id);
		projectAddresses.setImage(context.getInitParameter("api_url")+projectAddresses.getImage());
		return projectAddresses;
	}
	
	@GET 
	@Path("projectcount.json/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public ProjectCount getProjectCount(@PathParam("id") int id){
		ProjectCount projectAddresses = new ProjectAPIDAO().getProjectlevelDetails(id);
		return projectAddresses;
	}
	@GET
	@Path("accountotp.json/{pancard}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage getAccountOTP(@PathParam("pancard") String pancard){
		ResponseMessage responseMessage = new ResponseMessage();
		String characters = "0123456789";
		String otp = RandomStringUtils.random( 6, characters );
		globalBuyer.setPancard(pancard);
		globalBuyer.setOtp(otp);
		responseMessage = new BuyerDAO().isUserExist(globalBuyer);
		return responseMessage;
	}
	
	@GET
	@Path("buildinglist.json/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public CompletionList getBuildingList(@PathParam("id") int projectId){
		CompletionList completionList = new ProjectAPIDAO().getBuildingListByProjcet(projectId);
		List<CompletionStatus> completionStatusList = new ArrayList<>();
		for(CompletionStatus completionStatus: completionList.getCompletionStatus()){
			completionStatus.setImage(context.getInitParameter("api_url")+completionStatus.getImage());
			completionStatusList.add(completionStatus);
		}
		completionList.setCompletionStatus(completionStatusList);
		return completionList;
		
	}
	
	
}
