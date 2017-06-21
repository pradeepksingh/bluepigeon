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
@Table(name = "allot_leads", catalog = "blue_pigeon")
public class AllotLeads {
	private Integer id;
	private BuilderLead builderLead;
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
	@JoinColumn(name = "lead_id")
	public BuilderLead getBuilderLead() {
		return builderLead;
	}
	
	public void setBuilderLead(BuilderLead builderLead) {
		this.builderLead = builderLead;
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
