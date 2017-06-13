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
@Table(name = "bank_logo", catalog = "blue_pigeon")
public class BankLogo {
	private Integer id;
	private HomeLoanBanks homeLoanBanks;
	private String logoUrl;
	
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
	@JoinColumn(name = "bank_id")
	public HomeLoanBanks getHomeLoanBanks() {
		return homeLoanBanks;
	}
	
	public void setHomeLoanBanks(HomeLoanBanks homeLoanBanks) {
		this.homeLoanBanks = homeLoanBanks;
	}

	@Column(name = "logo_url")
	public String getLogoUrl() {
		return logoUrl;
	}

	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}
}