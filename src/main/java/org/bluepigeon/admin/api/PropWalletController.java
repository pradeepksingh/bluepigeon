package org.bluepigeon.admin.api;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.bluepigeon.admin.dao.ProjectAPIDAO;
import org.bluepigeon.admin.data.DocumentList;
import org.bluepigeon.admin.data.DocumentType;
import org.bluepigeon.admin.data.PropertyDocument;
import org.bluepigeon.admin.data.PropertyDocumentList;
import org.bluepigeon.admin.exception.ResponseMessage;
import org.bluepigeon.admin.model.GlobalBuyer;

import com.google.gson.Gson;

@Path("api1.0/bp/propwallet")
public class PropWalletController {
	@Context ServletContext context;
	GlobalBuyer globalBuyer=new GlobalBuyer();
	
	@GET
	@Path("property.json/{pancard}/{projectid}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getPropertyDocument(@PathParam("pancard") String pancard,@PathParam("projectid") int projectId){
		Gson gson = new Gson();
		String json = "";
		ResponseMessage responseMessage = new ResponseMessage();
		int flatId = 0;
		int flatCount = 0;
		PropertyDocumentList propertyDocumentList = new PropertyDocumentList();
		PropertyDocument propertyDocument = new PropertyDocument();
		List<DocumentList> result = new ProjectAPIDAO().getPropertyDocument(pancard, projectId);
//		try{
//			List<DocumentList> documentLists = new ArrayList<DocumentList>();
//			List<DocumentList> documentLists1 = new ArrayList<DocumentList>();
//			List<DocumentList> newdocuments = new ArrayList<DocumentList>();
//			List<DocumentList> newdocuments2 = new ArrayList<DocumentList>();
//			DocumentType documentType = new DocumentType();
//			DocumentType documentType1 = new DocumentType();
//			DocumentType documentType3 = new DocumentType();
//			DocumentType documentType4 = new DocumentType();
//			int tempflatid = result.get(0).getFlatId();
//			for(DocumentList doclist : result){
//				
//				if(flatId != doclist.getFlatId()){
//					flatCount++;
//				}
//				flatId = doclist.getFlatId();
//				if(doclist.getDocType()==1){
//					
//					if(flatId != tempflatid){
//						documentType.setDocTypeName("Documents");
//						DocumentList documentList = new DocumentList();
//						documentList.setId(doclist.getId());
//						documentList.setFlatId(flatId);
//						documentList.setFlatNo(doclist.getFlatNo());
//						documentList.setName(doclist.getName());
//						if(doclist.getUrl()!= null || doclist.getUrl() != ""){
//							documentList.setUrl(context.getInitParameter("api_url")+doclist.getUrl());
//						}
//						documentList.setDocType(doclist.getDocType());
//						documentLists.add(documentList);
//					}else{
//						documentType3.setDocTypeName("Documents");
//						DocumentList documentList2 = new DocumentList();
//						documentList2.setId(doclist.getId());
//						documentList2.setFlatId(flatId);
//						documentList2.setFlatNo(doclist.getFlatNo());
//						documentList2.setName(doclist.getName());
//						if(doclist.getUrl()!= null || doclist.getUrl() != ""){
//							documentList2.setUrl(context.getInitParameter("api_url")+doclist.getUrl());
//						}
//						documentList2.setDocType(doclist.getDocType());
//						newdocuments.add(documentList2);
//					}
//				}
//				if(doclist.getDocType()==2){
//					if(flatId != tempflatid){
//						documentType1.setDocTypeName("Demand letter Recipt");
//						DocumentList documentList = new DocumentList();
//						documentList.setId(doclist.getId());
//						documentList.setFlatId(flatId);
//						documentList.setFlatNo(doclist.getFlatNo());
//						documentList.setName(doclist.getName());
//						if(doclist.getUrl()!= null || doclist.getUrl() != ""){
//							documentList.setUrl(context.getInitParameter("api_url")+doclist.getUrl());
//						}
//						documentList.setDocType(doclist.getDocType());
//						documentLists1.add(documentList);
//					}else{
//						documentType4.setDocTypeName("Demand letter Recipt");
//						DocumentList documentList2 = new DocumentList();
//						documentList2.setId(doclist.getId());
//						documentList2.setFlatId(flatId);
//						documentList2.setFlatNo(doclist.getFlatNo());
//						documentList2.setName(doclist.getName());
//						if(doclist.getUrl()!= null || doclist.getUrl() != ""){
//							documentList2.setUrl(context.getInitParameter("api_url")+doclist.getUrl());
//						}
//						documentList2.setDocType(doclist.getDocType());
//						newdocuments2.add(documentList2);
//					}
//				}
//			}
//			documentType.setDocumentLists(documentLists);
//			documentType1.setDocumentLists(documentLists1);
//			documentType3.setDocumentLists(newdocuments);
//			documentType4.setDocumentLists(newdocuments2);
//			List<DocumentType> documentTypes = new ArrayList<DocumentType>();
//			List<DocumentType> documentTypes2 = new ArrayList<DocumentType>();
//			//List<DocumentType> documentTypes3 = new ArrayList<DocumentType>();
//			documentTypes.add(documentType);
//			documentTypes.add(documentType1);
//			documentTypes2.add(documentType3);
//		//	documentTypes3.add(documentType4);
//			propertyDocument.setDocumentTypes(documentTypes);
//			PropertyDocument propertyDocument2 = new PropertyDocument();
//			propertyDocument2.setDocumentTypes(documentTypes2);
//		//	PropertyDocument propertyDocument3 = new PropertyDocument();
//		//	propertyDocument3.setDocumentTypes(documentTypes3);
//			List<PropertyDocument> propertyDocuments = new ArrayList<PropertyDocument>();
//			propertyDocuments.add(propertyDocument);
//			propertyDocuments.add(propertyDocument2);
//			//propertyDocuments.add(e)
//			System.err.println("Flat Counts :: "+flatCount);
//			propertyDocumentList.setPropertyDocuments(propertyDocuments);
//			json = gson.toJson(propertyDocumentList);
//		}catch(Exception e){
//			responseMessage.setStatus(0);
//			responseMessage.setMessage("User doesn't exist.");
//			json = gson.toJson(responseMessage);
//		}
		try{
			List<DocumentList> documentLists = new ArrayList<DocumentList>();
			List<DocumentList> documentLists1 = new ArrayList<DocumentList>();
			List<DocumentList> newdocuments = new ArrayList<DocumentList>();
			List<DocumentList> newdocuments2 = new ArrayList<DocumentList>();
			DocumentType documentType = new DocumentType();
			DocumentType documentType1 = new DocumentType();
			DocumentType documentType3 = new DocumentType();
			DocumentType documentType4 = new DocumentType();
			int tempflatid = result.get(0).getFlatId();
			for(DocumentList doclist : result){
				
				if(flatId != doclist.getFlatId()){
					flatCount++;
				}
				flatId = doclist.getFlatId();
				
					if(doclist.getDocType()==1){
						
						if(flatId != tempflatid){
							documentType.setDocTypeName("Documents");
							DocumentList documentList = new DocumentList();
							documentList.setId(doclist.getId());
							documentList.setFlatId(flatId);
							documentList.setFlatNo(doclist.getFlatNo());
							documentList.setName(doclist.getName());
							if(doclist.getUrl()!= null || doclist.getUrl() != ""){
								documentList.setUrl(context.getInitParameter("api_url")+doclist.getUrl());
							}
							documentList.setDocType(doclist.getDocType());
							documentLists.add(documentList);
						}else{
							documentType3.setDocTypeName("Documents");
							DocumentList documentList2 = new DocumentList();
							documentList2.setId(doclist.getId());
							documentList2.setFlatId(flatId);
							documentList2.setFlatNo(doclist.getFlatNo());
							documentList2.setName(doclist.getName());
							if(doclist.getUrl()!= null || doclist.getUrl() != ""){
								documentList2.setUrl(context.getInitParameter("api_url")+doclist.getUrl());
							}
							documentList2.setDocType(doclist.getDocType());
							newdocuments.add(documentList2);
						}
					}
					if(doclist.getDocType()==2){
						if(flatId != tempflatid){
							documentType1.setDocTypeName("Demand letter Recipt");
							DocumentList documentList = new DocumentList();
							documentList.setId(doclist.getId());
							documentList.setFlatId(flatId);
							documentList.setFlatNo(doclist.getFlatNo());
							documentList.setName(doclist.getName());
							if(doclist.getUrl()!= null || doclist.getUrl() != ""){
								documentList.setUrl(context.getInitParameter("api_url")+doclist.getUrl());
							}
							documentList.setDocType(doclist.getDocType());
							documentLists1.add(documentList);
						}else{
							documentType4.setDocTypeName("Demand letter Recipt");
							DocumentList documentList2 = new DocumentList();
							documentList2.setId(doclist.getId());
							documentList2.setFlatId(flatId);
							documentList2.setFlatNo(doclist.getFlatNo());
							documentList2.setName(doclist.getName());
							if(doclist.getUrl()!= null || doclist.getUrl() != ""){
								documentList2.setUrl(context.getInitParameter("api_url")+doclist.getUrl());
							}
							documentList2.setDocType(doclist.getDocType());
							newdocuments2.add(documentList2);
						}
					}
				
			}
			documentType.setDocumentLists(documentLists);
			documentType1.setDocumentLists(documentLists1);
			documentType3.setDocumentLists(newdocuments);
			documentType4.setDocumentLists(newdocuments2);
			List<DocumentType> documentTypes = new ArrayList<DocumentType>();
			List<DocumentType> documentTypes2 = new ArrayList<DocumentType>();
			//List<DocumentType> documentTypes3 = new ArrayList<DocumentType>();
			documentTypes.add(documentType);
			documentTypes.add(documentType1);
			documentTypes2.add(documentType3);
		//	documentTypes3.add(documentType4);
			propertyDocument.setDocumentTypes(documentTypes);
			PropertyDocument propertyDocument2 = new PropertyDocument();
			propertyDocument2.setDocumentTypes(documentTypes2);
		//	PropertyDocument propertyDocument3 = new PropertyDocument();
		//	propertyDocument3.setDocumentTypes(documentTypes3);
			List<PropertyDocument> propertyDocuments = new ArrayList<PropertyDocument>();
			propertyDocuments.add(propertyDocument);
			propertyDocuments.add(propertyDocument2);
			//propertyDocuments.add(e)
			System.err.println("Flat Counts :: "+flatCount);
			propertyDocumentList.setPropertyDocuments(propertyDocuments);
			json = gson.toJson(propertyDocumentList);
		}catch(Exception e){
			responseMessage.setStatus(0);
			responseMessage.setMessage("User doesn't exist.");
			json = gson.toJson(responseMessage);
		}
		return json;
	}
	
}
