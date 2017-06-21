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
@Table(name = "demand_names", catalog = "blue_pigeon")
public class DemandNames {
	private Integer id;
	private DemandLetters demandLetters;
	private String demandName;
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
	@JoinColumn(name = "demand_id", nullable = false)
	public DemandLetters getDemandLetters() {
		return demandLetters;
	}
	public void setDemandLetters(DemandLetters demandLetters) {
		this.demandLetters = demandLetters;
	}
	@Column(name ="demand_name")
	public String getDemandName() {
		return demandName;
	}
	public void setDemandName(String demandName) {
		this.demandName = demandName;
	}
	
	
}
