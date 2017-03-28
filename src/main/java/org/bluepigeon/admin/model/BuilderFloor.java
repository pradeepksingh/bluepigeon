package org.bluepigeon.admin.model;
// Generated 27 Mar, 2017 5:55:47 PM by Hibernate Tools 4.0.0

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * BuilderFloor generated by hbm2java
 */
@Entity
@Table(name = "builder_floor", catalog = "blue_pigeon")
public class BuilderFloor implements java.io.Serializable {

	private Integer id;
	private BuilderBuilding builderBuilding;
	private BuilderFloorStatus builderFloorStatus;
	private String name;
	private Integer floorNo;
	private Integer totalFloor;
	private Byte status;
	private Set<BuilderFlat> builderFlats = new HashSet<BuilderFlat>(0);

	public BuilderFloor() {
	}

	public BuilderFloor(BuilderBuilding builderBuilding, BuilderFloorStatus builderFloorStatus, String name,
			Integer floorNo, Integer totalFloor, Byte status, Set<BuilderFlat> builderFlats) {
		this.builderBuilding = builderBuilding;
		this.builderFloorStatus = builderFloorStatus;
		this.name = name;
		this.floorNo = floorNo;
		this.totalFloor = totalFloor;
		this.status = status;
		this.builderFlats = builderFlats;
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
	@JoinColumn(name = "building_id")
	public BuilderBuilding getBuilderBuilding() {
		return this.builderBuilding;
	}

	public void setBuilderBuilding(BuilderBuilding builderBuilding) {
		this.builderBuilding = builderBuilding;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "status_id")
	public BuilderFloorStatus getBuilderFloorStatus() {
		return this.builderFloorStatus;
	}

	public void setBuilderFloorStatus(BuilderFloorStatus builderFloorStatus) {
		this.builderFloorStatus = builderFloorStatus;
	}

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "floor_no")
	public Integer getFloorNo() {
		return this.floorNo;
	}

	public void setFloorNo(Integer floorNo) {
		this.floorNo = floorNo;
	}

	@Column(name = "total_floor")
	public Integer getTotalFloor() {
		return this.totalFloor;
	}

	public void setTotalFloor(Integer totalFloor) {
		this.totalFloor = totalFloor;
	}

	@Column(name = "status")
	public Byte getStatus() {
		return this.status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderFloor")
	public Set<BuilderFlat> getBuilderFlats() {
		return this.builderFlats;
	}

	public void setBuilderFlats(Set<BuilderFlat> builderFlats) {
		this.builderFlats = builderFlats;
	}

}
