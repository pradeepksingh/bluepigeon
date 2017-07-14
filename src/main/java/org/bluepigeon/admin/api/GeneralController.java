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
import org.bluepigeon.admin.dao.BuyerDAO;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.GlobalBuyer;

@Path("api1.0/post/")
public class GeneralController extends ResourceConfig {
	@Context ServletContext context;
	GlobalBuyer globalBuyer=new GlobalBuyer();
	public GeneralController() {
		register(MultiPartFeature.class);
    }
	
	@POST
	@Path("signup")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseMessage signupUser(
			@FormParam("pancard") String pancard,
			@FormParam("password") String password){
		ResponseMessage responseMessage = new ResponseMessage();
		String characters = "0123456789";
		String otp = RandomStringUtils.random( 6, characters );
		globalBuyer.setPancard(pancard);
		globalBuyer.setPassword(password);
		globalBuyer.setOtp(otp);
		responseMessage = new BuyerDAO().isUserExist(globalBuyer);
		return responseMessage;
	}
	
	@POST
	@Path("login")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage loginUser(@FormParam("pancard") String pancard,
			@FormParam("password") String password){
		ResponseMessage responseMessage = new ResponseMessage();
		GlobalBuyer globalBuyer = new GlobalBuyer();
		globalBuyer.setPancard(pancard);
		globalBuyer.setPassword(password);
		responseMessage = new BuyerDAO().validateBuyer(globalBuyer);
		 return responseMessage;
	}
	
	@POST
	@Path("opt")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage verifyOtp(@FormParam("otp") String otp){
		ResponseMessage responseMessage = new ResponseMessage();
		GlobalBuyer globalBuyer = new GlobalBuyer();
		globalBuyer.setOtp(otp);
		
		return responseMessage;
	}
	
	
	@POST
	@Path("forgotpassword")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage retrivePassword(@FormParam("pancard") String pancard){
		ResponseMessage responseMessage = new ResponseMessage();
		
		
		return responseMessage;
		
		
	}
}
