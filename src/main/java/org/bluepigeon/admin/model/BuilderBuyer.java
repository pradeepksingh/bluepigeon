package org.bluepigeon.admin.model;
// Generated 10 Apr, 2017 4:27:03 PM by Hibernate Tools 4.0.0

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
 * BuilderBuyer generated by hbm2java
 */
@Entity
@Table(name = "builder_buyer", catalog = "blue_pigeon")
public class BuilderBuyer implements java.io.Serializable {

	private Integer id;
	private Builder builder;
	private Buyer buyer;
	private BuilderFlat builderFlat;

	public BuilderBuyer() {
	}

	public BuilderBuyer(Builder builder, Buyer buyer, BuilderFlat builderFlat) {
		this.builder = builder;
		this.buyer = buyer;
		this.builderFlat = builderFlat;
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
	@JoinColumn(name = "builder_id")
	public Builder getBuilder() {
		return this.builder;
	}

	public void setBuilder(Builder builder) {
		this.builder = builder;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "buyer_id")
	public Buyer getBuyer() {
		return this.buyer;
	}

	public void setBuyer(Buyer buyer) {
		this.buyer = buyer;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "flat_id")
	public BuilderFlat getBuilderFlat() {
		return this.builderFlat;
	}

	public void setBuilderFlat(BuilderFlat builderFlat) {
		this.builderFlat = builderFlat;
	}

}
