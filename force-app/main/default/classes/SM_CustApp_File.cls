@RestResource(urlMapping='/uploadFile')
global class SM_CustApp_File {
	
	@HttpPost
	global static FileResponse uploadFile() {
		try{
			RestRequest request = RestContext.request;
			Map<String,Object> params = (Map<String,Object>)JSON.deserializeUntyped(request.requestBody.tostring());
			//FileUploadRequest request = (FileUploadRequest)JSON.deserialize(requestBody, FileUploadRequest.class);
			ContentVersion cv = new ContentVersion();
			cv.Title = String.valueOf(params.get('fileName'));
			cv.PathOnClient = String.valueOf(params.get('pathOnClient'));
			cv.VersionData = EncodingUtil.base64Decode(String.valueOf(params.get('versionData')));
			insert cv;
			
			FileResponse fileRes = new FileResponse();
			fileRes.ContentVersion = cv.Id;
			fileRes.Status = 'Success';
			fileRes.Message = 'File uploaded successfully!'; 
			return fileRes;
		}
		catch (Exception e) {
			FileResponse fileRes = new FileResponse();
			fileRes.Status = 'Error!';
			fileRes.Message = e.getMessage();
			return fileRes;
		}
	}
	global class FileResponse {
		public String ContentVersion ;
		public String Status ;
		public String Message ;
	}
}