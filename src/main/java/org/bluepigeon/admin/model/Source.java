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
@Table(name = "source", catalog = "blue_pigeon")
public class Source {
	
	private Integer id;
	private String name;
	private Builder builder;
	private boolean isDeleted = false;
	
	public Source() {
		
	}
	public Source(Integer id, String name, Builder builder, boolean isDeleted) {
		super();
		this.id = id;
		this.name = name;
		this.builder = builder;
		this.isDeleted = isDeleted;
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
	@Column(name = "name")
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "builder_id")
	public Builder getBuilder() {
		return builder;
	}
	public void setBuilder(Builder builder) {
		this.builder = builder;
	}
	@Column(name = "is_deleted")
	public boolean getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}
	
}