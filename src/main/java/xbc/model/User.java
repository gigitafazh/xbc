package xbc.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.ColumnDefault;

import com.fasterxml.jackson.annotation.JsonFormat;

import xbc.model.Role;

@Entity
@Table(name = "t_user")
public class User implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 11, updatable = false, nullable = false)
	private int id;

	@Column(name = "username", length = 50, nullable = false)
	private String username;

	@Column(name = "password", length = 50, nullable = false)
	private String password;

	@Column(name = "email", length = 100, nullable = false)
	private String email;
	
	@Column(name = "role_id", length = 11, nullable = false)
	private int roleId;

	@ManyToOne
	@JoinColumn(name = "role_id", updatable = false, insertable = false)
	private Role role;

	@Column(name = "mobile_flag", nullable = false)
	private boolean mobileFlag;

	@Column(name = "mobile_token", length = 11, nullable = true)
	private int mobileToken;

	@Column(name = "created_by", length = 11, nullable = false)
	private int createdBy = 0;

	@Column(name = "created_on", nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:mm:ss", timezone = "Asia/Jakarta")
	private Date createdOn;

	@Column(name = "modified_by", length = 11, nullable = true)
	private int modifiedBy;

	@Column(name = "modified_on", nullable = true)
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:mm:ss", timezone = "Asia/Jakarta")
	private Date modifiedOn;

	@Column(name = "deleted_by", length = 11, nullable = true)
	private int deletedBy;

	@Column(name = "deleted_on", nullable = true)
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:mm:ss", timezone = "Asia/Jakarta")
	private Date deletedOn;

	@Column(name = "deleted", nullable = false)
	private boolean deleted;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public boolean isMobileFlag() {
		return mobileFlag;
	}

	public void setMobileFlag(boolean mobileFlag) {
		this.mobileFlag = mobileFlag;
	}

	public int getMobileToken() {
		return mobileToken;
	}

	public void setMobileToken(int mobileToken) {
		this.mobileToken = mobileToken;
	}

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public int getModifiedBy() {
		return modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public Date getModifiedOn() {
		return modifiedOn;
	}

	public void setModifiedOn(Date modifiedOn) {
		this.modifiedOn = modifiedOn;
	}

	public int getDeletedBy() {
		return deletedBy;
	}

	public void setDeletedBy(int deletedBy) {
		this.deletedBy = deletedBy;
	}

	public Date getDeletedOn() {
		return deletedOn;
	}

	public void setDeletedOn(Date deletedOn) {
		this.deletedOn = deletedOn;
	}

	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
}