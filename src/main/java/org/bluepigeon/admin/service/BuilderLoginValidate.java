package org.bluepigeon.admin.service;

import org.bluepigeon.admin.dao.BuilderLoginValidateImp;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.BuilderEmployee;

public class BuilderLoginValidate {
	BuilderEmployee ubuilderEmployee;
	
	public ResponseMessage isValidBuilder(BuilderEmployee registration) {
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
			BuilderLoginValidateImp loginValidationImp = new BuilderLoginValidateImp();
			if(loginValidationImp.isValidBuilderEmailId(registration.getEmail()))
			{
				BuilderEmployee emailList = loginValidationImp.getBuilderByEmail(registration.getEmail());
				if(emailList != null)
				{
					ubuilderEmployee = new BuilderEmployee();
					ubuilderEmployee = emailList;
					System.out.println("Builder Password :::: "+registration.getPassword());
					System.out.println("DB Builder Password :::: "+ubuilderEmployee.getPassword());
					if(ubuilderEmployee.getPassword().equals(registration.getPassword()))
					{
						System.out.println(":::::::::::::::Builder Builder Password ::::::::::");
						System.out.println("DB PASS:"+ubuilderEmployee.getPassword());
						System.out.println("Input PASS: "+registration.getPassword());
						if(ubuilderEmployee.getLoginStatus()==1)
						{
							response.setStatus(1);
							response.setMessage("loggedIn");
							response.setData(ubuilderEmployee);
							return response;
						}
						else if(ubuilderEmployee.getLoginStatus()==0) 
						{
							response.setStatus(0);
							response.setMessage("loggedIn");
							response.setData(ubuilderEmployee);
							return response;
						}
					}
					else
					{
						ubuilderEmployee = new BuilderEmployee();
						ubuilderEmployee.setLoginStatus(2);
						response.setStatus(2);
						response.setMessage("Invalid password");
						response.setData(ubuilderEmployee);
						return response;
					}
				} else {
					ubuilderEmployee = new BuilderEmployee();
					ubuilderEmployee.setLoginStatus(2);
					response.setStatus(2);
					response.setMessage("Please enter your valid email id");
					response.setData(ubuilderEmployee);
					return response;
				}
			} else if (loginValidationImp.isValidBuilderPassword(registration.getPassword())) {
				ubuilderEmployee = new BuilderEmployee();
				ubuilderEmployee.setLoginStatus(2);
				response.setStatus(2);
				response.setMessage("Please enter your valid email id");
				response.setData(ubuilderEmployee);
				return response;
			} else {
			
				ubuilderEmployee = new BuilderEmployee();
				ubuilderEmployee.setLoginStatus(2); 
				response.setStatus(2);
				response.setMessage("Invalid user id and password");
				response.setData(ubuilderEmployee);
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
	public int isActivateBuilderAccount(BuilderEmployee registration)
	{
		BuilderLoginValidateImp loginValidationImp = new BuilderLoginValidateImp();	
		return loginValidationImp.activateBuilderAccount(registration);
	}
}
