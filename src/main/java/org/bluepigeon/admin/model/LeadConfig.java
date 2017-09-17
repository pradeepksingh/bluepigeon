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
@Table(name = "lead_config", catalog = "blue_pigeon")
public class LeadConfig {
	private Integer id;
	private BuilderProjectPropertyConfiguration builderProjectPropertyConfiguration;
	private BuilderLead builderLead;
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
	@JoinColumn(name = "config_id")
	public BuilderProjectPropertyConfiguration getBuilderProjectPropertyConfiguration() {
		return builderProjectPropertyConfiguration;
	}
	public void setBuilderProjectPropertyConfiguration(
			BuilderProjectPropertyConfiguration builderProjectPropertyConfiguration) {
		this.builderProjectPropertyConfiguration = builderProjectPropertyConfiguration;
	}
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "lead_id")
	public BuilderLead getBuilderLead() {
		return builderLead;
	}
	public void setBuilderLead(BuilderLead builderLead) {
		this.builderLead = builderLead;
	}
	 
}