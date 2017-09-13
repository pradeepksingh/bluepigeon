package org.bluepigeon.admin.model;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "inbox_message", catalog = "blue_pigeon")
public class InboxMessage {
	private Integer id;
	private Buyer buyer;
	private Integer empId;
	private BuilderProject builderProject;
	private String message;
	private String attachment;
	private String subject;
	private Date imDate;
	
	
	public InboxMessage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public InboxMessage(Integer id, Buyer buyer, Integer empId, BuilderProject builderProject, String message,
			String attachment, String subject, Date imDate) {
		super();
		this.id = id;
		this.buyer = buyer;
		this.empId = empId;
		this.builderProject = builderProject;
		this.message = message;
		this.attachment = attachment;
		this.subject = subject;
		this.imDate = imDate;
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
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="buyer_id")
	public Buyer getBuyer() {
		return buyer;
	}
	public void setBuyer(Buyer buyer) {
		this.buyer = buyer;
	}
	@Column(name = "emp_id")
	public Integer getEmpId() {
		return empId;
	}
	public void setEmpId(Integer empId) {
		this.empId = empId;
	}
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "project_id")
	public BuilderProject getBuilderProject() {
		return builderProject;
	}
	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
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
	@Column(name = "im_date")
	 @Temporal(TemporalType.TIMESTAMP)
	public Date getImDate() {
		return imDate;
	}
	public void setImDate(Date imDate) {
		this.imDate = imDate;
	}
}
