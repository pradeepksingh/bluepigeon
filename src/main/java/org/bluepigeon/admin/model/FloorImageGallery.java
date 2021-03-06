package org.bluepigeon.admin.model;
// Generated 31 Mar, 2017 11:32:34 AM by Hibernate Tools 4.0.0

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * FloorImageGallery generated by hbm2java
 */
@Entity
@Table(name = "floor_image_gallery", catalog = "blue_pigeon")
public class FloorImageGallery implements java.io.Serializable {

	private Integer id;
	private BuilderFloor builderFloor;
	private String image;
	private float completion;
	private Date createdDate;
	private String title;

	public FloorImageGallery() {
	}

	public FloorImageGallery(BuilderFloor builderFloor, String image) {
		this.builderFloor = builderFloor;
		this.image = image;
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

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "floor_id")
	public BuilderFloor getBuilderFloor() {
		return this.builderFloor;
	}

	public void setBuilderFloor(BuilderFloor builderFloor) {
		this.builderFloor = builderFloor;
	}

	@Column(name = "image")
	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	@Column(name = "completion")
	public float getCompletion() {
		return completion;
	}

	public void setCompletion(float completion) {
		this.completion = completion;
	}
	@Column(name = "created_date", nullable = false, updatable=false)
	@Temporal(TemporalType.TIMESTAMP)
	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
    @Column(name = "title")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
