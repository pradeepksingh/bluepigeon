package org.bluepigeon.admin.model;
// Generated 24 May, 2017 6:27:50 PM by Hibernate Tools 4.0.0

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
 * NewProject generated by hbm2java
 */
@Entity
@Table(name = "new_project", catalog = "blue_pigeon")
public class NewProject implements java.io.Serializable {

	private Integer id;
	private Locality locality;
	private Builder builder; 
	private String name;

	public NewProject() {
	}

	public NewProject(Locality locality,Builder builder) {
		this.locality = locality;
		this.builder = builder;
	}

	public NewProject(Locality locality, String name) {
		this.locality = locality;
		this.name = name;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "locality_id", nullable = false)
	public Locality getLocality() {
		return this.locality;
	}

	public void setLocality(Locality locality) {
		this.locality = locality;
	}

	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "builder_id", nullable = false)
	public Builder getBuilder() {
		return this.builder;
	}

	public void setBuilder(Builder builder) {
		this.builder = builder;
	}
	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
