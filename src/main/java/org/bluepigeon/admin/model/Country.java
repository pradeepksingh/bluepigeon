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
 * Country generated by hbm2java
 */
@Entity
@Table(name = "country", catalog = "blue_pigeon")
public class Country implements java.io.Serializable {

	private Integer id;
	private String name;
	private Byte status;
	private Integer sortOrder;
	private Set<State> states = new HashSet<State>(0);
	private Set<BuilderProject> builderProjects = new HashSet<BuilderProject>(0);

	public Country() {
	}

	public Country(String name, Byte status, Integer sortOrder, Set<State> states,
			Set<BuilderProject> builderProjects) {
		this.name = name;
		this.status = status;
		this.sortOrder = sortOrder;
		this.states = states;
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

	@Column(name = "name", length = 200)
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

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "country")
	public Set<State> getStates() {
		return this.states;
	}

	public void setStates(Set<State> states) {
		this.states = states;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "country")
	public Set<BuilderProject> getBuilderProjects() {
		return this.builderProjects;
	}

	public void setBuilderProjects(Set<BuilderProject> builderProjects) {
		this.builderProjects = builderProjects;
	}

}
