package org.bluepigeon.admin.model;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "home_loan_banks", catalog = "blue_pigeon")
public class InboxMessage {
	private Integer id;
	private Integer buyerId;
	private Integer empId;
	private Integer projectId;
	private String message;
	private String attachment;
	private String subject;
	
	
	public InboxMessage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public InboxMessage(Integer id, Integer buyerId, Integer empId, Integer projectId, String message,
			String attachment, String subject) {
		super();
		this.id = id;
		this.buyerId = buyerId;
		this.empId = empId;
		this.projectId = projectId;
		this.message = message;
		this.attachment = attachment;
		this.subject = subject;
	}
	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(name="buyer_id")
	public Integer getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(Integer buyerId) {
		this.buyerId = buyerId;
	}
	@Column(name = "emp_id")
	public Integer getEmpId() {
		return empId;
	}
	public void setEmpId(Integer empId) {
		this.empId = empId;
	}
	@Column(name = "project_id")
	public Integer getProjectId() {
		return projectId;
	}
	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}
	@Column(name = "message")
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Column(name = "attachment")
	public String getAttachment() {
		return attachment;
	}
	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}
	@Column(name = "subject")
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
}
