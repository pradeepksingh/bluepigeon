package org.bluepigeon.admin.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "demand_letters", catalog = "blue_pigeon")
public class DemandLetters implements java.io.Serializable {

	private Integer id;
	//private BuilderFloor builderFloor;
	private BuilderBuilding builderBuilding;
	private BuilderFlat builderFlat;
	private BuilderProject builderProject;
	private String name;
	private String email;
	private String contact;
	private Integer paymentId;
	private Date lastDate;
	private String remind;
	private String content;
	public DemandLetters() {
	}

	public DemandLetters(//BuilderFloor builderFloor,
			BuilderBuilding builderBuilding, BuilderFlat builderFlat,
			BuilderProject builderProject, String name, String email, String contact, Integer paymentId, Date lastDate,
			String remind, String content) {
		//this.builderFloor = builderFloor;
		this.builderBuilding = builderBuilding;
		this.builderFlat = builderFlat;
		this.builderProject = builderProject;
		this.name = name;
		this.email = email;
		this.contact = contact;
		this.paymentId = paymentId;
		this.lastDate = lastDate;
		this.remind = remind;
		this.content = content;
	}



	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

//	@ManyToOne(fetch = FetchType.LAZY)
//	@JoinColumn(name = "floor_id")
//	public BuilderFloor getBuilderFloor() {
//		return this.builderFloor;
//	}
//
//	public void setBuilderFloor(BuilderFloor builderFloor) {
//		this.builderFloor = builderFloor;
//	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "building_id")
	public BuilderBuilding getBuilderBuilding() {
		return this.builderBuilding;
	}

	public void setBuilderBuilding(BuilderBuilding builderBuilding) {
		this.builderBuilding = builderBuilding;
	}

	

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "flat_id")
	public BuilderFlat getBuilderFlat() {
		return this.builderFlat;
	}

	public void setBuilderFlat(BuilderFlat builderFlat) {
		this.builderFlat = builderFlat;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "project_id")
	public BuilderProject getBuilderProject() {
		return this.builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "email", length = 225)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "contact", length = 128)
	public String getContact() {
		return this.contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}
	@Column(name = "payment_id")
	public Integer getPaymentId() {
		return this.paymentId;
	}

	public void setPaymentId(Integer paymentId) {
		this.paymentId = paymentId;
	}
	@Temporal(TemporalType.DATE)
	@Column(name = "last_date", length = 10)
	public Date getLastDate() {
		return this.lastDate;
	}

	public void setLastDate(Date lastDate) {
		this.lastDate = lastDate;
	}

	@Column(name = "remind", length = 128)
	public String getRemind() {
		return this.remind;
	}

	public void setRemind(String remind) {
		this.remind = remind;
	}

	@Column(name = "content", length = 65535)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
