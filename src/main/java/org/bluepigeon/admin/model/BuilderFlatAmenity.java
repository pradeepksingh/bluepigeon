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
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * BuilderFlatAmenity generated by hbm2java
 */
@Entity
@Table(name = "builder_flat_amenity", catalog = "blue_pigeon")
public class BuilderFlatAmenity implements java.io.Serializable {

	private Integer id;
	private String name;
	private Byte status;
	private Set<BuilderFlatAmenityStages> builderFlatAmenityStageses = new HashSet<BuilderFlatAmenityStages>(0);

	public BuilderFlatAmenity() {
	}

	public BuilderFlatAmenity(String name, Byte status, Set<BuilderFlatAmenityStages> builderFlatAmenityStageses) {
		this.name = name;
		this.status = status;
		this.builderFlatAmenityStageses = builderFlatAmenityStageses;
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderFlatAmenity")
	public Set<BuilderFlatAmenityStages> getBuilderFlatAmenityStageses() {
		return this.builderFlatAmenityStageses;
	}

	public void setBuilderFlatAmenityStageses(Set<BuilderFlatAmenityStages> builderFlatAmenityStageses) {
		this.builderFlatAmenityStageses = builderFlatAmenityStageses;
	}

}
