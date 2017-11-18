package org.bluepigeon.admin.controller;
import javax.servlet.http.*;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.bluepigeon.admin.dao.BuilderDetailsDAO;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.*;
import org.bluepigeon.admin.service.BuilderLoginValidate;
import org.bluepigeon.admin.service.ServiceLoginValidate;
@Path("validatebuilder")
public class BuilderLoginController {
	BuilderEmployee ubuilder;
	BuilderLoginValidate serviceLoginValidate;
	
	@Context 
	HttpServletRequest req;
	HttpServletResponse response;
	HttpSession session;
	
	@POST
	@Path("/builder")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage validateBuilder(@FormParam("email") String email,@FormParam("password") String password)//, @FormParam("cityid") int cityid)
//	public Registration getJson(@Context HttpServletRequest req)
	{
		ResponseMessage registration = new ResponseMessage();
		System.out.println("email in controller : "+email);
		System.out.println("password in controller : "+password);
		
		ubuilder = new BuilderEmployee();
		ubuilder.setEmail(email);
		ubuilder.setPassword(password);
		
		serviceLoginValidate = new BuilderLoginValidate();
		session = req.getSession();
		
		registration =  serviceLoginValidate.isValidBuilder(ubuilder);
		
		//if(registration.getStatus()!=0 || registration.getErrorMessage().getErrorState() == 8)
		//{
			session = req.getSession();
			session.setAttribute("ubname", registration.getData());
			//session.setAttribute("cityid", cityid);
			System.out.println("Hi from controller");
		//}	
			return registration;	
	}
	
	@POST
	@Path("/builder/switch")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage validateBuilderSwitch(@FormParam("access_id") int access_id)//, @FormParam("cityid") int cityid)
//	public Registration getJson(@Context HttpServletRequest req)
	{
		ResponseMessage registration = new ResponseMessage();
		
			session = req.getSession();
			session.getAttribute("ubname");
			BuilderEmployee builder = new BuilderEmployee();
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			BuilderEmployeeAccessType builderEmployeeAccessType = new BuilderEmployeeAccessType();
			builderEmployeeAccessType.setId(access_id);
			builder.setBuilderEmployeeAccessType(builderEmployeeAccessType);
			//session.setAttribute("cityid", cityid);
			System.out.println("Hi from controller");
			session.setAttribute("ubname", builder);
			registration.setStatus(1);
			return registration;	
	}

	@POST
	@Path("/activate/builder")
	public int activateBuilderAccount(@FormParam("id") int id,@FormParam("password") String password)
	{
		BuilderEmployee registration = new BuilderEmployee();
		ubuilder = new BuilderEmployee();
		ubuilder.setId(id);
		ubuilder.setPassword(password);
		System.out.println("in controller : "+password);
		serviceLoginValidate = new BuilderLoginValidate();
		int validate = serviceLoginValidate.isActivateBuilderAccount(ubuilder);
		return validate;
		
	}
	
	@GET
	@Path("/logoutbuilder")
	public Response logoutBuilder()
	{
		java.net.URI location1 = null;
		try
		{
		location1 = new java.net.URI("../builder/index.jsp");
		session = req.getSession(false);
		if(session != null)
		{
			session.invalidate();
			return Response.temporaryRedirect(location1).build();
		}
		else
		{
			return Response.temporaryRedirect(location1).build();
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return Response.temporaryRedirect(location1).build();
			
		}
	}
	@POST
	@Path("/builder/password")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage updateBuilderPassword(@FormParam("oldpassword") String oldPassword,@FormParam("password") String password){
		System.out.println("Input password :: "+oldPassword);
		BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
		return builderDetailsDAO.updateBuilderPassword(oldPassword,password);
	}
	
	@POST
	@Path("/builder/email")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage getRegisteredEmailId(@FormParam("emailid") String emailid){
		BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
		return builderDetailsDAO.getRegisteredEmailId(emailid);
	}
	
	@POST
	@Path("/builder/contact")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage getRegisteredMobileNumber(@FormParam("contactno") String contact){
		BuilderDetailsDAO builderDetailsDAO = new BuilderDetailsDAO();
		return builderDetailsDAO.getRegisteredMobileNumber(contact);
	}
}
