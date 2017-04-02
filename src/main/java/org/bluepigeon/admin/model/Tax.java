package org.bluepigeon.admin.model;
// Generated 2 Apr, 2017 8:59:00 PM by Hibernate Tools 4.0.0

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Tax generated by hbm2java
 */
@Entity
@Table(name = "tax", catalog = "blue_pigeon")
public class Tax implements java.io.Serializable {

	private Integer id;
	private String pincode;
	private Double tax;
	private Double stampDuty;
	private Double vat;

	public Tax() {
	}

	public Tax(String pincode, Double tax, Double stampDuty, Double vat) {
		this.pincode = pincode;
		this.tax = tax;
		this.stampDuty = stampDuty;
		this.vat = vat;
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

	@Column(name = "pincode", length = 6)
	public String getPincode() {
		return this.pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	@Column(name = "tax")
	public Double getTax() {
		return this.tax;
	}

	public void setTax(Double tax) {
		this.tax = tax;
	}

	@Column(name = "stamp_duty")
	public Double getStampDuty() {
		return this.stampDuty;
	}

	public void setStampDuty(Double stampDuty) {
		this.stampDuty = stampDuty;
	}

	@Column(name = "vat")
	public Double getVat() {
		return this.vat;
	}

	public void setVat(Double vat) {
		this.vat = vat;
	}

}
