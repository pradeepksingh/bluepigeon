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

@Entity
@Table(name = "building_amenity_icon", catalog = "blue_pigeon")
public class BuildingAmenityIcon {
	private Integer id;
	private BuilderBuildingAmenity builderBuildingAmenity;
	private String iconUrl;
	
	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "amenity_id")
	public BuilderBuildingAmenity getBuilderBuildingAmenity() {
		return builderBuildingAmenity;
	}
	public void setBuilderBuildingAmenity(BuilderBuildingAmenity builderBuildingAmenity) {
		this.builderBuildingAmenity = builderBuildingAmenity;
	}
	@Column(name = "icon_url", length = 225)
	public String getIconUrl() {
		return iconUrl;
	}
	public void setIconUrl(String iconUrl) {
		this.iconUrl = iconUrl;
	}
}