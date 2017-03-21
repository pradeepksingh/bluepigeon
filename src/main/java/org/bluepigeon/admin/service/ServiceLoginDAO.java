package org.bluepigeon.admin.service;

import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.AdminUser;

public interface ServiceLoginDAO {
	public ResponseMessage isValidUser(AdminUser registration);
}
