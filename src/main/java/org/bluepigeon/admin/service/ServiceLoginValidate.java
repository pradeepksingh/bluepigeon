package org.bluepigeon.admin.service;

import java.util.List;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.*;

import org.bluepigeon.admin.dao.LoginValidationImp;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.Builder;

public class ServiceLoginValidate implements ServiceLoginDAO {
	Builder ubuilder;
	AdminUser uregistration;
	public ResponseMessage isValidUser(AdminUser registration) {
		ResponseMessage response = new ResponseMessage();
		try
		{
		if(registration.getEmail().trim().length()<=0 && registration.getPassword().trim().length()<=0)
		{
			response.setStatus(2);
			response.setMessage("Please Enter your email id and password");
			
			return response;
		}
		else if(registration.getEmail().trim().length()<=0)
		{
			response.setStatus(2);
			response.setMessage("Please enter your email id");
			return response;
		}
		else if(registration.getPassword().trim().length()<=0)
		{
			response.setStatus(2);
			response.setMessage("Please enter your password");
			return response;
		}
		else 
		{
			LoginValidationImp loginValidationImp = new LoginValidationImp();
			if(loginValidationImp.isValidEmailId(registration.getEmail()))
			{
				List<AdminUser> emailList = loginValidationImp.getAdminUserByEmail(registration.getEmail());
				if(emailList.size() > 0)
				{
					uregistration = new AdminUser();
					uregistration = emailList.get(0);
					if(uregistration.getPassword().equals(registration.getPassword()))
					{
						System.out.println("DB PASS:"+uregistration.getPassword());
						System.out.println("Input PASS: "+registration.getPassword());
						if(uregistration.getStatus()==1)
						{
							response.setStatus(1);
							response.setMessage("loggedIn");
							response.setData(uregistration);
							return response;
						}
						else if(uregistration.getStatus()==0)
						{
							response.setStatus(0);
							response.setMessage("loggedIn");
							response.setData(uregistration);
							return response;
						}
					}
					else
					{
						uregistration = new AdminUser();
						uregistration.setStatus(2);
						response.setStatus(2);
						response.setMessage("Invalid password");
						response.setData(uregistration);
						return response;
					}
				} else {
					uregistration = new AdminUser();
					uregistration.setStatus(2);
					response.setStatus(2);
					response.setMessage("Please enter your valid email id");
					response.setData(uregistration);
					return response;
				}
			} else if (loginValidationImp.isValidPassword(registration.getPassword())) {
				uregistration = new AdminUser();
				uregistration.setStatus(2);
				response.setStatus(2);
				response.setMessage("Please enter your valid email id");
				response.setData(uregistration);
				return response;
			} else {
			
				uregistration = new AdminUser();
				uregistration.setStatus(2);
				response.setStatus(2);
				response.setMessage("Invalid user id and password");
				response.setData(uregistration);
				return response;
			}
		
		}
		}
		catch(NullPointerException e)
		{
			System.out.println(e);
			e.printStackTrace();
		}
		return response;
	}
 
	public int isActivateAccount(AdminUser registration)
	{
		LoginValidationImp loginValidationImp = new LoginValidationImp();	
		return loginValidationImp.activateAccount(registration);
	}
	
	public ResponseMessage isValidBuilder(Builder registration) {
		ResponseMessage response = new ResponseMessage();
		try
		{
		if(registration.getEmail().trim().length()<=0 && registration.getPassword().trim().length()<=0)
		{
			response.setStatus(2);
			response.setMessage("Please Enter your email id and password");
			
			return response;
		}
		else if(registration.getEmail().trim().length()<=0)
		{
			response.setStatus(2);
			response.setMessage("Please enter your email id");
			return response;
		}
		else if(registration.getPassword().trim().length()<=0)
		{
			response.setStatus(2);
			response.setMessage("Please enter your password");
			return response;
		}
		else 
		{
			LoginValidationImp loginValidationImp = new LoginValidationImp();
			if(loginValidationImp.isValidBuilderEmailId(registration.getEmail()))
			{
				List<Builder> emailList = loginValidationImp.getBuilderByEmail(registration.getEmail());
				if(emailList.size() > 0)
				{
					ubuilder = new Builder();
					ubuilder = emailList.get(0);
					if(ubuilder.getPassword().equals(registration.getPassword()))
					{
						System.out.println("DB PASS:"+ubuilder.getPassword());
						System.out.println("Input PASS: "+registration.getPassword());
						if(ubuilder.getLoginStatus()==1)
						{
							response.setStatus(1);
							response.setMessage("loggedIn");
							response.setData(ubuilder);
							return response;
						}
						else if(ubuilder.getLoginStatus()==0)
						{
							response.setStatus(0);
							response.setMessage("loggedIn");
							response.setData(ubuilder);
							return response;
						}
					}
					else
					{
						ubuilder = new Builder();
						ubuilder.setLoginStatus(2);
						response.setStatus(2);
						response.setMessage("Invalid password");
						response.setData(ubuilder);
						return response;
					}
				} else {
					ubuilder = new Builder();
					ubuilder.setLoginStatus(2);
					response.setStatus(2);
					response.setMessage("Please enter your valid email id");
					response.setData(ubuilder);
					return response;
				}
			} else if (loginValidationImp.isValidBuilderPassword(registration.getPassword())) {
				ubuilder = new Builder();
				ubuilder.setLoginStatus(2);
				response.setStatus(2);
				response.setMessage("Please enter your valid email id");
				response.setData(ubuilder);
				return response;
			} else {
			
				ubuilder = new Builder();
				ubuilder.setLoginStatus(2);
				response.setStatus(2);
				response.setMessage("Invalid user id and password");
				response.setData(ubuilder);
				return response;
			}
		
		}
		}
		catch(NullPointerException e)
		{
			System.out.println(e);
			e.printStackTrace();
		}
		return response;
	}
	public int isActivateBuilderAccount(Builder registration)
	{
		LoginValidationImp loginValidationImp = new LoginValidationImp();	
		return loginValidationImp.activateBuilderAccount(registration);
	}
	
}
