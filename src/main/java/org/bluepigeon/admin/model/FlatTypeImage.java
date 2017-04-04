package org.bluepigeon.admin.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
* FlatType Image generated by hbm2java
*/
@Entity
@Table(name = "flat_type_image", catalog = "blue_pigeon")
public class FlatTypeImage implements java.io.Serializable {

	private Integer id;
	private BuilderFlatType builderFlatType;
	private String image;
	private String title;

	public FlatTypeImage() {
	}

	public FlatTypeImage(BuilderFlatType builderFlatType, String image, String title) {
		this.builderFlatType = builderFlatType;
		this.image = image;
		this.title = title;
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
	@JoinColumn(name = "flat_type_id")
	public BuilderFlatType getBuilderFlatType() {
		return this.builderFlatType;
	}

	public void setBuilderFlatType(BuilderFlatType builderFlatType) {
		this.builderFlatType = builderFlatType;
	}

	@Column(name = "image")
	public String getImage() {
		return this.image;
	}

	public void setImage(String layout) {
		this.image = layout;
	}

	@Column(name = "title", length = 200)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}