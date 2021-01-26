//
// ReportSalaryAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class ReportSalaryAPI {
    /**

     - parameter reportId: (path)  
     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiSalaryV1ReportReportIdPut(reportId: String, body: ReportUserSalaryEdit? = nil, completion: @escaping ((_ data: ReportUserSalaryFullView?,_ error: Error?) -> Void)) {
        apiSalaryV1ReportReportIdPutWithRequestBuilder(reportId: reportId, body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - PUT /api/salary/v1/report/{reportId}
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - examples: [{contentType=application/json, example={
  "approved" : "2000-01-23T04:56:07.000+00:00",
  "reportId" : "reportId",
  "approverId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "count" : 0,
  "description" : "description"
}}]
     - parameter reportId: (path)  
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<ReportUserSalaryFullView> 
     */
    open class func apiSalaryV1ReportReportIdPutWithRequestBuilder(reportId: String, body: ReportUserSalaryEdit? = nil) -> RequestBuilder<ReportUserSalaryFullView> {
        var path = "/api/salary/v1/report/{reportId}"
        let reportIdPreEscape = "\(reportId)"
        let reportIdPostEscape = reportIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{reportId}", with: reportIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<ReportUserSalaryFullView>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    /**
     Get list of report salary

     - parameter userId: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiSalaryV1ReportUserUserIdGet(userId: UUID, completion: @escaping ((_ data: [ReportUserSalaryFullView]?,_ error: Error?) -> Void)) {
        apiSalaryV1ReportUserUserIdGetWithRequestBuilder(userId: userId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get list of report salary
     - GET /api/salary/v1/report/user/{userId}
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - examples: [{contentType=application/json, example=[ {
  "approved" : "2000-01-23T04:56:07.000+00:00",
  "reportId" : "reportId",
  "approverId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "count" : 0,
  "description" : "description"
}, {
  "approved" : "2000-01-23T04:56:07.000+00:00",
  "reportId" : "reportId",
  "approverId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "count" : 0,
  "description" : "description"
} ]}]
     - parameter userId: (path)  

     - returns: RequestBuilder<[ReportUserSalaryFullView]> 
     */
    open class func apiSalaryV1ReportUserUserIdGetWithRequestBuilder(userId: UUID) -> RequestBuilder<[ReportUserSalaryFullView]> {
        var path = "/api/salary/v1/report/user/{userId}"
        let userIdPreEscape = "\(userId)"
        let userIdPostEscape = userIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{userId}", with: userIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[ReportUserSalaryFullView]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}