package org.bluepigeon.admin.model;

public class ErrorMessages {

	private int errorState;
	 private String errormsg;
	 
	 
	public ErrorMessages() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ErrorMessages(int errorState, String errormsg) {
		super();
		this.errorState = errorState;
		this.errormsg = errormsg;
	}

	public int getErrorState() {
		return errorState;
	}
	public void setErrorState(int errorState) {
		this.errorState = errorState;
	}
	public String getErrormsg() {
		return errormsg;
	}
	public void setErrormsg(String errormsg) {
		this.errormsg = errormsg;
	}

	@Override
	public String toString() {
		return "ErrorMessages [errorState=" + errorState + ", errormsg="
				+ errormsg + "]";
	}
	 
}
