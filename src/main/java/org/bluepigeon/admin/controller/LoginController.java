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

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.*;
import org.bluepigeon.admin.service.ServiceLoginValidate;
@Path("validate")
public class LoginController {

	
	AdminUser uregistration;
	ServiceLoginValidate serviceLoginValidate;
	
	@Context 
	HttpServletRequest req;
	HttpServletResponse response;
	HttpSession session;
	
	
//	@SuppressWarnings("restriction")
	@POST
	@Path("/info")
	@Produces(MediaType.APPLICATION_JSON)
	public ResponseMessage getJson(@FormParam("email") String email,@FormParam("password") String password)//, @FormParam("cityid") int cityid)
//	public Registration getJson(@Context HttpServletRequest req)
	{
		ResponseMessage registration = new ResponseMessage();
		String email1 =req.getParameter("email");
		String password2 = req.getParameter("password");
		System.out.println("email in controller : "+email1);
		System.out.println("password in controller : "+password2);
		
		uregistration = new AdminUser();
		uregistration.setEmail(email);
		uregistration.setPassword(password);
		
		serviceLoginValidate = new ServiceLoginValidate();
		session = req.getSession();
		
		registration =  serviceLoginValidate.isValidUser(uregistration);
		
		//if(registration.getStatus()!=0 || registration.getErrorMessage().getErrorState() == 8)
		//{
			session = req.getSession();
			session.setAttribute("uname", registration.getData());
			//session.setAttribute("cityid", cityid);
			System.out.println("Hi from controller");
		//}	
			return registration;	
	}

	@POST
	@Path("/activate")
	public int activateAccount(@FormParam("id") int id,@FormParam("password") String password)
	{
		AdminUser registration = new AdminUser();
		uregistration = new AdminUser();
		uregistration.setId(id);
		uregistration.setPassword(password);
		System.out.println("in controller : "+password);
		serviceLoginValidate = new ServiceLoginValidate();
		int validate = serviceLoginValidate.isActivateAccount(uregistration);
		return validate;
		
	}
	@GET
	@Path("/logout")
	public Response logout()
	{
		java.net.URI location = null;
		try
		{
		location = new java.net.URI("../index.jsp");
		session = req.getSession(false);
		if(session != null)
		{
			session.invalidate();
			return Response.temporaryRedirect(location).build();
		}
		else
		{
			return Response.temporaryRedirect(location).build();
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return Response.temporaryRedirect(location).build();
			
		}
		
	}
	
}
