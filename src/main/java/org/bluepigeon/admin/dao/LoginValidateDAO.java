package org.bluepigeon.admin.dao;

import java.util.List;

import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.Builder;

public interface LoginValidateDAO {

	public List<AdminUser> getAdminUserByEmail(String email);
//	public List<Registration> getAdminUserByEmailAndPassword(String eail, String password);
	public  boolean isValidEmailId(String email);
	public boolean isValidPassword(String password);
	public Builder getBuilderByEmail(String email);
	public boolean isValidBuilderEmailId(String email);
	public boolean isValidBuilderPassword(String password);
}
