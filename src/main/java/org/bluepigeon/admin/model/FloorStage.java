package org.bluepigeon.admin.model;
// Generated 16 May, 2017 11:21:31 PM by Hibernate Tools 4.0.0

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * FloorStage generated by hbm2java
 */
@Entity
@Table(name = "floor_stage", catalog = "blue_pigeon")
public class FloorStage implements java.io.Serializable {

	private Integer id;
	private String name;
	private Byte status;
	private Byte isDeleted=0;
	private Set<FloorSubstage> floorSubstages = new HashSet<FloorSubstage>(0);

	public FloorStage() {
	}

	public FloorStage(String name, Byte status, Byte isDeleted, Set<FloorSubstage> floorSubstages) {
		this.name = name;
		this.status = status;
		this.isDeleted = isDeleted;
		this.floorSubstages = floorSubstages;
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

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "status")
	public Byte getStatus() {
		return this.status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	@Column(name = "is_deleted")
	public Byte getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Byte isDeleted) {
		this.isDeleted = isDeleted;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "floorStage")
	public Set<FloorSubstage> getFloorSubstages() {
		return this.floorSubstages;
	}

	public void setFloorSubstages(Set<FloorSubstage> floorSubstages) {
		this.floorSubstages = floorSubstages;
	}

}
