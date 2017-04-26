package org.bluepigeon.admin.controller;

import javax.servlet.ServletContext;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;

import org.bluepigeon.admin.service.ImageUploader;

@Path("builder/")
public class BuilderController {

	@Context ServletContext context;
	ImageUploader imageUploader = new ImageUploader();
}
