package org.bluepigeon.admin.data;

import java.util.List;

public class ReferEarnList {
	private List<Refer> refers;
	private int view;
	private int clicked;
	public List<Refer> getRefers() {
		return refers;
	}

	public void setRefers(List<Refer> refers) {
		this.refers = refers;
	}

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}

	public int getClicked() {
		return clicked;
	}

	public void setClicked(int clicked) {
		this.clicked = clicked;
	}

}
