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
@Table(name = "allot_project", catalog = "blue_pigeon")
public class AllotProject {
	private Integer id;
	private BuilderProject builderProject;
	private BuilderEmployee builderEmployee;
	 
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
	@JoinColumn(name = "project_id")
	public BuilderProject getBuilderProject() {
		return builderProject;
	}
	
	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "emp_id")
	public BuilderEmployee getBuilderEmployee() {
		return builderEmployee;
	}
	
	public void setBuilderEmployee(BuilderEmployee builderEmployee) {
		this.builderEmployee = builderEmployee;
	}
}