package org.bluepigeon.admin.dao;

import org.bluepigeon.admin.model.BuilderEmployee;;

public interface BuilderLoginValidateDAO {
	public BuilderEmployee getBuilderByEmail(String email);
	public boolean isValidBuilderEmailId(String email);
	public boolean isValidBuilderPassword(String password);
}
