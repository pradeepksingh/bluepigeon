package org.bluepigeon.admin.data;

import java.util.List;

public class DocumentType {
	private String docTypeName;
	private List<DocumentList> documentLists;
	
	public String getDocTypeName() {
		return docTypeName;
	}
	public void setDocTypeName(String docTypeName) {
		this.docTypeName = docTypeName;
	}
	public List<DocumentList> getDocumentLists() {
		return documentLists;
	}
	public void setDocumentLists(List<DocumentList> documentLists) {
		this.documentLists = documentLists;
	}
}
