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
@Table(name = "inbox_message_reply", catalog = "blue_pigeon")
public class InboxMessageReply {
	private Integer id;
	private BuilderEmployee builderEmployee;
	private InboxMessage inboxMessage;
	private String message;
	private String attachment;
	private String subject;
	private byte isReply=0;
	
	public InboxMessageReply() {
		super();
		// TODO Auto-generated constructor stub
	}
	public InboxMessageReply(Integer id, BuilderEmployee builderEmployee, InboxMessage inboxMessage, String message,
			String attachment, String subject) {
		super();
		this.id = id;
		this.builderEmployee = builderEmployee;
		this.inboxMessage = inboxMessage;
		this.message = message;
		this.attachment = attachment;
		this.subject = subject;
		this.builderEmployee = builderEmployee;
		this.inboxMessage = inboxMessage;
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
	@JoinColumn(name = "emp_id")
	public BuilderEmployee getBuilderEmployee() {
		return builderEmployee;
	}
	public void setBuilderEmployee(BuilderEmployee builderEmployee) {
		this.builderEmployee = builderEmployee;
	}
	
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "inbox_id")
	public InboxMessage getInboxMessage() {
		return inboxMessage;
	}
	public void setInboxMessage(InboxMessage inboxMessage) {
		this.inboxMessage = inboxMessage;
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
	public byte getIsReply() {
		return isReply;
	}
	public void setIsReply(byte isReply) {
		this.isReply = isReply;
	}
}
