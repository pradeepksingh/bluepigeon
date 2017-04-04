package org.bluepigeon.admin.data;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.FloorImageGallery;

public class FloorImageData {
	private BuilderFloor builderFloor;
	private List<FloorImageGallery> floorImageGallery = new ArrayList<FloorImageGallery>();
	public BuilderFloor getBuilderFloor() {
		return builderFloor;
	}
	public void setBuilderFloor(BuilderFloor builderFloor) {
		this.builderFloor = builderFloor;
	}
	public List<FloorImageGallery> getFloorImageGallery() {
		return floorImageGallery;
	}
	public void setFloorImageGallery(List<FloorImageGallery> floorImageGallery) {
		this.floorImageGallery = floorImageGallery;
	}
}
