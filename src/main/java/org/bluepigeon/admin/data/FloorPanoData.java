package org.bluepigeon.admin.data;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.FloorPanoramicImage;

public class FloorPanoData {
	private BuilderFloor builderFloor;
	List<FloorPanoramicImage> floorPanoramicImages = new ArrayList<FloorPanoramicImage>();
	public BuilderFloor getBuilderFloor() {
		return builderFloor;
	}
	public void setBuilderFloor(BuilderFloor builderFloor) {
		this.builderFloor = builderFloor;
	}
	public List<FloorPanoramicImage> getFloorPanoramicImages() {
		return floorPanoramicImages;
	}
	public void setFloorPanoramicImages(List<FloorPanoramicImage> floorPanoramicImages) {
		this.floorPanoramicImages = floorPanoramicImages;
	}
}
