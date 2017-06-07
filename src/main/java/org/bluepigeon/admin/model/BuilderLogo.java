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
@Table(name = "builder_logo", catalog = "blue_pigeon")
public class BuilderLogo implements java.io.Serializable {
	private Integer id;
	private Builder builder;
	private String builderUrl;
	
	
	public BuilderLogo() {
		
	}

	public BuilderLogo(String builderUrl, Builder builder) {
		this.builderUrl = builderUrl;
		this.builder = builder;
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
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "builder_id")
	public Builder getBuilder() {
		return builder;
	}

	public void setBuilder(Builder builder) {
		this.builder = builder;
	}
	
	@Column(name = "builder_url")
	public String getBuilderUrl() {
		return builderUrl;
	}

	public void setBuilderUrl(String builderUrl) {
		this.builderUrl = builderUrl;
	}
	
}
