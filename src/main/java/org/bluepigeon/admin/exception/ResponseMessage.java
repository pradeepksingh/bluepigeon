package org.bluepigeon.admin.exception;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Map;

public class ResponseMessage {
	
	private int status;
	private String message;
	private Object data;
	private ArrayList<String> errors; 
	private int id;
	
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public ArrayList<String> getErrors() {
		return errors;
	}
	public void setErrors(ArrayList<String> errors) {
		this.errors = errors;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
}
