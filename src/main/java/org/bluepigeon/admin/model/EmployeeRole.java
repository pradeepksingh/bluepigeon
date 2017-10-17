package org.bluepigeon.admin.model;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "employee_role", catalog = "blue_pigeon")
public class EmployeeRole {
	private Integer id;
	private BuilderEmployee builderEmployee;
	private BuilderEmployeeAccessType builderEmployeeAccessType;
	
	public EmployeeRole() {
		super();
		// TODO Auto-generated constructor stub
	}
	public EmployeeRole(BuilderEmployee builderEmployee, BuilderEmployeeAccessType builderEmployeeAccessType) {
		super();
		this.builderEmployee = builderEmployee;
		this.builderEmployeeAccessType = builderEmployeeAccessType;
	}
	
	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "emp_id")
	public BuilderEmployee getBuilderEmployee() {
		return builderEmployee;
	}
	public void setBuilderEmployee(BuilderEmployee builderEmployee) {
		this.builderEmployee = builderEmployee;
	}
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "role_id")
	public BuilderEmployeeAccessType getBuilderEmployeeAccessType() {
		return builderEmployeeAccessType;
	}
	public void setBuilderEmployeeAccessType(BuilderEmployeeAccessType builderEmployeeAccessType) {
		this.builderEmployeeAccessType = builderEmployeeAccessType;
	}
}