package xbc.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "t_audit_log")
public class AuditLog implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false, length = 11)
	private Integer id;

	@Column(name = "type", nullable = false, length = 10)
	private String type;

	@Column(name = "json_insert", nullable = true, length = 5000)
	private String jsonInsert;

	@Column(name = "json_before", nullable = true, length = 5000)
	private String jsonBefore;

	@Column(name = "json_after", nullable = true, length = 5000)
	private String jsonAfter;

	@Column(name = "json_delete", nullable = true, length = 5000)
	private String jsonDelete;

	@Column(name = "created_on", nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Jakarta")
	private Date createdOn;

	@Column(name = "created_by", nullable = false, length = 11)
	private Integer createdBy;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getJsonInsert() {
		return jsonInsert;
	}

	public void setJsonInsert(String jsonInsert) {
		this.jsonInsert = jsonInsert;
	}

	public String getJsonBefore() {
		return jsonBefore;
	}

	public void setJsonBefore(String jsonBefore) {
		this.jsonBefore = jsonBefore;
	}

	public String getJsonAfter() {
		return jsonAfter;
	}

	public void setJsonAfter(String jsonAfter) {
		this.jsonAfter = jsonAfter;
	}

	public String getJsonDelete() {
		return jsonDelete;
	}

	public void setJsonDelete(String jsonDelete) {
		this.jsonDelete = jsonDelete;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}
}