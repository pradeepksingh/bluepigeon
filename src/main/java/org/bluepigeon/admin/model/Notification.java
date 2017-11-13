package org.bluepigeon.admin.model;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "notification", catalog = "blue_pigeon")
public class Notification {
	private Integer id;
	private String description;
	private Integer buyerId = 0;
	private BuilderProject builderProject;
	private Integer type = 0;
	private Integer assignedBy = 0;
	private Integer assignedTo = 0;
	private boolean isRead = false;
	private Integer flatId=0;
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(name = "description")
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Column(name = "buyer_id")
	public Integer getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(Integer buyerId) {
		this.buyerId = buyerId;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "project_id", nullable = false)
	public BuilderProject getBuilderProject() {
		return builderProject;
	}
	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}
	@Column(name = "type")
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	@Column(name = "assigned_by")
	public Integer getAssignedBy() {
		return assignedBy;
	}
	public void setAssignedBy(Integer assignedBy) {
		this.assignedBy = assignedBy;
	}
	@Column(name = "assigned_to")
	public Integer getAssignedTo() {
		return assignedTo;
	}
	public void setAssignedTo(Integer assignedTo) {
		this.assignedTo = assignedTo;
	}
	@Column(name = "is_read")
	public boolean isRead() {
		return isRead;
	}
	public void setRead(boolean isRead) {
		this.isRead = isRead;
	}
	@Column(name = "flat_id")
	public Integer getFlatId() {
		return flatId;
	}
	public void setFlatId(Integer flatId) {
		this.flatId = flatId;
	}
	
}
