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
 * State generated by hbm2java
 */
@Entity
@Table(name = "state", catalog = "blue_pigeon")
public class State implements java.io.Serializable {

	private Integer id;
	private Country country;
	private String name;
	private Byte status;
	private Integer sortOrder;
	private Set<City> cities = new HashSet<City>(0);
	private Set<BuilderProject> builderProjects = new HashSet<BuilderProject>(0);

	public State() {
	}

	public State(Country country, String name, Byte status, Integer sortOrder, Set<City> cities,
			Set<BuilderProject> builderProjects) {
		this.country = country;
		this.name = name;
		this.status = status;
		this.sortOrder = sortOrder;
		this.cities = cities;
		this.builderProjects = builderProjects;
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
	@JoinColumn(name = "country_id")
	public Country getCountry() {
		return this.country;
	}

	public void setCountry(Country country) {
		this.country = country;
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

	@Column(name = "sort_order")
	public Integer getSortOrder() {
		return this.sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "state")
	public Set<City> getCities() {
		return this.cities;
	}

	public void setCities(Set<City> cities) {
		this.cities = cities;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "state")
	public Set<BuilderProject> getBuilderProjects() {
		return this.builderProjects;
	}

	public void setBuilderProjects(Set<BuilderProject> builderProjects) {
		this.builderProjects = builderProjects;
	}

}
